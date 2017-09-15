#include "globals.h"
#include "util.h"
#include "scan.h"

/* states in scanner DFA */
typedef enum
{
	START, INASSIGN, INCOMMENT, INNUM, INID, OVER_OR_COMMENT, 
	INASSIGN_OR_EQ, MINUS_OR_NEG, LT_OR_LE, GT_OR_GE,
	DONE
}
StateType;

/* lexeme of identifier or reserved word */
char tokenString[MAXTOKENLEN + 1];

/* BUFLEN = length of the input buffer for
source code lines */
#define BUFLEN 256

static char lineBuf[BUFLEN]; /* holds the current line */
static int linepos = 0; /* current position in LineBuf */
static int bufsize = 0; /* current size of buffer string */
static int EOF_flag = FALSE; /* corrects ungetNextChar behavior on EOF */

/* getNextChar fetches the next non-blank character
from lineBuf, reading in a new line if lineBuf is
exhausted */
static int getNextChar(void)
{
	if (!(linepos < bufsize))
	{
		lineno++;
		if (fgets(lineBuf, BUFLEN - 1, source))
		{
			if (EchoSource) fprintf(listing, "%4d: %s", lineno, lineBuf);
			bufsize = strlen(lineBuf);
			linepos = 0;
			return lineBuf[linepos++];
		}
		else
		{
			EOF_flag = TRUE;
			return EOF;
		}
	}
	else return lineBuf[linepos++];
}

/* ungetNextChar backtracks one character
in lineBuf */
static void ungetNextChar(void)
{
	if (!EOF_flag) linepos--;
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
= { { "if", IF }, { "then", THEN }, { "else", ELSE }, { "end", END },
{ "repeat", WHILE }, { "until", UNTIL }, { "read", READ },
{ "write", WRITE } };

/* lookup an identifier to see if it is a reserved word */
/* uses linear search */
static TokenType reservedLookup(char * s)
{
	int i;
	for (i = 0; i<MAXRESERVED; i++)
	if (!strcmp(s, reservedWords[i].str))
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
	TokenType currentToken;
	/* current state - always begins at START */
	StateType state = START;
	/* flag to indicate save to tokenString */
	int save;
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
			else if ((c == ' ') || (c == '\t') || (c == '\n'))
				save = FALSE;
			else if (c == '-')
			{
				state = MINUS_OR_NEG;
			}
			else if (c == '/')
			{
				state = OVER_OR_COMMENT;
			}
			else if (c == '<')
			{
				state = LT_OR_LE;
			}
			else if (c == '>')
			{
				state = GT_OR_GE;
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
				case '+':
					currentToken = PLUS;
					break;
				case '*':
					currentToken = TIMES;
					break;
				case '(':
					currentToken = LPAREN;
					break;
				case ')':
					currentToken = RPAREN;
				case '{':
					currentToken = LBRACKET;
					break;
				case '}':
					currentToken = RBRACKET;
					break;
				case ';':
					currentToken = SEMI;
					break;

				default:
					currentToken = ERROR;
					break;
				}
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
			if (c == '=')
				currentToken = EQ;
			else
			{ /* backup in the input */
				ungetNextChar();
				save = FALSE;
				currentToken = ASSIGN;
			}
			break;
		case INNUM:
			if (!isdigit(c))
			{ /* backup in the input */
				ungetNextChar();
				save = FALSE;
				state = DONE;
				currentToken = NUM;
			}
			break;
		case INID:
			if (!isalpha(c)){ /* backup in the input */
				ungetNextChar();
				save = FALSE;
				state = DONE;
				currentToken = ID;
			}
			break;
			// - or -100
		case MINUS_OR_NEG:
			if (isdigit(c)){
				state = INNUM;
			}
			else{
				ungetNextChar();
				currentToken = MINUS;
				state = DONE;
			}

			break;
		case OVER_OR_COMMENT:
			if (c == '/'){
				state = INCOMMENT;
				ungetTokenstring(&tokenStringIndex);
				save = FALSE;
			}
			else {//over
				state = DONE;
				ungetNextChar();
				currentToken = OVER;
			}
			break;
		case LT_OR_LE:
			if (c == '=')
				currentToken = LE;
			else{
				save = FALSE;
				state = DONE;
				ungetNextChar();
				currentToken = LT;
			}
			break;
		case GT_OR_GE:
			if (c == '=')
				currentToken = GE;
			else
			{
				save = FALSE;
				state = DONE;
				ungetNextChar();
			}
			break;
		case DONE:
		default: /* should never happen */
			fprintf(listing, "Scanner Bug: state= %d\n", state);
			state = DONE;
			currentToken = ERROR;
			break;
		}
		if ((save) && (tokenStringIndex <= MAXTOKENLEN))
			tokenString[tokenStringIndex++] = (char)c;
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
