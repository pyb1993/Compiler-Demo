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
	IF, ELSE,ELSIF, END, WHILE,BREAK,CONTINUE,RETURN,UNTIL, READ, WRITE,LINEEND,
	/* multicharacter tokens */
	ID,NEG,ADRESS, UNREF, NUM, FlOATNUM,
	/* special symbols */
	ASSIGN, EQ, LT, GT, LE, GE, PLUS,PPLUS,PLUSASSIGN, MINUS,MMINUS,MINUSASSIGN, TIMES, OVER, BITAND, LPAREN, RPAREN, SEMI, COMMA,
	POINT, LBRACKET, RBRACKET, LSQUARE, RSQUARE, STRING,STRUCT,
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
typedef enum { IfK, RepeatK, ReadK, WriteK,DeclareK,DefineK,StructDefineK,ParamK,BreakK,ContinueK,ReturnK } StmtKind;
typedef enum { AssignK, OpK, SingleOpK, IndexK, PointK, ConstK, IdK, FuncallK } ExpKind;
/* ExpType is used for type checking */
typedef enum { ErrorType, Void,Boolean, Integer, Float, Pointer,Array,Struct, Func } Type;// literal type, the expression has the rvalue, and the variable has the lvalue


#define MAXCHILDREN 3
struct _dimension;
typedef struct _dimension
{
	int dim; // used for array
	struct _dimension* next_dim;
} DimensionList;

typedef struct _ArrayType
{
	struct _TypeInfo* ele_type;
	int ele_num;
} ArrayType;

typedef struct _PointType
{
	int plevel;
	struct _TypeInfo * pointKind; // Integer,Float,Boolean,Struct
} PointType;

typedef struct _TypeInfo
{
	Type typekind;
	ArrayType array_type;
	PointType point_type;
	char *sname;
} TypeInfo;

typedef struct treeNode
{
	struct treeNode * child[MAXCHILDREN];
	struct treeNode * sibling;
	int lineno;
	bool empty_exp;
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
    
    TypeInfo type; // if type is not the elementary type;
	TypeInfo return_type; // used only for the return type of function || pointer_type
	TypeInfo converted_type; // used for exp
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

extern int done;
#endif
