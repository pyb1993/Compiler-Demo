#include "tinytype.h"
#include "util.h"
#include "assert.h"
#include "symtable.h"

#define MAXTYPENUM  100
// macro to simplify check same name
#define ensure_not_same_name(name,sname) do {\
	assert(strcmp(name, sname) != 0 \
	|| !"duplicate struct/function!!!"); }while (0)

static struct _Struct STypeCollection[MAXTYPENUM];
static int getIndexOfSType(char * key);
static int var_size_of_members(Member* members);


void initTypeCollection()
{
	for (int i = 0; i < MAXTYPENUM; ++i){ STypeCollection[i].typeinfo.sname = NULL; }
}

/*return the func_type, which is consisted of paramNode and return type*/
FuncType new_func_type(TreeNode * tree)
{
	FuncType ftype;
	ftype.return_type = (TypeInfo *)malloc(sizeof(TypeInfo));
	*ftype.return_type = tree->return_type;
	ftype.params = new_param_node(tree->child[0]);
	ftype.name = copyString(tree->attr.name);
	return ftype;
}

StructType new_struct_type(TreeNode * tree)
{
	StructType stype;
	stype.typeinfo = createTypeFromBasic(Struct);
	stype.members = new_member_list(tree->child[0],0);
	return stype;
}

Type getBasicType(TypeInfo typeinfo)
{
	return  typeinfo.typekind;
}

TypeInfo createTypeFromBasic(Type basic)
{
	TypeInfo typeinfo;
	typeinfo.typekind = basic;

	switch (basic)
	{
	case Pointer:
		typeinfo.point_type.pointKind = (TypeInfo*)malloc(sizeof(TypeInfo));
		break;
	}
	return typeinfo;
}
void setFunctionAdress(char * name,char * sname, int adress){
	if (sname == NULL){
		BucketList l = st_get_node(name);
		l->var_type.func_type.adress = adress;
	}
	else
	{
		StructType stype = getStructType(sname);
		Member * mem = getMember(stype, name);
		mem->typeinfo.func_type.adress = adress;
	}
}

int getFunctionAdress(char * name, char * sname){
	if (sname == NULL){
		TypeInfo type = st_lookup_type(name);
		return type.func_type.adress;
	}
	else{
		assert(0);
	
	}
}

void free_type(TypeInfo typeinfo)
{
	switch (typeinfo.typekind)
	{
	case Pointer:
		free(typeinfo.point_type.pointKind);
		break;
	case Array:
		free(typeinfo.array_type.ele_type);
		break;
	}
}

ParamNode * new_param_node(TreeNode * tree)
{
	ParamNode * current;
	ParamNode * pnode;
	if (tree == NULL) return NULL;
	pnode = new_param_node(tree->sibling);
	current = (ParamNode *)malloc(sizeof(ParamNode));
	current->type = (TypeInfo *)malloc(sizeof(TypeInfo *));
	*current->type = tree->type;
	current->next_param = pnode;
	return current;
}

/* new the member list for the tree */
Member * new_member_list(TreeNode * tree,int offset)
{
	if (tree == NULL) return NULL;
	else
	{
		Member * member = (Member *)malloc(sizeof(Member));
		if (is_basic_type(tree->type, Struct))
		{
			assert(ensure_type_defined(tree->type.sname) || "this struct is not defined");
		}


		member->typeinfo = tree->type;
		member->offset = offset;
		member->member_name = copyString(tree->attr.name);
		offset += var_size_of_type(tree->type);
	
		member->next_member = new_member_list(tree->sibling, offset);
		return member;
	}
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

// can b be converted to a
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
		return true;
		break;
	case Struct:
		return (a == b) && (strcmp(a_type.sname,b_type.sname) == 0);
		break;
	case Array:
		if (b == Array) return true;// the dimension is not cared
		else if (b == Pointer && can_convert(*b_type.point_type.pointKind, *a_type.array_type.ele_type)) return true;
		return false;
	default:
		assert(!"unknown type");
		return false;
		break;
	}
	return false;
}

int
getIndexOfSType(char * key)
{
	int i = 0;
	while ( i < MAXTYPENUM 
			&& (STypeCollection[i].typeinfo.sname == NULL 
				|| strcmp(STypeCollection[i].typeinfo.sname,key) != 0))	  
	{
		++i;
	}
	if (i == MAXTYPENUM){ return -1;}
	
	return i;
}



 StructType getStructType(char * key)
 {
	int i = getIndexOfSType(key);
	assert(i != -1 || !"struct type not exist");
	return STypeCollection[i];
 }

void freeType(TypeInfo * type)
{
	switch (type->typekind){
	case Func:
		break;
	}
}

void freeFuncType(FuncType * ftype)
{
	//free(ftype->name);
	//freeParamNode(ftype->params);
}

void freeParamNode(ParamNode * p)
{
}

void
addStructType(char * type_name, StructType stype)
{
	// ensure the type name is not duplicate
	for (int j = 0; j < MAXTYPENUM; ++j)
	{
		if (STypeCollection[j].members != NULL){
			assert(STypeCollection[j].typeinfo.sname || !"struct name is null");
			ensure_not_same_name(type_name, STypeCollection[j].typeinfo.sname);
		}
	}
	int i = 0;
	while (i < MAXTYPENUM && STypeCollection[i].typeinfo.sname != NULL){ i++; }
	assert(i < MAXTYPENUM || "struct exceed limit!!!");
	stype.typeinfo.sname = type_name;
	STypeCollection[i] = stype;
}

void
deleteStructType(char * key)
{
	int i = getIndexOfSType(key);
	// todo free members
	STypeCollection[i].members = NULL;
	STypeCollection[i].typeinfo = createTypeFromBasic(ErrorType);
	STypeCollection[i].typeinfo.sname = NULL;
}

// todo optimize : convert tree to type
int var_size_of_type(TypeInfo vtype)
{
	Type type = getBasicType(vtype);
	if (type == Integer) return 1;
	if (type == Float) return 1;
	if (type == Pointer) return 1;
	if (type == Func) return 1;
	if (type == Array)
	{
		ArrayType atype = vtype.array_type;
		return atype.ele_num * var_size_of_type(*atype.ele_type);
	}

	if (type == Struct)
	{
		StructType stype = getStructType(vtype.sname);
		return var_size_of_members(stype.members);
	}
	assert(!"undefined type size");
	return 0;
}

static int var_size_of_members(Member* members)
{
	if (members == NULL) return 0;
	int first_var_size = var_size_of_type(members->typeinfo);
	int remain_size = var_size_of_members(members->next_member);
	return first_var_size + remain_size;
}

bool is_basic_type(TypeInfo type, Type btype)
{
	return type.typekind == btype;
}

bool
ensure_type_defined(char * key)
{
	return getIndexOfSType(key) != -1;
}

Member* getMember(StructType stype,char * name)
{
	Member* members = stype.members;
	while (members != NULL && strcmp(members->member_name, name) != 0)
	{
		members = members->next_member;
	}
	assert(members != NULL || "member is not defined!");
	return members;
}

