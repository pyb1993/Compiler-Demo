* File: pyb_example.tm
* Standard prelude:
  0:    LDC  6,65535(0) 	load mp adress
  1:     ST  0,0(0) 	clear location 0
  2:    LDC  5,4095(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:    LDC  4,2000(0) 	load gp adress from location 1
  5:    LDC  2,60000(0) 	load first fp from location 2
  6:    LDC  3,60000(0) 	load first sp from location 2
  7:     ST  0,2(0) 	clear location 2
* End of standard prelude.
  8:    LDA  3,-1(3) 	stack expand
  9:    LDA  3,-1(3) 	stack expand
 10:    MOV  3,2,0 	resotre stack in struct
* function entry:
* main
 11:    LDC  0,14(0) 	get function adress
 12:     ST  0,0(5) 	set function adress
 14:    MOV  1,2,0 	store the caller fp temporarily
 15:    MOV  2,3,0 	exchang the stack(context)
 16:   PUSH  1,0(3) 	push the caller fp
 17:   PUSH  0,0(3) 	push the return adress
 18:    LDA  3,-2(3) 	stack expand
* -> assign
* -> Const
 19:    LDC  0,1(0) 	load integer const
 20:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 21:    LDA  0,-3(2) 	load id adress
 22:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 23:    POP  1,0,6 	load adress of lhs struct
 24:    LDC  0,0,0 	load offset of member
 25:    ADD  0,0,1 	compute the real adress if pointK
 26:   PUSH  0,0(6) 	
 27:    POP  1,0(6) 	move the adress of referenced
 28:    POP  0,0(6) 	copy bytes
 29:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Op
* -> Id
 30:    LDA  0,-3(2) 	load id adress
 31:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 32:    POP  1,0,6 	load adress of lhs struct
 33:    LDC  0,0,0 	load offset of member
 34:    ADD  0,0,1 	compute the real adress if pointK
 35:   PUSH  0,0(6) 	
 36:    POP  0,0(6) 	load adress from mp
 37:     LD  1,0(0) 	copy bytes
 38:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
 39:    LDA  0,-3(2) 	load id adress
 40:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 41:    POP  1,0,6 	load adress of lhs struct
 42:    LDC  0,0,0 	load offset of member
 43:    ADD  0,0,1 	compute the real adress if pointK
 44:   PUSH  0,0(6) 	
 45:    POP  0,0(6) 	load adress from mp
 46:     LD  1,0(0) 	copy bytes
 47:   PUSH  1,0(6) 	push a.x value into tmp
 48:    POP  1,0(6) 	pop right
 49:    POP  0,0(6) 	pop left
 50:    MUL  0,0,1 	op *
 51:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
 52:    LDA  0,-3(2) 	load id adress
 53:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 54:    POP  1,0,6 	load adress of lhs struct
 55:    LDC  0,1,0 	load offset of member
 56:    ADD  0,0,1 	compute the real adress if pointK
 57:   PUSH  0,0(6) 	
 58:    POP  1,0(6) 	move the adress of referenced
 59:    POP  0,0(6) 	copy bytes
 60:    MOV  9,0,0 	copy bytes
 61:     ST  9,0(1) 	copy bytes
* <- assign
* -> Id
 62:    LDA  0,-3(2) 	load id adress
 63:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 64:    POP  1,0,6 	load adress of lhs struct
 65:    LDC  0,0,0 	load offset of member
 66:    ADD  0,0,1 	compute the real adress if pointK
 67:   PUSH  0,0(6) 	
 68:    POP  0,0(6) 	load adress from mp
 69:     LD  1,0(0) 	copy bytes
 70:   PUSH  1,0(6) 	push a.x value into tmp
 71:    POP  0,0(6) 	move result to register
 72:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 73:    LDA  0,-3(2) 	load id adress
 74:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 75:    POP  1,0,6 	load adress of lhs struct
 76:    LDC  0,1,0 	load offset of member
 77:    ADD  0,0,1 	compute the real adress if pointK
 78:   PUSH  0,0(6) 	
 79:    POP  0,0(6) 	load adress from mp
 80:     LD  10,0(0) 	copy bytes
 81:   PUSH  10,0(6) 	push a.x value into tmp
 82:    POP  9,0(6) 	move result to register
 83:    OUT  9,0,0 	output value in register[ac / fac]
 84:    MOV  3,2,0 	restore the caller sp
 85:     LD  2,0(2) 	resotre the caller fp
 86:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 13:    LDA  7,73(7) 	skip the function body
* call main function
 87:     LD  1,0(5) 	get main function adress
 88:    LDC  0,90(0) 	store the return adress
 89:    LDA  7,0(1) 	ujp to the function body
 90:   HALT  0,0,0 	
