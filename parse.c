#include "globals.h"
#include "util.h"
#include "scan.h"
#include "assert.h"
#include "parse.h"

#define MAX_TYPE_DEF 100
#define MAX_TOKEN 10000

static TokenType token; /* holds current token */
static TokenType token_array[MAX_TOKEN];// holds last token
static char* token_string_array[MAX_TOKEN];
static int pos = 0;// hold the current token position
static typeDefMap type_map[MAX_TYPE_DEF];// typedef 映射


/* function prototypes for recursive calls */
static TreeNode * stmt_sequence();
static TreeNode * statement();
static TreeNode * if_stmt();
static TreeNode * while_stmt();
static TreeNode * funcall_exp();
static TreeNode * read_stmt();
static TreeNode * write_stmt();
static TreeNode * declare_stmt();
static TreeNode * break_stmt();
static TreeNode * continue_stmt();
static TreeNode * return_stmt();
static TreeNode * parseExp();
static TreeNode * conditionExp();
static TreeNode * parseAssignExp();
static TreeNode * parsePointExp(TreeNode*);
static TreeNode * parseArrowExp(TreeNode*);
static TreeNode * compare_exp();
static TreeNode * simple_exp();
static TreeNode * term();
static TreeNode * piexp();
static TreeNode * factor();
static TreeNode * lparenStartstmt();
static TreeNode * block_stmt();
static TreeNode * asmStmt();
static TreeNode * importStmt();
static void addTypedef();
static int indexOfTypeMap(char * key);

//help function
static TreeNode * parseOneVar();
static TreeNode * parseOneExp();
static TreeNode * param_pass();// parse function call params
static TreeNode * paramK_stmt();// parse function def params
static TreeNode * parseStruct();// parse struct declaration or struct definition
static TreeNode * parseStructDef();
static TreeNode * parseIndexNode(TreeNode*);
static TreeNode * parseSwitchStmt();
static TreeNode * parseCaseNode();
static TreeNode * parseDefaultNode();
static TypeInfo parseBaseType(void);
static TypeInfo parseDeclareType();
static TypeInfo parsePointerType(TypeInfo);
static void rollback(int);
static bool checkTokenIsType(TokenType,char *);


static void initTokens();
static void unGetToken();
static void matchWithoutSkipLineEnd(TokenType tok);
static void skipLineEnd();

static TokenType  currentToken();
static ArrayType parseArrayType(TypeInfo eleType);


static void syntaxError(char * message)
{
	fprintf(listing, "\n>>> ");
	fprintf(listing, "Syntax error at line %d: %s", lineno, message);
	Error = TRUE;
	assert(!message);
}

static TokenType tryNextToken()
{
	return token_array[pos + 1];
}

static void match(TokenType expected)
{
	if (token != expected){
		printToken(token,"");
		assert(token == expected);
	}
	token = currentToken();
	while (token == LINEEND && token != ENDFILE) { token = currentToken(); } // skip the remain empty line
}

bool match_possible_lbracket()
{
	if (token == LBRACKET) {
		match(LBRACKET);
		return true;
	}
	return false;
}

void match_possible_rbracket(bool in_block)
{
	if (in_block){
		if (token == RBRACKET) match(RBRACKET);
		else syntaxError("rbracket missing");
	}
}

/*fucking multi platform!!!*/
//there need to reconstruct , for check if ,while ,else statement in the global statement!
// if token beyond int/float,error need to be throw
TreeNode * stmt_sequence(void)
{
	TreeNode * t = statement();
	TreeNode * p = t;
	TreeNode* q;

	while ((token != ENDFILE) && (token != END) &&
		   (token != RBRACKET) && (token != ELSE) &&
		   (token != CASE) && (token != DEFAULT))
	{
		// typedef 比较特殊,单独处理
		q = statement();
		if (q != NULL) 
		{
			if (t == NULL) t = p = q;
			else /* now p cannot be NULL either */
			{
				p->sibling = q;
				p = q;
			}
		}
	}
	return t;
}

// 解析typedef语句
void addTypedef()
{
	matchWithoutSkipLineEnd(TYPEDEF);
	TypeInfo type = parseDeclareType();
	int i = 0;
	char * key = copyString(tokenString);
	while (i < MAX_TYPE_DEF && type_map[i].key != NULL){ ++i; }
	assert(i < MAX_TYPE_DEF);
	
	type_map[i].key = key;
	type_map[i].type = type;
	match(ID);
}

