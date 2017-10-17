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
/* 
 todo : convert the tranverse to more flexible ; similar to cgen!!!
 */

static void checkTree(TreeNode * t,int scope);
static void checkNodeType(TreeNode * t, int scope);

void insertNode(TreeNode * t, int scope);
void insertTree(TreeNode * t, int scope);
void tranverseSeq(TreeNode * t, int scope, void(*func) (TreeNode *, int));


static void defineError(TreeNode * t ,char * msg)
{
    fprintf(listing,"Define error at line %d: %s\n",t->lineno,msg);
	assert(!"Define error");
    Error = TRUE;
}

static void typeError(TreeNode * t, char * message)
{
	fprintf(listing, "id : %s,Type error at line %d: %s\n",t->attr.name, t->lineno, message);
	Error = TRUE;
}

/* Procedure insertNode inserts
 * identifiers stored in t into
 * the symbol table
 */

/*insert the param */

 void insertParam(TreeNode * t,int scope_depth)
{
	VarType * type;
	if (t == NULL) return 0;
	int offset = 0;
	
	while (t != NULL)
	{	
		if (is_duplicate_var(t->attr.name, scope_depth)){
			defineError(t, "duplicate definition");
		}

		int var_size = var_size_of(t);
		offset += var_size;
		type = type_from_basic(t->type);
		st_insert(t->attr.name, t->lineno, offset, var_size, scope_depth, type);
		printf("stack offset %s %d \n", t->attr.name, offset);
		t = t->sibling;
	}
}


 // delete all local variable from the stmtseq
 void deleteVarOfField(TreeNode * tree, int scope)
 {
	 TreeNode * t = tree;
	 if (scope == 0) return;
	 while (t != NULL)
	 {
		 deleteVar(t, scope);
		 t = t->sibling;
	 }
 }

 void insertTree(TreeNode * t,int scope)
 {
	 while (t != NULL)
	 {
		 insertNode(t, scope);
		 t = t->sibling;
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
					st_insert(t->attr.name, t->lineno, location--, 1,scope, type);// function occupy 4 bytes
					insertParam(t->child[0],scope + 1);
					insertTree(t->child[1], scope + 1);
					deleteVarOfField(t->child[0], scope + 1);
					deleteVarOfField(t->child[1], scope + 1);
					return;
				}
				if (scope == 0) //global var
                {   
                    int var_szie = var_size_of(t);
					type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, location, var_szie, scope,type);
					location -= var_szie;
					return;
                }
				else // local variable
				{
					int var_szie = var_size_of(t);
					type = type_from_basic(t->type);
					st_insert(t->attr.name, t->lineno, stack_offset, var_szie, scope, type);
					stack_offset -= var_szie;
					printf("local variable stack offset %s %d\n",t->attr.name,stack_offset+var_szie);
				}
                break;
            default:
                break;
        }
            break;
        case ExpK:
			if ((t->kind.exp == IdK || t->kind.exp == FuncallK) && st_lookup(t->attr.name) == NOTFOUND)
				defineError(t,"undefined variable");			
			break;
	 }

}

/*notice one thing: delete param list after function body,not imediately!*/
void deleteVar(TreeNode * t,int scope_depth)
{
	if (t == NULL){ return; }
	if (t->nodekind != StmtK ||( t->kind.stmt != DeclareK && t->kind.stmt != ParamK)) return;

	if (scope_depth > 0)
	{
		st_delete(t->attr.name);
	}
}


/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree)
{ 
	insertTree(syntaxTree, 0);// insert node and check them
	checkTree(syntaxTree, NULL, 0);
}


int var_size_of(TreeNode* tree)
{
	Type type = tree->type;
	if (type == Integer) return 1;
	if (type == Float) return 1;
	if (type == Struct)
    {
		assert(!"undefined struct size");
		return 0;
	}
	assert(!"undefined type size");
    return 0;
}



void checkTree(TreeNode * t,char * current_function, int scope)
{
	while (t != NULL)
	{
		checkNodeType(t, current_function, scope);
		t = t->sibling;
	}
}

