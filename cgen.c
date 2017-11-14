/****************************************************/
/* File: cgen.c                                     */
/* The code generator implementation                */
/* for the TINY compiler                            */
/* (generates code for the TM machine)              */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "symtable.h"
#include "code.h"
#include "cgen.h"
#include "util.h"
#include "tinytype.h"
#include "assert.h"
#include "analyze.h"

#define TRY_ADRESS_MODE(tree,proc) do {\
if (is_basic_type(tree->converted_type, Pointer)){\
	proc; \
}\
else{\
	setInAdressMode(); \
	proc; \
	restoreAdressMode(); \
}\
}while(0)




/* tmpOffset is the memory offset for temps
 It is decremented each time a temp is
 stored, and incremeted when loaded again
 */
static int label_table[1024];//label table
static bool in_adressMode = FALSE;
static char * current_function = NULL;
static int  genLabel();
static void addLabel();// add label to the labelTabel
int look_label(int label);// find the label representing the adress

/* prototype for internal recursive code generator */
static void cGen (TreeNode * tree,int scope);
/*function used to get the relative register  */
static int get_reg(Type type);
static int get_reg1(Type type);
/*get the current env's stack*/
static int get_stack_bottom(int scope);
static void pushParam(TreeNode * t,ParamNode * p, int scope);
static void popParam(ParamNode * p);

// help
// get the A.x from tmpOffset
static void getRealAdressBy(TreeNode* tree);

void setInAdressMode();
bool checkInAdressMode();
void restoreAdressMode();

