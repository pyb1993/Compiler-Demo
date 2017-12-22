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

#define ERROR_IF(cond,msg) do {if(!(cond)) assert(!msg);}while(0)

/* counter for global variable memory locations */
static int location = 0;
static int stack_offset = -2;
static int while_depth = 0;
static bool allowed_empty_exp = false;
/* 
 todo : convert the tranverse to more flexible ; similar to cgen!!!
*/
static void checkTree(TreeNode * t,char * curretn_function,int scope);
static void checkNodeType(TreeNode * t,char * curretn_function, int scope);
static void check_assign_node(TreeNode *,TreeNode *,TreeNode*, char * current_function, int scope);
static bool checkInWhile();
static void incrWhileDepth(int);
static void checkEmptyExp(TreeNode *);
static void checkEmptyExpOfTree(TreeNode *);
static void defineError(TreeNode * t ,char * msg)
{
    fprintf(listing,"Define error at line %d: %s\n",t->lineno,msg);
	assert(!"Define error");
    Error = TRUE;
}

static void typeError(TreeNode * t, char * message)
{
	fprintf(listing, "Type error at line %d: %s\n", t->lineno, message);
	Error = TRUE;
}

void insertNode(TreeNode * t, int scope);
void insertTree(TreeNode * t, int scope);
void tranverseSeq(TreeNode * t, int scope, void(*func) (TreeNode *, int));


 bool isExp(TreeNode * t, ExpKind ekind)
{
	return t->nodekind == ExpK && t->kind.exp == ekind;
}

 bool isStmt(TreeNode * t, StmtKind skind)
{
	return t->nodekind == StmtK && t->kind.exp == skind;
}

/* Procedure insertNode inserts
 * identifiers stored in t into
 * the symbol table
 */

/*insert the param */

 void insertParam(TreeNode * t,int scope_depth)
{
	if (t == NULL) return;
	int offset = 1;	
	while (t != NULL)
	{	
		if (is_duplicate_var(t->attr.name, scope_depth)){
			defineError(t, "duplicate definition");
		}

		int var_size = var_size_of(t);
		if (is_basic_type(t->type, Array)){
			var_size = 1;
			TypeInfo point_type; // not use createTypeInfoFromBasic to avoid alloc and free memory
			point_type.typekind = Pointer;
			point_type.point_type.pointKind = t->type.array_type.ele_type;
			point_type.point_type.plevel = 1;
			st_insert(t->attr.name, t->lineno, offset, var_size, scope_depth, point_type);
		}
		else{
			st_insert(t->attr.name, t->lineno, offset, var_size, scope_depth, t->type);
		}
		offset += var_size;
		t = t->sibling;
	}
}

 void __deleteVarOfField(TreeNode * tree,int scope)
 {
	 TreeNode * t = tree;
	 if (scope == 0) return;
	 while (t != NULL)
	 {
		 if (isStmt(t, DeclareK))
		 {
			 deleteVar(t, scope);
			 stack_offset += var_size_of(t);
		 }
		 t = t->sibling;
	 }
 }

 // delete all local variable from the stmtseq
 void deleteVarOfField(TreeNode * tree, int scope)
 {
	 __deleteVarOfField(tree, scope);
 }

 // delete all params from the stmtseq
 void deleteParams(TreeNode * tree, int scope)
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
	 switch (t->nodekind)
	 {
	 case StmtK:
		 switch (t->kind.stmt)
		 {
		 case DeclareK:
			 if (is_basic_type(t->type, Func))
			 {
				 /* todo : support local procedure */
				 t->type.func_type = new_func_type(t);
				 if (scope == 0){
					 st_insert(t->attr.name, t->lineno, location--, 1, scope, t->type);// function occupy 4 bytes
				 }
				 else{
					 st_insert(t->attr.name, t->lineno, stack_offset + 1, 1, scope, t->type);
					 stack_offset -= 1;
				 }
				 
				 insertParam(t->child[0], scope + 1);
				 insertTree(t->child[1], scope + 1);
				 deleteParams(t->child[0], scope + 1);
				 deleteVarOfField(t->child[1], scope + 1);
				 return;
			 }
		
			 if (scope == 0) //global var
			 {
				 // todo remove the stackoffset,location to the symtable
				 int var_szie = var_size_of(t);
				 location -= var_szie;
				 st_insert(t->attr.name, t->lineno, location + 1, var_szie, scope, t->type);
				 return;
			 }
			 else // local variable
			 {
				 int var_szie = var_size_of(t);
				 stack_offset -= var_szie;
				 st_insert(t->attr.name, t->lineno, stack_offset + 1, var_szie, scope, t->type);
			 }
			 break;
		 case RepeatK:
			 incrWhileDepth(1);
			 allowed_empty_exp = TRUE;
			 insertNode(t->child[0],scope + 1);
			 allowed_empty_exp = FALSE;
			 insertNode(t->child[1], scope);
			 incrWhileDepth(-1);
			 break;
		 case BlockK:
			 insertTree(t->child[0],scope + 1);
			 deleteVarOfField(t->child[0], scope + 1);
			 break;
		 case IfK:
			 allowed_empty_exp = TRUE;
			 insertNode(t->child[0], scope + 1);
			 allowed_empty_exp = FALSE;
			 insertTree(t->child[1], scope + 1);
			 insertTree(t->child[2], scope + 1);
			 break;
		 case BreakK:
		 case ContinueK:
			 ERROR_IF(checkInWhile(),"break can only be in while");
			 break;
		 case StructDefineK:
			 ERROR_IF(scope == 0, "only support global struct define stmt");
			 insertTree(t->child[0], scope + 1);
			 deleteVarOfField(t->child[0], scope + 1);
			 addStructType(t->attr.name, new_struct_type(t));
			 // todo support local struct
			 break;
		 default:
			 break;
		 }
		 break;
	 case ExpK:
		 checkEmptyExp(t);
		break;
	 }
}

