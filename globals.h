/****************************************************/
/* File: globals.h                                  */
/* Global types and vars for TINY compiler          */
/* must come before other include files             */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _GLOBALS_H_
#define _GLOBALS_H_

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

/* MAXRESERVED = the number of reserved words */
#define MAXRESERVED 20
#define MEMUNITSCALE 4      // the bytes of mem unit 
#define NOTFOUND    (404 * 404)
typedef enum
/* book-keeping tokens */
{
	ENDFILE, ERROR,
	/* reserved words */
	IF, ELSE,ELSIF, END, WHILE,BREAK,RETURN,UNTIL, READ, WRITE,LINEEND,
	/* multicharacter tokens */
	ID,NEG, NUM, FlOATNUM,
	/* special symbols */
	ASSIGN, EQ, LT, GT, LE, GE, PLUS, MINUS, TIMES, OVER, LPAREN, RPAREN, SEMI, COMMA,
	LBRACKET, RBRACKET, LSQUARE, RSQUARE, STRING,
	/*variable type*/
	INT,FLOAT,VOID,FUN
} TokenType;

extern FILE* source; /* source code text file */
extern FILE* listing; /* listing output text file */
extern FILE* code; /* code text file for TM simulator */
extern int lineno; /* source line number for listing */
/**************************************************/
/***********   Syntax tree for parsing ************/
/**************************************************/

typedef enum { StmtK, ExpK } NodeKind;
typedef enum { IfK, RepeatK, AssignK, ReadK, WriteK,DeclareK,ParamK,BreakK,ReturnK } StmtKind;
typedef enum { OpK,SingleOpK, ConstK, IdK,FuncallK } ExpKind;
/* ExpType is used for type checking */
typedef enum { ErrorType, Void,Boolean, Integer, Float, Struct, Func } Type;// literal type, the expression has the rvalue, and the variable has the lvalue

#define MAXCHILDREN 3

typedef struct treeNode
{
	struct treeNode * child[MAXCHILDREN];
	struct treeNode * sibling;
	int lineno;
	NodeKind nodekind;
	union { StmtKind stmt; ExpKind exp; } kind;
	union {
		TokenType op;//eg < > == + - * /
		char * name;// the id name
        union {
			int integer;
			float flt;
			char *str;
		} val;// constk should contain one of three values
	} attr;
    Type type;
	Type return_type; // used only for the return type
	Type converted_type;

} TreeNode;





/**************************************************/
/***********   Flags for tracing       ************/
/**************************************************/

/* EchoSource = TRUE causes the source program to
* be echoed to the listing file with line numbers
* during parsing
*/
extern int EchoSource;

/* TraceScan = TRUE causes token information to be
* printed to the listing file as each token is
* recognized by the scanner
*/
extern int TraceScan;

/* TraceParse = TRUE causes the syntax tree to be
* printed to the listing file in linearized form
* (using indents for children)
*/
extern int TraceParse;

/* TraceAnalyze = TRUE causes symbol table inserts
* and lookups to be reported to the listing file
*/
extern int TraceAnalyze;

/* TraceCode = TRUE causes comments to be written
* to the TM code file as code is generated
*/
extern int TraceCode;

/* Error = TRUE prevents further passes if an error occurs */
extern int Error;
#endif
