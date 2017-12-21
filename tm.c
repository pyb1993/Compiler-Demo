#include "tm.h"
#include "assert.h"
#include "code.h"

int labelLocMap[1024];// the label and location mapping

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

/******* const *******/
#define   IADDR_SIZE  4096 /* increase for large programs */
#define   DADDR_SIZE  4096 /* increase for large programs */

#define   GP_ADRESS 3072 /*the gp adress*/
#define   FIRST_FP  2048 /*the main fp*/

#define   NO_REGS 11
#define   PC_REG  7

#define   LINESIZE  121
#define   WORDSIZE  20

/******** vars ********/
int iloc = 0;
int dloc = 0;
int traceflag = FALSE;
int icountflag = FALSE;

INSTRUCTION iMem[IADDR_SIZE];
int dMem[DADDR_SIZE];
int reg[NO_REGS];

char * opCodeTab[]
= { "HALT", "IN", "OUT","MOV","NEG","ADD", "SUB", "MUL", "DIV","LABEL","GO", "????",
/* RR opcodes */
"LD", "ST","PUSH","POP","????", /* RM opcodes */
"LDA", "LDC", "JLT", "JLE", "JGT", "JGE", "JEQ", "JNE", "RETURN", "????"
/* RA opcodes */
   };

char * stepResultTab[] = 
{ "OK", "Halted", "Instruction Memory Fault",
  "Data Memory Fault", "Division by 0"
};

char pgmName[20];

char in_Line[LINESIZE];
int lineLen;
int inCol;
int num;
float flt_num;
char word[WORDSIZE];
char ch;

// macro used to DRY
#define operand_proc(op,func) do{\
					switch (op)\
				{\
					case '+': reg[r] = func(lhs + rhs); break;\
					case '-': reg[r] = func(lhs - rhs); break;\
					case '*': reg[r] = func(lhs * rhs); break;\
					case '/':\
						if (rhs == 0) return srZERODIVIDE;\
						else reg[r] = func(lhs / rhs);\
						break;\
				}\
				return srOKAY;\
				}while(0)

/********************************************/



static int reg_type(int reg){
	if (reg == ac || reg == ac1) return ac;
	if (reg == fac || reg == fac1) return fac;
	return -1;
}

static int same_reg_type(int reg1, int reg2);

static float flt_from_integer(int c);

static float flt_from_reg(int r);

static int int_from_flt(float x);

static void convert(int reg1, int reg2);

static STEPRESULT operand(int r, int s, int t, char op);

static STEPRESULT do_operand_flt(int r, float lhs, float rhs, char op);

static STEPRESULT do_operand_int(int r, int lhs, int rhs, char op);

static STEPRESULT do_neg_op(int r);

int opClass(int c)
{
	if (c <= opRRLim) return (opclRR);
	else if (c <= opRMLim) return (opclRM);
	else                    return (opclRA);
} /* opClass */

/********************************************/
void writeInstruction(int loc)
{
	printf("%5d: ", loc);
	if ((loc >= 0) && (loc < IADDR_SIZE))
	{
		printf("%6s%3d,", opCodeTab[iMem[loc].iop], iMem[loc].iarg1);
		switch (opClass(iMem[loc].iop))
		{
		case opclRR: printf("%1d,%1d", iMem[loc].iarg2, iMem[loc].iarg3);
			break;
		case opclRM:
		case opclRA: printf("%3d(%1d)", iMem[loc].iarg2, iMem[loc].iarg3);
			break;
		}
		printf("\n");
	}
} /* writeInstruction */

/********************************************/
void getCh(void)
{
	if (++inCol < lineLen)
		ch = in_Line[inCol];
	else ch = ' ';
} /* getCh */

/********************************************/
int nonBlank(void)
{
	while ((inCol < lineLen)
		&& (in_Line[inCol] == ' '))
		inCol++;
	if (inCol < lineLen)
	{
		ch = in_Line[inCol];
		return TRUE;
	}
	else
	{
		ch = ' ';
		return FALSE;
	}
} /* nonBlank */

