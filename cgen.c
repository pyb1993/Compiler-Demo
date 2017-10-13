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
#include "tinytype.h"
#include "assert.h"
#include "analyze.h"

/* tmpOffset is the memory offset for temps
 It is decremented each time a temp is
 stored, and incremeted when loaded again
 */
static int tmpOffset = 0;
/* prototype for internal recursive code generator */
static void cGen (TreeNode * tree,int scope);

/*function used to get the relative register  */
static int get_reg(Type type)
{
	if (type == LFloat || type == RFloat)
	{
		return fac;
	}
	else if (is_relative_type(type, LInteger) || is_relative_type(type, LBoolean))
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
/*get the current env's stack*/
static int get_stack_bottom(int scope)
{
    assert(scope >= 0 );
    if(scope == 0) return gp;
    else return fp;
}

// delete all local variable from the stmtseq
static void deleteLocalVar(TreeNode * tree, int scope)
{
	TreeNode * t = tree;
    if(scope > 0) return;
    while (t != NULL)
    {
        switch (t->kind.stmt)
        {
            case DeclareK:
                st_delete(t->attr.name);
                break;
            default:
                break;
        }
    }
}


/* Procedure genStmt generates code at a statement node */
static void genStmt( TreeNode * tree,int scope)
{
    TreeNode * p1, * p2, * p3;
    int savedLoc1,savedLoc2,currentLoc;
    int loc;
	Type type;
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
			cGen(p1,scope+1);// create code for test
			savedLoc1 = emitSkip(1);
			/* generate code for body */
			cGen(p2,scope+1);
			currentLoc = emitSkip(0);
			emitRM("LDA", pc, (savedLoc2 - (currentLoc + 1)), pc, "unconditional jmp");
			currentLoc = emitSkip(0);
            emitBackup(savedLoc1);
            emitRM_Abs("JEQ",ac,currentLoc,"repeat: jmp to the out of while");
            emitRestore();
            if (TraceCode)  emitComment("<- repeat") ;
            break; /* repeat */
        
        case AssignK:
            if (TraceCode) emitComment("-> assign");
			cGen(tree->child[0],scope + 1);// load value in register ac or fac 
			
            loc = st_lookup(tree->attr.name);// get the memory location of identifier
            int var_stack_bottom = get_stack_bottom(st_lookup_scope(tree->attr.name));

			if (tree->kind.exp != FuncallK)
			{
                // deal with the integer or float
                type = st_lookup_type(tree->attr.name);
                emitRO("MOV", get_reg(type), get_reg(tree->child[0]->converted_type), 0, "move register reg(s) tp reg(r)");
				emitRM("ST", get_reg(type), loc, var_stack_bottom, "assign: store value");//dMem[reg[gp]+loc] =  reg[ac]
			}
			else
			{
				// copy  writes from struct to another
				// emit COPY tmp to dMem[reg[(gp or fp) + loc] from tmpOffset(in reverse) vsize bytes
                int vsize = var_size_of(tree);
                while (vsize-- > 0)
                {
                    // move bytes tmpOffset to dMem[ac]
                    emitRM("LD", ac, ++tmpOffset, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
                    emitRM("ST", ac, loc,var_stack_bottom,"copy bytes ");
                }
			}
				if (TraceCode)  emitComment("<- assign");
            break; /* assign_k */
        case ReadK:
            loc = st_lookup(tree->attr.name);
			type = st_lookup_type(tree->attr.name);
			//todo, optimize follow code. DRY
			emitRO("IN", get_reg(type), 0, 0, "read integer/float value");
			emitRM("ST", get_reg(type), loc, gp, "assign: store value");//mem[reg[gp]+loc] =  reg[ac]
			break;
    
		case WriteK:
            /* generate code for expression to write */
			cGen(tree->child[0], scope + 1);
			type = tree->child[0]->type;
			/* now output it */
            emitRO("OUT",get_reg(type),0,0,"output value in register[ac]");
            break;
		
		case DeclareK:
			/*deal with the function  */
			if (scope == 0 && tree->type == Func) 
			{
				insertParam(tree->child[0], scope + 1);
				// load function adress
				setFunctionAdress(tree->attr.name, emitSkip(0));
				emitComment("enter the function");
				// assume the caller  move return adress in reg[ac]
				emitRO("MOV", ac1,fp,0,"store the caller fp temporarily");// store the caller fp
				emitRO("MOV", fp, sp, 0, "exchang the stack(context)");//reg[fp] = reg[sp]

				emitRM("PUSH", ac1, 0, sp, "push the caller fp");//dMem[reg[sp]--] = ac1 
				emitRM("PUSH", ac, 0, sp, "push the return adress");// dMem[reg[sp]--] = return adress;assume the caller sotre the return adress reg[pc] in reg[ac]
				cGen(tree->child[1], scope + 1);// generate code for the function body,insert local variable
				
                //todo support return value
				//todo this should be moved to return node
				emitRO("MOV", sp, fp, 0, "restore the caller sp");// restore the sp;reg[sp] = reg[fp]
				emitRM("LD", fp, 0, fp, "resotre the caller fp");//resotre the fp;reg[fp] = dMem[reg[fp]]
				emitRO("RETURN", 0, -1, sp, "return to adress : reg[fp]+1");// execute reg[pc] = return adress
				emitComment("leave the function");

				deleteLocalVar(tree->child[1], scope + 1);
				deleteNode(tree->child[0], scope + 1);
			}
			else if (scope > 0 && tree->type != Func)//local function
			{
				insertNode(tree, scope);
			}
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
	Type type = tree->converted_type;
	int integer;
	float float_num;
	switch (tree->kind.exp) 
	{       
        case ConstK :
            if (TraceCode) emitComment("-> Const") ;
            /* gen code to load integer constant using LDC */
            switch (type) 
			{
			case RInteger:
				 integer = integer_from_node(tree);
				 emitRM("LDC", ac, integer, 0, "load integer const");// reg[ac] = tree->ttr.val.integer
				break;
			case RFloat:
				 float_num = float_from_node(tree);
				 emitLDCF("LDC", fac, float_num, 0, "load float const");// reg[ac] = tree->ttr.val.integer
				break;
			default:
				assert(!"BUG in ConstK,unknwon expression type");
				break;
			}
            if (TraceCode)  emitComment("<- Const") ;
            break; /* ConstK */
          
        case IdK :
            if (TraceCode) emitComment("-> Id") ;
            loc = st_lookup(tree->attr.name);
			emitRM("LD", get_reg(tree->type), loc, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id value");// reg[ac] = Mem[reg[gp] + loc]
			emitRO("MOV", get_reg(type), get_reg(tree->type), 0, "move from one reg(s) to reg(r)");// tiny machine wuold analyze the instruction 
            if (TraceCode)  emitComment("<- Id") ;
            break; /* IdK */
		case FuncallK:

			//todo :push the paramter into the stack

			//jump to the function body
			emitRM("LDA", ac, 1, pc, "store the return adress");
			loc  = getFunctionAdress(tree->attr.name);
			emitRM("LDC", pc, loc, 0, "ujp to the function body");
			break;
		
		case OpK :
            if (TraceCode) emitComment("-> Op") ;
            p1 = tree->child[0];
            p2 = tree->child[1];
            /* gen code for ac = left arg */
            cGen(p1,scope);
            /* gen code to push left operand */
			emitRM("ST", get_reg(type), tmpOffset--, mp, "op: push left");
            /* gen code for ac = right operand */
			cGen(p2, scope + 1);
			emitRM("LD", get_reg1(type), ++tmpOffset, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
            
			int reg = get_reg(type);
			int reg1 = get_reg1(type);

			switch (tree->attr.op) 
			{
                case PLUS :
					emitRO("ADD", reg,reg1, reg, "op +");// ac = ac1 op ac
                    break;
                case MINUS :
					emitRO("SUB", reg, reg1, reg, "op -");
                    break;
                case TIMES :
					emitRO("MUL", reg, reg1, reg, "op *");
                    break;
                case OVER :
					emitRO("DIV", reg, reg1, reg, "op /");
                    break;
                case LT :
				case GT :
				case LE :
				case GE :
					op = tree->attr.op;
					char op_code[4] = "JLT";

					if (op == LT || op == LE)
					{
						emitRO("SUB", reg, reg1, reg, "op <");
						op_code[2] = (op == LT ? 'T' : 'E');
					}
					else
					{
						emitRO("SUB", reg, reg1, reg, "op <");
						op_code[1] = 'G';
						op_code[2] = (op == GT ? 'T' : 'E');
					}

					/* now the op_code is JLE,JLT,GLE,GLT*/
					emitRM(op_code, ac, 2, pc, "br if true");
					emitRM("LDC", ac, 0, ac, "false case");
					emitRM("LDA", pc, 1, pc, "unconditional jmp");
					emitRM("LDC", ac, 1, ac, "true case");
					break;
                case EQ :
					emitRO("SUB", reg, reg1, reg, "op ==, convertd_type");
					emitRM("JEQ", ac, 2, pc, "br if true");
					emitRM("LDC", ac, 0, ac, "false case" );
					emitRM("LDA", pc, 1, pc, "unconditional jmp");
					emitRM("LDC", ac, 1, ac, "true case");
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
	char * s = malloc(strlen(codefile)+7);
    strcpy(s,"File: ");
    strcat(s,codefile);
    emitComment(s);
    /* generate standard prelude */
    emitComment("Standard prelude:");
    emitRM("LD",mp,0,ac,"load maxaddress from location 0");//reg[mp] = dMem[reg[ac]] 
    emitRM("ST",ac,0,ac,"clear location 0");// dMem[reg[ac] + 0] = reg[ac]
	
	emitRM("LD", gp, 1, ac, "load gp adress from location 1");
	emitRM("ST", ac, 1, ac, "clear location 1");

	emitRM("LD", fp, 2, ac, "load first fp from location 2");
	emitRM("LD", sp, 2, ac, "load first sp from location 2");
	emitRM("ST", ac, 2, ac, "clear location 2");
    emitComment("End of standard prelude.");
	int currentLoc = emitSkip(2);// skip two,the first real instruction must be the main call
	/* generate code for TINY program */
	cGen(syntaxTree,0);
	
	int endLoc = emitSkip(0);
	emitBackup(currentLoc);
	emitComment("call main function");
	int adress = getFunctionAdress("main");
	emitRM("LDC", ac, endLoc,0, "store the return adress");
	emitRM("LDC", pc, adress, 0, "ujp to the function body");
	emitRestore();
	emitRO("HALT", 0, 0, 0, "");// finish

}

