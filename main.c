#include "stdio.h"
#include "globals.h"
#include "scan.h"
#include "parse.h"
#include "util.h"

int lineno = 0;
FILE * source;
FILE * listing;
FILE * code;

/* allocate and set tracing flags */
int EchoSource = FALSE;
int TraceScan = FALSE;
int TraceParse = FALSE;
int TraceAnalyze = FALSE;
int TraceCode = FALSE;

int Error = FALSE;


int main(){

	printf("hello world\n");
	char *filename = "pyb_example.p";
	source = fopen(filename, "r");
	listing = stdout;

	if (source == NULL){
		printf("open error\n");
		exit(1);
	}

	TreeNode *t = parse();
	 printTree(t);
    
	return 0;
}
