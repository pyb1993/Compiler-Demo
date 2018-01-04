#include "stdio.h"
#include "globals.h"
#include "scan.h"
#include "parse.h"
#include "analyze.h"
#include "cgen.h"
#include "util.h"
#include "compile.h"

void compile(char *, char *);

void import(char * filename)
{
	source = fopen(filename, "r");
	listing = stdout;

	if (source == NULL)
	{
		perror("1");
		printf("open error\n");
		exit(1);
	}

	char * targetFileName = createTmFileName(MainModule);
	compile(filename, targetFileName);
	free(targetFileName);
}

void compile(char *filename, char * targetFileName)
{

	TreeNode *t = parse();
	printTree(t);

	if (!Error)
	{
		if (TraceAnalyze) fprintf(listing, "\nBuilding Symbol Table...\n");
		buildSymtab(t);
		if (TraceAnalyze) fprintf(listing, "\nType Checking Finished\n");
	}

	code = fopen(targetFileName, "a+");
	codeGen(t, targetFileName);
	fclose(code);
}

char * createTmFileName(char * filename)
{

	/**compute the length of filename before .tm **/
	int len = (int)strcspn(filename, "//.");
	char * codeFile = (char *)calloc(len + 4, sizeof(char));
	strncpy(codeFile, filename, len);
	strcat(codeFile, ".tm");
	return codeFile;
}

// 从module的名字来创建文件名字 PYB => PYB.p
char * createSrcFileNameFromModule(char * module)
{
	int len = (int)strlen(module);
	char * srcFileName = (char *)calloc(len + 3, sizeof(char));
	strncpy(srcFileName, module, len);
	strcat(srcFileName, ".p");
	return srcFileName;
}