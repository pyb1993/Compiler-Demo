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
 13:    LDC  0,20(0) 	load integer const
 14:   PUSH  0,0(6) 	store exp
* <- Const
 15:    LDA  1,-2(2) 	move the adress of ID
 16:    POP  0,0(6) 	copy bytes
 17:     ST  0,0(1) 	copy bytes
* -> repeat
* repeat: jump after body comes back here
* -> Op
* -> Id
 18:     LD  0,-2(2) 	load id value
 19:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 20:    LDC  0,3(0) 	load integer const
 21:   PUSH  0,0(6) 	store exp
* <- Const
 22:    POP  1,0(6) 	pop right
 23:    POP  0,0(6) 	pop left
 24:    SUB  0,0,1 	op <
 25:    JGT  0,2(7) 	br if true
 26:    LDC  0,0(0) 	false case
 27:    LDA  7,1(7) 	unconditional jmp
 28:    LDC  0,1(0) 	true case
 29:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
 33:     LD  0,-2(2) 	load id value
 34:   PUSH  0,0(6) 	store exp
* <- Id
 35:    POP  0,0(6) 	move result to register
 36:    OUT  0,0,0 	output value in register[ac / fac]
* -> if
* -> Op
* -> Id
 37:     LD  0,-2(2) 	load id value
 38:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 39:    LDC  0,10(0) 	load integer const
 40:   PUSH  0,0(6) 	store exp
* <- Const
 41:    POP  1,0(6) 	pop right
 42:    POP  0,0(6) 	pop left
 43:    SUB  0,0,1 	op <
 44:    JLT  0,2(7) 	br if true
 45:    LDC  0,0(0) 	false case
 46:    LDA  7,1(7) 	unconditional jmp
 47:    LDC  0,1(0) 	true case
 48:   PUSH  0,0(6) 	op: load left
* <- Op
* if: jump to else belongs here
 50:     GO  0,0,0 	go to label
* if: jump to end belongs here
 49:    POP  0,0(6) 	pop the condition value
 50:    JEQ  0,1(7) 	if: jmp to else
 51:    LDA  7,0(7) 	jmp to end
* <- if
* -> assign
* -> Op
* -> Id
 52:     LD  0,-2(2) 	load id value
 53:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 54:    LDC  0,2(0) 	load integer const
 55:   PUSH  0,0(6) 	store exp
* <- Const
 56:    POP  1,0(6) 	pop right
 57:    POP  0,0(6) 	pop left
 58:    SUB  0,0,1 	op -
 59:   PUSH  0,0(6) 	op: load left
* <- Op
 60:    LDA  1,-2(2) 	move the adress of ID
 61:    POP  0,0(6) 	copy bytes
 62:     ST  0,0(1) 	copy bytes
* <- assign
 63:    LDA  7,-46(7) 	unconditional jmp
 30:    JEQ  0,33(7) 	repeat: jmp to the out of while
 64:  LABEL  0,0,0 	generate label
* <- repeat
 65:    MOV  3,2,0 	restore the caller sp
 66:     LD  2,0(2) 	resotre the caller fp
 67:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,60(7) 	skip the function body
* call main function
 68:    LDC  0,70(0) 	store the return adress
 69:    LDC  7,8(0) 	ujp to the function body
 70:   HALT  0,0,0 	
