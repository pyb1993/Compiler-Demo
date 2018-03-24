#include "tinytype.h"
#include "util.h"
#include "assert.h"
#include "symtable.h"

#define MAXTYPENUM  100
// macro to simplify check same name
#define ensure_not_same_name(name,sname) do {\
	assert(strcmp(name, sname) != 0 \
	|| !"duplicate struct/function!!!"); }while (0)

static StructType STypeCollection[MAXTYPENUM];
static ParamNode * new_param_node(TreeNode * tree);
static int getIndexOfSType(char * key);
static int var_size_of_members(Member* members);
static void deleteStructType(char * key);


void initTypeCollection()
{

	/*for (int i = 0; i < MAXTYPENUM; ++i){ if (STypeCollection[i].typeinfo.sname)
	{ 
		deleteStructType(STypeCollection[i].typeinfo.sname); }; 
	}*/
}

/*return the func_type, which is consisted of paramNode and return type*/
FuncType new_func_type(TreeNode * tree)
{
	FuncType ftype;
	ftype.return_type = (TypeInfo *)malloc(sizeof(TypeInfo));
	*ftype.return_type = tree->return_type;
	ftype.params = new_param_node(tree->child[0]);
	ftype.name = copyString(tree->attr.name);
	ftype.StructFunction = false;
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
	typeinfo.is_const = false;

	switch (basic)
	{
	case Pointer:
		typeinfo.point_type.pointKind = (TypeInfo*)malloc(sizeof(TypeInfo));
		
		break;
	}
	return typeinfo;
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
	if (tree == NULL) return NULL;
	else{
		ParamNode * pnode = new_param_node(tree->sibling);
		ParamNode * current = (ParamNode *)malloc(sizeof(ParamNode));
		current->type = (TypeInfo *)malloc(sizeof(TypeInfo));// 为type分配内存 FUUUuUUUUUCKKKKKKKKK
		*current->type = tree->type;// the name will be shared with tree->type
		current->next_param = pnode;
		return current;
	}
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
		return (a == b) || (b == Integer);
	case Char:
		return a == b || (b == Integer);
	case String:
		return a == b || b == Pointer;
	case Integer:
		if ((b == Boolean) || (b == Float) || (b == Pointer) || (b == Char)) return true;
	case Float:
		if (b == Float || b == Integer) return true;
		break;
	case Pointer:
		if (b != Pointer && b!= Integer) return false;
		return true;
		break;
	case Struct:
		return (a == b) && (strcmp(a_type.sname,b_type.sname) == 0);
		break;
	case Array:
		if (b == Array) return true;// the dimension is not cared
		else if (b == Pointer){return true;}
		return false;
	case Func:
		if (b == Integer || b == Func) return true;
		return  false;
	case Void:
		return b == Void;
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
	if (i == -1){
		assert(i != -1 || !"struct type not exist");
	}
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
			if (!STypeCollection[j].typeinfo.sname){
				assert(STypeCollection[j].typeinfo.sname || !"struct name is null");
			}
			ensure_not_same_name(type_name, STypeCollection[j].typeinfo.sname);
		}
	}
	int i = 0;
	while (i < MAXTYPENUM && STypeCollection[i].typeinfo.sname != NULL){ i++; }
	assert(i < MAXTYPENUM || "struct exceed limit!!!");
	stype.typeinfo.sname = copyString(type_name);
	STypeCollection[i] = stype;
}

void deleteStructType(char * key)
{
	int i = getIndexOfSType(key);
	
    // todo free members
    Member * member = STypeCollection[i].members;
    for(;member != NULL; member = member->next_member)
    {
        free(member);
    }
    
    STypeCollection[i].members = NULL;
	STypeCollection[i].typeinfo = createTypeFromBasic(ErrorType);
	free(STypeCollection[i].typeinfo.sname);
	STypeCollection[i].typeinfo.sname = NULL;
}

// todo optimize : convert tree to type
int var_size_of_type(TypeInfo vtype)
{
	Type type = getBasicType(vtype);
	if (type == Char) return 1;
	if (type == Integer) return 1;
	if (type == Float) return 1;
	if (type == Pointer) return 1;
	if (type == Func) return 1;
	if (type == Void) return 1;
	if (type == String) return 1;

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

bool memberExist(StructType stype, char * name){

	Member* members = stype.members;
	while (members != NULL && strcmp(members->member_name, name) != 0)
	{
		members = members->next_member;
	}
	return members != NULL;
}

Member* getMember(StructType stype,char * name)
{
	Member* members = stype.members;
	while (members != NULL && strcmp(members->member_name, name) != 0)
	{
		members = members->next_member;
	}
	if (members == NULL){
		assert(members != NULL || !"member is not defined!");
	}
	return members;
}

// 判断一个AST节点是不是含有self指针的函数(满足名字)
// TODO:加上对于
bool isStructFunction(const char * fname)
{
	if (fname == NULL) return false;
	return (strncmp(fname, "self__", 6) == 0);
}