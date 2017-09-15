/****************************************************/
/* File: parse.c                                    */
/* The parser implementation for the TINY compiler  */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "util.h"
#include "scan.h"
#include "parse.h"

static TokenType token; /* holds current token */

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

static void syntaxError(char * message)
{
	fprintf(listing, "\n>>> ");
	fprintf(listing, "Syntax error at line %d: %s", lineno, message);
	Error = TRUE;
}

static void match(TokenType expected)
{
	if (token == expected) token = getToken();
	else {
		syntaxError("unexpected token -> ");
		printToken(token, tokenString);
		fprintf(listing, "      ");
	}
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
		else syntaxError("缺少 右大括号 : }");
	}
}


TreeNode * stmt_sequence(void)
{
	TreeNode * t = statement();
	TreeNode * p = t;
	/*
		每一个语句节点都有一个SIBLING结点,指向下一条要执行的语句
	*/
	while ((token != ENDFILE) && (token != END) &&
		   (token != RBRACKET))
	{
		TreeNode * q;
		q = statement();
		if (q != NULL) {
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
	case ID: t = assign_stmt(); break;
	case READ: t = read_stmt(); break;
	case WRITE: t = write_stmt(); break;
	case Int:
	case Float:
	case String:
		t = declare_stmt();
		break;
	default: syntaxError("unexpected token -> ");
		printToken(token, tokenString);
		token = getToken();
		break;
  } /* end case */
	match(SEMI);
	return t;
}


TreeNode * if_stmt(void)
{
	TreeNode * t = newStmtNode(IfK);
	match(IF);
	if (t != NULL) t->child[0] = exp();
	
	/*下面的语句是一个{序列}*/
	bool in_block = match_possible_lbracket();
	t->child[1] = in_block ? stmt_sequence() : statement();/*如果在{}里面就是序列，否则就只有一个语句*/
	match_possible_rbracket(in_block);

	if (token == ELSE) {
		match(ELSE);
		bool in_block = match_possible_lbracket();
		t->child[2] = in_block ? stmt_sequence() : statement();/*如果在{}里面就是序列，否则就只有一个语句*/
		match_possible_rbracket(in_block);
	}
	return t;
}



TreeNode * while_stmt(void)
{
	TreeNode * t = newStmtNode(RepeatK);
	match(WHILE);
	if (t != NULL) t->child[0] = exp();
	bool in_block = match_possible_lbracket();
	t->child[1] = in_block ? stmt_sequence() : statement();/*如果在{}里面就是序列，否则就只有一个语句*/
	match_possible_rbracket(in_block);
	return t;
}

TreeNode * assign_stmt(void)
{
	TreeNode * t = newStmtNode(AssignK);
	if ((t != NULL) && (token == ID))
		t->attr.name = copyString(tokenString);
	match(ID);
	match(ASSIGN);
	if (t != NULL) t->child[0] = exp();
	return t;
}

TreeNode * read_stmt(void)
{
	TreeNode * t = newStmtNode(ReadK);
	match(READ);
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

/*对变量进行声明*/
TreeNode* declare_stmt(TokenType token)
{
	/*token一定是Int，String，Float里面的一种*/
	TreeNode* t = newStmtNode();
	match(token);
	/*
	current_id.vartype = token;
	current_id.name = copyString(tokenString);	
	*/
}

TreeNode * exp(void)
{
	TreeNode * t = simple_exp();
	if ((token == LT) || (token == EQ) || (token == GT)) {
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) {
			p->child[0] = t;
			p->attr.op = token;
			t = p;
		}
		match(token);
		if (t != NULL)
			t->child[1] = simple_exp();
	}
	return t;
}

/*这里采取了ENBF的循环表示法来表示 + - 组成的表达式*/
TreeNode * simple_exp(void)
{
	TreeNode * t = term();
	while ((token == PLUS) || (token == MINUS))
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) {
			p->child[0] = t;
			p->attr.op = token;
			t = p;
			match(token);
			t->child[1] = term();//获取第二个term表达式
		}
	}
	return t;
}

TreeNode * term(void)
{
	TreeNode * t = factor();
	while ((token == TIMES) || (token == OVER))
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL) {
			p->child[0] = t;
			p->attr.op = token;
			t = p;
			match(token);
			p->child[1] = factor();
		}
	}
	return t;
}

TreeNode * factor(void)
{
	TreeNode * t = NULL;
	switch (token) {
	case NUM:
		t = newExpNode(ConstK);
		if ((t != NULL) && (token == NUM))
			t->val.num = atoi(tokenString);
		match(NUM);
		break;
	case ID:
		t = newExpNode(IdK);
		if ((t != NULL) && (token == ID)){
			t->attr.name = copyString(tokenString);
			/*
			  需要检查类型对不对
			    id_record = get_id_record(t->attr.name)
				if ( id_record->token_type != Int && id_record->token_type != Float){
					syntaxerror("unexpected variable type :");
				}
			*/
		}
		match(ID);
		break;
	case LPAREN:
		match(LPAREN);
		t = exp();
		match(RPAREN);
		break;
	default:
		syntaxError("unexpected token -> ");
		printToken(token, tokenString);
		token = getToken( );
		break;
	}
	return t;
}

/****************************************/
/* the primary function of the parser   */
/****************************************/
/* Function parse returns the newly
* constructed syntax tree
*/
TreeNode * parse(void)
{
	TreeNode * t;
	token = getToken();
	t = stmt_sequence();
	if (token != ENDFILE)
		syntaxError("Code ends before file\n");
	return t;
}
