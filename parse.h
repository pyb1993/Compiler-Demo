/****************************************************/
/* File: parse.h                                    */
/* The parser interface for the TINY compiler       */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _PARSE_H_
#define _PARSE_H_
#include "globals.h"

/* Function parse returns the newly
* constructed syntax tree
*/
TreeNode * parse(void);
/* function prototypes for recursive calls */
static TreeNode * stmt_sequence(void);
static TreeNode * statement(void);
static TreeNode * if_stmt(void);
static TreeNode * while_stmt(void);
static TreeNode * assign_stmt(void);
static TreeNode * read_stmt(void);
static TreeNode * write_stmt(void);
static TreeNode * exp(void);
static TreeNode * simple_exp(void);
static TreeNode * term(void);
static TreeNode * factor(void);
bool match_possible_lbracket();



#endif
