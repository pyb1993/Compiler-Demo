
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
	case LStruct:
	case RStruct:
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
	case LStruct:
		assert(("not implemented struct", 1));
		break;
	default:
		assert(("not implemented int or other", 1));
		break;
	}
	return t;
}

/*return the func_type, which is consisted of paramNode and return type*/
FuncType new_func_type(TreeNode * tree){
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
		case LFloat:
		case RFloat:
			return t->attr.val.flt;
		case LInteger:
		case RInteger:
			return t->attr.val.integer;
		default:
			assert(!("not defined such conversion",1));
			return 0;
			break;
	}

}

float float_from_node(TreeNode * t)
{

	switch (t->type)
	{
	case LFloat:
	case RFloat:
		return t->attr.val.flt;
	case LInteger:
	case RInteger:
		return t->attr.val.integer;
	default:
		assert(!("not defined such conversion",1));
		return 0;
		break;
	}
}

bool is_relative_type(Type a, Type b)
{
	if (a == b)
		return true;
	else if (abs(b - a) == LRBOUND + 1)
		return true;

	return false;
}

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