// 用来获取对应的type的index
int indexOfTypeMap (char * key)
{
	int i = 0;
	while (i < MAX_TYPE_DEF)
	{
		if (type_map[i].key != NULL && strcmp(type_map[i].key, key) == 0)
		{
			break;
		}
		++i;
	}
	if (i == MAX_TYPE_DEF) { return -1; }
	return i;
}



TreeNode * statement(void)
{
	TreeNode * t = NULL;
	switch (token) 
  {
	case IF: t = if_stmt(); break;
	case WHILE: t = while_stmt(); break;
	case CONTINUE: t = continue_stmt(); break;
    case BREAK: t = break_stmt();break;
	case RETURN:t = return_stmt(); break;
	case LPAREN:t = lparenStartstmt();break;
	case ID:
		// 非类型ID单独开头只可能是 表达式
		if (indexOfTypeMap(tokenString) == -1) { t = parseExp(); }
		else { t = declare_stmt(); }
		break;
	case TIMES:
	case PPLUS:
	case MMINUS:
		t = parseExp();
		break;
	case LBRACKET: t = block_stmt(); break;
	case SWITCH: t = parseSwitchStmt(); break;
	case READ: t = read_stmt(); break;
	case WRITE: t = write_stmt(); break;
	case ASM: t = asmStmt(); break;
	case IMPORT: t = importStmt(); break;
	case CONST:
	case INT:  
	case FLOAT:
	case VOID:
	case CHAR:
		t = declare_stmt();
		break;
	case TYPEDEF:
		addTypedef();
		t = statement();//单独处理
		break;
	case STRUCT:
		t = parseStruct();
		break;
	case LINEEND: // ignore it
		match(LINEEND);
		break;
	case RBRACKET:// a empty statment
		break;
	default:
		syntaxError("unexpected token -> ");
		printToken(token, tokenString);
		token = currentToken();
		break;
  } /* end case */
	return t;
}


TreeNode * if_stmt(void)
{	
	TreeNode * t = newStmtNode(IfK);
	match(IF);
	if (t != NULL) t->child[0] = parseExp();
	skipLineEnd();

	bool in_block = match_possible_lbracket();
	t->child[1] = in_block ? stmt_sequence() : statement();
	skipLineEnd();
	match_possible_rbracket(in_block);
	
	if (token == ELSE)
    {
		match(ELSE);
		bool in_block = match_possible_lbracket();
		t->child[2] = in_block ? stmt_sequence() : statement();
		match_possible_rbracket(in_block);
	}
    else if(token == ELSIF)
    {
        match(ELSIF);
    }
	return t;
}

TreeNode * while_stmt(void)
{
	TreeNode * t = newStmtNode(RepeatK);
	match(WHILE);
	if (t != NULL) t->child[0] = parseExp(); //child[0] for test
	skipLineEnd();

	bool in_block = match_possible_lbracket();
	t->child[1] = in_block ? stmt_sequence() : statement();
	skipLineEnd();
	match_possible_rbracket(in_block);

	return t;
}

// import [其他模块]的语句节点
TreeNode * importStmt()
{
	TreeNode * t = newStmtNode(ImportK);
	match(IMPORT);
	t->attr.name = copyString(tokenString);
	match(ID);
	skipLineEnd();
	return t;
}
// 插入tm系统调用 语句的节点
TreeNode * asmStmt()
{
	TreeNode * t = newStmtNode(AsmK);
	match(ASM);
	match(LPAREN);
	t->attr.name = copyString(tokenString);// get system call name
	match(ID);
	match(COMMA);
	for (int i = 0; i < MAXCHILDREN && token != RPAREN; ++i)
	{
		t->child[i] = parseExp();
		if (token == COMMA) match(COMMA);
	}
	match(RPAREN);
	skipLineEnd();
	return t;
}

// parse {xxx;xxx;}
TreeNode * block_stmt(void)
{
	TreeNode * t = newStmtNode(BlockK);
	match(LBRACKET);
	t->child[0] = stmt_sequence(); // child[1] for body
	match(RBRACKET);
	return t;
}

TreeNode * break_stmt(void)
{
    TreeNode * t = newStmtNode(BreakK);
    match(BREAK);
    return t;
}

TreeNode * continue_stmt(void)
{
	TreeNode * t = newStmtNode(ContinueK);
	match(CONTINUE);
	return t;
}