/********************************************/
int getNum(void)
{
	int sign;
	int term;
	int temp = FALSE;
	num = 0;
	do
	{
		sign = 1;
		while (nonBlank() && ((ch == '+') || (ch == '-')))
		{
			temp = FALSE;
			if (ch == '-')  sign = -sign;
			getCh();
		}
		term = 0;
		nonBlank();
		while (isdigit(ch))
		{
			temp = TRUE;
			term = term * 10 + (ch - '0');
			getCh();
		}
		num = num + (term * sign);
	} while ((nonBlank()) && ((ch == '+') || (ch == '-')));
	return temp;
} /* getNum */

float getFloat()
{
	int retry_times = 2;
	char * str_head = (char*)malloc(30 * sizeof(char));
	char * str_tail = str_head;

	nonBlank();
	while (retry_times > 0){
		if (ch == '+' || ch == '-') *str_tail++ = ch;
		else if (ch == '.') { retry_times -= 1; *str_tail++ = ch;}
		else if (isdigit(ch)) { *str_tail++ = ch;}
		else { retry_times = 0; break; }
		getCh();
	}
	*str_tail = '\0';
	flt_num = atof(str_head);
	free(str_head);
	return TRUE;
}


/********************************************/
int getWord(void)
{
	int temp = FALSE;
	int length = 0;
	if (nonBlank())
	{
		while (isalnum(ch))
		{
			if (length < WORDSIZE - 1) word[length++] = ch;
			getCh();
		}
		word[length] = '\0';
		temp = (length != 0);
	}
	return temp;
} /* getWord */

/********************************************/
int skipCh(char c)
{
	int temp = FALSE;
	if (nonBlank() && (ch == c))
	{
		getCh();
		temp = TRUE;
	}
	return temp;
} /* skipCh */

/********************************************/
int atEOL(void)
{
	return (!nonBlank());
} /* atEOL */

/********************************************/
int error(char * msg, int lineNo, int instNo)
{
	printf("Line %d", lineNo);
	if (instNo >= 0) printf(" (Instruction %d)", instNo);
	printf("   %s\n", msg);
	return FALSE;
} /* error */

/********************************************/
int readInstructions(FILE *pgm)
{
	OPCODE op;
	int arg1 = -1, arg2 = -1, arg3 = -1;
	int loc, regNo, lineNo;
	for (regNo = 0; regNo < NO_REGS; regNo++)
		reg[regNo] = 0;

	dMem[0] = DADDR_SIZE - 1;
	dMem[1] = GP_ADRESS;
	dMem[2] = FIRST_FP;
	
	for (loc = 3; loc < DADDR_SIZE; loc++)
		dMem[loc] = 0;
	for (loc = 0; loc < IADDR_SIZE; loc++)
	{
		iMem[loc].iop = opHALT;
		iMem[loc].iarg1 = 0;
		iMem[loc].iarg2 = 0;
		iMem[loc].iarg3 = 0;
	}
	lineNo = 0;
	while (!feof(pgm))
	{
		fgets(in_Line, LINESIZE - 2, pgm);
		inCol = 0;
		lineNo++;
		lineLen = (int)strlen(in_Line) - 1;
		if (in_Line[lineLen] == '\n') in_Line[lineLen] = '\0';
		else in_Line[++lineLen] = '\0';
		if ((nonBlank()) && (in_Line[inCol] != '*'))
		{
			if (!getNum())
				return error("Bad location", lineNo, -1);
			loc = num;
			if (loc > IADDR_SIZE)
				return error("Location too large", lineNo, loc);
			if (!skipCh(':'))
				return error("Missing colon", lineNo, loc);
			if (!getWord())
				return error("Missing opcode", lineNo, loc);
			// get the instruction type op
			op = opHALT;
			while ((op < opRALim)
				&& (strncmp(opCodeTab[op], word, 4) != 0))
				op++;

			if (strncmp(opCodeTab[op], word, 4) != 0)
				return error("Illegal opcode", lineNo, loc);
			


			switch (opClass(op))
			{
			case opclRR:
				/***********************************/
				// process the label related
				if (loc == 48)
				{
					int b = 1000;
				}
				if (strncmp("LABEL", word, 5) == 0)
				{
					getNum();
					labelLocMap[num] = loc;
				}
				else if ((!getNum()) || (num < 0) || (num >= NO_REGS))
					return error("Bad first register", lineNo, loc);
				arg1 = num;
				if (!skipCh(','))
					return error("Missing comma", lineNo, loc);
				if ((!getNum()) || (num < 0) || (num >= NO_REGS))
					return error("Bad second register", lineNo, loc);
				arg2 = num;
				if (!skipCh(','))
					return error("Missing comma", lineNo, loc);
				if ((!getNum()) || (num < 0) || (num >= NO_REGS))
					return error("Bad third register", lineNo, loc);
				arg3 = num;
				break;

			case opclRM:
			case opclRA:
				/***********************************/
				if ((!getNum()) || (num < 0) || (num >= NO_REGS))
					return error("Bad first register", lineNo, loc);
				arg1 = num;
				if (!skipCh(','))
					return error("Missing comma", lineNo, loc);
				/*
					load float , load integer	
				*/
				if (op == opLDC && same_reg_type(arg1,fac))
				{
					getFloat();
					arg2 = *(int *)(&flt_num);
				}
				else{
					if (!getNum())	return error("Bad displacement", lineNo, loc);
					arg2 = num;
				}
				
				if (!skipCh('(') && !skipCh(','))
					return error("Missing LParen", lineNo, loc);
				if ((!getNum()) || (num < 0) || (num >= NO_REGS))
					return error("Bad second register", lineNo, loc);
				arg3 = num;
				break;
			}
			iMem[loc].iop = op;
			iMem[loc].iarg1 = arg1;
			iMem[loc].iarg2 = arg2;
			iMem[loc].iarg3 = arg3;
		}
	}
	return TRUE;
} /* readInstructions */


