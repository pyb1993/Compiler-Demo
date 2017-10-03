/****************************************************/
/* File: analyze.c                                  */
/* Semantic analyzer implementation                 */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "symtable.h"
#include "analyze.h"
#include "tinytype.h"
/* counter for variable memory locations */
static int location = 0;
static bool can_convert(Type a, Type b);

 /* Procedure traverse is a generic recursive
 * syntax tree traversal routine:
 * it applies preProc in preorder and postProc
 * in postorder to tree pointed to by t
 */
static void traverse( TreeNode * t, void (* preProc) (TreeNode *), void (* postProc) (TreeNode *))
{
    if (t != NULL)
    {
        preProc(t);
        for (int i=0; i < MAXCHILDREN; i++)
        {
                traverse(t->child[i],preProc,postProc);
        }
        postProc(t);
        traverse(t->sibling,preProc,postProc);
    }
}

static void defineError(TreeNode * t ,char * msg){
    fprintf(listing,"Define error at line %d: %s\n",t->lineno,msg);
    Error = TRUE;
}


static void typeError(TreeNode * t, char * message)
{
	fprintf(listing, "id : %s,Type error at line %d: %s\n",t->attr.name, t->lineno, message);
	Error = TRUE;
}

static int var_size_of(Type);
static bool is_relative_type(Type a, Type b);

/* nullProc is a do-nothing procedure to
 * generate preorder-only or postorder-only
 * traversals from traverse
 */
static void nullProc(TreeNode * t) { }

/* Procedure insertNode inserts
 * identifiers stored in t into
 * the symbol table
 */
static void insertNode( TreeNode * t)
{
    switch (t->nodekind)
    { case StmtK:
            switch (t->kind.stmt)
        {
            case DeclareK:
                if (t->type == Func)
                {
                    /*
                     possible method:
                     t has the attribute of parameters list and return type
                     the symtable should also contain the type info.
                     */
                    defineError(t,"func type not implemented");
                }
                else
                {
                    if (st_lookup(t->attr.name) == -1)
                    {
                        int var_szie = var_size_of(t->type);
						VarType type = type_from_basic(t->type);
                        st_insert(t->attr.name,t->lineno,location++,var_szie,type);
                    }
                    else
                    {
                        defineError(t,"duplicate definition");
                    }
                }
                
                break;
            case AssignK:
            case ReadK:
                if (st_lookup(t->attr.name) == -1)// todo there are look up two times, can be optimized
                /* not yet in table, so treat as new definition */
                    defineError(t,"undefined variable");
				else{
					/* already in table, so ignore location,
					 add line number of use only */
					VarType type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, 0, 1, type);					
				}
                break;
            default:
                break;
        }
            break;
        case ExpK:
            switch (t->kind.exp)
        {
            case IdK:
                if (st_lookup(t->attr.name) == -1)
                /* not yet in table, undefined variable */
                    defineError(t,"undefined variable");
				else{
					VarType type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, 0, 1,type);
				}
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}

/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree)
{ traverse(syntaxTree,insertNode,nullProc);
    if (TraceAnalyze)
    { fprintf(listing,"\nSymbol table:\n\n");
        printSymTab(listing);
    }
}


int var_size_of(Type type){
    return 1;
}


/* Procedure checkNode performs
 * type checking at a single tree node
 */
static void checkNode(TreeNode * t)
{

    switch (t->nodekind)
    {
	 case ExpK:
		gen_converted_type(t); // set the attribute converted_type 
        switch (t->kind.exp)
		{
		case OpK:
		{
			TokenType op = t->attr.op;
			if (can_convert(t->child[0]->type,RInteger) && can_convert(t->child[1]->type,RInteger))
				typeError(t, "Op applied to non-integer");
			if ((op == EQ) || (op == LT) || (op == LE) || (op == GT) || (op == GE))
				t->type = RBoolean;
			else if (t->child[0]->type == LFloat || t->child[0]->type == RFloat ||
					    t->child[1]->type == LFloat || t->child[1]->type == RFloat )
				t->type = RFloat;
			break;	
		}
        default:
            break;
        }
        break;
        
	case StmtK:
            switch (t->kind.stmt)
        { 
			case IfK:
                if (t->child[0]->type != RBoolean && t->child[0]->type != LBoolean)
                    typeError(t->child[0],"if test is not Boolean");
                break;
            case AssignK:
                st_lookup(t->attr.name);
                Type id_type = st_lookup_type(t->attr.name);
				Type child_type = t->child[0]->type;
				if (!can_convert(child_type,id_type))
				{
					typeError(t->child[0], "assgin is not allowed for this two types");					
				}
                break;
            case WriteK:
				if (t->child[0]->type != RInteger && t->child[0]->type != LInteger)
                    typeError(t->child[0],"write of non-integer value");
                break;
            case RepeatK:
                if (t->child[1]->type != RBoolean && t->child[1]->type != LBoolean)
                    typeError(t->child[1],"repeat test is not Boolean");
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}

/*
 check if type a and type b is the same or relative LType,RType
 */
bool is_relative_type(Type a, Type b)
{
    if (a == b)
        return true;
    else if (abs(b - a) == LRBOUND + 1)
        return true;

    return false;
}
// check type a can be converted to b

bool can_convert(Type a, Type b)
{

	if (is_relative_type(a, b)) return true;
	if (a == LBoolean || a == RBoolean){
		if (b == LInteger || b == RInteger) return true;
	}

	if (a == LInteger || a == RInteger) {
		if (b == LBoolean || b == RBoolean) return true;
		if (b == LFloat || b == RFloat) return true;
	}

	if (a == LFloat || a == RFloat){
		if (b == LInteger || b == RInteger) return true;
	}

	return false;
}

/* Procedure typeCheck performs type checking 
 * by a postorder syntax tree traversal
 */
void typeCheck(TreeNode * syntaxTree)
{ traverse(syntaxTree,nullProc,checkNode);
}


/*assert the node is exp*/
static Type is_float(TreeNode * t)
{
	if (t == NULL) return Void;
	switch (t->kind.exp)
	{
	case ConstK:
		return t->type;
		break;
	case IdK:
		return st_lookup_type(t->attr.name);
		break;
	default:
		for (int i = 0; i < MAXCHILDREN; ++i)
		{
			if (is_float(t->child[i]) == RFloat)
			{
				return RFloat;
			}
		}
		break;
	}

	return RInteger;
}

static void set_convertd_type(TreeNode * t, TokenType type){
	if (t == NULL) return;

	t->converted_type = type;
	for (int i = 0; i < MAXCHILDREN; ++i){
		set_convertd_type(t->child[i], type);
	}
}



static void gen_converted_type(TreeNode * tree)
{
	Type _is_float = is_float(tree);
	set_convertd_type(tree, _is_float);
}
