#include "globals.h"
#include "util.h"
#include "scan.h"
#include "assert.h"
#include "parse.h"

static TokenType token; /* holds current token */
static TokenType token_array[10000];// holds last token
static char* token_string_array[10000];
static int pos = 0;// hold the current token position

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
//help function
static TreeNode * parseOneVar();
static TreeNode * parseOneExp();
static TreeNode * param_pass();// parse function call params
static TreeNode * paramK_stmt();// parse function def params
static TreeNode * parseStruct();// parse struct declaration or struct definition
static TreeNode * parseStructDef();
static TreeNode * parseIndexNode(TreeNode*);

static TypeInfo parseBaseType(void);
static TypeInfo parsePointerType(TypeInfo);
static void rollback(int);

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

	while ((token != ENDFILE) && (token != END) &&
		   (token != RBRACKET) && (token != ELSE))
	{
		TreeNode * q;
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
	case TIMES:
	case PPLUS:
	case MMINUS:
		t = parseExp();
		break;
	case LBRACKET: t = block_stmt(); break;
	case READ: t = read_stmt(); break;
	case WRITE: t = write_stmt(); break;
	case ASM: t = asmStmt(); break;
	case IMPORT: t = importStmt(); break;
	case INT:  
	case FLOAT:
	case VOID:
	case CHAR:
		t = declare_stmt();
		break;
	case STRUCT:
		t = parseStruct();
		break;
	case LINEEND: // ignore it
		match(LINEEND);
		break;
	case RBRACKET:// a empty statment
		break;
	default: syntaxError("unexpected token -> ");
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
	t->child[1] = block_stmt();
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

TreeNode * block_stmt(void)
{
	TreeNode * t = newStmtNode(BlockK);
	bool in_block = match_possible_lbracket();
	t->child[0] = in_block ? stmt_sequence() : statement(); // child[1] for body
	match_possible_rbracket(in_block);
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
        if (token == VOID)
        {
            matchWithoutSkipLineEnd(VOID);
        }

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
	 while (tok == LINEEND && tok != ENDFILE) tok = getToken();// skip the first token
	 addToken(tok, copyString(tokenString));// 

	 while (tok != ENDFILE)
	 {
		 TokenType last_tok = tok;
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
    TypeInfo ptype;
    ptype.point_type.pointKind = (TypeInfo*)(malloc(sizeof(TypeInfo)));
    ptype.typekind = Pointer;
    *ptype.point_type.pointKind = type;
    ptype.point_type.plevel = 0;
    while (token == TIMES) { ptype.point_type.plevel += 1; match(TIMES); }
	 
	 return ptype; 
 }

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
	 TypeInfo type;
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
	 default:
		 matchWithoutSkipLineEnd(token);
		 type = createTypeFromBasic(ErrorType);
		 syntaxError("undefined type");
		 break;
	 }
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
		 t->return_type = t->type;//define the return type;
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
	 matchWithoutSkipLineEnd(LPAREN);
	 while (token == LPAREN)
	 {
		 matchWithoutSkipLineEnd(LPAREN);
	 }


	 if (token == FLOAT || token == INT || token == STRUCT || token == VOID)
	 {
		 rollback(pos_backup);
		 return declare_stmt();
	 }
	 else
	 {
		 rollback(pos_backup);
		 return parseExp();
	 }
 }

TreeNode * parseExp()
{
	TreeNode * t = compare_exp();
	while (token == ASSIGN)
	{
		TreeNode * p = newExpNode(AssignK);
		if (p != NULL) 
		{
			p->child[0] = t;
			t = p;
			matchWithoutSkipLineEnd(token);
			t->child[1] = parseExp();// why? because the x = y = z,y = z is also a assinK
		}
	}
	return t;
}

TreeNode * compare_exp(void)
{
	TreeNode * t = simple_exp();
	if ((token == LT) || (token == EQ) || (token == GT) || (token == LE) || (token == GE))
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) {
			p->child[0] = t;
			p->attr.op = token;
			t = p;
		}
		matchWithoutSkipLineEnd(token);
		if (t != NULL)
			t->child[1] = simple_exp();
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

TreeNode * term(void)
{
	TreeNode * t = piexp();
	while ((token == TIMES) || (token == OVER) || (token == BITAND) || token == PPLUS || token  == MMINUS
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

TreeNode * factor(void)
{
	TreeNode * t = NULL;
    TokenType last_token;

	switch (token) 
	{
	case MINUS:
		matchWithoutSkipLineEnd(MINUS);
		t = newExpNode(SingleOpK);
		t->child[0] = factor();
		t->attr.op = NEG;
		break;
	case TIMES:
		matchWithoutSkipLineEnd(TIMES);
		t = newExpNode(SingleOpK);
		t->child[0] = factor();
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
		// todo, remove code to other
		t = newExpNode(IdK);
		t->attr.name = copyString(tokenString);
		matchWithoutSkipLineEnd(ID);
		
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
	if (token != ENDFILE)
		syntaxError("Code ends before file\n");
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