/********************************************/
STEPRESULT stepTM(void)
{

	INSTRUCTION currentinstruction;
	int pc_pos;
	int r, s, t, m;
	int ok;

	pc_pos = reg[PC_REG];

	printf("run ins:%d\n", pc_pos);
	if (pc_pos == 13)
	{
		ok = 100;
	}

    if ((pc_pos < 0) || (pc_pos > IADDR_SIZE)) {return srIMEM_ERR;}
    
	reg[PC_REG] = pc_pos + 1;
	currentinstruction = iMem[pc_pos];
	switch (opClass(currentinstruction.iop))
	{
	case opclRR:
		/***********************************/
		r = currentinstruction.iarg1;
		s = currentinstruction.iarg2;
		t = currentinstruction.iarg3;
		break;

	case opclRM:
		/***********************************/
		r = currentinstruction.iarg1;
		s = currentinstruction.iarg3;
		m = currentinstruction.iarg2 + reg[s];
		if ((m < 0) || (m > DADDR_SIZE))
			return srDMEM_ERR;
		break;

	case opclRA:
		/***********************************/
		r = currentinstruction.iarg1;
		s = currentinstruction.iarg3;
		m = currentinstruction.iarg2 + reg[s];
		break;
    default:
        assert(!"unknown op type");
        return srDMEM_ERR;
        break;
	} /* case */

	switch (currentinstruction.iop)
	{ /* RR instructions */
	case opHALT:
		/***********************************/
		printf("HALT: %1d,%1d,%1d\n", r, s, t);
		return srHALT;
		/* break; */

	case opIN:
		/***********************************/
		do
		{
			printf("Enter value for IN instruction: ");
			fflush(stdin);
			fflush(stdout);
			gets(in_Line);
			lineLen = (int)strlen(in_Line);
			inCol = 0;
			/*
				deal with the float number
			*/
			if (same_reg_type(r, ac)) { 
				ok = getNum(); 
				reg[r] = num;
			}
			else if (same_reg_type(r,fac)) {
				ok = getFloat();
				reg[r] = flt_num;
			}
			else{
				assert(!"undefined type");
			}
			if (!ok) printf("Illegal value\n");
		} while (!ok);
		break;

	case opOUT:
		if (same_reg_type(r, ac)) {
			printf("OUT instruction prints int: %d\n", reg[r]);
		}
		else if (same_reg_type(r, fac)) {
			flt_num = flt_from_reg(r);
			printf("OUT instruction prints float: %f\n", flt_num);
		}
		break;
	case opMOV:	 
		/*deal  with the conversion of different format*/
		convert(s,r);// s -> r
		break;
	case opNEG:	 do_neg_op(r);break;
			
	case opADD:  operand(r, s, t, '+'); break;
	case opSUB:  operand(r, s, t, '-');  break;
	case opMUL:  operand(r, s, t, '*'); break;

	case opDIV:
		/***********************************/
		if (operand(r, s, t, '/') != srOKAY) return srZERODIVIDE;
		break;
	case opGO:	   reg[PC_REG] = labelLocMap[r]; break;
	case opLAEBL: break;

		/*************** RM instructions ********************/
	case opLD:    reg[r] = dMem[m];  break;
	case opST:    dMem[m] = reg[r];  break;// no need to convert float,integer
	case opPUSH:  
		dMem[m] = reg[r];
		reg[s]--;
		break;
	case opPOP:
		reg[r] = dMem[m + 1];
		reg[s]++;
		break;
		/*************** RA instructions ********************/
	case opLDA:    reg[r] = m; break;
	case opLDC:    reg[r] = currentinstruction.iarg2; break;
	case opJLT:    if (reg[r] <  0) reg[PC_REG] = m; break;
	case opJLE:    if (reg[r] <= 0) reg[PC_REG] = m; break;
	case opJGT:    if (reg[r] >  0) reg[PC_REG] = m; break;
	case opJGE:    if (reg[r] >= 0) reg[PC_REG] = m; break;
	case opJEQ:    if (reg[r] == 0) reg[PC_REG] = m; break;
	case opJNE:    if (reg[r] != 0) reg[PC_REG] = m; break;
	case opRETURN: reg[PC_REG] = dMem[m];	break;
    default:        assert(!"unknown op type");break;
		/* end of legal instructions */
	} /* case */
	return srOKAY;
} /* stepTM */