// return / return x;
TreeNode * return_stmt(void)
{
	TreeNode * t = newStmtNode(ReturnK);
	TokenType next = tryNextToken();
	match(RETURN);

	if (next == LINEEND)
	{
		t->child[0] = NULL;
	}
	else
	{
		t->child[0] = parseExp();
	}
	return t;
}

TreeNode * funcall_exp(TreeNode * t)
{
	TreeNode * function = newExpNode(FuncallK);
	function->attr.name = copyString(t->attr.name);
	match(ID);
	match(LPAREN);
	function->child[0] = param_pass();
	function->child[1] = t;
	return function;
}

 TreeNode * param_pass(void)
{
    TreeNode * next;
	TreeNode * t;
	if (token == VOID || token == RPAREN)
	{
		if (token == VOID) matchWithoutSkipLineEnd(VOID);
		match(RPAREN);
		return NULL;
	}

	t = parseOneExp();// parse first param, why deal with it specifically? because I need to return t
	next = t;

	while (token != RPAREN)
	{
		next->sibling = parseOneExp();
		next = next->sibling;
	}
	matchWithoutSkipLineEnd(RPAREN);
	return t;
}


TreeNode * read_stmt(void)
{
	TreeNode * t = newStmtNode(ReadK);
	matchWithoutSkipLineEnd(READ);
	if ((t != NULL) && (token == ID))
		t->attr.name = copyString(tokenString);
	match(ID);
	return t;
}

TreeNode * write_stmt(void)
{
	TreeNode * t = newStmtNode(WriteK);
	match(WRITE);
	if (t != NULL) t->child[0] = parseExp();
	return t;
}

/*this function will return paramk -> paramk -> .... paramk*/
static TreeNode* paramK_stmt(void)
{
	matchWithoutSkipLineEnd(LPAREN);
	
	if ((token == VOID  && tryNextToken() == RPAREN) || token == RPAREN)
	{
		if (token == VOID) { matchWithoutSkipLineEnd(VOID); }
        
        match(RPAREN);
        return NULL;
    }

	TreeNode *t = parseOneVar();// parse first param, why deal with it specifically? because I need to return t
	TreeNode *next = t;

	while (token != RPAREN)
	{
		next->sibling = parseOneVar();
		next = next->sibling;
	}
	match(RPAREN);
	return t;
}

TreeNode* parseOneVar()
{
	TreeNode * t = declare_stmt();
	t->kind.stmt = ParamK;
	if (token != RPAREN) { matchWithoutSkipLineEnd(COMMA); }
	return t;
}

