/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "tinytype.h"
#include "util.h"

/* Procedure printToken prints a token
 * and its lexeme to the listing file
 */
void printToken(TokenType token, const char* tokenString)
{
    switch (token)
    {
        case IF:
        case ELSE:
        case END:
        case WHILE:
        case UNTIL:
        case READ:
        case WRITE:
            fprintf(listing,
                    "reserved word: %s\n", tokenString);
            break;
        case ASSIGN: fprintf(listing, "=\n"); break;
        case LT: fprintf(listing, "<\n"); break;
        case LE: fprintf(listing, "<=\n"); break;
        case GT: fprintf(listing, ">\n"); break;
        case GE: fprintf(listing, ">=\n"); break;
        case EQ: fprintf(listing, "==\n"); break;
        case LPAREN: fprintf(listing, "(\n"); break;
        case RPAREN: fprintf(listing, ")\n"); break;
        case SEMI: fprintf(listing, ";\n"); break;
		case NEG: fprintf(listing, "-\n"); break;
		case ADRESS: fprintf(listing, "&\n"); break;
        case PLUS: fprintf(listing, "+\n"); break;
        case MINUS: fprintf(listing, "-\n"); break;
        case TIMES: fprintf(listing, "*\n"); break;
        case OVER: fprintf(listing, "/\n"); break;
        case LBRACKET:fprintf(listing, "{\n"); break;
        case RBRACKET:fprintf(listing, "\n}"); break;
		case LSQUARE:fprintf(listing, "[\n"); break;
		case RSQUARE:fprintf(listing, "]\n"); break;
        case INT:fprintf(listing, "int\n "); break;
        case FLOAT:fprintf(listing, "float\n "); break;
		case VOID:fprintf(listing, "void\n "); break;
        case STRING:fprintf(listing, "STRING val = %s\n", tokenString);
		case RETURN:fprintf(listing, "RETURN statement\n");
		case LINEEND:fprintf(listing,"\n"); break;
		case ENDFILE: fprintf(listing, "EOF\n"); break;
        case NUM:
		case FlOATNUM:
            fprintf(listing,
                    "NUM/FLOATNUM, val= %s\n", tokenString);
            break;
        case ID:
            fprintf(listing,
                    "ID, name= %s\n", tokenString);
            break;
        case ERROR:
            fprintf(listing,
                    "ERROR: %s\n", tokenString);
            break;
        default: /* should never happen */
            fprintf(listing, "Unknown token: %d\n", token);
    }
}

/* Function newStmtNode creates a new statement
 * node for syntax tree construction
 */
TreeNode * newStmtNode(StmtKind kind)
{
    TreeNode * t = (TreeNode *)malloc(sizeof(TreeNode));
    int i;
    if (t == NULL)
        fprintf(listing, "Out of memory error at line %d\n", lineno);
    else {
        for (i = 0; i<MAXCHILDREN; i++) t->child[i] = NULL;
        t->sibling = NULL;
        t->nodekind = StmtK;
        t->kind.stmt = kind;
        t->lineno = lineno;
    }
    return t;
}

/* Function newExpNode creates a new expression
 * node for syntax tree construction
 */
TreeNode * newExpNode(ExpKind kind)
{
    TreeNode * t = (TreeNode *)malloc(sizeof(TreeNode));
    int i;
    if (t == NULL)
        fprintf(listing, "Out of memory error at line %d\n", lineno);
    else {
        for (i = 0; i<MAXCHILDREN; i++) t->child[i] = NULL;
        t->sibling = NULL;
        t->nodekind = ExpK;
        t->kind.exp = kind;
        t->lineno = lineno;
		t->type = createTypeFromBasic(Void);
    }
    return t;
}

/* Function copyString allocates and makes a new
 * copy of an existing string
 */

void my_strcpy(char * s,int len,char * t)
{
    int i = 0;
    while(i++ < len){
        *s++ = *t++;
    }
	*s++ = '\0';
}

char * copyString(char * s)
{
    int n;
    char * t;
    if (s == NULL) return NULL;
    n = strlen(s) + 1;
    t = (char *)malloc(n);
    if (t == NULL)
        fprintf(listing, "Out of memory error at line %d\n", lineno);
    else my_strcpy(t,strlen(s),s);
    return t;
}

/* Variable indentno is used by printTree to
 * store current number of spaces to indent
 */
static int indentno = 0;

/* macros to increase/decrease indentation */
#define INDENT indentno+=2
#define UNINDENT indentno-=2

/* printSpaces indents by printing spaces */
static void printSpaces(void)
{
    int i;
    for (i = 0; i<indentno; i++)
        fprintf(listing, " ");
}

/* procedure printTree prints a syntax tree to the
 * listing file using indentation to indicate subtrees
 */
void printTree(TreeNode * tree)
{
    int i;
    INDENT;
    while (tree != NULL)
	{
        printSpaces();
        if (tree->nodekind == StmtK)
        {
            switch (tree->kind.stmt) 
			{
                case IfK:
                    fprintf(listing, "If\n");
                    break;
                case RepeatK:
                    fprintf(listing, "While\n");
                    break;
                case ReadK:
                    fprintf(listing, "Read: %s\n", tree->attr.name);
                    break;
                case WriteK:
                    fprintf(listing, "Write\n");
                    break;
                case DeclareK:
                    fprintf(listing, "Declare variable (%s)\n",tree->attr.name);
                    break;
				case StructDefineK:
					fprintf(listing, "define struct (%s)\n", tree->attr.name);
					break;
				case ParamK:
					fprintf(listing, "Param variable (%s)\n", tree->attr.name);
					break;
				case BreakK:
                    fprintf(listing, "Break \n");
                    break;
				case ReturnK:
					fprintf(listing, "Return \n");
					break;
                default:
                    fprintf(listing, "Unknown StmtNode kind %d\n",tree->nodekind);
                    break;
            }
        }
        else if (tree->nodekind == ExpK)
        {
            switch (tree->kind.exp) 
			{
				case SingleOpK:
					fprintf(listing, "SingleOp: ");
					printToken(tree->attr.op, "\0");
					break;
                case OpK:
                    fprintf(listing, "Op: ");
                    printToken(tree->attr.op, "\0");
                    break;
				case AssignK:
					if (tree->child[1] == NULL)fprintf(listing, "Assign to: %s\n", tree->attr.name);
					else fprintf(listing, "Assign to unref exp\n");
					break;
				case IndexK:
					fprintf(listing, "Index: []..[]\n ");
					break;
                case ConstK:
                    switch (getBasicType(tree->type)) {
                        case Integer:
                            fprintf(listing, "Const: %d\n", tree->attr.val.integer);
                            break;
                        case Float:
                            fprintf(listing, "Const: %f\n", tree->attr.val.flt);
                            break;
                        default:
							fprintf(listing, "unknown constK\b");
							break;
                    }
                    break;
                case IdK:
                    fprintf(listing, "Id: %s\n", tree->attr.name);
                    break;
				case FuncallK:
					fprintf(listing, "function call: %s()\n", tree->attr.name);
					break;
                default:
                    fprintf(listing, "Unknown ExpNode kind %d\n",tree->nodekind);
                    break;
            }
        }
        else fprintf(listing, "Unknown node kind: %d\n",tree->nodekind);
        
        for (i = 0; i<MAXCHILDREN; i++)
            printTree(tree->child[i]);
        tree = tree->sibling;
    }
    UNINDENT;
}
