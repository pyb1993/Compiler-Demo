

#ifndef tinytype_h
#define tinytype_h

#include "globals.h"
typedef enum {BTYPE,FUNTYPE,STYPE} TypeKind;// the basic type,function type and struct type


/*
	the parmaNode must be declared before FuncType
*/
typedef struct _ParamNode{
	Type type;
	struct _ParamNode * next_param;
}  ParamNode;


typedef struct _FuncType{
	Type return_type;
	ParamNode * params;
} FuncType;


typedef struct _VarType
{
    //struct BasicType * basic_type;//  -> LFloat -> LBoolean and so on;
    union
    {
         Type btype;	   // case basic type : such as the LInteger,LBoolean,LFloat
         FuncType ftype;   //  case function type: function can also be a variable. which is not implemented.
         struct _VarType * stype; //   case struct type :  
    } typeinfo;
    
    struct _VarType * next; // only meaningful in the case strcut type
	char * name; // eg: A.a,B.teacher.grades 
    TypeKind typekind; //the upper type
} VarType;


struct _VarType * type_from_basic(Type type);
int integer_from_node(TreeNode * t);
float float_from_node(TreeNode * t);
bool is_relative_type(Type a, Type b);
bool can_convert(Type a, Type b);
VarType * new_type(TreeNode * tree);
FuncType new_func_type(TreeNode * tree);
void	free_type(VarType *);
ParamNode * new_param_node(TreeNode * tree);

#endif /* tinytype_h */
