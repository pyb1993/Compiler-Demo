#include "stdio.h"
#include "globals.h"
#include "scan.h"
#include "parse.h"
#include "analyze.h"
#include "cgen.h"
#include "util.h"
#include "compile.h"
#include "assert.h"

void compile(char *, char *);
static int modules_imported = -1;
static char * imported_modules[1000];

// 是否已经import过了
bool isAlreadyImported(char * file_name){
	assert(++modules_imported < 1000);

	int i;
	for (i = 0; i < modules_imported && strcmp(file_name, imported_modules[i]) != 0;i++){}
	if (i == modules_imported)
	{
		imported_modules[modules_imported] = copyString(file_name);
		return false;
	}
	return true;
}

void clearImport(){
	modules_imported = -1;
	for (int i = 0; i < modules_imported; i++){ 
		free(imported_modules[i]); imported_modules[i] = NULL; 
	}
}

void import(char * filename)
{
	
	char buf[BUFSIZ];
	if (isAlreadyImported(filename)) return;
	source = fopen(filename, "r");
	setbuf(source, buf);
	
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
	if(TraceParse) printTree(t);

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