TreeNode* parseOneExp()
{
	TreeNode * t = parseExp();
	if (token != RPAREN) { matchWithoutSkipLineEnd(COMMA); }
	return t;
}

 void unGetToken()
{
	 token = token_array[--pos];
	 while (token == LINEEND && pos > 0) { token = token_array[--pos]; }
	 int i = 0;
	 
	 char * str = token_string_array[pos];
	 do{ tokenString[i++] = *str; } while (*str++ != '\0');
}

 TokenType getLastTokenWithoutSkipLineEnd()
 {
	 return token_array[pos - 1];
 }

 void skipLineEnd()
 {
	 if (token == LINEEND) match(LINEEND);
 }

 void matchWithoutSkipLineEnd(TokenType expected)
 {
	 if (token == expected){
		 token = currentToken();
	 }
	 else {
		 syntaxError("unexpected token -> ");
		 printToken(token, tokenString);
		 syntaxError("the required toke should be");
		 printToken(expected, "");
		 fprintf(listing, "      ");
	 }
 }


 TokenType  currentToken()
 {
	 int i = 0;
	 char * str = token_string_array[++pos];
	 do{ tokenString[i++] = *str; } while (*str++ != '\0');
	 
	 return token_array[pos];
 }

 /* init tokens and tokenStrings */
 void initTokens()
 {
	#define addToken(token,tokenstr)  do\
	 {\
		token_array[i] = token;\
		token_string_array[i++] = tokenstr;\
	}while(0)\

	 int i = 0;

	 TokenType tok = getToken();
	 TokenType last_tok;
	 while (tok == LINEEND && tok != ENDFILE) tok = getToken();// skip the first LINEEND
	 addToken(tok, copyString(tokenString));// 

	 while (tok != ENDFILE)
	 {
		 last_tok = tok;
		 tok = getToken();
		 if (tok == last_tok && last_tok == LINEEND) continue;
		 addToken(tok, copyString(tokenString));
		 
	 }

	 addToken(ENDFILE, NULL);
	 pos = -1;
 }


 TypeInfo parsePointerType(TypeInfo type)
{
    assert(token == TIMES);
    TypeInfo ptype = createTypeFromBasic(Pointer);
    *ptype.point_type.pointKind = type;
    ptype.point_type.plevel = 0;
    while (token == TIMES) { ptype.point_type.plevel += 1; match(TIMES); }
	 
	 return ptype; 
 }

 // 用来解析一个type的声明
 // eg: int/ int * / int []
 TypeInfo parseDeclareType()
 {
	 TypeInfo type = parseBaseType();

	 if (token == TIMES)
	 {
		 type = parsePointerType(type);
	 }

	 if (token == LSQUARE)// array
	 {
		 type.array_type = parseArrayType(type);
		 type.typekind = Array;
		 skipLineEnd();
	 }
	 return type;
 }

 TypeInfo parseBaseType(void)
 {
	 TypeInfo type = createTypeFromBasic(Void);
	 bool is_const = false;
	 int index = -1;

	 if (token == CONST)
	 {
		 is_const = true;
		 matchWithoutSkipLineEnd(CONST);
	 }

	 switch (token)
	 {
	 case LPAREN:
		 matchWithoutSkipLineEnd(LPAREN);
		 type = parseDeclareType();
		 matchWithoutSkipLineEnd(RPAREN);
		 break;
	 case INT:
		 matchWithoutSkipLineEnd(INT);
		 type = createTypeFromBasic(Integer);
		 break;
	 case FLOAT:
		 matchWithoutSkipLineEnd(FLOAT);
		 type = createTypeFromBasic(Float);
		 break;
	 case CHAR:
		 matchWithoutSkipLineEnd(CHAR);
		 type = createTypeFromBasic(Char);
		 break;
	 case VOID:
		 matchWithoutSkipLineEnd(VOID);
		 type = createTypeFromBasic(Void);
		 break;
	 case STRUCT:
		 matchWithoutSkipLineEnd(STRUCT);
		 type = createTypeFromBasic(Struct);
		 type.sname = copyString(tokenString);
		 matchWithoutSkipLineEnd(ID);// struct name
		 break;
	 case ID:
		 index = indexOfTypeMap(tokenString);
		 if (index >= 0){ 
			 type = type_map[index].type;
			 matchWithoutSkipLineEnd(ID);// type name
		 }
		 else { syntaxError("undefined type");}
		 break;
	 
	 default:
		 matchWithoutSkipLineEnd(token);
		 syntaxError("undefined type");
		 break;
	 }

	 // 此处考虑 typedef const x type 这样的可能,type本身就是const的了
	 type.is_const = is_const || type.is_const;
	 return type;
 }

 TreeNode* declare_stmt(void)
 {
	 TreeNode* t = newStmtNode(DeclareK);
	 t->type = parseBaseType();

	 if (token == TIMES)
	 {
		 t->type = parsePointerType(t->type);
	 }
	 t->attr.name = copyString(tokenString);
	 matchWithoutSkipLineEnd(ID);

	 if (token == LSQUARE)// array
	 {
		 t->type.array_type = parseArrayType(t->type);
		 t->type.typekind = Array;
	 }
	 else if (token == LPAREN)// function
	 {
		 t->return_type = t->type; // define the return type;
		 t->type = createTypeFromBasic(Func);
		 t->child[0] = paramK_stmt();
         if(token == LBRACKET)
         {
		  match(LBRACKET);
		  t->child[1] = stmt_sequence();
		  match(RBRACKET);
         }
    }
	 else if (token == ASSIGN)
	 {
		// not support array initialzation
		 matchWithoutSkipLineEnd(ASSIGN);// can ignore empty line
		t->child[2] = parseExp();
	 }

	 skipLineEnd();
	 return t;
 }
 
 /*
 two possible case
 (....) type declaration
 (.....) exp
 */
 TreeNode * lparenStartstmt()
 {
	 int pos_backup = pos;
	 int state = 0;// the parse_exp
	 matchWithoutSkipLineEnd(LPAREN);
	 while (token == LPAREN)
	 {
		 matchWithoutSkipLineEnd(LPAREN);
	 }
	 
	 if (checkTokenIsType(token,tokenString))
	 {
		 while (tryNextToken() != ID && tryNextToken() != LINEEND)
		 {
			 matchWithoutSkipLineEnd(token);
		 }
		 assert(tryNextToken() == ID);
		 if (token == LPAREN) state = 0;// (type)(f) exp
		 else state = 1; //declare stmt
	 }
	 else
		 state = 0;// (ID) exp

	 rollback(pos_backup);
	 return state == 0 ? declare_stmt() : parseExp();
 }

 // 优先级别最低
 TreeNode * parseExp()
{
	 return conditionExp();
}



