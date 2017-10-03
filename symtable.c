
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtable.h"
#include "tinytype.h"
/* SIZE is the size of the hash table */
#define SIZE 211

/* SHIFT is the power of two used as multiplier
 in hash function  */
#define SHIFT 4


/* the hash function */
static int hash ( char * key )
{ int temp = 0;
    int i = 0;
    while (key[i] != '\0')
    {
        temp = ((temp << SHIFT) + key[i]) % SIZE;
        ++i;
    }
    return temp;
}

/* the list of line numbers of the source
 * code in which a variable is referenced
 */
typedef struct LineListRec
{
    int lineno;
    struct LineListRec * next;
} * LineList;

/*
   The LineList is used to reference how many lineno are reference by the variable
   HashTable [BucketList(   )->BucketList(   )][ BucketList()->BucketList(   )]
 */
typedef struct BucketListRec
{   char * name;
    LineList lines;
    int memloc ; /* memory location for variable */
    int mem_size;/* memory size for this variable */
    VarType var_type;
    struct BucketListRec * next;
} * BucketList;

/* the hash table */
static BucketList hashTable[SIZE];
/* the Lab table*/

/* Procedure st_insert inserts line numbers and
 * memory locations into the symbol table
 * loc = memory location is inserted only the
 * first time, otherwise ignored
 */

void st_insert( char * name, int lineno, int loc,int size,VarType type)
{
    int h = hash(name);
    BucketList l =  hashTable[h];
    while ((l != NULL) && (strcmp(name,l->name) != 0))
        l = l->next;
    if (l == NULL) /* variable not yet in table */
    {
        l = (BucketList) malloc(sizeof(struct BucketListRec));
        l->name = name;
        l->lines = (LineList) malloc(sizeof(struct LineListRec));
        l->lines->lineno = lineno;
        l->memloc = loc;
        l->mem_size = size;
		l->var_type = type;
        l->lines->next = NULL;
        l->next = hashTable[h];
        hashTable[h] = l;
    }
    else /* found in table, so just add line number */
    { LineList t = l->lines;
        while (t->next != NULL) t = t->next;
        t->next = (LineList) malloc(sizeof(struct LineListRec));
        t->next->lineno = lineno;
        t->next->next = NULL;
    }
} /* st_insert */

/* Function st_lookup returns the memory
 * location of a variable or -1 if not found
 */
int st_lookup ( char * name )
{   int h = hash(name);
    BucketList l =  hashTable[h];
    while ((l != NULL) && (strcmp(name,l->name) != 0))
        l = l->next;
    if (l == NULL) return -1;
    else return l->memloc;
}

/*
	return the upper type of variable
*/
Type st_lookup_type(char * name)
{
    int h = hash(name);
    BucketList l =  hashTable[h];
    while ((l != NULL) && (strcmp(name,l->name) != 0))
        l = l->next;
    if (l == NULL)
        return ErrorType;
    if (l->var_type.typekind == BTYPE){
        return l->var_type.typeinfo.btype;
    }
    else
	{
		printf("type beyond BTYPE is not implemented\n");
        return ErrorType;
    }
}


/* Procedure printSymTab prints a formatted
 * listing of the symbol table contents
 * to the listing file
 */
void printSymTab(FILE * listing)
{
    int i;
    fprintf(listing,"Variable Name  Location   Memory Size      Line Numbers\n");
    fprintf(listing,"-------------  --------   -----------       -------------\n");
    for (i=0;i<SIZE;++i)
	{
		if (hashTable[i] == NULL) continue;

        BucketList l = hashTable[i];
        while (l != NULL)
        { LineList t = l->lines;
            fprintf(listing,"%-14s ",l->name);
            fprintf(listing,"%-8d  ",l->memloc);
            fprintf(listing,"%-8d bytes  ",l->mem_size);
            while (t != NULL)
            { fprintf(listing,"%4d ",t->lineno);
                t = t->next;
            }
            fprintf(listing,"\n");
            l = l->next;
        }
     
    }
} /* printSymTab */
