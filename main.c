#include "stdio.h"
#include "globals.h"
#include "scan.h"
#include "parse.h"
#include "analyze.h"
#include "util.h"

int lineno = 0;
FILE * source;
FILE * listing;
FILE * code;

/* allocate and set tracing flags */
int EchoSource = FALSE;
int TraceScan = FALSE;
<<<<<<< HEAD
int TraceParse = FALSE;
int TraceAnalyze = FALSE;
=======
int TraceParse = TRUE;
int TraceAnalyze = TRUE;
>>>>>>> 2ee1e519b6408575c38322dd242c201803a3612c
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
	buildSymtab(t);
    
	return 0;
}