/* Procedure genStmt generates code at a statement node */
static void genStmt( TreeNode * tree,int scope)
{
    TreeNode * p1, * p2, * p3;
    int savedLoc1,savedLoc2,currentLoc;
    int loc;
	TypeInfo type;
    switch (tree->kind.stmt)
	{            
        case IfK :
            if (TraceCode) emitComment("-> if");
            p1 = tree->child[0] ;
            p2 = tree->child[1] ;
            p3 = tree->child[2] ;
            /* generate code for test expression */
            cGen(p1,scope+1);
            savedLoc1 = emitSkip(1) ;
            emitComment("if: jump to else belongs here");
            /* recurse on then part */
            cGen(p2,scope+1);
            savedLoc2 = emitSkip(1);
            emitComment("if: jump to end belongs here");
            currentLoc = emitSkip(0) ;
            emitBackup(savedLoc1) ;
			// we know the condition value is used as bool, so conversion is uncessary
			emitRM("POP", ac, 0, mp, "pop the condition value");
            emitRM_Abs("JEQ",ac,currentLoc,"if: jmp to else");
            emitRestore() ;
            /* recurse on else part */
            cGen(p3,scope+1);
            currentLoc = emitSkip(0) ;
            emitBackup(savedLoc2);
            emitRM_Abs("LDA",pc,currentLoc,"jmp to end") ;
            emitRestore() ;
            if (TraceCode)  emitComment("<- if") ;
            break; /* if_k */
            
        case RepeatK:/*gen code for while statement*/
            if (TraceCode) emitComment("-> repeat");
			p1 = tree->child[0];
			p2 = tree->child[1] ;
            emitComment("repeat: jump after body comes back here");
			savedLoc2 = emitSkip(0);
			cGen(p1,scope + 1);// create code for test
			savedLoc1 = emitSkip(1);
			/* generate code for body */
			cGen(p2,scope + 1);
			currentLoc = emitSkip(0);
			emitRM("LDA", pc, (savedLoc2 - (currentLoc + 1)), pc, "unconditional jmp");
			currentLoc = emitSkip(0);
            emitBackup(savedLoc1);
            emitRM_Abs("JEQ",ac,currentLoc,"repeat: jmp to the out of while");
            emitRestore();
            if (TraceCode)  emitComment("<- repeat") ;
            break; /* repeat */
                  
        case ReadK:
            loc = st_lookup(tree->attr.name);
			type = st_lookup_type(tree->attr.name);
			//todo, optimize follow code. DRY
			emitRO("IN", get_reg(getBasicType(type)), 0, 0, "read integer/float value");
			emitRM("ST", get_reg(getBasicType(type)), loc, gp, "assign: store value");//mem[reg[gp]+loc] =  reg[ac]
			break;
    
		case WriteK:
            /* generate code for expression to write */
			cGen(tree->child[0], scope);
			type = tree->child[0]->type;
			emitRM("POP", get_reg(getBasicType(type)), 0, mp, "move result to register");
			emitRO("OUT", get_reg(getBasicType(type)), 0, 0, "output value in register[ac / fac]");
            break;
		case ReturnK:
			if (tree->child[0] != NULL) 
			{ 
				cGen(tree->child[0], scope);
				// now the result is in the ac or fac or tmpOffset according to the type 
				TypeInfo ctype = tree->child[0]->converted_type;
				TypeInfo return_type = getFunctionType(current_function).return_type;
				assert(ctype.typekind != Struct);
				
				// convert the type!
				// todo : construct the function copy_tmpOffset_to_register(origin_type,target_type)
				emitRM("POP", get_reg(getBasicType(ctype)), 0, mp, "op: POP left");
				emitRO("MOV", get_reg(getBasicType(return_type)), get_reg(getBasicType(ctype)), 0, "move register reg(s) tp reg(r)");
				emitRM("PUSH", get_reg(getBasicType(return_type)), 0, mp, "op: push left");
			}
			//todo // support label, so the function can retrun directly
			emitRO("MOV", sp, fp, 0, "restore the caller sp");// restore the sp;reg[sp] = reg[fp]
			emitRM("LD", fp, 0, fp, "resotre the caller fp");//resotre the fp;reg[fp] = dMem[reg[fp]]
			emitRO("RETURN", 0, -1, sp, "return to the caller");
			break;
		
		case DeclareK:
			/*deal with the function  */
			if (scope == 0 && is_basic_type(tree->type,Func)) 
			{
				emitComment("function entry");
				insertParam(tree->child[0], scope + 1);
				addFunctionType(tree->attr.name, new_func_type(tree));
				char * last_current = current_function;
				current_function = tree->attr.name;

				int skip_adress = emitSkip(1);
				// load function adress
				setFunctionAdress(tree->attr.name, emitSkip(0));
				// assume the caller  move return adress in reg[ac]
				emitRO("MOV", ac1, fp, 0,"store the caller fp temporarily");// store the caller fp
				emitRO("MOV", fp,  sp, 0, "exchang the stack(context)");//reg[fp] = reg[sp]

				emitRM("PUSH", ac1, 0, sp, "push the caller fp");//dMem[reg[sp]--] = ac1 
				emitRM("PUSH", ac,  0, sp, "push the return adress");// dMem[reg[sp]--] = return adress;assume the caller sotre the return adress reg[pc] in reg[ac]
						
				cGen(tree->child[1], scope + 1);// generate code for the function body,insert local variable
				
				//todo this should be moved to return node
				emitRO("MOV", sp, fp, 0, "restore the caller sp");// restore the sp;reg[sp] = reg[fp]
				emitRM("LD", fp, 0, fp, "resotre the caller fp");//resotre the fp;reg[fp] = dMem[reg[fp]]
				emitRO("RETURN", 0, -1, sp, "return to adress : reg[fp]+1");// execute reg[pc] = return adress
				emitComment("function end");
				int leave_adress = emitSkip(0);
				emitBackup(skip_adress);
				emitRM_Abs("LDA",pc,leave_adress,"skip the function body");
				emitRestore();
				//deleteVarOfField(tree->child[1], scope + 1);
				//deleteVarOfField (tree->child[0], scope + 1);
				//deleteFuncType(tree->attr.name);
				current_function = last_current;
			}
			else if (scope > 0 && !is_basic_type(tree->type,Func))//local variable
			{
				insertNode(tree, scope);
				emitRM("PUSH",0,0,sp,"stack expand");// todo support expand stack
			}
			break;
		case StructDefineK:
//			addStructType(tree->attr.name,new_struct_type(tree->child[0]));
			break;
        default:
            break;
    }
} /* genStmt */

