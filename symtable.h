#ifndef _SYMTAB_H_
#define _SYMTAB_H_
#include "globals.h"
#include "tinytype.h"

typedef struct BucketListRec
{
	char * name;
	int memloc; /* memory location for variable */
	int mem_size;/* memory size for this variable */
	int scope_depth;// the scope depth
	TypeInfo var_type;
	struct BucketListRec * next;
} *BucketList;

/* st_insert insert token name, lineno and memory location */
BucketList st_get_node(char * name);
void st_insert(char * name, int lineno, int loc, int size,int depth,TypeInfo type);
void st_delete(char * name);
TypeInfo st_lookup_type(char * name);
int  st_lookup_scope(char * name);
int st_lookup(char * name); /*   Function st_lookup returns the memory location of a variable or -1 if not found*/
void printSymTab(FILE * listing);
bool is_duplicate_var(char * name, int depth);
#endif
