/****************************************************/
/* File: parse.c                                    */
/* The parser implementation for the TINY compiler  */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "tinytype.h"
#include "util.h"
#include "scan.h"
#include "assert.h"
#include "parse.h"
/*
	todo: solve the ugly implementation!!!
		   how to solve function call and assignment???
		   see the source code impl
*/
static TokenType token; /* holds current token */
static TokenType token_array[10000];// holds last token
static char* token_string_array[10000];
static int pos = 0;// hold the current token position

/* function prototypes for recursive calls */
static TreeNode * stmt_sequence(void);
static TreeNode * statement(void);
static TreeNode * if_stmt(void);
static TreeNode * while_stmt(void);
static TreeNode * funcall_exp(void);
static TreeNode * read_stmt(void);
static TreeNode * write_stmt(void);
static TreeNode * declare_stmt(void);
static TreeNode * break_stmt(void);
static TreeNode * return_stmt(void);
static TreeNode * exp(void);
static TreeNode * compare_exp(void);
static TreeNode * simple_exp(void);
static TreeNode * term(void);
static TreeNode * factor(void);

//help function
static TreeNode * getPointerLevel(void);
static TreeNode * parseOneVar();
static TreeNode * parseOneExp();
static TreeNode * param_pass(void);// parse function call params
static TreeNode * paramK_stmt(void);// parse function def params
static TreeNode * idStartStmt();
static void       initTokens();
static TokenType  currentToken();
static void		  unGetToken();
static void matchWithoutSkipLineEnd(TokenType tok);
static void skipLineEnd();
static ArrayType parseArrayType(TypeInfo eleType);
static TreeNode * parseIndexNode();


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
	assert(token == expected);
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
    case BREAK: t = break_stmt();break;
	case RETURN:t = return_stmt(); break;
	case ID: t = idStartStmt(); break;
	case TIMES:
	case LPAREN:
		t = exp();
		break;
	case READ: t = read_stmt(); break;
	case WRITE: t = write_stmt(); break;
	case INT:  
	case FLOAT:
	case VOID:
		t = declare_stmt();
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
	if (t != NULL) t->child[0] = exp();
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
	if (t != NULL) t->child[0] = exp(); //child[0] for test
	skipLineEnd();
	bool in_block = match_possible_lbracket();
	t->child[1] = in_block ? stmt_sequence() : statement(); // child[1] for body
    match_possible_rbracket(in_block);
	return t;
}


TreeNode * break_stmt(void)
{
    TreeNode * t = newStmtNode(BreakK);
    match(BREAK);
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
		t->child[0] = exp();
	}
	return t;
}

TreeNode * funcall_exp(void)
{

	TreeNode *t = newExpNode(FuncallK);
	t->attr.name = copyString(tokenString);//function name
	match(ID);
	match(LPAREN);
	t->child[0] = param_pass();
	return t;
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
	match(RPAREN);
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
	if (t != NULL) t->child[0] = exp();
	return t;
}

/*this function will return paramk -> paramk -> .... paramk*/
static TreeNode* paramK_stmt(void)
{
	matchWithoutSkipLineEnd(LPAREN);
	
	if (token == VOID || token == RPAREN)
	{
		if (token == VOID) matchWithoutSkipLineEnd(VOID);
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
	TreeNode * t = exp();
	if (token != RPAREN) { matchWithoutSkipLineEnd(COMMA); }
	return t;
}

// if the first token is id, two possibilities
TreeNode * idStartStmt()
{
	match(ID);

	if(token == LPAREN)
	{
		unGetToken();
		return funcall_exp();
	}
	else
	{
		unGetToken();
	    return exp();
	}
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
	#define addToken(token,tokenstr)  do{\
									     token_array[i] = token;\
										 token_string_array[i++] = tokenstr;\
										}while(0)\

	 int i = 0;
//	 TokenType tok = getToken();
//	 while (tok == LINEEND && tok != ENDFILE) { tok = getToken();}// skip the first empty lines
//	 addToken(tok, copyString(tokenString));

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


TreeNode* declare_stmt(void)
{

	/*switch case token type */
    TreeNode* t = newStmtNode(DeclareK);
    
    switch(token)
    {
      // define a variable; eg: int value;
      case INT:
            match(INT);
			t->type = createTypeFromBasic(Integer);
            break;
	  case FLOAT:
          match(FLOAT);
		  t->type = createTypeFromBasic(Float);
		  break;
	  case VOID:
          match(VOID);
		  t->type = createTypeFromBasic(Void);
		  break;
      default:
		  match(token);
		  t->type = createTypeFromBasic(ErrorType);
          syntaxError("undefined type");
          break;
    }

    
	bool is_pointer = (token == TIMES);
    if (is_pointer)
    {
		t->type.pointKind = t->type.typekind;
		t->type.typekind = Pointer;
		t->type.plevel = 0;
		while (token == TIMES) { t->type.plevel += 1; match(TIMES);}
    }
    
    t->attr.name = copyString(tokenString);
    match(ID);

	// deal with array
	if (token == LSQUARE)
	{
		TypeInfo ele_type = t->type;
		t->type.typekind = Array;
		t->type.array_type	= parseArrayType(ele_type);
	}

    bool func_dec = (token == LPAREN);
	if (func_dec)
	{
		t->return_type = t->type;//define the return type;
		t->type = createTypeFromBasic(Func);
		t->child[0] = paramK_stmt();
		match(LBRACKET);
		t->child[1] = stmt_sequence();
		match(RBRACKET);
	}
	return t;
}

TreeNode * exp(void)
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
			t->child[1] = compare_exp();
		}
	}
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
	while ((token == PLUS) || (token == MINUS))
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) 
		{
			p->child[0] = t;
			p->attr.op = token;
			t = p;
			matchWithoutSkipLineEnd(token);
			t->child[1] = term();//
		}
	}

	// eg (p+5)[i] || (f(123)[j][k])
	if (token == LSQUARE)
	{
		TreeNode * exp = t;
		t = newExpNode(IndexK);
		t->child[0] = exp;
		t->child[1] = parseIndexNode();
	}
	return t;
}

