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
/* tmpOffset is the memory offset for temps
 It is decremented each time a temp is
 stored, and incremeted when loaded again
 */
static int tmpOffset = 0;

/* prototype for internal recursive code generator */
static void cGen (TreeNode * tree);

/*function used to get the relative register  */
static int get_reg(Type type){
	if (type == LInteger || type == RInteger){
		return fac;
	}
	else if (type == LFloat || type == RFloat) {
		return ac;
	}
	else{
		assert(!"get reg is not implemented for other type");
		return 0;
	}
}

static int get_reg1(Type type){
	return get_reg(type) + 1;
}

/* Procedure genStmt generates code at a statement node */
static void genStmt( TreeNode * tree)
{
    TreeNode * p1, * p2, * p3;
	Type type = st_lookup_type(tree->attr.name);
    int savedLoc1,savedLoc2,currentLoc;
    int loc;
    switch (tree->kind.stmt) {
            
        case IfK :
            if (TraceCode) emitComment("-> if");
            p1 = tree->child[0] ;
            p2 = tree->child[1] ;
            p3 = tree->child[2] ;
            /* generate code for test expression */
            cGen(p1);
            savedLoc1 = emitSkip(1) ;
            emitComment("if: jump to else belongs here");
            /* recurse on then part */
            cGen(p2);
            savedLoc2 = emitSkip(1);
            emitComment("if: jump to end belongs here");
            currentLoc = emitSkip(0) ;
            emitBackup(savedLoc1) ;
            emitRM_Abs("JEQ",ac,currentLoc,"if: jmp to else");
            emitRestore() ;
            /* recurse on else part */
            cGen(p3);
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
			cGen(p1);// create code for test
			savedLoc1 = emitSkip(1);
			/* generate code for body */
			cGen(p2);
			currentLoc = emitSkip(0);
			emitRM("LDA", pc, (savedLoc2 - (currentLoc + 1)), pc, "unconditional jmp",type);
			currentLoc = emitSkip(0);
            emitBackup(savedLoc1);
            emitRM_Abs("JEQ",ac,currentLoc,"repeat: jmp to the out of while");
            emitRestore();
            if (TraceCode)  emitComment("<- repeat") ;
            break; /* repeat */
        
        case AssignK:
            if (TraceCode) emitComment("-> assign");
            /*	to gen converted_attribute*/
			cGen(tree->child[0]);// load value in register ac or fac 
			emitRO("MOV", get_reg(type), get_reg(tree->converted_type), 0, "move register reg(s) tp reg(r)");
            loc = st_lookup(tree->attr.name);// get the memory location of identifier
			emitRM("ST", get_reg(type), loc, gp, "assign: store value",type);//mem[reg[gp]+loc] =  reg[ac]		
            if (TraceCode)  emitComment("<- assign") ;
            break; /* assign_k */
            
        case ReadK:
            loc = st_lookup(tree->attr.name);
			//todo, optimize follow code. DRY
			emitRO("IN", get_reg(type), 0, 0, "read integer/float value",type);
			emitRM("ST", get_reg(type), loc, gp, "assign: store value",type);//mem[reg[gp]+loc] =  reg[ac]
			break;
        case WriteK:
            /* generate code for expression to write */
            cGen(tree->child[0]);
            /* now output it */
            emitRO("OUT",get_reg(type),0,0,"output value in register[ac]",type);
            break;
        default:
            break;
    }
} /* genStmt */

/* Procedure genExp generates code at an expression node */
static void genExp( TreeNode * tree)
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
				 emitRM("LDC", ac, integer, 0, "load integer const", type);// reg[ac] = tree->ttr.val.integer
				break;
			case RFloat:
				 float_num = float_from_node(tree);
				 emiLDC("LDC", fac1, float_num, 0, "load float const", type);// reg[ac] = tree->ttr.val.integer
				break;
			default:
				emitComment("BUG in ConstK,unknwon expression type");
				break;
			}
            if (TraceCode)  emitComment("<- Const") ;
            break; /* ConstK */
          
        case IdK :
            if (TraceCode) emitComment("-> Id") ;
            loc = st_lookup(tree->attr.name);
			emitRM("LD", get_reg(tree->type), loc, gp, "load id value", type);// reg[ac] = Mem[reg[gp] + loc]
			emitRM("MOV", get_reg(type), get_reg(tree->type), 0, "move from one reg(s) to reg(r)",type);// tiny machine wuold analyze the instruction 
            if (TraceCode)  emitComment("<- Id") ;
            break; /* IdK */
        case OpK :
            if (TraceCode) emitComment("-> Op") ;
            p1 = tree->child[0];
            p2 = tree->child[1];
            /* gen code for ac = left arg */
            cGen(p1);
            /* gen code to push left operand */
			emitRM("ST", get_reg(type), tmpOffset--, mp, "op: push left",type);
            /* gen code for ac = right operand */
            cGen(p2);
			emitRM("LD", get_reg1(type), ++tmpOffset, mp, "op: load left",type); //reg[ac1] = mem[reg[mp] + tmpoffset]
            
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

					if (op == LT || op == LE){
						emitRO("SUB", reg, reg1, reg, "op <");
						op_code[2] = (op == LT ? 'T' : 'E');
					}
					else{
						emitRO("SUB", reg, reg1, reg, "op <");
						op_code[1] = 'G';
						op_code[2] = (op == GT ? 'T' : 'E');
					}

					/* now the op_code is JLE,JLT,GLE,GLT*/
					emitRM(op_code, ac, 2, pc, "br if true", type);
					emitRM("LDC", ac, 0, ac, "false case", type);
					emitRM("LDA", pc, 1, pc, "unconditional jmp", type);
					emitRM("LDC", ac, 1, ac, "true case", type);
					break;
                case EQ :
					emitRO("SUB", reg, reg1, reg, "op ==, convertd_type", type);
					emitRM("JEQ", ac, 2, pc, "br if true", type);
					emitRM("LDC", ac, 0, ac, "false case", type);
					emitRM("LDA", pc, 1, pc, "unconditional jmp", type);
					emitRM("LDC", ac, 1, ac, "true case", type);
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
static void cGen( TreeNode * tree)
{ if (tree != NULL)
{ switch (tree->nodekind) {
    case StmtK:
        genStmt(tree);
        break;
    case ExpK:
        genExp(tree);
        break;
    default:
        break;
}
    cGen(tree->sibling);
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
	TokenType type = syntaxTree->type;
	char * s = malloc(strlen(codefile)+7);
    strcpy(s,"File: ");
    strcat(s,codefile);
    emitComment(s);
    /* generate standard prelude */
    emitComment("Standard prelude:");
    emitRM("LD",mp,0,ac,"load maxaddress from location 0",type);
    emitRM("ST",ac,0,ac,"clear location 0",type);
    emitComment("End of standard prelude.");
    /* generate code for TINY program */
    cGen(syntaxTree);
    /* finish */
    emitComment("End of execution.");
    emitRO("HALT",0,0,0,"");
}

