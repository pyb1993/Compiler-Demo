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

static void checkTree(TreeNode * t,char * curretn_function,int scope);
static void checkNodeType(TreeNode * t,char * curretn_function, int scope);

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
	if (t == NULL) return;
	int offset = 0;	
	while (t != NULL)
	{	
		if (is_duplicate_var(t->attr.name, scope_depth)){
			defineError(t, "duplicate definition");
		}

		int var_size = var_size_of(t);
		offset += var_size;
		st_insert(t->attr.name, t->lineno, offset, var_size, scope_depth, t->type);
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
	StructType * type = NULL;

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
				
				if (is_basic_type(t->type,Func))
                {
					/*
						todo :support local procedure
					*/
					st_insert(t->attr.name, t->lineno, location--, 1,scope, t->type);// function occupy 4 bytes
					addFunctionType(t->attr.name, new_func_type(t));
					insertParam(t->child[0],scope + 1);
					insertTree(t->child[1], scope + 1);
					deleteVarOfField(t->child[0], scope + 1);
					deleteVarOfField(t->child[1], scope + 1);
					return;
				}
				if (scope == 0) //global var
                {   
					// todo remove the stackoffset,location to the symtable
                    int var_szie = var_size_of(t);
					location -= var_szie;
					st_insert(t->attr.name, t->lineno, location + 1, var_szie, scope,t->type);
					return;
                }
				else // local variable
				{
					int var_szie = var_size_of(t);
					stack_offset -= var_szie;
					st_insert(t->attr.name, t->lineno, stack_offset + 1, var_szie, scope, t->type);
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
	initTypeCollection();
	insertTree(syntaxTree, 0);// insert node and check them
	checkTree(syntaxTree, NULL, 0);
}

// todo optimize : convert tree to type
int var_size_of(TreeNode* tree)
{
	Type type = tree->type.typekind;
	if (type == Integer) return 1;
	if (type == Float) return 1;
	if (type == Pointer) return 1;
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
	TreeNode * child1, child2;

	switch (t->nodekind)
	{
	case ExpK:
		switch (t->kind.exp)
		{
		case SingleOpK:
			// todo optimize following code to functio. bad smell
			child1 = t->child[0];
			checkNodeType(child1,current_function,scope);
			if (t->attr.op == NEG)
			{
				assert(t->type.typekind == Integer || t->type.typekind == Float);
			}
			else if (t->attr.op == ADRESS)
			{
				assert(child1->kind.exp == IdK);
				if (is_basic_type(child1->type, Pointer))
				{
					t->type = child1->type;
					t->type.plevel = child1->type.plevel + 1;
				}
				else
				{
					t->type = createTypeFromBasic(Pointer);
					t->type.plevel = 1;
					t->type.pointKind = child1->type.typekind;
					t->type.sname = child1->type.sname;
				}
			}
			else if (t->attr.op == UNREF)
			{
				assert(is_basic_type(child1->type, Pointer));
				if (child1->type.plevel == 1)
				{
					t->type = createTypeFromBasic(child1->type.pointKind);
					t->type.sname = child1->type.sname;
				}
				else
				{
					t->type = child1->type;
					t->type.plevel -= 1;
				}
			}
			t->converted_type = t->type;
			return;// important! skip set_converted_type
			break;
		case OpK:
		{
			checkNodeType(t->child[0],current_function,scope);
			checkNodeType(t->child[1],current_function,scope);
			TokenType op = t->attr.op;
			if (   !can_convert(t->child[0]->type, createTypeFromBasic(Integer)) ||
				   !can_convert(t->child[1]->type, createTypeFromBasic(Integer))
			   )
				typeError(t, "Op applied to type beyond bool,integer,float");
			if ((op == EQ) || (op == LT) || (op == LE) || (op == GT) || (op == GE))
				t->type = createTypeFromBasic(Boolean);
			else if ((is_basic_type(t->child[0]->type,Float)) || 
				     (is_basic_type(t->child[1]->type, Float))
					 )
				t->type = createTypeFromBasic(Float);
			else
				t->type = createTypeFromBasic(Integer);
			break;
		}
		case IdK:
			t->type = st_lookup_type(t->attr.name);
			break;

		case FuncallK:
			assert(t->attr.name != 0);
			FuncType ftype = getFunctionType(t->attr.name);
			t->type = ftype.return_type;// set the function return type
			/*check the paramter type is legal*/
			ParamNode *param_type_node = ftype.params;
			TreeNode * param_node = t->child[0];
			while (param_type_node != NULL)
			{
				if (param_node == NULL)
				{
					typeError(param_node, "parameter num doesn't match the function definition");
					break;
				}

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
		gen_converted_type(t); // set the attribute converted_type 
		break;

	case StmtK:
		switch (t->kind.stmt)
		{
		case IfK:
			checkNodeType(t->child[0], current_function, scope + 1);
			if (!is_basic_type(t->child[0]->type,Boolean))
			{
				typeError(t->child[0], "if test is not Boolean");
			}
			checkNodeType(t->child[0],current_function,scope + 1);
			checkTree(t->child[1],current_function, scope + 1);
			checkTree(t->child[2],current_function, scope + 1);
			break;
		case ReturnK:
			assert(current_function != NULL);
			checkNodeType(t->child[0],current_function,scope);
			FuncType function_type = getFunctionType(current_function);
			TypeInfo function_return_type = function_type.return_type;
			TypeInfo return_exp_type = t->child[0] == NULL ? createTypeFromBasic(Void) : t->child[0]->type;
			if (!can_convert(return_exp_type, function_return_type))
			{
				typeError(t, "return type is not converted to funtion type");
			}
			break;
		case AssignK:
			checkNodeType(t->child[0],current_function, scope);
			TypeInfo exp_type = t->child[0]->converted_type;

			if (t->child[1] == NULL)
			{
				assert(st_lookup(t->attr.name) != NOTFOUND);
				TypeInfo id_type = st_lookup_type(t->attr.name);
				t->type = id_type;
				if (!can_convert(exp_type, id_type))
				{
					typeError(t->child[0], "assgin is not allowed for this two types");
				}
			}
			else{
			// *..p = xx
				TreeNode * unref_child = t->child[1];
				checkNodeType(unref_child, current_function, scope);
				assert(unref_child->child[0] != NULL);
				assert(can_convert(unref_child->type, exp_type));
			}
			break;			
		case RepeatK:
			checkNodeType(t->child[0],current_function, scope + 1);
			checkNodeType(t->child[1],current_function, scope + 1);
			if (!is_basic_type(t->child[0]->type,Boolean))
			{
				typeError(t->child[0], "repeat test is not Boolean");
			}
			break;
		case WriteK:
			checkNodeType(t->child[0],current_function,scope);
			exp_type = t->child[0]->converted_type;
			assert(can_convert(exp_type, createTypeFromBasic(Integer)) || 
				   is_basic_type(exp_type,Pointer) || "can only write bool,integer,float");
			break;
	
		case DeclareK:
			if (is_basic_type(t->type,Func))
			{
				/*
				todo :remove these to function insertFunction
				*/
				addFunctionType(t->attr.name, new_func_type(t)); // insert Functype
				st_insert(t->attr.name, t->lineno, location--, 1, scope, t->type);// function occupy 4 bytes
				insertParam(t->child[0], scope + 1);
				insertTree(t->child[1], scope + 1);
				checkTree(t->child[1], t->attr.name, scope + 1);
				// remove this to function deleteFunction
				deleteVarOfField(t->child[0], scope + 1);
				deleteVarOfField(t->child[1], scope + 1);
				deleteFuncType(t->attr.name);
			}
			break;
		default:
			for (int i = 0; i < MAXCHILDREN; ++i)
			{
				checkTree(t->child[i],current_function, scope + 1);
			}
			break;
		}
		break;
	default:
		break;
	}
}


/*assert the node is exp*/
static TypeInfo get_converted_type(TreeNode * t)
{
	assert(t != NULL);
	
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
		assert(t->attr.name != NULL);
		FuncType ftype = getFunctionType(t->attr.name);
		TypeInfo return_type = ftype.return_type;
		assert(!is_basic_type(return_type, Void));
		return return_type;
		break;
	case OpK:
		for (int i = 0; i < 2; ++i)
		{
			if (t->child[i] != NULL && is_basic_type(t->child[i]->converted_type,Float))
			{
				return createTypeFromBasic(Float);
			}
		}
		return t->child[0]->type;
		break;
	default:
		assert(!"undefined exp !");
		return createTypeFromBasic(Void);
		break;
	}
}

static void set_convertd_type(TreeNode * t, TypeInfo type){
	if (t == NULL) return;

	t->converted_type = type;
	for (int i = 0; i < MAXCHILDREN; ++i){
		set_convertd_type(t->child[i], type);
	}
}

 void gen_converted_type(TreeNode * tree)
{
	
	TypeInfo converted_type = get_converted_type(tree);
	set_convertd_type(tree, converted_type);
	assert(!is_basic_type(converted_type,Void));

 }