TreeNode * term(void)
{
	TreeNode * t = factor();
	while ((token == TIMES) || (token == OVER) || (token == BITAND))
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) 
		{
			p->child[0] = t;
			p->attr.op = token;
			t = p;
			matchWithoutSkipLineEnd(token);
			p->child[1] = factor();
		}
	}
	return t;
}

TreeNode * factor(void)
{
	TreeNode * t = NULL;
    TokenType last_token;
	TokenType next_token;
	switch (token) 
	{
	case MINUS:
        last_token = getLastTokenWithoutSkipLineEnd();
		matchWithoutSkipLineEnd(MINUS);
		// the last token are part of exp; exp -
		// so the minus is just substract!
		// todo remove this to help function
		if (last_token == RBRACKET || last_token == ID || last_token == RSQUARE || last_token == NUM)
		{
			t = exp();
		}
		else
		{
			t = newExpNode(SingleOpK);
			t->child[0] = factor();
			t->attr.op = NEG;
		}
		break;
	case TIMES:
		last_token = getLastTokenWithoutSkipLineEnd();
		matchWithoutSkipLineEnd(TIMES);
		// the last token are part of exp; exp -
		// so the minus is just substract!
		// todo remove this to help function
		if (last_token == RBRACKET || last_token == ID || last_token == RSQUARE || last_token == NUM)
		{
			t = exp();
		}
		else
		{
			t = newExpNode(SingleOpK);
			t->child[0] = factor();
			t->attr.op = UNREF;
		}
		break;
	case BITAND:
		last_token = getLastTokenWithoutSkipLineEnd();
		matchWithoutSkipLineEnd(BITAND);
		// the last token are part of exp; exp -
		// so the minus is just substract!
		// todo remove this to help function
		if (last_token == RBRACKET || last_token == ID || last_token == RSQUARE || last_token == NUM)
		{
			t = exp();
		}
		else
		{
			t = newExpNode(SingleOpK);
			t->child[0] = factor();
			t->attr.op = ADRESS;
		}
		break;
	case NUM:
		t = newExpNode(ConstK);
		t->attr.val.integer = atoi(tokenString);
		t->type = createTypeFromBasic(Integer);
		matchWithoutSkipLineEnd(NUM);
		break;
    case FlOATNUM:
            t = newExpNode(ConstK);
			t->attr.val.flt = atof(tokenString);
			t->type = createTypeFromBasic(Float);
			matchWithoutSkipLineEnd(FlOATNUM);
            break;
	case ID:
		// todo, support assignment exp
		// todo, remove code to other
		next_token = tryNextToken();
		if (next_token == LPAREN) {
			t = funcall_exp();
		}
		else {
			t = newExpNode(IdK);
			t->attr.name = copyString(tokenString);
			matchWithoutSkipLineEnd(ID);
		}
		break;
	case LPAREN:
		// todo support comma expression, backup the pos, and restore!!!
		matchWithoutSkipLineEnd(LPAREN);
		t = exp();
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
	return t;
}

ArrayType parseArrayType(TypeInfo element_type)
{
	ArrayType atype;
	atype.ele_type = (TypeInfo *)malloc(sizeof(TypeInfo));
	*atype.ele_type = element_type;

	// todo remove bad smell
	int dimension = 0;
	DimensionList * origin_dimension = (DimensionList *) malloc(sizeof(DimensionList));
	DimensionList * dim_node = origin_dimension;
	match(LSQUARE);
	dim_node->dim = atoi(tokenString);
	match(NUM);
	match(RSQUARE);
	// deal with remain dimension
	while (token == LSQUARE)
	{	
		match(LSQUARE);
		dim_node->next_dim = (DimensionList *)malloc(sizeof(DimensionList));
		dim_node = dim_node->next_dim;
		dim_node->dim = atoi(tokenString);
		assert(dim_node->dim > 0);
		match(NUM);
		match(RSQUARE);
	}

	dim_node->next_dim = NULL;
	atype.dimension = origin_dimension;
	return atype;
}

TreeNode * parseIndexNode()
{
	TreeNode * index_list = NULL;
	TreeNode * head = NULL;
	while (token == LSQUARE)
	{
		matchWithoutSkipLineEnd(LSQUARE);
		if (index_list == NULL) { 
			head = exp();
			index_list = head;
		}
		else
		{
			index_list->sibling = exp();
			index_list = index_list->sibling;		
		}
		matchWithoutSkipLineEnd(RSQUARE);
	}

	return head;
}


