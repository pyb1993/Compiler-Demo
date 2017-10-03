#include "stdio.h"
#include "globals.h"
#include "scan.h"
#include "parse.h"
#include "analyze.h"
#include "util.h"
#include "tm.h"


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
int done;


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

	#if !NO_ANALYZE
		if (!Error)
		{
			if (TraceAnalyze) fprintf(listing, "\nBuilding Symbol Table...\n");
			buildSymtab(t);
			if (TraceAnalyze) fprintf(listing, "\nChecking Types...\n");
			typeCheck(t);
			if (TraceAnalyze) fprintf(listing, "\nType Checking Finished\n");
		}
	#endif

	/**compute the length of filename before .tm **/
	int len = strcspn(filename, ".");
	char * codeFile = (char *)calloc(len+4,sizeof(char));
	strncpy(codeFile, filename, len);
	strcat(codeFile, ".tm");
	code = fopen(codeFile,"w");
	codeGen(t,codeFile);
	fclose(code);

	/* read the program */
	code = fopen(codeFile, "r");
	if (!readInstructions(code))
		exit(1);

	printf("TM  simulation (enter h for help)...\n");
	do
	{
		done = !doCommand();
	} while (!done);
	printf("Simulation done.\n");
	fclose(code);

	float a = 100;
	unsigned char* b = (unsigned char*)&a;
	printf("%02X %02X %02X %02X", b[0], b[1], b[2], b[3]);
	int d = *(int *)(b);
	float f = *(float *)(&d);
	return 0;
}