void checkNodeType(TreeNode * t,char * current_function, int scope)
{
	Type exp_type;
	switch (t->nodekind)
	{
	case ExpK:
		gen_converted_type(t); // set the attribute converted_type 
		switch (t->kind.exp)
		{
		case SingleOpK:
			if (t->attr.op == NEG)
			{
				assert(t->type == Integer || t->type == Float);
			}
			break;
		case OpK:
		{
			checkNodeType(t->child[0],current_function,scope);
			checkNodeType(t->child[1],current_function,scope);
			TokenType op = t->attr.op;
			if (!can_convert(t->child[0]->type, Integer) || !can_convert(t->child[1]->type, Integer))
				typeError(t, "Op applied to type beyond bool,integer,float");
			if ((op == EQ) || (op == LT) || (op == LE) || (op == GT) || (op == GE))
				t->type = Boolean;
			else if ((t->child[0]->type == Float) ||
				(t->child[1]->type == Float))
				t->type = Float;
			else
				t->type = Integer;
			break;
		}
		case IdK:
			t->type = st_lookup_type(t->attr.name);
			break;

		case FuncallK:
			t->type = st_lookup_type(t->attr.name);// set the function return type
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
				º¯ÊýÈëÕ°ÓÐ´í

				checkNodeType(param_node, current_function, scope + 1);

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
			checkNodeType(t->child[0], current_function, scope + 1);
			if (t->child[0]->type != Boolean){
				typeError(t->child[0], "if test is not Boolean");
			}
			checkNodeType(t->child[0],current_function,scope + 1);
			checkTree(t->child[1],current_function, scope + 1);
			checkTree(t->child[2],current_function, scope + 1);
			break;
		case ReturnK:
			assert(current_function != NULL);
			checkNodeType(t->child[0],current_function,scope);
			Type function_type = st_lookup_type(current_function);
			Type return_exp_type = t->child[0] == NULL ? Void : t->child[0]->type;
			if (!can_convert(return_exp_type, function_type))
			{
				typeError(t, "return type is not converted to funtion type");
			}
			break;
		case AssignK:
			checkNodeType(t->child[0],current_function, scope);

			assert(st_lookup(t->attr.name) != NOTFOUND);
			Type id_type = st_lookup_type(t->attr.name);
			Type exp_type = t->child[0]->converted_type;
			t->type = id_type;
			if (!can_convert(exp_type, id_type))
			{
				typeError(t->child[0], "assgin is not allowed for this two types");
			}
			break;			
		case RepeatK:
			checkNodeType(t->child[0],current_function, scope + 1);
			checkNodeType(t->child[1],current_function, scope + 1);
			if (t->child[0]->type != Boolean){
				typeError(t->child[0], "repeat test is not Boolean");
			}
			break;
		case WriteK:
			checkNodeType(t->child[0],current_function,scope);
			exp_type = t->child[0]->converted_type;
			assert(can_convert(exp_type, Integer) || !"can only write bool,integer,float");
			break;
	
		case DeclareK:
			if (t->type == Func)
			{
				/*
				todo :remove these to function insertFunction
				*/
				VarType * type = new_type(t);// create the function type
				st_insert(t->attr.name, t->lineno, location--, 1, scope, type);// function occupy 4 bytes
				insertParam(t->child[0], scope + 1);
				insertTree(t->child[1], scope + 1);
				checkTree(t->child[1], t->attr.name, scope + 1);
				// remove this to function deleteFunction
				deleteVarOfField(t->child[0], scope + 1);
				deleteVarOfField(t->child[1], scope + 1);
			}
			break;
		default:
			for (int i = 0; i < MAXCHILDREN; ++i){
				checkTree(t->child[i],current_function, scope + 1);
			}
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
	if (t == NULL) return ErrorType;
	
	switch (t->kind.exp)
	{
	case ConstK:
		return t->type;
		break;
	case SingleOpK:
		return t->type;
		break;
	case IdK:
		return st_lookup_type(t->attr.name);
		break;
	case FuncallK:
		return st_lookup_type(t->attr.name);
		break;
	case OpK:
		for (int i = 0; i < MAXCHILDREN; ++i)
		{
			if (is_float(t->child[i]) == Float)
			{
				return Float;
			}
		}
		return Integer;
		break;
	default:
		assert(!"undefined exp !");
		return ErrorType;
		break;
	}
}

static void set_convertd_type(TreeNode * t, Type type){
	if (t == NULL) return;

	t->converted_type = type;
	for (int i = 0; i < MAXCHILDREN; ++i){
		set_convertd_type(t->child[i], type);
	}
}

 void gen_converted_type(TreeNode * tree)
{
	Type _is_float = is_float(tree);
	set_convertd_type(tree, _is_float);	 
}
