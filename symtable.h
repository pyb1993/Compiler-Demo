#ifndef _SYMTAB_H_
#define _SYMTAB_H_
#include "globals.h"
#include "tinytype.h"
/* st_insert insert token name, lineno and memory location */
void st_insert(char * name, int lineno, int loc, int size,int depth,TypeInfo type);
void st_delete(char * name);
TypeInfo st_lookup_type(char * name);
Type getBasicType(TypeInfo typeinfo);
int  st_lookup_scope(char * name);
int st_lookup(char * name); /*   Function st_lookup returns the memory location of a variable or -1 if not found*/
void printSymTab(FILE * listing);
void setFunctionAdress(char * name,int adress);
int getFunctionAdress(char * name);
bool is_duplicate_var(char * name, int depth);
bool is_basic_type(TypeInfo type,Type btype);
#endif
