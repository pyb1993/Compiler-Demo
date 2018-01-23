/****************************************************/
/* File: parse.h                                    */
/* The parser interface for the TINY compiler       */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _PARSE_H_
#define _PARSE_H_
#include "globals.h"
#include "tinytype.h"

/* Function parse returns the newly
* constructed syntax tree
*/
TreeNode * parse(void);
/* function prototypes for recursive calls */
bool match_possible_lbracket();
bool is_line_end();// is the end of line?

/*用来存储typedef 定义的映射关系*/
typedef struct type_def_map
{
	char * key;
	TypeInfo type;
} typeDefMap;


#endif
