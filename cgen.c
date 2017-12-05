#include "globals.h"
#include "symtable.h"
#include "code.h"
#include "cgen.h"
#include "util.h"
#include "tinytype.h"
#include "assert.h"
#include "analyze.h"

typedef void(*emitFunc)(int, int, int);
#define checkInAdressMode() (in_adress_mode)

#define TRY_ADRESS_MODE(tree,proc) do {\
restoreAdressMode();\
if (is_basic_type(tree->converted_type, Pointer)){\
	proc; \
}\
else{\
	setInAdressMode(); \
	proc; \
	emitRM("PUSH", ac, 0, mp, "sotre lhs adress");\
	restoreAdressMode(); \
}\
}while(0)


/* tmpOffset is the memory offset for temps
 It is decremented each time a temp is
 stored, and incremeted when loaded again
*/


static bool in_adressMode = FALSE;
static char * current_function = NULL;
static int  genLabel();
static void emitLabel(int);
static void emitGoto(int);

static void cgen_assign(TreeNode *,TreeNode *,int);
static void cGenPushTemp(int size, int tar, int ori, int adress_reg);

static void __cGenST(int , int , int );
static void __cGenPUSH(int ,int, int );
static void __cgenPopFromTemp(int, int, int,int, emitFunc);
static void cgenCopyObj(int origin_reg, int target_reg, int offset, int target_adress_reg)
{
	__cgenPopFromTemp(origin_reg, target_reg, offset, target_adress_reg, __cGenST);
}
static void cgenPushObj(int origin_reg, int target_reg, int offset)
{
	__cgenPopFromTemp(origin_reg, target_reg, offset, sp, __cGenPUSH);
}
static void cGen(TreeNode * tree, int scope,int start_label,int end_label,bool in_adress_mode);
static void cGenInAdressMode(TreeNode * tree, int scope, int start_label, int end_label);
void cGenInValueMode(TreeNode * tree, int scope, int start_label, int end_label);
/*function used to get the relative register of specific type  */
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
void restoreAdressMode();
int look_label(int start_label,int end_label);// find the label representing the adress

