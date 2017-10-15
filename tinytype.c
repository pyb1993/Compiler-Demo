
#include "tinytype.h"
#include "assert.h"
/*
 to compare type a and type b is identical
 */


VarType * type_from_basic(Type type)
{
	VarType * t;
	switch (type)
	{
	case Struct:
	case Func:
		t = NULL;
		assert((!"ERROR TYPE !!!"));
		break;
	default:
		t = (VarType *)malloc(sizeof(VarType));
		t->typekind = BTYPE;
		t->typeinfo.btype = type;
		break;
	}
	return t;
}

VarType * new_type(TreeNode * tree){
	VarType * t = (VarType *)malloc(sizeof(VarType));
	switch (tree->type){
	case Func:
		t->typekind = FUNTYPE;
		t->typeinfo.ftype = new_func_type(tree);
		break;
	case Struct:
		assert("not implemented struct");
		break;
	default:
		assert("not implemented int or other");
		break;
	}
	return t;
}

/*return the func_type, which is consisted of paramNode and return type*/
FuncType new_func_type(TreeNode * tree)
{
	FuncType ftype;
	ftype.return_type = tree->return_type;
	ftype.params = new_param_node(tree->child[0]);
	return ftype;
}

ParamNode * new_param_node(TreeNode * tree)
{
	ParamNode * current;
	ParamNode * pnode;
	if (tree == NULL) return NULL;
	pnode = new_param_node(tree->sibling);
	current = (ParamNode *)malloc(sizeof(ParamNode));
	current->type = tree->type;
	current->next_param = pnode;
	return current;
}

int integer_from_node(TreeNode * t){
	
	switch (t->type)
	{
		case Float:
			return t->attr.val.flt;
		case Integer:
			return t->attr.val.integer;
		default:
			assert(!"not defined such conversion");
			return 0;
			break;
	}

}

float float_from_node(TreeNode * t)
{

	switch (t->type)
	{
	case Float:
		return t->attr.val.flt;
	case Integer:
		return t->attr.val.integer;
	default:
		assert(!"not defined such conversion");
		return 0;
		break;
	}
}

int my_abs(Type a,Type b){return a > b ? a - b : b - a;}


bool can_convert(Type a, Type b)
{
	// todo : add a map to represent the function
	if (a == b) return true;
	if (a == Boolean ){
		if (b == Integer) return true;
	}

	if (a == Integer) {
		if (b == Boolean) return true;
		if (b == Float) return true;
	}

	if (a == Float){
		if (b == Integer) return true;
	}

	return false;
}

void free_type(VarType * t)
{
	if (t->typekind == BTYPE){
		free(t);
	}
	else {
		printf("MEMORY LEAKED!!!!!!!!!!!!!!!!,NOT IMPLEMENTED!\n");
	}

}
