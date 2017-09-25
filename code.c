
#include "globals.h"
#include "code.h"
#include "symtable.h"
/* TM location number for current instruction emission */
static int emitLoc = 0 ;

static int highEmitLoc = 0;/*the highest EmitLocation the instruction has been created */
static int labNum = 0;
/* Procedure emitComment prints a comment line
 * with comment c in the code file
 *
 */

void emitComment( char * c )
{ if (TraceCode) fprintf(code,"* %s\n",c);}

/* Procedure emitRO emits a register-only
 * TM instruction
 * op = the opcode
 * r = target register
 * s = 1st source register
 * t = 2nd source register
 * c = a comment to be printed if TraceCode is TRUE
 */
void emitRO( char *op, int r, int s, int t, char *c)
{ fprintf(code,"%3d:  %5s  %d,%d,%d ",emitLoc++,op,r,s,t);
    if (TraceCode) fprintf(code,"\t%s",c) ;
    fprintf(code,"\n") ;
    if (highEmitLoc < emitLoc) highEmitLoc = emitLoc ;
} /* emitRO */

/* Procedure emitRM emits a register-to-memory
 * TM instruction
 * op = the opcode
 * r = target register
 * d = the offset
 * s = the base register
 * c = a comment to be printed if TraceCode is TRUE
 */
void emitRM( char * op, int r, int d, int s, char *c)
{
    fprintf(code,"%3d:  %5s  %d,%d(%d) ",emitLoc++,op,r,d,s);
    if (TraceCode) fprintf(code,"\t%s",c) ;
    fprintf(code,"\n") ;
    if (highEmitLoc < emitLoc)  highEmitLoc = emitLoc ;
} /* emitRM */

/* Function emitSkip skips "howMany" code
 * locations for later backpatch. It also
 * returns the current code position.
 * emitSkip, emitRM,emitRestore
 */

int emitSkip( int howMany)
{  int i = emitLoc;
    emitLoc += howMany ;
    if (highEmitLoc < emitLoc)  highEmitLoc = emitLoc ;
    return i;
} /* emitSkip */


/* Procedure emitBackup backs up to
 * loc = a previously skipped location
 */
void emitBackup( int loc)
{
    if (loc > highEmitLoc) emitComment("BUG in emitBackup");
    emitLoc = loc ;
} /* emitBackup */


/* Procedure emitRestore restores the current
 * code position to the highest previously
 * unemitted position
 */

void emitRestore(void)
{ emitLoc = highEmitLoc;}

/* Procedure emitRM_Abs converts an absolute reference
 * to a pc-relative reference when emitting a
 * register-to-memory TM instruction
 * op = the opcode
 * r = target register
 * a = the absolute location in memory
 * c = a comment to be printed if TraceCode is TRUE
 */
void emitRM_Abs( char *op, int r, int a, char * c)
{ fprintf(code,"%3d:  %5s  %d,%d(%d) ",
          emitLoc,op,r,a-(emitLoc+1),pc);
    ++emitLoc ;
    if (TraceCode) fprintf(code,"\t%s",c) ;
    fprintf(code,"\n") ;
    if (highEmitLoc < emitLoc) highEmitLoc = emitLoc ;
} /* emitRM_Abs */


// generate a lab
char* genLab()
{
    sprintf(labelTable[labNum], "lab%d",labNum);
    return labelTable[labNum++];
}







