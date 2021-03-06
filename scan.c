#include "globals.h"
#include "util.h"
#include "scan.h"
#include "tinytype.h"

char tokenString[MAXTOKENLEN + 5];
/* states in scanner DFA */
typedef enum
{
	START, INASSIGN, INCOMMENT, INMULCOMMENT, INNUM, INFLOATNUM, INID, OVER_OR_COMMENT,
	INASSIGN_OR_EQ, MINUS_START, LT_OR_LE, GT_OR_GE,IN_STR,
	PLUS_START, NOT_OR_NOTEQ,AND_START,OR_START,
	DONE
} StateType;

/* BUFLEN = length of the input buffer for
source code lines */
#define setStateMinus() do{currentToken = MINUS; ungetNextChar(c); state = DONE;} while (0)
#define SET_CUR_TOKEN(tok) do {state = DONE; currentToken = tok;}while(0)
#define SET_CUR_TOKEN_AND_UNGET(tok) do{ungetNextChar(c);SET_CUR_TOKEN(tok);}while(0)

#define BUFLEN 256
static int EOF_flag = FALSE; /* corrects ungetNextChar behavior on EOF */
static char lineBuf[BUFLEN]; /* holds the current line */
static int linepos = 0; /* current position in LineBuf */
static int bufsize = 0; /* current size of buffer string */

/* getNextChar fetches the next non-blank character
from lineBuf, reading in a new line if lineBuf is
exhausted */

static int getNextChar()
{
	int c =  fgetc(source);
	if (c == '\n') lineno++;
	return c;
}

static bool isAplhaUnderscore(char ch)
{
	return isalpha(ch) || ch == '_' || (ch >= '0' && ch <= '9');
}

static void ungetNextChar(int c){
	if (!EOF_flag) ungetc(c,source);
}


//将读入的tokenstring退出一格,比如说用在退出//的第一个/上面
static void ungetTokenstring(int *tokenstringindex)
{
	if (!EOF_flag) (*tokenstringindex)--;
}

/* lookup table of reserved words */
static struct
{
	char* str;
	TokenType tok;
} reservedWords[MAXRESERVED]
= {	  { "if", IF }, { "else", ELSE }, { "end", END },
	  { "while", WHILE }, { "break", BREAK }, {"continue",CONTINUE}, 
	  {"return", RETURN}, { "until", UNTIL }, { "read", READ },{ "write", WRITE },
	  { "int", INT }, { "float", FLOAT }, { "void", VOID }, { "char", CHAR }, {"const",CONST},
	  { "def", FUN }, { "struct", STRUCT }, { "asm", ASM }, { "import", IMPORT }, {"switch",SWITCH},
	  { "case", CASE }, {"default",DEFAULT}, { "sizeof", SIZEOF }, { "typedef", TYPEDEF }
  };

/* lookup an identifier to see if it is a reserved word */
/* uses linear search */
static TokenType reservedLookup(char * s)
{
	int i;
	for (i = 0; i<MAXRESERVED; i++)
	if (reservedWords[i].str != NULL && !strcmp(s, reservedWords[i].str))
		return reservedWords[i].tok;
	return ID;
}