/*notice one thing: delete param list after function body, not imediately!*/
void deleteVar(TreeNode * t,int scope_depth)
{
	if (t == NULL){ return; }
	if (t->nodekind != StmtK || ( t->kind.stmt != DeclareK && t->kind.stmt != ParamK)) return;
	assert(scope_depth > 0);
	st_delete(t->attr.name);
}

/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree)
{ 
	initTypeCollection();
	printf("insert tree is done %d \n", stack_offset);
	insertTree(syntaxTree, 0);// insert node and check them
	printf("insert tree is done %d \n",stack_offset);
	checkTree(syntaxTree, NULL, 0);
	printf("check tree is done %d \n", stack_offset);

}

int var_size_of(TreeNode* tree)
{
	return var_size_of_type(tree->type);
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
	TreeNode * child1;

	switch (t->nodekind)
	{
	case ExpK:
		switch (t->kind.exp)
		{
		case SingleOpK:
			// todo optimize following code to functio. bad smell
			child1 = t->child[0];
			checkNodeType(child1,current_function,scope);
			if (t->attr.op == NEG || t->attr.op == PPLUS || t->attr.op == MMINUS)
			{
				t->type = child1->type;
				assert(can_convert(child1->converted_type,createTypeFromBasic(Integer)) ||
					   is_basic_type(child1->type,Pointer));
			}
			else if (t->attr.op == ADRESS)
			{
				if (is_basic_type(child1->type, Pointer))
				{
					t->type = child1->type;
					t->type.point_type.plevel = child1->type.point_type.plevel + 1;
				}
				else
				{
					//free_type(t->type);// in general, t->type should be null
					t->type = createTypeFromBasic(Pointer);// malloc new memory
					t->type.point_type.plevel = 1;
					*t->type.point_type.pointKind = child1->type;//warnning, share same memory
					t->type.sname = child1->type.sname;
				}
			}
			else if (t->attr.op == UNREF)
			{
				assert(is_basic_type(child1->type, Pointer));
				if (child1->type.point_type.plevel == 1)
				{
					t->type = *child1->type.point_type.pointKind;
				}
				else
				{
					t->type = child1->type;
					t->type.point_type.plevel -= 1;
				}
			}
			t->converted_type = t->type;
			return;// important! skip set_converted_type
			break;

		case AssignK:
			checkNodeType(t->child[0], current_function, scope);
			checkNodeType(t->child[1], current_function, scope);
			check_assign_node(t, t->child[0], t->child[1], current_function, scope);
			break;

		case OpK:
			checkNodeType(t->child[0], current_function, scope);
			checkNodeType(t->child[1], current_function, scope);
			// todo optimize bad smell
			TokenType op = t->attr.op;
			
			if (   !((can_convert(t->child[0]->type, createTypeFromBasic(Integer)) ||
				    can_convert(t->child[0]->type, createTypeFromBasic(Pointer))) 
				   && 
				   (can_convert(t->child[1]->type, createTypeFromBasic(Integer)) ||
				    can_convert(t->child[1]->type, createTypeFromBasic(Pointer))
				    )))
				typeError(t, "Op applied to type beyond bool,integer,float");
			if ((op == EQ) || (op == LT) || (op == LE) || (op == GT) || (op == GE)){
				t->type = createTypeFromBasic(Boolean);
				t->converted_type = t->type;
			}
			else if ((is_basic_type(t->child[0]->type, Float)) ||
				(is_basic_type(t->child[1]->type, Float))
				)
			{
				t->type = createTypeFromBasic(Float);
				gen_converted_type(t); // set the attribute converted_type 
			}
			else if (is_basic_type(t->child[0]->type, Pointer) || is_basic_type(t->child[1]->type, Pointer))
			{
				// swap the pointer to the first child. it's handy to check in remain steps
				if (is_basic_type(t->child[1]->type, Pointer))
				{
					TreeNode * p = t->child[0];
					t->child[0] = t->child[1];
					t->child[1] = p;
				}

				t->type = is_basic_type(t->child[0]->type, Pointer) ? t->child[0]->type : t->child[1]->type;
				t->converted_type = t->type;
			}
			else{
				t->type = createTypeFromBasic(Integer);
				gen_converted_type(t); // set the attribute converted_type 
			}

			break;

		case IdK:
			ERROR_IF(st_lookup(t->attr.name) != NOTFOUND, "undefined variable");
			t->type = st_lookup_type(t->attr.name);
			t->converted_type = t->type;
			break;
		case IndexK:
			checkNodeType(t->child[0],current_function,scope);
			checkNodeType(t->child[1], current_function, scope);
			assert(can_convert(t->child[1]->converted_type, createTypeFromBasic(Integer)));
			assert(is_basic_type(t->child[0]->converted_type, Array) || 
				   is_basic_type(t->child[0]->converted_type, Pointer) ||
				   !"left expression is not array or pointer");
			
			if (is_basic_type(t->child[0]->converted_type, Array)){
				t->type = *(t->child[0]->type.array_type.ele_type);
			}
			else{
				t->type = *(t->child[0]->type.point_type.pointKind);
			}
			t->converted_type = t->type;
			break;
		case ArrowK:{
			checkNodeType(t->child[0], current_function, scope);
			TypeInfo lhs_type = t->child[0]->type;
			ERROR_IF(is_basic_type(lhs_type, Pointer) && lhs_type.point_type.plevel == 1, "illegal arrow: lhs must be pointer");
			ERROR_IF(is_basic_type(*lhs_type.point_type.pointKind, Struct), "illegal arrow: lhs must point to struct");
			StructType stype = getStructType(lhs_type.point_type.pointKind->sname);
			Member* member = getMember(stype, t->attr.name);
			t->type = member->typeinfo;
			t->converted_type = t->type;
			break;
		}
		case PointK:
		{
			checkNodeType(t->child[0], current_function, scope);
			StructType stype = getStructType(t->child[0]->type.sname);
			Member* member = getMember(stype, t->attr.name);
			t->type = member->typeinfo;
			t->converted_type = t->type;
			break;
		}
		case FuncallK:
			assert(t->attr.name != 0);
			checkNodeType(t->child[1], current_function, scope);
			FuncType ftype = t->child[1]->type.func_type;
			t->type = *ftype.return_type;// set the function return type
			/*check the paramter type is legal*/
			ParamNode *param_type_node = ftype.params;
			TreeNode * param_node = t->child[0];
			while (param_type_node != NULL)
			{
				if (param_node == NULL)
				{
					assert(!"parameter num cannot match ");
					break;
				}

				checkNodeType(param_node, current_function, scope + 1);

				if (!can_convert(param_node->converted_type, *param_type_node->type))
				{
					assert(!"parameter cannot match the function definition");
					break;
				}
				param_type_node = param_type_node->next_param;
				param_node = param_node->sibling;
			}
			ERROR_IF(param_node == NULL, "parameter num cannot match ");
			t->converted_type = t->type;
			break;
		case ConstK:
			t->converted_type = t->type;
			break;
		default:
			assert(0);
			break;
		}
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
		
			TypeInfo function_return_type = *st_lookup_type(current_function).func_type.return_type;
			TypeInfo return_exp_type = t->child[0] == NULL ? createTypeFromBasic(Void) : t->child[0]->type;
			if (!can_convert(return_exp_type, function_return_type))
			{
				typeError(t, "return type is not converted to funtion type");
			}
			break;		
		case RepeatK:
			checkNodeType(t->child[0],current_function, scope + 1);
			checkTree(t->child[1],current_function, scope);
			if (!is_basic_type(t->child[0]->type,Boolean))
			{
				typeError(t->child[0], "repeat test is not Boolean");
			}
			break;
		case WriteK:
			checkNodeType(t->child[0],current_function,scope);
			TypeInfo exp_type = t->child[0]->converted_type;
			assert(can_convert(exp_type, createTypeFromBasic(Integer)) || 
				   is_basic_type(exp_type,Pointer) || "can only write bool,integer,float,pointer");
			break;
	
		case DeclareK:
			if (is_basic_type(t->type,Func))
			{
				/*todo :remove these  function insert Function*/
				insertParam(t->child[0], scope + 1);
				insertTree(t->child[1], scope + 1);
				checkTree(t->child[1], t->attr.name, scope + 1);
				deleteParams(t->child[0], scope + 1);
				deleteVarOfField(t->child[1], scope + 1);
			}	
			else if (t->child[2] != NULL)// int x = 100
			{
				checkNodeType(t->child[2], current_function, scope);
				check_assign_node(t, t, t->child[2], current_function, scope);
			}
			break;
		case BlockK:
			insertTree(t->child[0], scope + 1);
			checkTree(t->child[0], current_function, scope + 1);
			deleteVarOfField(t->child[0], scope + 1);
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
	ERROR_IF(t != NULL,"try to get type of null node");
	
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
		ERROR_IF(t->attr.name != NULL,"function not found");
		TypeInfo return_type = *t->type.func_type.return_type;
		return return_type;
		break;
	case AssignK:
	case OpK:
		for (int i = 0; i < 2; ++i)
		{
			if (t->child[i] != NULL && is_basic_type(t->child[i]->converted_type,Float))
			{
				return createTypeFromBasic(Float);
			}
		}
		return t->type;
		break;
	default:
		assert(!"undefined exp !");
		return createTypeFromBasic(Void);
		break;
	}
}

