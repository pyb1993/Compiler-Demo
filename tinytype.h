//
//  tinytype.h
//  compiler
//
//  Created by pyb on 2017/9/26.
//  Copyright © 2017年 pyb. All rights reserved.
//

#ifndef tinytype_h
#define tinytype_h

#include "globals.h"
typedef enum {BTYPE,FUNTYPE,STYPE} TypeKind;// the basic type,function type and struct type

struct FuncType{
	int a;
};

struct  VarType
{
    
    //struct BasicType * basic_type;// basic type such as the LInteger,LBoolean -> LFloat -> LBoolean and so on;
    union
    {
        Type btype;
        struct FuncType ftype;// function can also be a variable
        struct VarType * stype;
    } typeinfo;
    
    struct VarType * next; //
    TypeKind typekind; //
};


bool equal_type(struct VarType a,struct VarType b);



#endif /* tinytype_h */
