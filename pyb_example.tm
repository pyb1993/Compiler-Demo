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
 13:    LDC  0,0(0) 	load integer const
 14:   PUSH  0,0(6) 	store exp
* <- Const
 15:    LDA  1,-2(2) 	move the adress of ID
 16:    POP  0,0(6) 	copy bytes
 17:     ST  0,0(1) 	copy bytes
* -> repeat
 18:  LABEL  0,0,0 	generate label
* repeat: jump after body comes back here
* -> Op
* -> Id
 19:     LD  0,-2(2) 	load id value
 20:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 21:    LDC  0,10(0) 	load integer const
 22:   PUSH  0,0(6) 	store exp
* <- Const
 23:    POP  1,0(6) 	pop right
 24:    POP  0,0(6) 	pop left
 25:    SUB  0,0,1 	op <
 26:    JLT  0,2(7) 	br if true
 27:    LDC  0,0(0) 	false case
 28:    LDA  7,1(7) 	unconditional jmp
 29:    LDC  0,1(0) 	true case
 30:   PUSH  0,0(6) 	op: load left
* <- Op
* -> if
* -> Op
* -> Id
 32:     LD  0,-2(2) 	load id value
 33:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 34:    LDC  0,8(0) 	load integer const
 35:   PUSH  0,0(6) 	store exp
* <- Const
 36:    POP  1,0(6) 	pop right
 37:    POP  0,0(6) 	pop left
 38:    SUB  0,0,1 	op ==, convertd_type
 39:    JEQ  0,2(7) 	br if true
 40:    LDC  0,0(0) 	false case
 41:    LDA  7,1(7) 	unconditional jmp
 42:    LDC  0,1(0) 	true case
 43:   PUSH  0,0(6) 	op: load left
* <- Op
* if: jump to else
 46:     GO  0,0,0 	go to label
* if: jump to end
 44:    POP  0,0(6) 	pop the condition value
 45:    JEQ  0,2(7) 	if: jmp to else
 47:    LDA  7,0(7) 	jmp to end
* <- if
* -> assign
* -> Op
* -> assign
* -> Op
* -> Id
 48:     LD  0,-2(2) 	load id value
 49:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 50:    LDC  0,1(0) 	load integer const
 51:   PUSH  0,0(6) 	store exp
* <- Const
 52:    POP  1,0(6) 	pop right
 53:    POP  0,0(6) 	pop left
 54:    ADD  0,0,1 	op +
 55:   PUSH  0,0(6) 	op: load left
* <- Op
 56:    LDA  1,-2(2) 	move the adress of ID
 57:    POP  0,0(6) 	copy bytes
 58:     ST  0,0(1) 	copy bytes
* -> Id
 59:    LDA  0,-2(2) 	load id adress
* <- Id
 60:     LD  1,0(0) 	load bytes
 61:   PUSH  1,0(6) 	push bytes 
* <- assign
* -> Const
 62:    LDC  0,3(0) 	load integer const
 63:   PUSH  0,0(6) 	store exp
* <- Const
 64:    POP  1,0(6) 	pop right
 65:    POP  0,0(6) 	pop left
 66:    ADD  0,0,1 	op +
 67:   PUSH  0,0(6) 	op: load left
* <- Op
 68:    LDA  1,-2(2) 	move the adress of ID
 69:    POP  0,0(6) 	copy bytes
 70:     ST  0,0(1) 	copy bytes
* -> Id
 71:    LDA  0,-2(2) 	load id adress
* <- Id
 72:     LD  1,0(0) 	load bytes
 73:   PUSH  1,0(6) 	push bytes 
* <- assign
 74:    POP  0,0(6) 	move result to register
 75:    OUT  0,0,0 	output value in register[ac / fac]
 76:    LDA  7,-58(7) 	unconditional jmp
 31:    JEQ  0,45(7) 	repeat: jmp to the out of while
 77:  LABEL  1,0,0 	generate label
* <- repeat
 78:    MOV  3,2,0 	restore the caller sp
 79:     LD  2,0(2) 	resotre the caller fp
 80:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,73(7) 	skip the function body
* call main function
 81:    LDC  0,83(0) 	store the return adress
 82:    LDC  7,8(0) 	ujp to the function body
 83:   HALT  0,0,0 	
