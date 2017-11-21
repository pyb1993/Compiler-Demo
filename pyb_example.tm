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
* -> Const
  7:    LDC  0,2(0) 	load integer const
  8:   PUSH  0,0(6) 	store exp
* <- Const
  9:    LDA  1,0(5) 	move the adress of ID
 10:    POP  0,0(6) 	copy bytes
 11:     ST  0,0(1) 	copy bytes 
* function entry
 13:    MOV  1,2,0 	store the caller fp temporarily
 14:    MOV  2,3,0 	exchang the stack(context)
 15:   PUSH  1,0(3) 	push the caller fp
 16:   PUSH  0,0(3) 	push the return adress
* -> assign
* -> Op
* -> Const
 17:    LDC  0,2(0) 	load integer const
 18:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 19:    LDC  0,9(0) 	load integer const
 20:   PUSH  0,0(6) 	store exp
* <- Const
 21:    POP  1,0(6) 	pop right
 22:    POP  0,0(6) 	pop left
 23:    ADD  0,0,1 	op +
 24:   PUSH  0,0(6) 	op: load left
* <- Op
 25:    LDA  1,2(2) 	move the adress of ID
 26:    POP  0,0(6) 	copy bytes
 27:     ST  0,0(1) 	copy bytes 
* <- assign
* -> Op
* -> Id
 28:     LD  0,1(2) 	load id value
 29:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 30:     LD  0,2(2) 	load id value
 31:   PUSH  0,0(6) 	store exp
* <- Id
 32:    POP  1,0(6) 	pop right
 33:    POP  0,0(6) 	pop left
 34:    ADD  0,0,1 	op +
 35:   PUSH  0,0(6) 	op: load left
* <- Op
 36:    POP  0,0(6) 	op: POP left
 37:   PUSH  0,0(6) 	op: push left
 38:    MOV  3,2,0 	restore the caller sp
 39:     LD  2,0(2) 	resotre the caller fp
 40:  RETURN  0,-1,3 	return to the caller
 41:    MOV  3,2,0 	restore the caller sp
 42:     LD  2,0(2) 	resotre the caller fp
 43:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,31(7) 	skip the function body
* function entry
 45:    MOV  1,2,0 	store the caller fp temporarily
 46:    MOV  2,3,0 	exchang the stack(context)
 47:   PUSH  1,0(3) 	push the caller fp
 48:   PUSH  0,0(3) 	push the return adress
 49:   PUSH  0,0(3) 	stack expand
 50:   PUSH  0,0(3) 	stack expand
* -> assign
* -> assign
* -> Op
* -> Const
 51:    LDC  0,1(0) 	load integer const
 52:   PUSH  0,0(6) 	store exp
* <- Const
* -> assign
* -> Const
 53:    LDC  0,3(0) 	load integer const
 54:   PUSH  0,0(6) 	store exp
* <- Const
 55:    POP  0,0(6) 	pop exp 
 56:   PUSH  0,0(3) 	push parameter into stack
* -> Const
 57:    LDC  0,2(0) 	load integer const
 58:   PUSH  0,0(6) 	store exp
* <- Const
 59:    POP  0,0(6) 	pop exp 
 60:   PUSH  0,0(3) 	push parameter into stack
 61:    LDA  0,1(7) 	store the return adress
 62:    LDC  7,13(0) 	ujp to the function body
 63:    LDA  3,2(3) 	pop parameters
 64:    LDA  1,0(5) 	move the adress of ID
 65:    POP  0,0(6) 	copy bytes
 66:     ST  0,0(1) 	copy bytes 
* -> Id
 67:    LDA  0,0(5) 	load id adress
* <- Id
 68:     LD  1,0(0) 	load bytes
 69:   PUSH  1,0(6) 	push bytes 
* <- assign
 70:    POP  1,0(6) 	pop right
 71:    POP  0,0(6) 	pop left
 72:    ADD  0,0,1 	op +
 73:   PUSH  0,0(6) 	op: load left
* <- Op
 74:    LDA  1,-2(2) 	move the adress of ID
 75:    POP  0,0(6) 	copy bytes
 76:    MOV  9,0,0 	move register 
 77:     ST  9,0(1) 	copy bytes 
* -> Id
 78:    LDA  0,-2(2) 	load id adress
* <- Id
 79:     LD  10,0(0) 	load bytes
 80:   PUSH  10,0(6) 	push bytes 
* <- assign
 81:    LDA  1,-3(2) 	move the adress of ID
 82:    POP  9,0(6) 	copy bytes
 83:    MOV  0,9,0 	move register 
 84:     ST  0,0(1) 	copy bytes 
* <- assign
* -> Id
 85:     LD  9,-2(2) 	load id value
 86:   PUSH  9,0(6) 	store exp
* <- Id
 87:    POP  9,0(6) 	move result to register
 88:    OUT  9,0,0 	output value in register[ac / fac]
* -> Id
 89:     LD  0,-3(2) 	load id value
 90:   PUSH  0,0(6) 	store exp
* <- Id
 91:    POP  0,0(6) 	move result to register
 92:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 93:     LD  0,0(5) 	load id value
 94:   PUSH  0,0(6) 	store exp
* <- Id
 95:    POP  0,0(6) 	move result to register
 96:    OUT  0,0,0 	output value in register[ac / fac]
 97:    MOV  3,2,0 	restore the caller sp
 98:     LD  2,0(2) 	resotre the caller fp
 99:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 44:    LDA  7,55(7) 	skip the function body
* call main function
100:    LDC  0,102(0) 	store the return adress
101:    LDC  7,45(0) 	ujp to the function body
102:   HALT  0,0,0 	
