#ifndef tinytype_h
#define tinytype_h

#include "globals.h"

typedef enum {BTYPE,FUNTYPE,STYPE} TypeKind;// the basic type,function type and struct type
int var_size_of_type(TypeInfo);


/*
	the parmaNode must be declared before FuncType
*/
typedef struct _ParamNode{
	TypeInfo type;
	struct _ParamNode * next_param;
}  ParamNode;


typedef struct _FuncType{
	TypeInfo return_type;
	ParamNode * params;
	char * name;
} FuncType;

typedef struct _member
{
	TypeInfo typeinfo;
	int offset;
	char * member_name;// A.x eg:x is the member_name
	struct _member *next_member;
} Member;

typedef struct _Struct
{
    // struct BasicType * basic_type;//  -> LFloat -> LBoolean and so on;
	TypeInfo typeinfo;
    Member * members; // only meaningful when typeinfo is struct
} StructType;
/*
	how to analyze the struct?
	parse.c part
	parseStructDef:
		[1] first , when enter the keyword struct
			(1) definition:
					crate the structType of this definition by call parseStruct recursively
					insert the <sname,structtype> to the structType array
			(2) declaration
				parseStructDeclare:				
					create a member
					<1> find if the struct is declared, if not, abort
					<2> else get the typeInfo and member_name,created complete
				end
				append the member to the members

*/


/*
how to access Stu.x
// analyze.c part
 convert the type of Stu.x
 [1] find the x in next list
 [2] find the _StructType and then return it's name(note TypeInfo will not contain detail of Structure)
 [3] how to set the name ?


[1]. find the structure of Stu S
[2]. find the loc of Stu
[3]. compute the offset of x in the S
[4]. compute the location of x 

*/

/*
	how to acces p->x
	[1]assert p is a pointer, assert PointKind is a struct
	[2]find the PointKind(structure) of p
	[3]find the value of p(adress of real ref)
	[4]the same thing above
*/

int integer_from_node(TreeNode * t);
float float_from_node(TreeNode * t);
bool can_convert(TypeInfo a, TypeInfo b);
bool is_basic_type(TypeInfo type, Type btype);

FuncType new_func_type(TreeNode * tree);
StructType new_struct_type(TreeNode * tree);
ParamNode * new_param_node(TreeNode * tree);
Member * new_member_list(TreeNode * tree,int offset);
FuncType getFunctionType(char * name);
Type getBasicType(TypeInfo typeinfo);
TypeInfo createTypeFromBasic(Type basic);
void addFunctionType(char * key, FuncType ftype);
void deleteFuncType(char * key);
void initTypeCollection();
bool ensure_type_defined(char * key);
#endif /* tinytype_h */
