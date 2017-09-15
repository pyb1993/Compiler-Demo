#include "stdio.h"
#include "globals.h"
#include "scan.h"

int lineno = 0;
FILE * source;
FILE * listing;
FILE * code;

/* allocate and set tracing flags */
int EchoSource = FALSE;
int TraceScan = TRUE;
int TraceParse = FALSE;
int TraceAnalyze = FALSE;
int TraceCode = FALSE;

int Error = FALSE;

int main(){

	printf("hello world\n");
	char *filename ="pyb_example.p";
	source = fopen(filename,"r");
	listing = stdout;

	if (source == NULL){
		printf("open error\n");
		exit(1);
	}
	TokenType token = getToken();


	return 0;
}