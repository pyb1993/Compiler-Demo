
#include "tinytype.h"
#include "assert.h"
/*
 to compare type a and type b is identical
 */
bool equal_type( VarType a, VarType b){
    return false;
}

VarType type_from_basic(Type type)
{
	VarType * t = (VarType *)malloc(sizeof(VarType));
	t->typekind = BTYPE;
	t->typeinfo.btype = type;
	return (*t);
}


int integer_from_node(TreeNode * t){
	if (t->converted_type == Void) return t->attr.val.integer;
	
	switch (t->type)
	{
		case LFloat:
		case RFloat:
			return t->attr.val.flt;
		default:
			assert(!("not defined such conversion",1));
			return 0;
			break;
	}

}

float float_from_node(TreeNode * t){
	if (t->converted_type == Void) return t->attr.val.flt;

	switch (t->type)
	{
	case LInteger:
	case RInteger:
		return t->attr.val.integer;
	default:
		assert(!("not defined such conversion",1));
		return 0;
		break;
	}
}
