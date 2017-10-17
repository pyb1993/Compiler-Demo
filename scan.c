#include "globals.h"
#include "util.h"
#include "scan.h"

/* states in scanner DFA */
typedef enum
{
	START, INASSIGN, INCOMMENT, INMULCOMMENT, INNUM, INFLOATNUM, INID, OVER_OR_COMMENT,
	INASSIGN_OR_EQ, MINUS_OR_NEG, LT_OR_LE, GT_OR_GE,IN_STR,
	DONE
}
StateType;


/* BUFLEN = length of the input buffer for
source code lines */
#define setStateMinus() do{currentToken = MINUS; ungetNextChar(); state = DONE;} while (0)

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

	if ( bufsize <= linepos)
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

static bool checkPreBlank(int pre_line_pos)
{
	pre_line_pos -= 3;//skip the c and -
	while (pre_line_pos >= 0 && isblank(lineBuf[pre_line_pos]))
	{
		pre_line_pos--;
	}
	return pre_line_pos  ;
}

static bool isAplhaUnderscore(char ch)
{
	
	return isalpha(ch) || ch == '_' || (ch >= '0' && ch <= '9');
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
= { { "if", IF }, { "else", ELSE }, { "end", END },
  { "while", WHILE }, { "break", BREAK }, {"return", RETURN}, { "until", UNTIL }, { "read", READ },
	{ "write", WRITE }, { "int", INT }, { "float", FLOAT }, {"void",VOID},{"def", FUN} 
  };

/* lookup an identifier to see if it is a reserved word */
/* uses linear search */
static TokenType reservedLookup(char * s)
{
	int i;
	for (i = 0; i<MAXRESERVED; i++)
	if (reservedWords[i].str!=NULL && !strcmp(s, reservedWords[i].str))
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
			else if ((c == ' ') || (c == '\t'))
				save = FALSE;
			else if (c == '\n')
			{
				save = FALSE;
				state = DONE;
				currentToken = LINEEND;
			}
			else if (c == '-')
			{
				state = DONE;
				currentToken = MINUS;
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
			else if (c == '"'){
				state = IN_STR;
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
					break;
				case '{':
					currentToken = LBRACKET;
					break;
				case '}':
					currentToken = RBRACKET;
					break;
				case ';':
					currentToken = SEMI;
					break;
				case ',':
					currentToken = COMMA;
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
			if (c == '='){
				currentToken = EQ;
			}
			else
			{ /* backup in the input */
				ungetNextChar();
				save = FALSE;
				currentToken = ASSIGN;
			}
			break;
		case INNUM:
			if (!isdigit(c) && c != '.')
			{ /* backup in the input */
				ungetNextChar();
				save = FALSE;
				state = DONE;
				currentToken = NUM;
			}
			else if (c == '.')
			{
				state = INFLOATNUM;
			}
			break;

		case INFLOATNUM:
			if (!isdigit(c))
			{
				ungetNextChar();
				save = FALSE;
				state = DONE;
				currentToken = FlOATNUM;
			}
			break;
		case INID:
		
			if (!(isAplhaUnderscore(c))){ /* backup in the input */
				ungetNextChar();
				save = FALSE;
				currentToken = ID;
				state = DONE;
			}
			break;

			// - or -100
		case MINUS_OR_NEG:
		/*	if (isdigit(c))
			{
				if (checkPreBlank(linepos)) { state = INNUM;}// -1
				else setStateMinus(); // n-1 || n   -   1 || n   -1 
			}
			else if (isAplhaUnderscore(c))
			{
				if (checkPreBlank(linepos)){ currentToken = NEG;state = DONE; }// -x || -   x
				else  setStateMinus(); //n-x || n -x || n - x
			}
			else
			{
				 fprintf(listing, "Scanner Error: -%c", c);
			}
			break;*/
		case OVER_OR_COMMENT:
			if (c == '/'){
				state = INCOMMENT;
				ungetTokenstring(&tokenStringIndex);
				save = FALSE;
			}
			else if (c == '*'){
				state = INMULCOMMENT;
				ungetTokenstring(&tokenStringIndex);
				save = FALSE;
			}
			else {
				//over
				state = DONE;
				ungetNextChar();
				currentToken = OVER;
			}
			break;
		case INMULCOMMENT:
			save = FALSE;
			if (c == EOF)
			{
				state = DONE;
				currentToken = ENDFILE;
			}
			if (c == '*' ){
				if (getNextChar() == '/'){
					state = START;
				}
				else
					ungetNextChar();
			}
		break;
		case LT_OR_LE:
			if (c == '='){
				currentToken = LE;
			}
			else{
				save = FALSE;
				ungetNextChar();
				currentToken = LT;
			}
			state = DONE;
			break;
		case GT_OR_GE:
			if (c == '=')
				currentToken = GE;
			else
			{
				save = FALSE;
				ungetNextChar();
				currentToken = GT;
			}
			state = DONE;
			break;
		case IN_STR:
			if (c == EOF){
				state = DONE;
				currentToken = ENDFILE;
			}
			else if (c == '"'){
				state = DONE;
				currentToken = STRING;
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
		{
			tokenString[tokenStringIndex++] = (char)c;
			if (c == '\n') ungetNextChar();// to return LINEND
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





