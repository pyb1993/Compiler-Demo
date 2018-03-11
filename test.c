#include <stdio.h>
#include <string.h>
#include "stdlib.h"
#include <ctype.h>
#include "globals.h"
#include "compile.h"
#include "assert.h"

#define AROUND_UNIT_TEST(msg,prog){\
	test_log = msg;\
	test_level++;\
	printf("%s begin :\n",test_log);\
	prog;\
	test_level--;\
}
#define SET_FAIL_SUB_LOG(msg){test_sub_log = msg;test_sub_case = 0;}

#define TEST_ANY(expected,real,EQ,testError){\
if (!(EQ)){\
\
for (int i = 0; i < test_level; ++i){ printf("	");}\
	printf("%s case[%d] failed ", test_sub_log,test_sub_case); \
	testError; \
}\
else{\
	test_accepted++; \
}\
	test_num++; \
	test_sub_case++; \
}

static int test_accepted = 0;
static int test_num = 0;
static int test_level = 0;
static char * test_log = "test log";
static char * test_sub_log = "test sub log";
static int test_sub_case = 0;
static FILE * file;

void setTestFailLog(char * msg);
void testListOperation();
void testListInsert();

void testHash();
void testHashPut();

void testFunctionCall();
void testInteger(int ret, int real);
void skipInstruction();
void testStatistic();
void testFloat(float expected, float real);
void testChar(char,char);
void clearFile(char * codeFileName)
{
	file = fopen(codeFileName, "w");//清理该文件
	fclose(file);
}

int getInteger()
{
	skipInstruction();
	int sign = 1;
	char c;
	int ret = 0;
	while (1)
	{
		c = getc(file);
		if (c == '+' || c == '-'){
			sign = c == '+' ? 1 : -1;
			continue;
		}
		if (c == EOF || c == '\n') break;
		ret = ret * 10 + c - '0';
	}
	return ret * sign;
}

float getFloatNum()
{
	skipInstruction();
	int sign = 1;
	char c;
	int ret = 0;
	int float_part = 0;
	bool point = 0;
	while (1)
	{
		c = getc(file);
		if (c == '+' || c == '-'){
			sign = c == '+' ? 1 : -1;
			continue;
		}
		if (c == EOF || c == '\n') break;
		if (c == '.') { point = true; continue; }
		if (!point)
			ret = ret * 10 + c - '0';
		else
			float_part = float_part * 10 + c - '0';
	}

	float flt_part = float_part;
	while (flt_part > 1) flt_part /= 10;

	return ret + flt_part;
}

char getChar(){
	skipInstruction();
	char c = getc(file);
	return c;
}




// 跳过所有的指令 xxx xxx xxx : 
void skipInstruction()
{
	char c;
	do{
		 c = getc(file);
	} while (c != EOF && c != ':');
	// now c is : or EOF
	if (c == EOF) return;
	c = getc(file);//skip:
	do {
		c = getc(file);
	  } while (c == ' ');
		
	if (c != EOF) ungetc(c, file);// push the alphanum back to the file stream

}
void initResultFile(char * procedure_file_name)
{
	char * codeFileName = createTmFileName(procedure_file_name);// xxx.tm
	clearFile(codeFileName);
	import(procedure_file_name);
	file = fopen(codeFileName, "r");
	if (!readInstructions(file)){
		exit(1);
	}

	listing = fopen("test_result.p","w");
	!doCommand('g');
	fclose(file);
	fclose(listing);
	listing = fopen("test_result.p", "r");
	clearSymTable();
	clearImport();
	clearGode();
	clearVmem();
}



void testFuntion()
{
	AROUND_UNIT_TEST("test Function", testFunctionCall());
}

void testRecursion(){


}


void testFunctionCall()
{
	MainModule = "function_example.p";
	initResultFile(MainModule);

	/*------ test function, integer as parameters  ----------*/
	SET_FAIL_SUB_LOG("test function call list:");
	testFloat(200, getFloatNum());
	
	testFloat(3, getFloatNum());
	testFloat(33, getFloatNum());
	testFloat(13.2, getFloatNum());
	testInteger(101, getFloatNum());
	testInteger(111, getFloatNum());
	testInteger(121, getFloatNum());
	testInteger(5, getFloatNum());
	testInteger(8, getFloatNum());


}

void testHash(){
	AROUND_UNIT_TEST("test Hash", testHashPut());


}

void testHashPut(){
	MainModule = "hash_example.p";
	initResultFile(MainModule);	/*------ test hash  ----------*/
	SET_FAIL_SUB_LOG("test hash:");
	testInteger(2, getInteger());
	testInteger(3, getInteger());
	testInteger(4, getInteger());
	testInteger(5, getInteger());
	testChar('f', getChar());
	testChar('u', getChar());
	testChar('c', getChar());
	testChar('k', getChar());
	testChar('\n', getChar());
	testChar('y', getChar());
	testChar('o', getChar());
	testChar('u', getChar());
}



void testList(){
	AROUND_UNIT_TEST("test list", testListOperation());
}

void testListOperation()
{
	MainModule = "list_example.p";
	initResultFile(MainModule);

	/*------ test list match  ----------*/
	SET_FAIL_SUB_LOG("match listNode:");
	testInteger(0, getInteger());

	/*------ test insert list  ----------*/
	SET_FAIL_SUB_LOG("insert sorted list:");
	testInteger(-100000, getInteger());
	testInteger(-20, getInteger());
	testInteger(-20, getInteger());
	testInteger(-20, getInteger());
	testInteger(-1, getInteger());
	testInteger(1, getInteger());
	testInteger(100, getInteger());
	testInteger(2000, getInteger());

	/*------ test append list  ----------*/
	SET_FAIL_SUB_LOG("insert append list:");
	testInteger(-1, getInteger());
	testInteger(1, getInteger());
	testInteger(-20, getInteger());
	testInteger(-20, getInteger());
	testInteger(-20, getInteger());
	testInteger(-100000, getInteger());
	testInteger(2000, getInteger());
	testInteger(100, getInteger());


	/****------test remove list--------*******/
	SET_FAIL_SUB_LOG("insert remove list:");
	testInteger(-20, getInteger());
	testInteger(-1, getInteger());
	testInteger(1, getInteger());
	testInteger(5675541, getInteger());

	/****------test pop right--------*******/
	SET_FAIL_SUB_LOG("insert pop list:");
	testInteger(1, getInteger());
	testInteger(100, getInteger());
	testInteger(5453, getInteger());
	testInteger(2001515, getInteger());
}

void test()
{
	 EchoSource = FALSE;
	 TraceScan = FALSE;
	 TraceParse = FALSE;
	 TraceAnalyze = FALSE;
	 TraceCode = FALSE;
	 Error = FALSE;
	 done = FALSE;

	testList();
	testHash();
	testFuntion();
	//testStatistic();
	return;
}

void testStatistic()
{
	printf("[%d] test failed, success/all : [%d / %d]", test_num - test_accepted, test_accepted,test_num);
}

void testInteger(int expected, int real)
{
	TEST_ANY(expected, real, expected == real, printf("expected = %d, real = %d\n", expected, real));
}

void testChar(char expected, char real){
	TEST_ANY(expected, real, expected == real, printf("expected = %d, real = %d\n", expected, real));
}

void testFloat(float expected, float real){
	TEST_ANY(expected, real, abs(expected - real) < 0.00001, printf("expected = %f, real = %f\n", expected, real));
}
