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
/* counter for global variable memory locations */
static int location = 0;
static int stack_offset = 0; 
static int g_scope_depth = 0; //  0 is global scope,1 is the first child scope

/* 
   a global 
 */

static void checkNode(TreeNode * t);

static void traverse(TreeNode * t, void(*preProc) (TreeNode *,int ), void(*postProc) (TreeNode *), void(*postProc2) (TreeNode *,int))
{
    if (t != NULL)
    {
		preProc(t, g_scope_depth);
        for (int i=0; i < MAXCHILDREN; i++)
        {

			g_scope_depth++;
            traverse(t->child[i],preProc,postProc,postProc2);
			g_scope_depth--;
		}
        postProc(t);
        traverse(t->sibling,preProc,postProc,postProc2);// sibling means the stmt_sequence
		postProc2(t, g_scope_depth);
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
int insertParam(TreeNode * t,int scope_depth){
	_insertParam(t,scope_depth);
	stack_offset = -2;
}

 int _insertParam(TreeNode * t,int scope_depth)
{
	VarType * type;
	if (t == NULL) return 0;
	type = type_from_basic(t->type);
	int var_size = var_size_of(t->type);
	int size = insertParam(t->sibling,scope_depth) + var_size;// offset of param in reverse
	
	// convert to the DeclareK temporarily to insert it as the declare node	
	if (is_duplicate_var(t->attr.name,scope_depth))
	{
		defineError(t, "duplicate definition");
	}

	st_insert(t->attr.name, t->lineno, size,var_size,scope_depth, type);
	printf("stack offset %s %d \n",t->attr.name, size);
	stack_offset += var_size;
	return size;
}

 void deleteParam(TreeNode * t)
 {
	 stack_offset = 0;
	 TreeNode * param = t;
	 while (param != NULL)
	 {
		 st_delete(param->attr.name);
		 param = param->sibling;
	 }
 }


 void insertNode( TreeNode * t,int scope)
{
	VarType * type = NULL;

	 switch (t->nodekind)
    { 
	 case StmtK:
            switch (t->kind.stmt)
        {
            case DeclareK:
				if (is_duplicate_var(t->attr.name,scope))
				{
					defineError(t, "duplicate definition");
				}
				
				if (t->type == Func)
                {
					/*
						todo :support local procedure
					*/
					type = new_type(t);// create the function type
					st_insert(t->attr.name, t->lineno, location++, 1,scope, type);// function occupy 4 bytes
					insertParam(t->child[0],scope+1);
				}
				else if (scope == 0) //global var
                {   
                    int var_szie = var_size_of(t->type);
					type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, location, var_szie, scope,type);
					location += var_szie;
                }
				else // local variable
				{
					int var_szie = var_size_of(t->type);
					type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, stack_offset, var_szie, scope, type);
					stack_offset -= var_szie;
					printf("local variable stack offset %s %d\n",t->attr.name,stack_offset+var_szie);
				}
                break;
        }
            break;
        case ExpK:
			if (t->kind.exp == IdK || t->kind.exp == FuncallK && st_lookup(t->attr.name) == -1)
				defineError(t,"undefined variable");
            break;
    }
}

/*notice one thing: delete param list after function body,not imediately!*/
void deleteNode(TreeNode * t,int scope_depth)
{
	if (t->nodekind != StmtK) return;
	switch (t->kind.stmt)
	{
	case DeclareK:
		if (scope_depth > 0)
		{
			st_delete(t->attr.name);
		}
		if(t->type == Func)
		{
			deleteParam(t->child[0]);
		}
		break;
	}
}


/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree)
{ 
	g_scope_depth = 0;
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

		case FuncallK:
			t->type = st_lookup_type(t->attr.name);// get function return type
		
			/*check the paramter type is legal*/
			VarType *var_type = st_get_var_type_info(t->attr.name);
			ParamNode *param_type_node = var_type->typeinfo.ftype.params;
			TreeNode * param_node = t->child[0];
			while (param_type_node != NULL)
			{
				if (param_node == NULL)
				{
					typeError(param_node, "parameter num doesn't match the function definition");
					break;
				}
				if (!can_convert(param_type_node->type, param_node->converted_type))
				{
					typeError(param_node, "parameter cannot match the function definition");
					break;
				}
				param_type_node = param_type_node->next_param;
				param_node = param_node->sibling;
			}
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
	if (t->child[0] != NULL && t->child[0]->converted_type != Void) return t->child[0]->converted_type;
	
	switch (t->kind.exp)
	{
	case ConstK:
		return t->type;
		break;
	case IdK:
		return st_lookup_type(t->attr.name);
		break;
	case FuncallK:
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
