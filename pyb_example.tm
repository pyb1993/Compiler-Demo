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
 12:    LDA  3,-5(3) 	stack expand
 13:    LDA  3,-1(3) 	stack expand
* ->Single Op
* -> Id
 14:    LDA  0,-6(2) 	load id adress
 15:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 16:    POP  1,0,6 	load adress of lhs struct
 17:    LDC  0,4,0 	load offset of member
 18:    ADD  0,0,1 	compute the real adress if pointK
 19:   PUSH  0,0(6) 	
 20:    POP  1,0,6 	load adress of lhs struct
 21:    LDC  0,0,0 	load offset of member
 22:    ADD  0,0,1 	compute the real adress if pointK
 23:   PUSH  0,0(6) 	
* <-Single Op
 24:    LDA  1,-7(2) 	move the adress of ID
 25:    POP  0,0(6) 	copy bytes
 26:     ST  0,0(1) 	copy bytes
* -> assign
* -> Const
 27:    LDC  0,33(0) 	load integer const
 28:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 29:     LD  0,-7(2) 	load id value
 30:   PUSH  0,0(6) 	store exp
* <- Id
 31:    POP  1,0(6) 	move the adress of referenced
 32:    POP  0,0(6) 	copy bytes
 33:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
 34:     LD  0,-7(2) 	load id value
 35:   PUSH  0,0(6) 	store exp
* <- Id
 36:    POP  0,0(6) 	move result to register
 37:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 38:    LDA  0,-6(2) 	load id adress
 39:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 40:    POP  1,0,6 	load adress of lhs struct
 41:    LDC  0,3,0 	load offset of member
 42:    ADD  0,0,1 	compute the real adress if pointK
 43:   PUSH  0,0(6) 	
 44:    POP  0,0(6) 	load adress from mp
 45:     LD  1,0(0) 	copy bytes
 46:   PUSH  1,0(6) 	push a.x value into tmp
 47:    POP  0,0(6) 	move result to register
 48:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 49:    LDA  0,-6(2) 	load id adress
 50:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 51:    POP  1,0,6 	load adress of lhs struct
 52:    LDC  0,4,0 	load offset of member
 53:    ADD  0,0,1 	compute the real adress if pointK
 54:   PUSH  0,0(6) 	
 55:    POP  1,0,6 	load adress of lhs struct
 56:    LDC  0,0,0 	load offset of member
 57:    ADD  0,0,1 	compute the real adress if pointK
 58:   PUSH  0,0(6) 	
 59:    POP  0,0(6) 	load adress from mp
 60:     LD  1,0(0) 	copy bytes
 61:   PUSH  1,0(6) 	push a.x value into tmp
 62:    POP  0,0(6) 	move result to register
 63:    OUT  0,0,0 	output value in register[ac / fac]
 64:    MOV  3,2,0 	restore the caller sp
 65:     LD  2,0(2) 	resotre the caller fp
 66:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,59(7) 	skip the function body
* call main function
 67:    LDC  0,69(0) 	store the return adress
 68:    LDC  7,8(0) 	ujp to the function body
 69:   HALT  0,0,0 	
