#include "stdio.h"
#include "globals.h"
#include "scan.h"
#include "parse.h"
#include "analyze.h"
#include "cgen.h"
#include "compile.h"
#include "util.h"
#include "tm.h"
#include "test.h"


int lineno = 0;
FILE * source;
FILE * listing;
FILE * code;
char * MainModule;

/* allocate and set tracing flags */
int EchoSource = TRUE;
int TraceScan = TRUE;
int TraceParse = TRUE;
int TraceAnalyze = TRUE;
int TraceCode = TRUE;
int Error = FALSE;
int done = FALSE;

int main()
{    

	/*MainModule = "pyb_example.p";
	char * codeFileName = createTmFileName(MainModule);
	code = fopen(codeFileName, "w");//清理该文件
	fclose(code);
	import(MainModule);

#if 1
	code = fopen(codeFileName, "r");
	if (!readInstructions(code))
		exit(1);
#endif

#if 1
	printf("TM  simulation (enter h for help)...\n");
	do
	{
		done = !doCommand();
	} while (!done);
	printf("Simulation done.\n");
	fclose(code);
	
#endif
	*/
	test();
	return 0;
}
