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
int TraceParse = FALSE;
int TraceAnalyze = TRUE;
int TraceCode = TRUE;
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
	typeCheck(t);


	/**compute the length of filename before .tm **/
	int len = strcspn(filename, ".");
	char * codeFile = (char *)calloc(len+4,sizeof(char));
	strncpy(codeFile, filename, len);
	strcat(codeFile, ".tm");
	code = fopen(codeFile,"w");
	codeGen(t,codeFile);
	fclose(code);
	return 0;
}
