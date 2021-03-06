#ifndef TM_HEAD
#define TM_HEAD
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "globals.h"


/******* type  *******/

typedef enum {
	opclRR,     /* reg operands r,s,t */
	opclRM,     /* reg r, mem d+s */
	opclRA,      /* reg r, int d+s */
	opclSYS
} OPCLASS;

typedef enum {
	/* RR instructions */
	opHALT,    /* RR     halt, operands are ignored */
	opIN,      /* RR     read into reg(r); s and t are ignored */
	opOUT,     /* RR     write from reg(r), s and t are ignored */
	opMOV,     /* RR	 move register from one to another*/
	opNEG,     /*RR      reg[r] = -reg[r]             */
	opADD,    /* RR     reg(r) = reg(s)+reg(t) */
	opSUB,    /* RR     reg(r) = reg(s)-reg(t) */
	opMUL,    /* RR     reg(r) = reg(s)*reg(t) */
	opDIV,    /* RR     reg(r) = reg(s)/reg(t) */
	opMOD,
	opLAEBL,    /* RR   label num*/
	opGO,    /* RR     go to the label num*/

	opRRLim,   /* limit of RR opcodes */

	/* RM instructions */
	opLD,      /* RM     reg(r) = mem(d+reg(s)) */
	opST,      /* RM     mem(d+reg(s)) = reg(r) */
	opPUSH,    /* RR	 push registr to dMem[reg[sp]--]	*/
	opPOP,
	opRMLim,   /* Limit of RM opcodes */

	/* RA instructions */
	opLDA,     /* RA     reg(r) = d+reg(s) */
	opLDC,     /* RA     reg(r) = d ; reg(s) is ignored */
	opJLT,     /* RA     if reg(r)<0 then reg(7) = d+reg(s) */
	opJLE,     /* RA     if reg(r)<=0 then reg(7) = d+reg(s) */
	opJGT,     /* RA     if reg(r)>0 then reg(7) = d+reg(s) */
	opJGE,     /* RA     if reg(r)>=0 then reg(7) = d+reg(s) */
	opJEQ,     /* RA     if reg(r)==0 then reg(7) = d+reg(s) */
	opJNE,     /* RA     if reg(r)!=0 then reg(7) = d+reg(s) */
	opRETURN,  /* RA     reg[pc] = dMem[a]; */
	opRALim,    /* Limit of RA opcodes */
	/*SYSTEM instructions*/
	opMALLOC,
	opFREE,
	opEND
} OPCODE;

typedef enum {
	srOKAY,
	srHALT,
	srIMEM_ERR,
	srDMEM_ERR,
	srZERODIVIDE
} STEPRESULT;

typedef struct {
	int iop;
	int iarg1;
	int iarg2;
	int iarg3;
} INSTRUCTION;


int readInstructions(FILE *pgm);
int doCommand(char);











#endif