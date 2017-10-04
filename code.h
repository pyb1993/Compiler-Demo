//
//  code.h
//  compiler
//
//  Created by pyb on 2017/9/23.
//  Copyright © 2017年 pyb. All rights reserved.
//

#ifndef code_h
#define code_h
/****************************************************/
/* File: code.h                                     */
/* Code emitting utilities for the TINY compiler    */
/* and interface to the TM machine                  */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _CODE_H_
#define _CODE_H_

/* pc = program counter  */
#define  pc 7

/* mp = "memory pointer" points
 * to top of memory (for temp storage)
 */
#define  mp 6

/* gp = "global pointer" points
 * to bottom of memory for (global)
 * variable storage
 */
#define gp 5

/* accumulator */
#define  ac 0

/* 2nd accumulator */
#define  ac1 1

/* the float register*/
#define fac 9
#define fac1 10

/* code emitting utilities */

/* Procedure emitComment prints a comment line
 * with comment c in the code file
 */

static char labelTable[211][6];


void emitComment( char * c );

/* Procedure emitRO emits a register-only
 * TM instruction
 * op = the opcode
 * r = target register
 * s = 1st source register
 * t = 2nd source register
 * c = a comment to be printed if TraceCode is TRUE
 */
void emitRO( char *op, int r, int s, int t, char *c);

/* Procedure emitRM emits a register-to-memory
 * TM instruction
 * op = the opcode
 * r = target register
 * d = the offset
 * s = the base register
 * c = a comment to be printed if TraceCode is TRUE
 */
void emitRM(char * op, int r, int d, int s, char *c);

/* Function emitSkip skips "howMany" code
 * locations for later backpatch. It also
 * returns the current code position
 */
int emitSkip( int howMany);

/* Procedure emitBackup backs up to
 * loc = a previously skipped location
 */
void emitBackup( int loc);

/* Procedure emitRestore restores the current
 * code position to the highest previously
 * unemitted position
 */
void emitRestore(void);

/* Procedure emitRM_Abs converts an absolute reference
 * to a pc-relative reference when emitting a
 * register-to-memory TM instruction
 * op = the opcode
 * r = target register
 * a = the absolute location in memory
 * c = a comment to be printed if TraceCode is TRUE
 */
void emitRM_Abs( char *op, int r, int a, char * c);


char* genLabel();
/*
    the section 8.4 talked about how to use lab to control code
    we can pass the label as the parameter in function gencode
    in addition, we need to store the lab in labeltabl, a struct to store relevant information,with it's instruction localtion
    when we execute the code, we need labeltable.
 */

// emit LDC code specifically
void emitLDCF(char * op, int r, float d, int s, char *c);



#endif

#endif /* code_h */