static void set_convertd_type(TreeNode * t, TypeInfo type)
{
	if (t == NULL) return;

	t->converted_type = type;
	for (int i = 0; i < MAXCHILDREN; ++i)
	{
		if (t->kind.exp == OpK)
			set_convertd_type(t->child[i], type);
	}
}

 void gen_converted_type(TreeNode * tree)
{
	TypeInfo converted_type = get_converted_type(tree);	
	// todo optimize
	if (is_basic_type(converted_type, Pointer)){
		assert(is_basic_type(tree->child[0]->type, Pointer));
		tree->converted_type = converted_type;
		set_convertd_type(tree->child[0], converted_type);
		set_convertd_type(tree->child[1], createTypeFromBasic(Integer));// todo
	}
	else
		set_convertd_type(tree, converted_type);
}

  void check_assign_node(TreeNode * t,TreeNode * left,TreeNode * right, char * current_function, int scope)
 {
	  ERROR_IF(right->nodekind == ExpK,"illegal assign");
	  assert(!is_basic_type(left->type,Array));
	  TypeInfo exp_type = right->converted_type;
	  
	  if (isExp(left,IdK) || isStmt(t,DeclareK))
	  {
		  ERROR_IF(st_lookup(left->attr.name) != NOTFOUND,"variable not defined");
		  TypeInfo id_type = st_lookup_type(left->attr.name);
		  t->type = id_type;
		  ERROR_IF(can_convert(exp_type, id_type),
					"conversion is not allowed for this two types");
	  }
	  else
	  {
		  // *..p = xx || a[exp] = xxx
		  TreeNode * unref_child = t->child[0];
		  ERROR_IF(left->child[0] != NULL,"illegal assgin stmt");
		  ERROR_IF(can_convert(exp_type, unref_child->type),"not converted type in assign");
		  t->type = unref_child->type;
		  if (isExp(unref_child,IndexK))
		  {
			  ERROR_IF(!is_basic_type(unref_child->type, Array),
						"Const array cannot be left operand");
		  }
	  }
	  t->converted_type = t->type;
 }

 bool checkInWhile()
  {
	  return while_depth > 0;
  }
 void incrWhileDepth(int delta)
  {
	  while_depth += delta;
  }

 void checkEmptyExp(TreeNode * t){
	 if (allowed_empty_exp) return;// eg: while(exp),if(exp)
	 ERROR_IF(isExp(t, FuncallK) || isExp(t, AssignK) || 
			  (isExp(t,SingleOpK) && (t->attr.op == PPLUS || t->attr.op == MMINUS)),
			  "empty exp beyond call and assign or ++/-- is not allowed!");
	 if (isExp(t, FuncallK)) 
	 {
		 TreeNode * function_format = t->child[1];
		 if (function_format->kind.exp == IdK){
			 ERROR_IF(is_basic_type(*st_lookup_type(t->attr.name).func_type.return_type, Void),
				 "only function return nothing can be the empty exp");
		 }
	 }
	 t->empty_exp = TRUE;
 }