/****************************************/
/* the primary function of the scanner  */
/****************************************/
/* function getToken returns the
* next token in source file
*/
TokenType getToken(void)
{  /* index for storing into tokenString */
	int tokenStringIndex = 0;
	/* holds current token to be returned */
	TokenType currentToken = ERROR;
	/* current state - always begins at START */
	StateType state = START;
	/* flag to indicate save to tokenString */
	int save;
	int comment_num = 0;
	while (state != DONE)
	{
		int c = getNextChar();
		save = TRUE;
		switch (state)
		{
		case START:
			if (isdigit(c))
				state = INNUM;
			else if (isalpha(c))
				state = INID;
			else if (c == '=')
				state = INASSIGN_OR_EQ;
			else if ((c == ' ') || (c == '\t')){
				save = FALSE;
			}
			else if (c == '\n'){
				save = FALSE;
				SET_CUR_TOKEN(LINEEND);
			}
			else if (c == '%'){
				SET_CUR_TOKEN(MOD);
			}
			else if (c == '/'){
				state = OVER_OR_COMMENT;
			}
			else if (c == '-'){
				state = MINUS_START;
			}
			else if (c == '<'){
				state = LT_OR_LE;
			}
			else if (c == '>'){
				state = GT_OR_GE;
			}
			else if (c == '"' || c == '\''){
				state = IN_STR;
			}
			else if (c == '+'){
				state = PLUS_START;
			}
			else if (c == '!'){
				state = NOT_OR_NOTEQ;
			}
			else if (c == '&'){
				state = AND_START;
			}
			else if (c == '|'){
				state = OR_START;
			}
			//consider specific case
			else
			{
				state = DONE;
				switch (c)
				{
				case EOF:
					save = FALSE;
					currentToken = ENDFILE;
					break;
				case '*':
					currentToken = TIMES;
					break;
				case '(':
					currentToken = LPAREN;
					break;
				case ')':
					currentToken = RPAREN;
					break;
				case '{':
					currentToken = LBRACKET;
					break;
				case '}':
					currentToken = RBRACKET;
					break;
				case '[':
					currentToken = LSQUARE;
					break;
				case ':':
					currentToken = CLON;
					break;
				case ']':
					currentToken = RSQUARE;
					break;
				case ';':
					currentToken = SEMI;
					break;
				case ',':
					currentToken = COMMA;
					break;
				case '.':
					currentToken = POINT;
					break;
				default:
					currentToken = ERROR;
					break;
				}
			}
			break;

		case AND_START:
			if (c == '&'){
				SET_CUR_TOKEN(AND);
			}
			else{
				SET_CUR_TOKEN_AND_UNGET(BITAND);
			}
			break;
		case OR_START:
			if (c == '|'){
				SET_CUR_TOKEN(OR);
			}
			else{
				SET_CUR_TOKEN_AND_UNGET(BITOR);

			}
			break;
		case PLUS_START:
			if (c == '+'){
				SET_CUR_TOKEN(PPLUS);
			}
			else if (c == '='){
				SET_CUR_TOKEN(PLUSASSIGN);
			}
			else{
				save = false;
				SET_CUR_TOKEN_AND_UNGET(PLUS);
			}
			break;
		case MINUS_START:
			if (c == '-'){
				SET_CUR_TOKEN(MMINUS);
			}
			else if (c == '='){
				SET_CUR_TOKEN(MINUSASSIGN);
			}
			else if (c == '>'){
				SET_CUR_TOKEN(ARROW);
			}
			else{
				save = false;
				SET_CUR_TOKEN_AND_UNGET(MINUS);
			}
			break;
		case INCOMMENT:
			save = FALSE;
			if (c == EOF)
			{
				state = DONE;
				currentToken = ENDFILE;
			}
			else if (c == '\n') state = START;
			break;
			// == or =
		case INASSIGN_OR_EQ:
			state = DONE;
			if (c == '='){
				currentToken = EQ;
			}
			else
			{ /* backup in the input */
				save = FALSE;
				SET_CUR_TOKEN_AND_UNGET(ASSIGN);
			}
			break;
		case INNUM:
			if (!isdigit(c) && c != '.')
			{ 
				save = FALSE;
				SET_CUR_TOKEN_AND_UNGET(NUM);
			}
			else if (c == '.')
			{
				state = INFLOATNUM;
			}
			break;

		case INFLOATNUM:
			if (!isdigit(c))
			{
				save = FALSE;
				SET_CUR_TOKEN_AND_UNGET(FlOATNUM);
			}
			break;
		case INID:
			if (!(isAplhaUnderscore(c))){ /* backup in the input */
				save = FALSE;
				SET_CUR_TOKEN_AND_UNGET(ID);
			}
			break;	
		case OVER_OR_COMMENT:
			if (c == '/'){
				state = INCOMMENT;
				ungetTokenstring(&tokenStringIndex);
				save = FALSE;
			}
			else if (c == '*'){
				state = INMULCOMMENT;
				comment_num = 1;
				ungetTokenstring(&tokenStringIndex);
				save = FALSE;
			}
			else {		
				SET_CUR_TOKEN_AND_UNGET(OVER);//over
			}
			break;
		case INMULCOMMENT:
			save = FALSE;
			if (c == EOF)
			{
				SET_CUR_TOKEN(ENDFILE);
			}
			
			if (c == '*')
			{
				if ((c = getNextChar()) == '/')
				{
					if (--comment_num == 0)
						state = START;
				}
				else ungetNextChar(c); 
			}
			else if (c == '/' && getNextChar() == '*')
			{
				comment_num += 1;
			}
		break;
		case LT_OR_LE:
			if (c == '='){
				SET_CUR_TOKEN(LE);
			}
			else{
				save = FALSE;
				SET_CUR_TOKEN_AND_UNGET(LT);
			}
			break;
		case GT_OR_GE:
			if (c == '=')
			{
				SET_CUR_TOKEN(GE);
			}
			else
			{
				save = FALSE;
				SET_CUR_TOKEN_AND_UNGET(GT);
			}
			break;
		case NOT_OR_NOTEQ:
			if (c == '='){
				SET_CUR_TOKEN(NOTEQ);
			}
			else{
				SET_CUR_TOKEN(NOT);
			}
			
			break;
		case IN_STR:
			if (c == EOF){ SET_CUR_TOKEN(ENDFILE);}
			else if (c == '"'){SET_CUR_TOKEN(STRING);}
			else if (c == '\''){ SET_CUR_TOKEN(CHARACTER);}
			break;
		case DONE:
		default: /* should never happen */
			fprintf(listing, "Scanner Bug: state= %d\n", state);
			SET_CUR_TOKEN(ERROR);
			break;
		}
		if ((save) && (tokenStringIndex <= MAXTOKENLEN))
		{
			tokenString[tokenStringIndex++] = (char)c;
			if (c == '\n') ungetNextChar(c);// to return LINEND
		}
			if (state == DONE)
		{
			tokenString[tokenStringIndex] = '\0';
			if (currentToken == ID)
				currentToken = reservedLookup(tokenString);
		}
	}
	if (TraceScan) {
		fprintf(listing, "\t%d: ", lineno);
		printToken(currentToken, tokenString);
	}
	return currentToken;
} /* end getToken */

//scan过一次之后需要将所有标志置为初始状态，方便下一次处理别的模块
void clear()
{
	EOF_flag = FALSE;
	linepos = 0;
	fclose(source);
}