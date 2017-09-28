* TINY Compilation to TM Code
* File: pyb_example.tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
* -> repeat
* repeat: jump after body comes back here
* -> Op
* -> Id
  2:     LD  0,0(5) 	load id value
* <- Id
  3:     ST  0,0(6) 	op: push left
* -> Const
  4:    LDC  0,1(0) 	load const
* <- Const
  5:     LD  1,0(6) 	op: load left
  6:    SUB  0,1,0 	op <
  7:    JLE  0,2(7) 	br if true
  8:    LDC  0,0(0) 	false case
  9:    LDA  7,1(7) 	unconditional jmp
 10:    LDC  0,1(0) 	true case
* <- Op
* -> if
* -> Op
* -> Id
 11:     LD  0,0(5) 	load id value
* <- Id
 12:     ST  0,0(6) 	op: push left
* -> Const
 13:    LDC  0,0(0) 	load const
* <- Const
 14:     LD  1,0(6) 	op: load left
 15:    SUB  0,0,1 	op <
 16:    JGT  0,2(7) 	br if true
 17:    LDC  0,0(0) 	false case
 18:    LDA  7,1(7) 	unconditional jmp
 19:    LDC  0,1(0) 	true case
* <- Op
* if: jump to else belongs here
* -> assign
* -> Op
* -> Id
 21:     LD  0,0(5) 	load id value
* <- Id
 22:     ST  0,0(6) 	op: push left
* -> Const
 23:    LDC  0,2(0) 	load const
* <- Const
 24:     LD  1,0(6) 	op: load left
 25:    ADD  0,1,0 	op +
* <- Op
 26:     ST  0,0(5) 	assign: store value
* <- assign
* if: jump to end belongs here
 20:    JEQ  0,7(7) 	if: jmp to else
 28:     IN  0,0,0 	read integer value
 29:     ST  0,1(5) 	read: store value
 27:    LDA  7,2(7) 	jmp to end
* <- if
 11:    JEQ  0,18(7) 	repeat: jmp back to body
* <- repeat
* End of execution.
 30:   HALT  0,0,0 	