// 处理各种逻辑表达符号 eg:&&,||,!
TreeNode * conditionExp()
{
	TreeNode * t = compare_exp();
	while (token == AND || token == OR)
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL)
		{
			p->child[0] = t;
			p->attr.op = token;
			matchWithoutSkipLineEnd(token);
			p->child[1] = compare_exp();
			t = p;
		}
	}
	return t;
}

TreeNode * compare_exp(void)
{
	TreeNode * t = parseAssignExp();
	if ((token == LT) || (token == EQ) || (token == GT) || (token == LE) || (token == GE) || (token == NOTEQ))
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) {
			p->child[0] = t;
			p->attr.op = token;
			t = p;
		}
		matchWithoutSkipLineEnd(token);
		if (t != NULL)
			t->child[1] = parseAssignExp();
	}

	return t;
}

// 用来处理 a = b = c
TreeNode * parseAssignExp()
{
	TreeNode * t = simple_exp();
	while (token == ASSIGN)
	{
		TreeNode * p = newExpNode(AssignK);
		if (p != NULL)
		{
			p->child[0] = t;
			t = p;
			matchWithoutSkipLineEnd(token);
			t->child[1] = simple_exp();// why? because the x = y = z = w,y = z = w is also a assinK
		}
	}
	return t;
}


TreeNode * simple_exp(void)
{
	TreeNode * t = term();
	while (token == PLUS || token == MINUS || token == PLUSASSIGN || token == MINUSASSIGN)
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) 
		{
			// convert x += y to x = x + y || a[3] += 4
			if (token == PLUSASSIGN || token == MINUSASSIGN)
			{
				TreeNode * assign_left = t;
				t = newExpNode(AssignK);
				t->child[0] = assign_left;
	
				// parse the y of x += y
				p->attr.op = token;
				p->child[0] = newExpNode(IdK);
				*p->child[0] = *assign_left;// copy attr of assign left
				matchWithoutSkipLineEnd(token);
				p->child[1] = term();
				t->child[1] = p;
			}
			else
			{
				p->child[0] = t;
				p->attr.op = token;
				t = p;
				matchWithoutSkipLineEnd(token);
				t->child[1] = term();//
			}
		}
	}

	return t;
}
// s.f()
// l.x-- => (l.x)--
TreeNode * term(void)
{
	TreeNode * t = piexp();
	while ((token == TIMES) || (token == OVER) || (token == MOD) || (token == BITAND) || token == PPLUS || token  == MMINUS
		   || token == LPAREN)
	{
		if (token == PPLUS || token == MMINUS)
		{

			TreeNode * p = newExpNode(SingleOpK);
			p->child[0] = t;
			p->return_type.typekind = After;
			p->attr.op = token;
			t = p;
			matchWithoutSkipLineEnd(token);
		}
		else if (token == LPAREN)
		{
			unGetToken();
			t = funcall_exp(t);	
		}
		else
		{
			TreeNode * p = newExpNode(OpK);
			p->child[0] = t;
			p->attr.op = token;
			t = p;
			matchWithoutSkipLineEnd(token);
			p->child[1] = piexp();
		}
		
	}
	return t;
}
/*
   单目操作符号,它和前面的操作是帮定在一起的,结合顺序定义为从左到右
   同时注意到特点是先有左边的结果,然后才有右边符号的结合。
   exp[a].s[6]
*/
TreeNode * piexp()
{
	TreeNode * t = factor();
	while (token == POINT || token == LSQUARE || token == ARROW)
	{
		// eg (p+5)[i] || f(123)[j][k] || s[x].y
		switch (token)
		{
		case POINT:t = parsePointExp(t); break;
		case LSQUARE: t = parseIndexNode(t); break;
		case ARROW: t = parseArrowExp(t); break;
		}
	}
	return t;
}