/* Procedure genExp generates code at an expression node */
static void genExp( TreeNode * tree,int scope)
{
	int loc;
	TokenType op;
    TreeNode * p1, * p2;
	TypeInfo type = tree->converted_type;
	int integer;
	float float_num;
	int vsize = 0;
	int origin_reg, target_reg;
	switch (tree->kind.exp) 
	{       
        case ConstK :
            if (TraceCode) emitComment("-> Const") ;
            /* gen code to load integer constant using LDC */
            switch (getBasicType(type)) 
			{
			case Integer:
				 integer = integer_from_node(tree);
				 emitRM("LDC", ac, integer, 0, "load integer const");// reg[ac] = tree->ttr.val.integer
				 emitRM("PUSH", ac, 0, mp,"store exp");
				 break;
			case Float:
				 float_num = float_from_node(tree);
				 emitLDCF("LDC", fac, float_num, 0, "load float const");// reg[ac] = tree->ttr.val.integer
				 emitRM("PUSH", fac,0, mp, "store exp");
				 break;
			default:
				assert(!"BUG in ConstK,unknwon expression type");
				break;
			}
            if (TraceCode)  emitComment("<- Const") ;
            break; /* ConstK */
          
        case IdK :
            if (TraceCode) emitComment("-> Id");
            loc = st_lookup(tree->attr.name);
			
			if (checkInAdressMode() || is_basic_type(tree->converted_type,Array))
			{
				restoreAdressMode();
				emitRM("LDA", ac, loc, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id adress");// reg[ac] = Mem[reg[gp] + loc]			
			}
			else
			{
				int vsize = var_size_of(tree);
				
				for (int i = 0; i < vsize; ++i)
				{
					emitRM("LD", get_reg(getBasicType(tree->type)), loc + i, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id value");// reg[ac] = Mem[reg[gp] + loc]			
					emitRO("MOV", get_reg(getBasicType(type)), get_reg(getBasicType(tree->type)), 0, "move from one reg(s) to reg(r)");// tiny machine wuold analyze the instruction 
					emitRM("PUSH", get_reg(getBasicType(type)), 0, mp, "store exp");
				}
			}
			if (TraceCode)  emitComment("<- Id");
            break; /* IdK */
		case FuncallK:
			//todo :tail recursion optimize
			assert(tree->attr.name != NULL);
			TreeNode *e = tree->child[0];
			FuncType ftype = getFunctionType(tree->attr.name);
			ParamNode *p = ftype.params;
			pushParam(e, p, scope + 1);

			loc = getFunctionAdress(tree->attr.name);
			emitRM("LDA", ac, 1, pc, "store the return adress");
			emitRM("LDC", pc, loc, 0, "ujp to the function body");
			// after gen the exp
			popParam(p);
			// convert the type of return_type and converted_type
			
			if (!is_basic_type(tree->type,Void) )
			{
				origin_reg = get_reg(getBasicType(tree->type));
				target_reg = get_reg(getBasicType(tree->converted_type));
				if (origin_reg != target_reg) 
				{
					emitRM("POP", origin_reg, 0, mp, "");
					emitRO("MOV", target_reg, origin_reg, mp, "convert tmpOffset");// reg[ac] = Mem[reg[gp] + loc]
					emitRM("PUSH", target_reg, 0, mp, "store exp");
				}
			}
			break;
		case SingleOpK:
			if (TraceCode) emitComment("->Single Op");
			p1 = tree->child[0];
			// todo optimize following code. bad smell
			// if the p1 is a struct and op is unref, the size is more than 1;
			if (tree->attr.op != ADRESS && tree->attr.op != UNREF)
			{
				cGen(p1, scope);
				origin_reg = get_reg(getBasicType(p1->converted_type));
				target_reg = get_reg(getBasicType(type));
				emitRM("POP", origin_reg, 0, mp, "pop right");
				emitRO("MOV", target_reg, origin_reg, 0, "convert type");
			}

			switch (tree->attr.op)
			{
                case NEG:
                    emitRO("NEG", target_reg, 0, 0, "single op (-)");// fac = -fac || ac = -ac
                    emitRM("PUSH", target_reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
                    break;
				case ADRESS:
					// todo support &p[1][2] || &(*(xxxx))
					loc = st_lookup(p1->attr.name);
					emitRO("LDA", ac, loc, get_stack_bottom(st_lookup_scope(p1->attr.name)),"LDA the var adress");
					emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
				case UNREF:
					// todo remove the bad smell
					// todo support *(&p)
					assert(p1 != NULL);
					if (checkInAdressMode())
					{
						restoreAdressMode();
						cGen(p1, scope);
						emitRM("POP", ac, 0, mp, "pop the adress");
					}
					else
					{
						cGen(p1, scope);
						emitRM("POP", ac, 0, mp, "pop the adress");
						vsize = var_size_of(p1);
						for (loc = 0; loc < vsize; ++loc)
						{
							TypeInfo ptype = *p1->converted_type.point_type.pointKind;
							bool is_basic = is_basic_type(ptype, Integer) || is_basic_type(ptype, Float);
							target_reg = is_basic ? get_reg1(ptype.typekind) : ac1;

							// todo optimize : move memory to memory
							emitRM("LD", target_reg, loc, ac, "load bytes");//
							emitRM("PUSH", target_reg, 0, mp, "push bytes ");
						}
					}
					break;
				default:
                    assert(!"not implemented single op");
                    break;
			}
			break;
		case AssignK:
			if (TraceCode) emitComment("-> assign");
			cGen(tree->child[1], scope);// load value 
			// emit COPY tmp to dMem[reg[(gp or fp) + loc] from tmpOffset(in reverse) vsize bytes
			// todo optimize the code :bad smell
			TypeInfo exp_type = tree->child[1]->converted_type;

			int origin_reg = get_reg(getBasicType(exp_type));
			vsize = 1;
			if (tree->child[0]->kind.exp == IdK)
			{
				char * name = tree->child[0]->attr.name;
				type = st_lookup_type(name);
				int target_reg = get_reg(getBasicType(type));

				vsize = var_size_of(tree);
				loc = st_lookup(name);// get the memory location of identifier
				int var_stack_bottom = get_stack_bottom(st_lookup_scope(name));
				while (vsize-- > 0)
				{
					// move bytes tmpOffset to dMem[ac]
					// todo optimize
					emitRM("POP", origin_reg, 0, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
					emitRO("MOV", target_reg, origin_reg, 0, "move register ");
					emitRM("ST", target_reg, loc + vsize, var_stack_bottom, "copy bytes ");
				}
			}
			else if (tree->child[0]->kind.exp == SingleOpK && tree->child[0]->attr.op == UNREF)
			{
				/*  *..p = ffff */
				TreeNode *unref = tree->child[0];
				type = unref->type;
				int target_reg = get_reg(getBasicType(type));
				vsize = var_size_of(unref);

				cGen(unref->child[0], scope);				
				emitRM("POP", ac1, 0, mp, "move the adress of referenced");
				while (vsize-- > 0)
				{
					emitRM("POP", origin_reg, 0, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
					emitRO("MOV", target_reg, origin_reg, 0, "move register(convert) ");
					emitRM("ST", target_reg, vsize, ac1, "copy bytes ");
				}
			}
			else if (tree->child[0]->kind.exp == IndexK)
			{
				// analyze.c ensure the left operand is not pointed to array
				// todo: optimize the code: IndexK should run in the AdressMode
				TreeNode *unref = tree->child[0];
				vsize = var_size_of(unref);
				setInAdressMode();
				cGen(unref, scope);
				restoreAdressMode();
				emitRO("MOV", ac1, ac, 0, "move adress to ac1");
				int target_reg = get_reg(getBasicType(unref->converted_type));

				while (vsize-- > 0)
				{
					emitRM("POP", origin_reg, 0, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
					emitRO("MOV", target_reg, origin_reg, 0, "move register(convert) ");
					emitRM("ST", target_reg, vsize, ac1, "copy bytes ");
				}
			
			}
			else if (tree->child[0]->nodekind == ExpK 
					&& tree->child[0]->kind.exp == PointK)
			{
				cGen(tree->child[1], scope);

				setInAdressMode();
				cGen(tree->child[0], scope);
				restoreAdressMode();

				vsize = var_size_of(tree->child[0]);
				type = tree->child[0]->converted_type;
				int target_reg = get_reg(getBasicType(type));
				emitRO("MOV", ac1, ac, 0, "move adress to ac1");
				while (vsize-- > 0)
				{
					emitRM("POP", origin_reg, 0, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
					emitRO("MOV", target_reg, origin_reg, 0, "move register(convert) ");
					emitRM("ST", target_reg, vsize, ac1, "copy bytes ");
				}
			}
			if (TraceCode)  emitComment("<- assign");
			break; /* assign_k */
		case IndexK:
			if (TraceCode) emitComment("->index k");
			vsize = var_size_of(tree);
			// todo skip the adress
			bool adress_mode = checkInAdressMode() \
				|| is_basic_type(tree->converted_type, Array);
			
			restoreAdressMode();// avoid the effect of adress_mode
			TRY_ADRESS_MODE(tree->child[0], do {
				cGen(tree->child[0], scope);
				emitRM("PUSH", ac, 0, mp, "sotre lhs adress");
			} while (0));
			
			cGen(tree->child[1], scope);
			emitRM("POP", ac, 0, mp, "load index value to ac");
			emitRO("LDC", ac1, vsize, 0, "load array size");
			emitRO("MUL", ac, ac1, ac, "compute the offset");

			emitRM("POP", ac1, 0, mp, "load lhs adress to ac1");
			emitRO("ADD", ac, ac, ac1, "compute the real index adress a[index]");
			
			if (!adress_mode)
			{
				origin_reg = get_reg1(getBasicType(tree->type));
				target_reg = get_reg1(getBasicType(tree->converted_type));
				for (int i = 0; i < vsize; ++i)
				{
					// move bytes tmpOffset to tmpOffset
					// todo optimize
					emitRM("LD", origin_reg, i, ac, "copy bytes");//reg[ac] =  dMem[reg[ac]]
					emitRO("MOV", target_reg, origin_reg, 0, "move register ");
					emitRM("PUSH", target_reg, 0, mp, "push a.x value into tmp");
				}
			}
			break;
		case PointK:
			if (!checkInAdressMode())
			{
				setInAdressMode();// enter the adress mode,eg:A.x will only create the adress of A!
				cGen(tree->child[0], scope);//generate the adress
				getRealAdressBy(tree);
				// now need to produce the real value rather than Adress
				origin_reg = get_reg1(getBasicType(tree->type));
				target_reg = get_reg1(getBasicType(tree->converted_type));
				vsize = var_size_of(tree);
				
				for (int i = 0; i < vsize; ++i)
				{
					// move bytes tmpOffset to tmpOffset
					// todo optimize
					emitRM("LD", origin_reg, i, ac, "copy bytes");//reg[ac] =  dMem[reg[ac]]
					emitRO("MOV", target_reg, origin_reg, 0, "move register ");
					emitRM("PUSH", target_reg, 0, mp, "push a.x value into tmp");
				}
				restoreAdressMode();
			}
			else
			{
				// copy from memory to memory
				cGen(tree->child[0], scope);//generate the adress
				getRealAdressBy(tree);
				restoreAdressMode();
			}
			break;
		case OpK :
            if (TraceCode) emitComment("-> Op") ;
            p1 = tree->child[0];
            p2 = tree->child[1];
            /* gen code for ac = left arg */
            cGen(p1,scope);
			cGen(p2, scope);
			
			origin_reg = get_reg(getBasicType(p1->converted_type));
			int origin_reg1 = get_reg1(getBasicType(p2->converted_type));
			int reg = get_reg(getBasicType(type));
			int reg1 = get_reg1(getBasicType(type));

			emitRM("POP", origin_reg1,0,mp,"pop right");
			emitRO("MOV", reg1, origin_reg1, 0, "convert type");
			
			emitRM("POP", origin_reg, 0, mp, "pop left");
			emitRO("MOV", reg, origin_reg, 0, "convert type");

			switch (tree->attr.op) 
			{
                case PLUS :
					emitRO("ADD", reg,reg, reg1, "op +");// ac = ac1 op ac
					emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
                    break;
                case MINUS :
					emitRO("SUB", reg, reg, reg1, "op -");
					emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
                case TIMES :
					emitRO("MUL", reg, reg, reg1, "op *");
					emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
                case OVER :
					emitRO("DIV", reg, reg, reg1, "op /");
					emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
                case LT :
				case GT :
				case LE :
				case GE :
					op = tree->attr.op;
					char op_code[4] = "JLT";

					if (op == LT || op == LE)
					{
						emitRO("SUB", reg, reg, reg1, "op <");
						op_code[2] = (op == LT ? 'T' : 'E');
					}
					else
					{
						emitRO("SUB", reg, reg, reg1, "op <");
						op_code[1] = 'G';
						op_code[2] = (op == GT ? 'T' : 'E');
					}

					/* now the op_code is JLE,JLT,GLE,GLT*/
					emitRM(op_code, ac, 2, pc, "br if true");
					emitRM("LDC", ac, 0, ac, "false case");
					emitRM("LDA", pc, 1, pc, "unconditional jmp");
					emitRM("LDC", ac, 1, ac, "true case");
					emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
                case EQ :
					emitRO("SUB", reg, reg, reg1, "op ==, convertd_type");
					emitRM("JEQ", ac, 2, pc, "br if true");
					emitRM("LDC", ac, 0, ac, "false case" );
					emitRM("LDA", pc, 1, pc, "unconditional jmp");
					emitRM("LDC", ac, 1, ac, "true case");
					emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
                default:
                    emitComment("BUG: Unknown operator");
                    break;
            } /* case op */
            if (TraceCode)  emitComment("<- Op") ;
            break; /* OpK */
            
        default:
            break;
    }
} /* genExp */

/* Procedure cGen recursively generates code by
 * tree traversal
 */
static void cGen( TreeNode * tree,int scope)
{ if (tree != NULL)
	{ 
		switch (tree->nodekind) 
		{
			case StmtK:
				genStmt(tree,scope);			
				break;
			case ExpK:
				genExp(tree,scope);
				break;
			default:
				break;
		}
		cGen(tree->sibling,scope);
	}
}

/**********************************************/
/* the primary function of the code generator */
/**********************************************/
/* Procedure codeGen generates code to a code
 * file by traversal of the syntax tree. The
 * second parameter (codefile) is the file name
 * of the code file, and is used to print the
 * file name as a comment in the code file
 */
void codeGen(TreeNode * syntaxTree, char * codefile)
{ 
	char *s = copyString("File: ");
    strcat(s,codefile);
    emitComment(s);
    /* generate st\andard prelude */
    emitComment("Standard prelude:");
    emitRM("LD",mp,0,ac,"load maxaddress from location 0");//reg[mp] = dMem[reg[ac]] 
    emitRM("ST",ac,0,ac,"clear location 0");// dMem[reg[ac] + 0] = reg[ac]
	
	emitRM("LD", gp, 1, ac, "load gp adress from location 1");
	emitRM("ST", ac, 1, ac, "clear location 1");

	emitRM("LD", fp, 2, ac, "load first fp from location 2");
	emitRM("LD", sp, 2, ac, "load first sp from location 2");
	emitRM("ST", ac, 2, ac, "clear location 2");
    emitComment("End of standard prelude.");
	/* generate code for TINY program */
	cGen(syntaxTree,0);
	
	
	emitComment("call main function");
	int adress = getFunctionAdress("main");
	int endLoc = emitSkip(0) + 2;
	emitRM("LDC", ac, endLoc,0, "store the return adress");
	emitRM("LDC", pc, adress, 0, "ujp to the function body");
	emitRO("HALT", 0, 0, 0, "");// finish

}

int genLabel(void)
{
	static int label = 0;
	return label++; 
}

void addLabel(int label,int pc_loc)
{
	label_table[label] = pc_loc;
}

int look_label(int label)
{
	return label_table[label];
}

int get_reg(Type type)
{
	if (type == Float)
	{
		return fac;
	}
	else if ((type == Integer) || (type == Boolean) ||
			(type == Pointer) || (type == Array) || (type == Struct))
	{
		return ac;
	}
	else
	{
		assert(!"get reg is not implemented for other type");
		return 0;
	}
}

static int get_reg1(Type type)
{
	return get_reg(type) + 1;
}

int get_stack_bottom(int scope)
{
	assert(scope >= 0);
	if (scope == 0) return gp;
	else return fp;
}
// push param from right to left
void pushParam(TreeNode * e,ParamNode * p,int scope)
{
	if (e != NULL)
	{
		pushParam(e->sibling, p->next_param, scope);
	}
	else
    {
		assert(p == NULL);
		return;
	}
	genExp(e, scope);// very important! cannot use cGen to avoid cGen generate exp list automatically

	int exp_reg = get_reg(getBasicType(e->converted_type));
	int par_reg = get_reg(getBasicType(p->type));
	// todo support remove from memory to memory
	// todo support struct pass
	emitRM("POP", exp_reg, 0, mp, "pop exp ");
	emitRO("MOV", par_reg, exp_reg, 0, "");
	emitRM("PUSH", par_reg, 0, sp, "push parameter into stack");
}
/*pop parameters*/
void popParam(ParamNode * p)
{
	int param_size = 0;
	while (p != NULL)
	{
		param_size += 1;
		p = p->next_param;
	}
	emitRM("LDA",sp, param_size, sp, "pop parameters");
}

void setInAdressMode()
{
	in_adressMode = TRUE;
}
bool checkInAdressMode()
{
	return in_adressMode;
}
void restoreAdressMode()
{
	in_adressMode = FALSE;
}

// compute and store Adress of A.x in ac
void getRealAdressBy( TreeNode* tree)
{
	// assure the adress of A  in ac
	StructType stype = getStructType(tree->child[0]->type.sname);
	Member* member = getMember(stype, tree->attr.name);
	int loc = member->offset;
	emitRO("MOV", ac1, ac, 0, "load adress of lhs struct");
	emitRO("LDC", ac, loc, 0, "load offset of member");
	emitRO("ADD", ac, ac, ac1, "compute the real adress if pointK");
	//emitRM("PUSH", ac, 0, mp, "");
}