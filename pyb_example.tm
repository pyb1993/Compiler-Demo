* File: pyb_example.tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
* -> assign
* -> Const
  2:    LDC  0,2(0) 	load integer const
* <- Const
  3:     ST  0,0(5) 	assign: store value
* <- assign
  4:     IN  0,0,0 	read integer/float value
  5:     ST  0,1(5) 	assign: store value
* -> assign
* -> Const
  6:    LDC  0,1(0) 	load integer const
* <- Const
  7:     ST  0,2(5) 	assign: store value
* <- assign
* -> assign
* -> Const
  8:    LDC  0,1(0) 	load integer const
* <- Const
  9:     ST  0,3(5) 	assign: store value
* <- assign
* -> Id
 10:     LD  0,3(5) 	load id value
* <- Id
 11:    OUT  0,0,0 	output value in register[ac]
* -> repeat
* repeat: jump after body comes back here
* -> Op
* -> Id
 12:     LD  0,0(5) 	load id value
* <- Id
 13:     ST  0,0(6) 	op: push left
* -> Op
* -> Id
 14:     LD  0,1(5) 	load id value
* <- Id
 15:     ST  0,-1(6) 	op: push left
* -> Const
 16:    LDC  0,3(0) 	load integer const
* <- Const
 17:     LD  1,-1(6) 	op: load left
 18:    ADD  0,1,0 	op +
* <- Op
 19:     LD  1,0(6) 	op: load left
 20:    SUB  0,1,0 	op <
 21:    JLT  0,2(7) 	br if true
 22:    LDC  0,0(0) 	false case
 23:    LDA  7,1(7) 	unconditional jmp
 24:    LDC  0,1(0) 	true case
* <- Op
* -> assign
* -> Id
 26:     LD  0,2(5) 	load id value
* <- Id
 27:     ST  0,4(5) 	assign: store value
* <- assign
* -> assign
* -> Id
 28:     LD  0,3(5) 	load id value
* <- Id
 29:     ST  0,2(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 30:     LD  0,4(5) 	load id value
* <- Id
 31:     ST  0,0(6) 	op: push left
* -> Id
 32:     LD  0,3(5) 	load id value
* <- Id
 33:     LD  1,0(6) 	op: load left
 34:    ADD  0,1,0 	op +
* <- Op
 35:     ST  0,3(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 36:     LD  0,0(5) 	load id value
* <- Id
 37:     ST  0,0(6) 	op: push left
* -> Const
 38:    LDC  0,1(0) 	load integer const
* <- Const
 39:     LD  1,0(6) 	op: load left
 40:    ADD  0,1,0 	op +
* <- Op
 41:     ST  0,0(5) 	assign: store value
* <- assign
 42:    LDA  7,-31(7) 	unconditional jmp
 25:    JEQ  0,17(7) 	repeat: jmp to the out of while
* <- repeat
* -> Id
 43:     LD  0,3(5) 	load id value
* <- Id
 44:    OUT  0,0,0 	output value in register[ac]
* -> Op
* -> Id
 45:     LD  0,3(5) 	load id value
 46:    MOV  9,0,0 	move from one reg(s) to reg(r)
* <- Id
 47:     ST  9,0(6) 	op: push left
* -> Const
 48:    LDC  10,3.000000(0) * <- Const
 49:     LD  10,0(6) 	op: load left
 50:    DIV  9,10,9 	op /
* <- Op
 51:    OUT  9,0,0 	output value in register[ac]
* End of execution.
 52:   HALT  0,0,0 	