/* Procedure genStmt generates code at a statement node */
static void genStmt( TreeNode * tree,int scope,int start_label,int end_label, bool in_adress_mode)
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
            cGenInValueMode(p1,scope + 1,start_label,end_label);
            savedLoc1 = emitSkip(2) ;
            emitComment("if: jump to else");
            /* recurse on then part */
			cGenInValueMode(p2, scope + 1, start_label, end_label);
            savedLoc2 = emitSkip(1);
            emitComment("if: jump to end");
            currentLoc = emitSkip(0) ;
            emitBackup(savedLoc1) ;
			// we know the condition value is used as bool, so conversion is uncessary
			emitRM("POP", ac, 0, mp, "pop the condition value");
            emitRM_Abs("JEQ",ac,currentLoc,"if: jmp to else");
            emitRestore() ;
            /* recurse on else part */
			cGenInValueMode(p3, scope + 1, start_label, end_label);
            currentLoc = emitSkip(0) ;
            emitBackup(savedLoc2);
            emitRM_Abs("LDA",pc,currentLoc,"jmp to end") ;
            emitRestore() ;
            if (TraceCode)  emitComment("<- if") ;
            break; /* if_k */
            
        case RepeatK:/*gen code for while statement*/
            if (TraceCode) emitComment("-> repeat");
			int new_start_label = genLabel();// the label before repeat
			int new_end_label = genLabel();
			emitLabel(new_start_label);// generate start label

			p1 = tree->child[0];
			p2 = tree->child[1];
            emitComment("repeat: jump after body comes back here");
			savedLoc2 = emitSkip(0);

			cGenInValueMode(p1, scope + 1, new_start_label, new_end_label);// create code for test
			savedLoc1 = emitSkip(1);
			/* generate code for body */
			cGenInValueMode(p2, scope + 1, new_start_label, new_end_label);
			currentLoc = emitSkip(0);
			emitRM("LDA", pc, (savedLoc2 - (currentLoc + 1)), pc, "unconditional jmp");
			currentLoc = emitSkip(0);
            emitBackup(savedLoc1);
            emitRM_Abs("JEQ",ac,currentLoc,"repeat: jmp to the out of while");
            emitRestore();
			emitLabel(new_end_label);// generate a label
			if (TraceCode)  emitComment("<- repeat") ;
            break; /* repeat */
		case BreakK:
			emitGoto(start_label);
			break;
		case ContinueK:
			emitGoto(start_label);
			break;
        case ReadK:
            loc = st_lookup(tree->attr.name);
			type = st_lookup_type(tree->attr.name);
			//todo, optimize follow code. DRY
			emitRO("IN", get_reg(getBasicType(type)), 0, 0, "read integer/float value");
			emitRM("ST", get_reg(getBasicType(type)), loc, gp, "assign: store value");//mem[reg[gp]+loc] =  reg[ac]
			break;
    
		case WriteK:
            /* generate code for expression to write */
			cGenInValueMode(tree->child[0], scope, start_label, end_label);
			type = tree->child[0]->type;
			emitRM("POP", get_reg(getBasicType(type)), 0, mp, "move result to register");
			emitRO("OUT", get_reg(getBasicType(type)), 0, 0, "output value in register[ac / fac]");
            break;
		case ReturnK:
			if (tree->child[0] != NULL) 
			{ 
				cGenInValueMode(tree->child[0], scope, start_label, end_label);
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
				// warnning: pop param is executed in outside

				//addFunctionType(tree->attr.name, new_func_type(tree));
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
				
				cGenInValueMode(tree->child[1], scope + 1, start_label, end_label);// generate code for the function body,insert local variable
				deleteParams(tree->child[0], scope + 1);
				deleteVarOfField(tree->child[1], scope + 1);

				//todo this should be moved to return node
				emitRO("MOV", sp, fp, 0, "restore the caller sp");// restore the sp;reg[sp] = reg[fp]
				emitRM("LD", fp, 0, fp, "resotre the caller fp");//resotre the fp;reg[fp] = dMem[reg[fp]]
				emitRO("RETURN", 0, -1, sp, "return to adress : reg[fp]+1");// execute reg[pc] = return adress
				emitComment("function end");
				int leave_adress = emitSkip(0);
				emitBackup(skip_adress);
				emitRM_Abs("LDA",pc,leave_adress,"skip the function body");
				emitRestore();
				current_function = last_current;
			}
			else if (scope > 0 && !is_basic_type(tree->type,Func))//local variable
			{
				insertNode(tree, scope);
				int vsize = var_size_of(tree);
				emitRM("LDA",sp,-vsize,sp,"stack expand");
			}

			// int x = 1
			if (tree->child[2] != NULL){
				cgen_assign(tree, tree->child[2], scope);
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
static void genExp( TreeNode * tree,int scope,int start_label,int end_label,bool in_adress_mode)
{
	int loc;
	TokenType op;
    TreeNode * p1, * p2;
	TypeInfo type = tree->converted_type;
	int integer;
	float float_num;
	int vsize = 0;
	int origin_reg = -1, target_reg = -1;
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
			
			if (checkInAdressMode())
			{
				emitRM("LDA", ac, loc, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id adress");// reg[ac] = Mem[reg[gp] + loc]			
				emitRM("PUSH", ac, 0, mp, "push array adress to mp");
			}
			else if (is_basic_type(tree->converted_type, Array))
			{
				emitRM("LDA", ac, loc, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id adress");// reg[ac] = Mem[reg[gp] + loc]			
				emitRM("PUSH", ac, 0, mp, "push array adress to mp");
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
			popParam(p);
			
			// ensure the function need to 
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
				cGenInValueMode(p1, scope, start_label, end_label);
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
					cGenInAdressMode(p1, scope, start_label, end_label);
					//loc = st_lookup(p1->attr.name);
					//emitRO("LDA", ac, loc, get_stack_bottom(st_lookup_scope(p1->attr.name)),"LDA the var adress");
					//emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
				case UNREF:
					// todo remove the bad smell
					// todo support *(&p)
					assert(p1 != NULL);
					if (checkInAdressMode())
					{
						cGenInValueMode(p1, scope, start_label, end_label);
						emitRM("POP", ac, 0, mp, "pop the adress");
					}
					else
					{
						cGenInValueMode(p1, scope, start_label, end_label);
						emitRM("POP", ac, 0, mp, "pop the adress");
						vsize = var_size_of(tree);
						TypeInfo ptype = *p1->converted_type.point_type.pointKind;
						TypeInfo ptype_ori = *p1->type.point_type.pointKind;
						target_reg = get_reg1(ptype.typekind);
						origin_reg = get_reg1(ptype_ori.typekind);
						cGenPushTemp(vsize, target_reg, origin_reg, ac);
					}
					break;
				default:
                    assert(!"not implemented single op");
                    break;
			}
            if (TraceCode) emitComment("<-Single Op");

			break;
		case AssignK:
			if (TraceCode) emitComment("-> assign");
			cgen_assign(tree->child[0], tree->child[1], scope);
			if (!tree->empty_exp)
			{
				// generate value for write  x = y
				setInAdressMode();
				cGenInValueMode(tree->child[0], scope, start_label, end_label);
				restoreAdressMode();
				cGenPushTemp(
					var_size_of(tree),
					get_reg1(tree->converted_type.typekind),
					get_reg1(tree->type.typekind),
					ac);
			}
			if (TraceCode)  emitComment("<- assign");
			break; /* assign_k */
		case IndexK:
			if (TraceCode) emitComment("->index k");
			
			vsize = var_size_of(tree);
			// todo skip the adress
			bool adress_mode = checkInAdressMode() || \
				 is_basic_type(tree->converted_type, Array);

			if (is_basic_type(tree->child[0]->converted_type, Pointer)){
				cGenInValueMode(tree->child[0], scope,start_label,end_label);
			}
			else{
				cGenInAdressMode(tree->child[0], scope, start_label, end_label);
			}

			cGenInValueMode(tree->child[1], scope,start_label,end_label);
			emitRM("POP", ac, 0, mp, "load index value to ac");
			emitRO("LDC", ac1, vsize, 0, "load array size");
			emitRO("MUL", ac, ac1, ac, "compute the offset");

			emitRM("POP", ac1, 0, mp, "load lhs adress to ac1");
			emitRO("ADD", ac, ac, ac1, "compute the real index adress a[index]");
			
			if (!adress_mode)
			{
				origin_reg = get_reg1(getBasicType(tree->type));
				target_reg = get_reg1(getBasicType(tree->converted_type));
				cGenPushTemp(vsize, target_reg, origin_reg, ac);
			}
			else
			{
				emitRM("PUSH", ac, 0, mp, "push the adress mode into mp");
			}
			break;
		case PointK:
			if (!checkInAdressMode())
			{
				cGenInAdressMode(tree->child[0], scope,start_label,end_label);//generate the adress
				getRealAdressBy(tree);
				emitRM("POP", ac, 0, mp, "load adress from mp");
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
			}
			else
			{
				// copy from memory to memory
				cGenInAdressMode(tree->child[0], scope,start_label,end_label);//generate the adress
				getRealAdressBy(tree);
			}
			break;
		case OpK :
            if (TraceCode) emitComment("-> Op") ;
            p1 = tree->child[0];
            p2 = tree->child[1];
			/* gen code for ac = left arg */
			cGenInValueMode(p1, scope, start_label, end_label);
			cGenInValueMode(p2, scope, start_label, end_label);
			// todo
			if (is_basic_type(tree->converted_type, Pointer))
			{
				int vsize = vsize = var_size_of(tree);
				switch (tree->attr.op)

				{
				case PLUS:
					emitRM("POP", ac, 0, mp, "load index value to ac");
					emitRO("LDC", ac1, vsize, 0, "load pointkind size");
					emitRO("MUL", ac, ac1, ac, "compute the offset");

					emitRM("POP", ac1, 0, mp, "load lhs adress to ac1");
					emitRO("ADD", ac, ac, ac1, "compute the real index adress a[index]");
					emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
					break;
				}
				return;
			}
			

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
				case PLUSASSIGN:
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
static void cGen( TreeNode * tree,int scope,int start_label,int end_label,bool in_adress_mode)
{ if (tree != NULL)
	{ 
		switch (tree->nodekind) 
		{
			case StmtK:
				genStmt(tree,scope,start_label,end_label,in_adress_mode);			
				break;
			case ExpK:
				genExp(tree,scope,-1,-1,in_adress_mode);
				break;
			default:
				break;
		}
		cGen(tree->sibling,scope,start_label,end_label,false);
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
	cGen(syntaxTree,0,-1,-1,false);
	
	
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

void emitLabel(int label)
{
	assert(label >= 0);
	emitRO("LABEL", label++, 0, 0, "generate label");// finish
}

void emitGoto(int label)
{
	assert(label >= 0 );
	emitRO("GO", label, 0, 0, "go to label");// finish
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
	genExp(e, scope,-1,-1,false);// very important! cannot use cGen to avoid cGen generate exp list automatically

	int exp_reg = get_reg(getBasicType(e->converted_type));
	int par_reg = get_reg(getBasicType(p->type));
	int vsize = var_size_of(e);
	// todo support struct pass
	//cgenPushObj(exp_reg, par_reg, vsize);

	while (vsize--){
		emitRM("POP", exp_reg, 0, mp, "pop exp ");
		emitRO("MOV", par_reg, exp_reg, 0, "");
		emitRM("PUSH", par_reg, 0, sp, "push parameter into stack");
	}
}
/*pop parameters*/
void popParam(ParamNode * p)
{
	int param_size = 0;
	while (p != NULL)
	{
		param_size += var_size_of_type(p->type);
		p = p->next_param;
	}

	emitRM("LDA",sp, param_size, sp, "pop parameters");
}

void setInAdressMode()
{
	in_adressMode = TRUE;
}

void restoreAdressMode()
{
	in_adressMode = FALSE;
}

// compute and store Adress of A.x in ac
void getRealAdressBy( TreeNode* tree)
{
	StructType stype = getStructType(tree->child[0]->type.sname);
	Member* member = getMember(stype, tree->attr.name);
	int loc = member->offset;
	emitRO("POP", ac1, 0, mp, "load adress of lhs struct");
	emitRO("LDC", ac, loc, 0, "load offset of member");
	emitRO("ADD", ac, ac, ac1, "compute the real adress if pointK");
	emitRM("PUSH", ac, 0, mp, "");
}

void cgen_assign(TreeNode * left,TreeNode * right,int scope)
{
	cGenInValueMode(right, scope, -1, -1);// load value 

	// emit COPY tmp to dMem[reg[(gp or fp) + loc] from tmpOffset(in reverse) vsize bytes
	int origin_reg = get_reg(getBasicType(right->converted_type));
	int target_reg = get_reg(getBasicType(left->converted_type));
	int vsize = var_size_of(left);

	if (isExp(left,IdK) || isStmt(left,DeclareK))
	{
		char * name = left->attr.name;
		int loc = st_lookup(name);// get the memory location of identifier
		int var_stack_bottom = get_stack_bottom(st_lookup_scope(name));
		emitRM("LDA", ac1, loc, var_stack_bottom, "move the adress of ID");
	}
	else if (isExp(left, SingleOpK))
	{
		//  *..p = ffff 
		// todo run in the adress mode

		assert(left->attr.op == UNREF || !"illegal left operand on assign");
		cGenInValueMode(left->child[0], scope, -1, -1);
		emitRM("POP", ac1, 0, mp, "move the adress of referenced");
	}
	else if (isExp(left, IndexK) || isExp(left,PointK))
	{
		// todo: optimize the code: IndexK should run in the AdressMode
		cGenInAdressMode(left, scope, -1, -1);
		emitRM("POP", ac1, 0, mp, "move the adress of referenced");
	}
	cgenCopyObj(origin_reg, target_reg, vsize, ac1);
}

void cGenPushTemp(int vsize, int target_reg, int origin_reg, int adress_reg)
{
	for (int loc = 0; loc < vsize; ++loc)
	{
		// todo optimize : move memory to memory
		emitRM("LD", target_reg, loc, adress_reg, "load bytes");//
		emitRO("MOV", target_reg, origin_reg, 0, "move between reg");
		emitRM("PUSH", target_reg, 0, mp, "push bytes ");
	}
}

void cGenInAdressMode(TreeNode * tree, int scope, int start_label, int end_label){
	cGen(tree, scope, start_label, end_label, true);
}

void cGenInValueMode(TreeNode * tree, int scope, int start_label, int end_label){
	cGen(tree, scope, start_label, end_label, false);
}


//pop and do something
void __cgenPopFromTemp(int origin_reg, int target_reg, int offset,int adress_reg, emitFunc f)
{
	while (offset-- > 0)
	{
		emitRM("POP", origin_reg, 0, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
		emitRO("MOV", target_reg, origin_reg, 0, "copy bytes");
		f(target_reg, offset, adress_reg);// do something
	}
}

void __cGenST(int target_reg, int offset, int target_adress_reg)
{
	emitRM("ST", target_reg, offset, target_adress_reg, "copy bytes");
}

void __cGenPUSH(int target_reg,int offset, int target_adress_reg)
{
	emitRM("PUSH", target_reg, 0, target_adress_reg, "PUSH bytes");
}

