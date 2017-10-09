#ifndef _SYMTAB_H_
#define _SYMTAB_H_
#include "globals.h"
#include "tinytype.h"
/* st_insert insert token name, lineno and memory location */
void st_insert(char * name, int lineno, int loc, int size,int depth,struct _VarType * type);
void st_delete(char * name);
Type st_lookup_type(char * name);
VarType* st_get_var_type_info(char * key);
int st_lookup(char * name); /*   Function st_lookup returns the memory location of a variable or -1 if not found*/
bool is_duplicate_var(char * name, int depth);
void printSymTab(FILE * listing);

#endif