/********************************************/
int doCommand(void)
{
	char cmd;
	int stepcnt = 0, i;
	int printcnt;
	int stepResult;
	int regNo, loc;
	do
	{
		printf("Enter command: ");
		fflush(stdin);
		fflush(stdout);
		gets(in_Line);
		lineLen = (int)strlen(in_Line);
		inCol = 0;
	} while (!getWord());

	cmd = word[0];
	switch (cmd)
	{
	case 't':
		/***********************************/
		traceflag = !traceflag;
		printf("Tracing now ");
		if (traceflag) printf("on.\n"); else printf("off.\n");
		break;

	case 'h':
		/***********************************/
		printf("Commands are:\n");
		printf("   s(tep <n>      "\
			"Execute n (default 1) TM instructions\n");
		printf("   g(o            "\
			"Execute TM instructions until HALT\n");
		printf("   r(egs          "\
			"Print the contents of the registers\n");
		printf("   i(Mem <b <n>>  "\
			"Print n iMem locations starting at b\n");
		printf("   d(Mem <b <n>>  "\
			"Print n dMem locations starting at b\n");
		printf("   t(race         "\
			"Toggle instruction trace\n");
		printf("   p(rint         "\
			"Toggle print of total instructions executed"\
			" ('go' only)\n");
		printf("   c(lear         "\
			"Reset simulator for new execution of program\n");
		printf("   h(elp          "\
			"Cause this list of commands to be printed\n");
		printf("   q(uit          "\
			"Terminate the simulation\n");
		break;

	case 'p':
		/***********************************/
		icountflag = !icountflag;
		printf("Printing instruction count now ");
		if (icountflag) printf("on.\n"); else printf("off.\n");
		break;

	case 's':
		/***********************************/
		if (atEOL())  stepcnt = 1;
		else if (getNum())  stepcnt = abs(num);
		else   printf("Step count?\n");
		break;

	case 'g':   stepcnt = 1;     break;

	case 'r':
		/***********************************/
		for (i = 0; i < NO_REGS; i++)
		{
			printf("%1d: %4d    ", i, reg[i]);
			if ((i % 4) == 3) printf("\n");
		}
		break;

	case 'i':
		/***********************************/
		printcnt = 1;
		if (getNum())
		{
			iloc = num;
			if (getNum()) printcnt = num;
		}
		if (!atEOL())
			printf("Instruction locations?\n");
		else
		{
			while ((iloc >= 0) && (iloc < IADDR_SIZE)
				&& (printcnt > 0))
			{
				writeInstruction(iloc);
				iloc++;
				printcnt--;
			}
		}
		break;

	case 'd':
		/***********************************/
		printcnt = 1;
		if (getNum())
		{
			dloc = num;
			if (getNum()) printcnt = num;
		}
		if (!atEOL())
			printf("Data locations?\n");
		else
		{
			while ((dloc >= 0) && (dloc < DADDR_SIZE)
				&& (printcnt > 0))
			{
				printf("%5d: %5d\n", dloc, dMem[dloc]);
				dloc++;
				printcnt--;
			}
		}
		break;

	case 'c':
		/***********************************/
		iloc = 0;
		dloc = 0;
		stepcnt = 0;
		for (regNo = 0; regNo < NO_REGS; regNo++)
			reg[regNo] = 0;
		dMem[0] = DADDR_SIZE - 1;
		for (loc = 1; loc < DADDR_SIZE; loc++)
			dMem[loc] = 0;
		break;

	case 'q': return FALSE;  /* break; */

	default: printf("Command %c unknown.\n", cmd); break;
	}  /* case */
	
	stepResult = srOKAY;
	if (stepcnt > 0)
	{
		if (cmd == 'g')
		{
			stepcnt = 0;
			while (stepResult == srOKAY)
			{
				iloc = reg[PC_REG];
				if (traceflag) writeInstruction(iloc);
				stepResult = stepTM();
				stepcnt++;
			}
			if (icountflag)
				printf("Number of instructions executed = %d\n", stepcnt);
		}
		else
		{
			while ((stepcnt > 0) && (stepResult == srOKAY))
			{
				iloc = reg[PC_REG];
				if (traceflag) writeInstruction(iloc);
				stepResult = stepTM();
				stepcnt--;
			}
		}
		printf("%s\n", stepResultTab[stepResult]);
	}
	return TRUE;
} /* doCommand */


 float flt_from_integer(int c){
	float ret = *(float *)(&c);
	return ret;
}

 float flt_from_reg(int r)
{
	float flt = flt_from_integer(reg[r]);
	return flt;
}

  int int_from_flt(float x)
 {
	 int ret = *(int *)(&x);
	 return ret;
 }

   STEPRESULT do_operand_flt(int r, float lhs, float rhs, char op){
	  operand_proc(op, int_from_flt);
  }

   STEPRESULT do_operand_int(int r, int lhs, int rhs, char op){
	  operand_proc(op, (int));
  }


   STEPRESULT do_neg_op(int r)
   {
	   float flt;
	   switch (r)
	   {
	   case ac:
	   case ac1:
		   reg[r] = -reg[r];
		   break;
	   case fac:
	   case fac1:
		   flt = flt_from_reg(r);
		   reg[r] = int_from_flt(-flt);
		   break;
	   }
	   return srOKAY;
   }

    STEPRESULT operand(int r, int s, int t, char op)
   {
	   assert(same_reg_type(r, s) && same_reg_type(s, t));
	   float flt_s, flt_t;
	   switch (r)
	   {
	   case ac:
	   case ac1:
		   //int operation
		   return do_operand_int(r, reg[s], reg[t], op);
		   break;
	   case fac:
	   case fac1:
		   //float to int
		   flt_s = flt_from_reg(s);
		   flt_t = flt_from_reg(t);
		   return do_operand_flt(r, flt_s, flt_t, op);
		   break;
	   default:
               assert(!"undefined type for operand");
               return  srHALT;
               break;
       }

}

void convert(int reg1, int reg2)
{
		if (same_reg_type(reg1, reg2))
		{
			reg[reg2] = reg[reg1];
			return;
		}
		float flt;
		switch (reg1)
		{
		case ac:
		case ac1:
			assert(reg2 == fac || reg2 == fac1);
			//int to float
			flt = reg[reg1];
			reg[reg2] = int_from_flt(flt);
			break;
		case fac:
		case fac1:
			assert(reg2 == ac || reg2 == ac1);
			//float to int
			flt = flt_from_reg(reg1);
			reg[reg2] = flt;
			break;
		default:
			reg[reg2] = reg[reg1];
			break;
		}

	}



 int same_reg_type(int reg1, int reg2)
{
	return reg_type(reg1) == reg_type(reg2);
}