// 处理所有优先级别最高的表达式
TreeNode * factor(void)
{
	TreeNode * t = NULL;
    TokenType last_token;

	// 如果是 type(exp) 的类型表达式
	if (checkTokenIsType(token, tokenString))
	{
		TypeInfo type = parseDeclareType();
		TreeNode * t = newExpNode(SingleOpK);
		TreeNode * exp = parseExp();
		t->child[0] = exp;
		t->attr.op = CONVERSION;
		t->type = type;
		return t;
	}

	// 接下来是各种普通表达式子
	switch (token) 
	{
	case MINUS:
		matchWithoutSkipLineEnd(MINUS);
		t = newExpNode(SingleOpK);
		t->child[0] = piexp();
		t->attr.op = NEG;
		break;
	case TIMES:
		matchWithoutSkipLineEnd(TIMES);
		t = newExpNode(SingleOpK);
		t->child[0] = piexp();
		t->attr.op = UNREF;
		break;
	case BITAND:
		matchWithoutSkipLineEnd(BITAND);		
		t = newExpNode(SingleOpK);
		t->child[0] = piexp();
		t->attr.op = ADRESS;
		break;
	case MMINUS:
	case PPLUS:// ++x, ++a[i], ++s.x
		t = newExpNode(SingleOpK);
		t->attr.op = token;
		t->return_type.typekind = Before;
		matchWithoutSkipLineEnd(token);
		t->child[0] = piexp();
		break;
	case NUM:
		t = newExpNode(ConstK);
		t->attr.val.integer = atoi(tokenString);
		t->type = createTypeFromBasic(Integer);
		matchWithoutSkipLineEnd(NUM);
		break;
    case FlOATNUM:
        t = newExpNode(ConstK);
		t->attr.val.flt = (float)atof(tokenString);
		t->type = createTypeFromBasic(Float);
		matchWithoutSkipLineEnd(FlOATNUM);
        break;
	case CHARACTER:
		t = newExpNode(ConstK);
		t->attr.val.integer = (char)(tokenString[1]);
		t->type = createTypeFromBasic(Char);
		matchWithoutSkipLineEnd(CHARACTER);
		break;
	case STRING:
		t = newExpNode(ConstK);
		t->attr.name = copyString(tokenString + 1);
		*(t->attr.name + strlen(tokenString) - 2) = '\0'; // 处理多出的"
		t->type = createTypeFromBasic(String);
		matchWithoutSkipLineEnd(STRING);
		break;
	case ID:
		t = newExpNode(IdK);
		t->attr.name = copyString(tokenString);
		matchWithoutSkipLineEnd(ID);
		break;
	case SIZEOF:
		// todo : 增加一个宏用来判断是不是类型
		// sizeof(x) 这种操作时最小的独立个体,后面不能接. -> []等表达式
		t = newExpNode(SingleOpK);
		t->attr.op = SIZEOF;
		matchWithoutSkipLineEnd(SIZEOF);
		matchWithoutSkipLineEnd(LPAREN);
		if (checkTokenIsType(token,tokenString)){
			t->return_type = parseDeclareType();
		}
		else {
			t->child[0] = parseExp();
		}
		matchWithoutSkipLineEnd(RPAREN);
		break;
	case LPAREN:
		// todo support comma expression, backup the pos, and restore!!!
		matchWithoutSkipLineEnd(LPAREN);
		t =  parseExp();
		matchWithoutSkipLineEnd(RPAREN);
		break;
	default:
		syntaxError("unexpected token -> ");
		printToken(token, tokenString);
		token = currentToken( );
		break;
	}
	return t;
}


/* Function parse returns the newly constructed syntax tree*/
TreeNode * parse(void)
{
	TreeNode * t;
	initTokens();
	token = currentToken();
	t = stmt_sequence();
	if (token != ENDFILE) syntaxError("Code ends before file\n");
	clear();
	return t;
}

ArrayType parseArrayType(TypeInfo element_type)
{
	ArrayType atype;
	atype.ele_type = (TypeInfo *)malloc(sizeof(TypeInfo));
	// todo remove bad smell
	int element_num = 0;

	matchWithoutSkipLineEnd(LSQUARE);
	element_num = atoi(tokenString);
	matchWithoutSkipLineEnd(NUM);
	matchWithoutSkipLineEnd(RSQUARE);
	if (token != LSQUARE)
	{
		*atype.ele_type = element_type;
	}
	else
	{
		TypeInfo * ele_type = atype.ele_type;
		ele_type->array_type = parseArrayType(element_type);
		ele_type->typekind = Array;
	}

	atype.ele_num = element_num;
	return atype;
}

