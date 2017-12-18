* File: pyb_example.tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
  2:     LD  5,1(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:     LD  2,2(0) 	load first fp from location 2
  5:     LD  3,2(0) 	load first sp from location 2
  6:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry
  8:    MOV  1,2,0 	store the caller fp temporarily
  9:    MOV  2,3,0 	exchang the stack(context)
 10:   PUSH  1,0(3) 	push the caller fp
 11:   PUSH  0,0(3) 	push the return adress
 12:    LDA  3,-1(3) 	stack expand
* -> Const
 13:    LDC  0,3(0) 	load integer const
 14:   PUSH  0,0(6) 	store exp
* <- Const
 15:    LDA  1,-2(2) 	move the adress of ID
 16:    POP  0,0(6) 	copy bytes
 17:     ST  0,0(1) 	copy bytes
 18:    LDA  3,-1(3) 	stack expand
* -> Const
 19:    LDC  0,1(0) 	load integer const
 20:   PUSH  0,0(6) 	store exp
* <- Const
 21:    LDA  1,-3(2) 	move the adress of ID
 22:    POP  0,0(6) 	copy bytes
 23:     ST  0,0(1) 	copy bytes
 24:    LDA  3,-1(3) 	stack expand
* -> Const
 25:    LDC  0,4(0) 	load integer const
 26:   PUSH  0,0(6) 	store exp
* <- Const
 27:    LDA  1,-4(2) 	move the adress of ID
 28:    POP  0,0(6) 	copy bytes
 29:     ST  0,0(1) 	copy bytes
* -> Id
 30:     LD  0,-4(2) 	load id value
 31:   PUSH  0,0(6) 	store exp
* <- Id
 32:    POP  0,0(6) 	move result to register
 33:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 34:     LD  0,-3(2) 	load id value
 35:   PUSH  0,0(6) 	store exp
* <- Id
 36:    POP  0,0(6) 	move result to register
 37:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 38:     LD  0,-2(2) 	load id value
 39:   PUSH  0,0(6) 	store exp
* <- Id
 40:    POP  0,0(6) 	move result to register
 41:    OUT  0,0,0 	output value in register[ac / fac]
 42:    MOV  3,2,0 	restore the caller sp
 43:     LD  2,0(2) 	resotre the caller fp
 44:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,37(7) 	skip the function body
* call main function
 45:    LDC  0,47(0) 	store the return adress
 46:    LDC  7,8(0) 	ujp to the function body
 47:   HALT  0,0,0 	
