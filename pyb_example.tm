* File: pyb_example.tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
* -> assign
* -> Const
  2:    LDC  0,2(0) 	load const
* <- Const
  3:     ST  0,0(5) 	assign: store value
* <- assign
  4:     IN  0,0,0 	read integer value
  5:     ST  0,1(5) 	read: store value
* -> assign
* -> Const
  6:    LDC  0,1(0) 	load const
* <- Const
  7:     ST  0,2(5) 	assign: store value
* <- assign
* -> assign
* -> Const
  8:    LDC  0,1(0) 	load const
* <- Const
  9:     ST  0,3(5) 	assign: store value
* <- assign
* -> repeat
* repeat: jump after body comes back here
* -> Op
* -> Id
 10:     LD  0,0(5) 	load id value
* <- Id
 11:     ST  0,0(6) 	op: push left
* -> Id
 12:     LD  0,1(5) 	load id value
* <- Id
 13:     LD  1,0(6) 	op: load left
 14:    SUB  0,1,0 	op <
 15:    JLT  0,2(7) 	br if true
 16:    LDC  0,0(0) 	false case
 17:    LDA  7,1(7) 	unconditional jmp
 18:    LDC  0,1(0) 	true case
* <- Op
* -> assign
* -> Id
 20:     LD  0,2(5) 	load id value
* <- Id
 21:     ST  0,4(5) 	assign: store value
* <- assign
* -> assign
* -> Id
 22:     LD  0,3(5) 	load id value
* <- Id
 23:     ST  0,2(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 24:     LD  0,4(5) 	load id value
* <- Id
 25:     ST  0,0(6) 	op: push left
* -> Id
 26:     LD  0,3(5) 	load id value
* <- Id
 27:     LD  1,0(6) 	op: load left
 28:    ADD  0,1,0 	op +
* <- Op
 29:     ST  0,3(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 30:     LD  0,0(5) 	load id value
* <- Id
 31:     ST  0,0(6) 	op: push left
* -> Const
 32:    LDC  0,1(0) 	load const
* <- Const
 33:     LD  1,0(6) 	op: load left
 34:    ADD  0,1,0 	op +
* <- Op
 35:     ST  0,0(5) 	assign: store value
* <- assign
 36:    LDA  7,-27(7) 	unconditional jmp
 19:    JEQ  0,17(7) 	repeat: jmp to the out of while
* <- repeat
* -> Id
 37:     LD  0,3(5) 	load id value
* <- Id
 38:    OUT  0,0,0 	output value in register[ac]
* End of execution.
 39:   HALT  0,0,0 	