TreeNode * parseSwitchStmt()
{
	TreeNode * t = newStmtNode(SwitchK);
	matchWithoutSkipLineEnd(SWITCH);
	t->child[0] = parseExp();// switch(exp)

	// parse casenode1->casenode2->casenode3...->casenodex->NULL
	// 因为需要检查case,所以不能使用通用的block_stmt
	skipLineEnd();
	match(LBRACKET);
	TreeNode *blockNode = newStmtNode(BlockK);
	blockNode->child[0] = parseCaseNode();
	TreeNode * cur_case = blockNode->child[0];
	while (token == CASE)
	{
		cur_case->sibling = parseCaseNode();
		cur_case = cur_case->sibling;
	}

	if (token == DEFAULT){
		cur_case->sibling = parseDefaultNode();
		cur_case = cur_case->sibling;
	}

	t->child[1] = blockNode;
	match(RBRACKET);
	return t;
}
// default: 
TreeNode * parseDefaultNode(){
	matchWithoutSkipLineEnd(DEFAULT);
	TreeNode * default_node = newStmtNode(DefaultK);
	match(CLON);
	default_node->child[1] = stmt_sequence();
	return default_node;
}

// 用来解析case 语法
TreeNode * parseCaseNode()
{
	matchWithoutSkipLineEnd(CASE);
	TreeNode * case_node = newStmtNode(CaseK);
	case_node->child[0] = parseExp();
	match(CLON);
	if (token == CASE){
		//处理空的case
		case_node->child[1] = NULL;
	}
	else{
		case_node->child[1] = stmt_sequence();
	}
	return case_node;
}

TreeNode * parseIndexNode(TreeNode * lhs_exp)
{
	TreeNode * t = newExpNode(IndexK);
	if (token != LSQUARE) 
	{
		return lhs_exp;
	}

	matchWithoutSkipLineEnd(LSQUARE);
	t->child[0] = lhs_exp;
	t->child[1] =  parseExp();
	matchWithoutSkipLineEnd(RSQUARE);
	return parseIndexNode(t);
}

TreeNode * parseStruct()
{

	int pos_backup = pos;
	matchWithoutSkipLineEnd(STRUCT);
	match(ID);
	if (token == LBRACKET)
	{
		rollback(pos_backup);
		return parseStructDef();
	}
	else
	{
		rollback(pos_backup);
		return declare_stmt();
	}
}

// parse the strcut definition,return the member list
TreeNode * parseStructDef()
{
	TreeNode * t = newStmtNode(StructDefineK);
	TreeNode * members = NULL;

	match(STRUCT);
	t->attr.name = copyString(tokenString);
	match(ID);

	match(LBRACKET);
	while (token != RBRACKET)
	{
		if (members == NULL)
		{
			t->child[0] = declare_stmt();
			members = t->child[0];
		}
		else
		{
			members->sibling = declare_stmt();
			members = members->sibling;
		}
	}
	
	match(RBRACKET);
	return t;
}

// todo remove this to one function
 TreeNode * parsePointExp(TreeNode* lhs_exp)
{
	 if (token != POINT) { return lhs_exp; }
	 TreeNode * t = newExpNode(PointK);
	 matchWithoutSkipLineEnd(POINT);
	 t->child[0] = lhs_exp;
	 t->attr.name = copyString(tokenString);
	 matchWithoutSkipLineEnd(ID);
	 return parsePointExp(t);
}

 TreeNode * parseArrowExp(TreeNode* lhs_exp)
 {
	 if (token != ARROW) { return lhs_exp; }
	 TreeNode * t = newExpNode(ArrowK);
	 matchWithoutSkipLineEnd(ARROW);
	 t->child[0] = lhs_exp;
	 t->attr.name = copyString(tokenString);
	 matchWithoutSkipLineEnd(ID);
	 return parseArrowExp(t);
 }

 void rollback(int pos_backup) 
 {
	 while (pos > pos_backup) unGetToken(); 
 }

 static bool checkTokenIsType(TokenType token,char * tokenStr)
 {
	 return token == INT || token == FLOAT || 
			token == CHAR || token == STRUCT ||
			token == VOID || (indexOfTypeMap(tokenStr) >= 0);
 }
