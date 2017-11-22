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
* -> assign
* ->Single Op
* -> Id
 12:     LD  0,4(2) 	load id value
 13:   PUSH  0,0(6) 	store exp
* <- Id
 14:    POP  0,0(6) 	pop the adress
 15:     LD  1,0(0) 	load bytes
 16:   PUSH  1,0(6) 	push bytes 
 17:    LDA  1,1(2) 	move the adress of ID
 18:    POP  0,0(6) 	copy bytes
 19:     ST  0,2(1) 	copy bytes
 20:    POP  0,0(6) 	copy bytes
 21:     ST  0,1(1) 	copy bytes
 22:    POP  0,0(6) 	copy bytes
 23:     ST  0,0(1) 	copy bytes
* <- assign
 24:    MOV  3,2,0 	restore the caller sp
 25:     LD  2,0(2) 	resotre the caller fp
 26:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,19(7) 	skip the function body
* function entry
 28:    MOV  1,2,0 	store the caller fp temporarily
 29:    MOV  2,3,0 	exchang the stack(context)
 30:   PUSH  1,0(3) 	push the caller fp
 31:   PUSH  0,0(3) 	push the return adress
 32:    LDA  3,-3(3) 	stack expand
* -> assign
* -> Const
 33:    LDC  0,12(0) 	load integer const
 34:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 35:    LDA  0,-4(2) 	load id adress
* <- Id
 36:    MOV  1,0,0 	load adress of lhs struct
 37:    LDC  0,0,0 	load offset of member
 38:    ADD  0,0,1 	compute the real adress if pointK
 39:    MOV  1,0,0 	move adress to ac1
 40:    POP  0,0(6) 	copy bytes
 41:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Const
 42:    LDC  0,2(0) 	load integer const
 43:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 44:    LDA  0,-4(2) 	load id adress
* <- Id
 45:    MOV  1,0,0 	load adress of lhs struct
 46:    LDC  0,1,0 	load offset of member
 47:    ADD  0,0,1 	compute the real adress if pointK
 48:    MOV  1,0,0 	move adress to ac1
 49:    POP  0,0(6) 	copy bytes
 50:     ST  0,0(1) 	copy bytes
* <- assign
 51:    LDA  3,-1(3) 	stack expand
* ->Single Op
 52:    LDA  0,-4,2 	LDA the var adress
 53:   PUSH  0,0(6) 	op: load left
 54:    LDA  1,-5(2) 	move the adress of ID
 55:    POP  0,0(6) 	copy bytes
 56:     ST  0,0(1) 	copy bytes
* -> assign
* ->Single Op
* -> Id
 57:     LD  0,-5(2) 	load id value
 58:   PUSH  0,0(6) 	store exp
* <- Id
 59:    POP  0,0(6) 	pop the adress
 60:     LD  1,0(0) 	load bytes
 61:   PUSH  1,0(6) 	push bytes 
 62:    LDA  1,-4(2) 	move the adress of ID
 63:    POP  0,0(6) 	copy bytes
 64:     ST  0,2(1) 	copy bytes
 65:    POP  0,0(6) 	copy bytes
 66:     ST  0,1(1) 	copy bytes
 67:    POP  0,0(6) 	copy bytes
 68:     ST  0,0(1) 	copy bytes
* <- assign
* -> Const
 69:    LDC  0,1(0) 	load integer const
 70:   PUSH  0,0(6) 	store exp
* <- Const
 71:    POP  0,0(6) 	move result to register
 72:    OUT  0,0,0 	output value in register[ac / fac]
 73:    MOV  3,2,0 	restore the caller sp
 74:     LD  2,0(2) 	resotre the caller fp
 75:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 27:    LDA  7,48(7) 	skip the function body
* call main function
 76:    LDC  0,78(0) 	store the return adress
 77:    LDC  7,28(0) 	ujp to the function body
 78:   HALT  0,0,0 	
