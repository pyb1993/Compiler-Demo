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
 12:   PUSH  0,0(3) 	stack expand
 13:   PUSH  0,0(3) 	stack expand
* -> assign
* ->Single Op
 14:    LDA  0,-5,2 	LDA the var adress
 15:   PUSH  0,0(6) 	op: load left
 16:    POP  0,0(6) 	copy bytes
 17:     ST  0,-2(2) 	copy bytes 
* <- assign
* -> assign
* -> Const
 18:    LDC  0,10(0) 	load integer const
 19:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 20:    LDC  0,10(0) 	load integer const
 21:   PUSH  0,0(6) 	store exp
* <- Const
* ->Single Op
* -> Id
 22:     LD  0,-2(2) 	load id value
 23:   PUSH  0,0(6) 	store exp
* <- Id
 24:    POP  0,0(6) 	pop the adress
 25:    MOV  1,0,0 	load adress of lhs struct
 26:    LDC  0,1,0 	load offset of member
 27:    ADD  0,0,1 	compute the real adress if pointK
 28:    MOV  1,0,0 	move adress to ac1
 29:    POP  0,0(6) 	copy bytes
 30:     ST  0,0(1) 	copy bytes 
* <- assign
* -> assign
* -> Op
* -> Id
 31:    LDA  0,-5(2) 	load id adress
* <- Id
 32:    MOV  1,0,0 	load adress of lhs struct
 33:    LDC  0,1,0 	load offset of member
 34:    ADD  0,0,1 	compute the real adress if pointK
 35:     LD  0,0(0) 	copy bytes
 36:   PUSH  0,0(6) 	push a.x value into tmp
* -> Const
 37:    LDC  0,5(0) 	load integer const
 38:   PUSH  0,0(6) 	store exp
* <- Const
 39:    POP  1,0(6) 	pop right
 40:    POP  0,0(6) 	pop left
 41:    ADD  0,0,1 	op +
 42:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Op
* -> Id
 43:    LDA  0,-5(2) 	load id adress
* <- Id
 44:    MOV  1,0,0 	load adress of lhs struct
 45:    LDC  0,1,0 	load offset of member
 46:    ADD  0,0,1 	compute the real adress if pointK
 47:     LD  0,0(0) 	copy bytes
 48:   PUSH  0,0(6) 	push a.x value into tmp
* -> Const
 49:    LDC  0,5(0) 	load integer const
 50:   PUSH  0,0(6) 	store exp
* <- Const
 51:    POP  1,0(6) 	pop right
 52:    POP  0,0(6) 	pop left
 53:    ADD  0,0,1 	op +
 54:   PUSH  0,0(6) 	op: load left
* <- Op
* ->Single Op
* -> Id
 55:     LD  0,-2(2) 	load id value
 56:   PUSH  0,0(6) 	store exp
* <- Id
 57:    POP  0,0(6) 	pop the adress
 58:    MOV  1,0,0 	load adress of lhs struct
 59:    LDC  0,2,0 	load offset of member
 60:    ADD  0,0,1 	compute the real adress if pointK
 61:    MOV  1,0,0 	move adress to ac1
 62:    POP  0,0(6) 	copy bytes
 63:    MOV  9,0,0 	move register(convert) 
 64:     ST  9,0(1) 	copy bytes 
* <- assign
* -> Id
 65:    LDA  0,-5(2) 	load id adress
* <- Id
 66:    MOV  1,0,0 	load adress of lhs struct
 67:    LDC  0,2,0 	load offset of member
 68:    ADD  0,0,1 	compute the real adress if pointK
 69:     LD  9,0(0) 	copy bytes
 70:   PUSH  9,0(6) 	push a.x value into tmp
 71:    POP  9,0(6) 	move result to register
 72:    OUT  9,0,0 	output value in register[ac / fac]
 73:    MOV  3,2,0 	restore the caller sp
 74:     LD  2,0(2) 	resotre the caller fp
 75:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,68(7) 	skip the function body
* call main function
 76:    LDC  0,78(0) 	store the return adress
 77:    LDC  7,8(0) 	ujp to the function body
 78:   HALT  0,0,0 	
