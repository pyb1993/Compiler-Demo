#ifndef tinytype_h
#define tinytype_h
#include "globals.h"

typedef enum
/* book-keeping tokens */
{
	ENDFILE, ERROR,
	/* reserved words */
	IF, ELSE, ELSIF, END, WHILE, BREAK, CONTINUE, RETURN, UNTIL, READ, WRITE, LINEEND,ASM,IMPORT,
	/* multicharacter tokens */
	ID, NEG, ADRESS, UNREF, NUM, FlOATNUM,
	/* special symbols */
	ASSIGN, EQ, LT, GT, LE, GE, PLUS, PPLUS, PLUSASSIGN, MINUS, MMINUS, MINUSASSIGN, TIMES, 
	OVER, BITAND, LPAREN, RPAREN, SEMI, COMMA,POINT, ARROW, LBRACKET, RBRACKET, LSQUARE,CLON, 
	RSQUARE, CHARACTER, STRING, STRUCT,CONST,SWITCH,CASE,CONVERSION,SIZEOF,
	/*variable type*/
	INT, FLOAT, VOID, CHAR, FUN
} TokenType;

typedef enum {BTYPE,FUNTYPE,STYPE} TypeKind;// the basic type,function type and struct type
typedef enum { StmtK, ExpK } NodeKind;
typedef enum { IfK, RepeatK, ReadK, WriteK, DeclareK, BlockK, SwitchK,CaseK, DefineK, StructDefineK, ParamK, BreakK, ContinueK, ReturnK, AsmK, ImportK } StmtKind;
typedef enum { AssignK, OpK, SingleOpK, IndexK, PointK, ArrowK, ConstK, IdK, FuncallK} ExpKind;
typedef enum { ErrorType, Void, Before, After, Boolean, Integer, Float, Char, String, Pointer, Array, Struct, Func } Type;// literal type, the expression has the rvalue, and the variable has the lvalue

/**************         function type      *********************/
/**************         function type      *********************/
/**************         function type      *********************/
typedef struct _TypeInfo TypeInfo;

typedef struct _ParamNode{
	TypeInfo * type;
	struct _ParamNode* next_param;
} ParamNode;

typedef struct _FuncType
{
	TypeInfo * return_type;
	ParamNode * params;
	char * name;
	int scope_depth;
	int adress;
} FuncType;


/**************         Array type      *********************/
/**************         Array type      *********************/
/**************         Array type      *********************/
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

/**************         Pointer type      *********************/

typedef struct _PointType
{
	int plevel;
	struct _TypeInfo * pointKind; // Integer,Float,Boolean,Struct
} PointType;


/**************   TypeInfo       *********************/
/**************   TypeInfo       *********************/
/**************   TypeInfo       *********************/

typedef struct _TypeInfo
{
	bool is_const;
	Type typekind;
	ArrayType array_type;
	PointType point_type;
	FuncType func_type;
	char *sname;
} TypeInfo;

/**************         struct type      *********************/
/**************         struct type      *********************/
/**************         struct type      *********************/
typedef struct _member
{
	TypeInfo typeinfo;
	int offset;
	char * member_name;// A.x eg:x is the member_name
	struct _member *next_member;
} Member;

typedef struct _Struct
{
	TypeInfo typeinfo;  // struct BasicType * basic_type;//  -> LFloat -> LBoolean and so on;
	int scope_depth;
	Member * members; // only meaningful when typeinfo is struct
} StructType;
/**************         Tree Node       *********************/
/**************         Tree Node       *********************/

typedef struct treeNode
{
	int lineno;
	struct treeNode * child[MAXCHILDREN];
	struct treeNode * sibling;
	bool empty_exp;
	NodeKind nodekind;
	union { StmtKind stmt; ExpKind exp; } kind;
	struct {
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

/************************  FUNCTION ****************************************/
int integer_from_node(TreeNode * t);
float float_from_node(TreeNode * t);
int var_size_of_type(TypeInfo);

bool can_convert(TypeInfo a, TypeInfo b);
bool is_basic_type(TypeInfo, Type);
bool ensure_type_defined(char * key);

FuncType new_func_type(TreeNode * tree);
StructType new_struct_type(TreeNode * tree);
Type getBasicType(TypeInfo);
Member * new_member_list(TreeNode * tree,int offset);
Member * getMember(StructType, char * name);
StructType getStructType(char * name);
TypeInfo createTypeFromBasic(Type basic);

void free_type(TypeInfo );
void addStructType(char * key, StructType stype);
void freeFuncType(FuncType * ftype);
void freeParamNode(ParamNode * p);

void deleteStructType(char * key);
void initTypeCollection();
#endif /* tinytype_h */
