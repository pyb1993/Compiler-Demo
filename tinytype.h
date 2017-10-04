

#ifndef tinytype_h
#define tinytype_h

#include "globals.h"
typedef enum {BTYPE,FUNTYPE,STYPE} TypeKind;// the basic type,function type and struct type

typedef struct _FuncType{
	int a;
} FuncType;

typedef struct _VarType
{
    
    //struct BasicType * basic_type;//  -> LFloat -> LBoolean and so on;
    union
    {
        Type btype;				  // case basic type : such as the LInteger,LBoolean,LFloat
         FuncType ftype;   //  case function type: function can also be a variable. which is not implemented.
        struct _VarType * stype; //   case struct type :  
    } typeinfo;
    
    struct _VarType * next; // only meaningful in the case strcut type
    TypeKind typekind; //the upper type
} VarType;


bool equal_type(VarType a, VarType b);
VarType type_from_basic(Type type);
int integer_from_node(TreeNode * t);
float float_from_node(TreeNode * t);
bool is_relative_type(Type a, Type b);
bool can_convert(Type a, Type b);


#endif /* tinytype_h */
