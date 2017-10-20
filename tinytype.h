

#ifndef tinytype_h
#define tinytype_h

#include "globals.h"
typedef enum {BTYPE,FUNTYPE,STYPE} TypeKind;// the basic type,function type and struct type


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


typedef struct _Struct
{
    //struct BasicType * basic_type;//  -> LFloat -> LBoolean and so on;
	TypeInfo typeinfo;
    struct _StructType * next; // only meaningful in the case strcut type
	char * name; // eg: A.a,B.teacher.grades 
} StructType;


int integer_from_node(TreeNode * t);
float float_from_node(TreeNode * t);
bool can_convert(TypeInfo a, TypeInfo b);
FuncType new_func_type(TreeNode * tree);
ParamNode * new_param_node(TreeNode * tree);
FuncType getFunctionType(char * name);
Type getBasicType(TypeInfo typeinfo);
TypeInfo createTypeFromBasic(Type basic);
void addFunctionType(char * key, FuncType ftype);
void deleteFuncType(char * key);
void initTypeCollection();
#endif /* tinytype_h */
