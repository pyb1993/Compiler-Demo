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
#include "assert.h"
/* counter for variable memory locations */
static int location = 0;

 /* 
   a global 
 */

static bool is_global = true;
static int scope_depth = 0; //  0 is global scope,1 is the first child scope
static void checkNode(TreeNode * t);

static void traverse(TreeNode * t, void(*preProc) (TreeNode *), void(*postProc) (TreeNode *), void(*postProc2) (TreeNode *))
{
    if (t != NULL)
    {
        preProc(t);
        for (int i=0; i < MAXCHILDREN; i++)
        {
			bool tmp = is_global;
			is_global = false;
			scope_depth++;

            traverse(t->child[i],preProc,postProc,postProc2);

			is_global = tmp;//restore
			scope_depth--;
		}
        postProc(t);
        traverse(t->sibling,preProc,postProc,postProc2);// sibling means the stmt_sequence
		postProc2(t);
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

/* nullProc is a do-nothing procedure to
 * generate preorder-only or postorder-only
 * traversals from traverse
 */
static void nullProc(TreeNode * t) { }

/* Procedure insertNode inserts
 * identifiers stored in t into
 * the symbol table
 */

/*insert the param */
static int insertParam(TreeNode * t)
{
	VarType * type;
	if (t == NULL) return 0;
	type = type_from_basic(t->type);
	int var_size = var_size_of(t->type);
	int size = insertParam(t->sibling) + var_size;// offset of param in reverse
	
	// convert to the DeclareK temporarily to insert it as the declare node	
	if (is_duplicate_var(t->attr.name,scope_depth))
	{
		defineError(t, "duplicate definition");
	}

	st_insert(t->attr.name, t->lineno, size,var_size,scope_depth, type);
	location += var_size;
	return size;
}

static void insertNode( TreeNode * t)
{
	VarType * type = NULL;

	 switch (t->nodekind)
    { 
	 case StmtK:
            switch (t->kind.stmt)
        {
            case DeclareK:
				if (is_duplicate_var(t->attr.name,scope_depth))
				{
					defineError(t, "duplicate definition");
				}
				
				if (t->type == Func)
                {
					type = new_type(t);// create the function type
					st_insert(t->attr.name, t->lineno, location++, 1,scope_depth, type);// function occupy 4 bytes
					scope_depth++;
					insertParam(t->child[0]);
					scope_depth--;
				}
                else
                {   
                    int var_szie = var_size_of(t->type);
					type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, location, var_szie, scope_depth,type);
					location += var_szie;
                }
                break;
        }
            break;
        case ExpK:
			if (t->kind.exp == IdK && st_lookup(t->attr.name) == -1)
				defineError(t,"undefined variable");
            break;
    }
}


static void deleteNode(TreeNode * t)
{
	if (is_global) return;

	if ((t->nodekind == StmtK) && (t->kind.stmt == DeclareK || t->kind.stmt == ParamK))
	{
		st_delete(t->attr.name);
		
	}
}


/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree)
{ 
	is_global = true;
	scope_depth = 0;
	traverse(syntaxTree,insertNode,checkNode,deleteNode);
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
 void checkNode(TreeNode * t)
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
			if (!can_convert(t->child[0]->type,RInteger) || !can_convert(t->child[1]->type,RInteger))
				typeError(t, "Op applied to type beyond bool,integer,float");
			if ((op == EQ) || (op == LT) || (op == LE) || (op == GT) || (op == GE))
				t->type = RBoolean;
			else if (is_relative_type(t->child[0]->type, LFloat) ||
					 is_relative_type(t->child[1]->type, LFloat))
				t->type = RFloat;
			else
				t->type = RInteger;
			break;	
		}
		case IdK:
			t->type = st_lookup_type(t->attr.name);
			break;
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
            case RepeatK:
                if (t->child[0]->type != RBoolean && t->child[0]->type != LBoolean)
                    typeError(t->child[0],"repeat test is not Boolean");
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}


// check type a can be converted to b


/* Procedure typeCheck performs type checking 
 * by a postorder syntax tree traversal
 */



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
