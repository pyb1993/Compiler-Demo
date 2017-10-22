
#include "tinytype.h"
#include "assert.h"

#define MAXTYPENUM  100
static FuncType FTypeCollection[MAXTYPENUM];
static StructType STypeCollection[MAXTYPENUM];


static int getIndexOfFType(char *key);

void initTypeCollection()
{
	for (int i = 0; i < MAXTYPENUM; ++i){ FTypeCollection[i].name = NULL;}
	for (int i = 0; i < MAXTYPENUM; ++i){ STypeCollection[i].name = NULL; }
}

/*return the func_type, which is consisted of paramNode and return type*/
FuncType new_func_type(TreeNode * tree)
{
	FuncType ftype;
	ftype.return_type = tree->return_type;
	ftype.params = new_param_node(tree->child[0]);
	ftype.name = tree->attr.name;
	return ftype;
}

Type getBasicType(TypeInfo typeinfo)
{
	return  typeinfo.typekind;
}

TypeInfo createTypeFromBasic(Type basic)
{
	TypeInfo typeinfo;
	switch (basic)
	{
	case Integer:
	case Float:
	case Boolean:
	case Void:
	case Pointer:
	case Func:
		typeinfo.typekind = basic;
		return typeinfo;
		break;	
	}
	assert(!"unknown basic type");
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
	
	switch (t->type.typekind)
	{
		case Float:
			return (int)t->attr.val.flt;
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

	switch (t->type.typekind)
	{
	case Float:
		return t->attr.val.flt;
	case Integer:
		return (float)t->attr.val.integer;
	default:
		assert(!"not defined such conversion");
		return 0;
		break;
	}
}

bool can_convert(TypeInfo a_type, TypeInfo b_type)
{
	// todo : add a map to represent the function
	Type a = getBasicType(a_type);
	Type b = getBasicType(b_type);

	switch (a)
	{
	case Boolean:
		return a == b || b == Integer;
	case Integer:
		if (b == Boolean) return true;
		if (b == Float) return true;
		if (b == Integer) return true;
		break;
	case Float:
		if (b == Float) return true;
		if (b == Integer) return true;
		break;
	case Pointer:
		if (b != Pointer) return false;
		if (a_type.plevel != b_type.plevel) return false;
		if (!can_convert(createTypeFromBasic(a_type.pointKind), createTypeFromBasic(b_type.pointKind))) return false;
		return true;
		break;
	case Struct:
		assert(0);
		return false;
		break;
	default:
		assert(!"unknown type");
		return false;
		break;
	}
	return false;
}



bool is_basic_type(TypeInfo typeinfo, Type btype) 
{
	return typeinfo.typekind == btype;
}

int getIndexOfFType(char *key)
{
	assert(key != NULL);
	for (int i = MAXTYPENUM - 1; i >= 0; --i)
	{
		
		if (FTypeCollection[i].name != NULL && strcmp(key, FTypeCollection[i].name) == 0)
			return i;
	}
	assert(!"FUNCTION TYPE MISSED!");
}

 FuncType getFunctionType(char * key)
{
	int i = getIndexOfFType(key);
	return FTypeCollection[i];
}

void addFunctionType(char * key,FuncType ftype)
{
	for (int i = 0; i < MAXTYPENUM; ++i)
	{
		if (FTypeCollection[i].name != NULL) 
			continue;
		else
		{
			FTypeCollection[i] = ftype;
			return;
		}
	}
	assert(!"FUNCTION OVER THE MAX NUM");
}

void deleteFuncType (char * key)
{
	int i = getIndexOfFType(key);
	FTypeCollection[i].name = NULL;
}