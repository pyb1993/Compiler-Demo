#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtable.h"
#include "tinytype.h"
#include "assert.h"
/* SIZE is the size of the hash table */
#define SIZE 211

/* SHIFT is the power of two used as multiplierin hash function  */
#define SHIFT 4

typedef struct BucketListRec
{
	char * name;
	int memloc; /* memory location for variable */
	int mem_size;/* memory size for this variable */
	int scope_depth;// the scope depth
	VarType* var_type;
	struct BucketListRec * next;
} *BucketList;

/* the hash table */
static BucketList hashTable[SIZE];

static int hash(char * key);
static BucketList construct_node(char * name, int lineno, int loc, int size,int depth, VarType * type);
static BucketList insert_into_list( BucketList list,BucketList inserted);
static BucketList del_from_list(BucketList list, char * name);
static void free_node(BucketList node);
static BucketList st_get_node(char * name);


/*insert the node into the hashtable */
/* the hash function */
int hash(char * key)
{
	int temp = 0;
	int i = 0;
	while (key[i] != '\0')
	{
		temp = ((temp << SHIFT) + key[i]) % SIZE;
		++i;
	}
	return temp;
}


void st_delete(char * name)
{
	int h = hash(name);
	hashTable[h] = del_from_list(hashTable[h], name);
}

/* Procedure st_insert inserts line numbers and
* memory locations into the symbol table
* loc = memory location is inserted only the
* first time, otherwise ignored
*/

void st_insert( char * name, int lineno, int loc,int size,int depth,VarType * type)
{
    int h = hash(name);
	BucketList inserted = construct_node(name, lineno, loc, size,depth, type);
	hashTable[h] = insert_into_list(hashTable[h],inserted);
} 

/*
	return the head of list, and insert node to the list;
*/
BucketList insert_into_list(BucketList list,BucketList inserted)
{
	if (list == NULL) {	return inserted;}

	BucketList p = list;
	if (strcmp(p->name, inserted->name) == 0)
	{
		inserted->next = p;
		return inserted;
	}

	while (p->next != NULL && strcmp(p->next,inserted->name) != 0){ p = p->next;}
	inserted->next = p->next;
	p->next = inserted;
	return list;
}

BucketList construct_node(char * name, int lineno, int loc, int size,int depth, VarType * type)
{
	BucketList list = (BucketList)malloc(sizeof(struct BucketListRec));
	list->name = name; // note: name cannot be free !!!
	list->memloc = loc;
	list->mem_size = size;
	list->scope_depth = depth;
	list->var_type = type;
	list->next = NULL;
	return list;
}


/*return the first node in the list after delete*/
BucketList del_from_list(BucketList list, char * name){
	assert((list != NULL || !"delete failed!"));
	if (strcmp(list->name, name) == 0){
		BucketList last = list->next;
		free_node(list);
		return last;
	}
	
	while ((list->next != NULL) && (strcmp(name, list->next->name) != 0))
	{
		list = list->next;
	}

	assert((list != NULL || !"delete failed!"));
	BucketList last = list->next->next;
	free_node(list->next);
	list->next = last;
	return list;
}

void free_node(BucketList l){
	free(l);
}

/* Function st_lookup returns the memory
 * location of a variable or -1 if not found
 */
int st_lookup ( char * name )
{  
	BucketList l = st_get_node(name);
	return (l == NULL) ? -1 : l->memloc;
}

/*
	used for get type
	return the upper type of variable
*/
Type st_lookup_type(char * name)
{
	BucketList l = st_get_node(name);
	assert(l != NULL);
	assert(l->var_type->typekind == BTYPE);
    return l->var_type->typeinfo.btype;
}

bool is_duplicate_var(char * name, int depth)
{
	BucketList l = st_get_node(name);
	if (l == NULL)
	{
		return false;
	}

	return l->scope_depth == depth;
}

/*assume name must exist*/
static BucketList st_get_node(char * name)
{
	int h = hash(name);
	BucketList l = hashTable[h];
	while ((l != NULL) && (strcmp(name, l->name) != 0))
		l = l->next;
	return l;
}


/* Procedure printSymTab prints a formatted
 * listing of the symbol table contents
 * to the listing file
 */
void printSymTab(FILE * listing)
{
    int i;
    fprintf(listing,"Variable Name  Location   Memory Size   Scope Depth      Line Numbers\n");
    fprintf(listing,"-------------  --------   -----------	 -----------	  ------------\n");
    for (i=0;i<SIZE;++i)
	{
		if (hashTable[i] == NULL) continue;

        BucketList l = hashTable[i];
        while (l != NULL)
        { 
            fprintf(listing,"%-14s ",l->name);
            fprintf(listing,"%-8d  ",l->memloc);
            fprintf(listing,"%-8d bytes  ",l->mem_size);
			fprintf(listing, "%-8d bytes  ", l->scope_depth);
            fprintf(listing,"\n");
            l = l->next;
        }
     
    }
} /* printSymTab */
