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
* function entry:
* main
  8:    LDC  0,11(0) 	get function adress
  9:     ST  0,0(5) 	set function adress
 11:    MOV  1,2,0 	store the caller fp temporarily
 12:    MOV  2,3,0 	exchang the stack(context)
 13:   PUSH  1,0(3) 	push the caller fp
 14:   PUSH  0,0(3) 	push the return adress
 15:    LDA  3,-1(3) 	stack expand
* -> Const
 16:    LDC  0,11(0) 	load integer const
 17:   PUSH  0,0(6) 	store exp
* <- Const
 18:    LDA  1,-2(2) 	move the adress of ID
 19:    POP  0,0(6) 	copy bytes
 20:     ST  0,0(1) 	copy bytes
* -> if
* -> Op
* -> Id
 21:     LD  0,-2(2) 	load id value
 22:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 23:    LDC  0,11(0) 	load integer const
 24:   PUSH  0,0(6) 	store exp
* <- Const
 25:    POP  1,0(6) 	pop right
 26:    POP  0,0(6) 	pop left
 27:    SUB  0,0,1 	op <
 28:    JGE  0,2(7) 	br if true
 29:    LDC  0,0(0) 	false case
 30:    LDA  7,1(7) 	unconditional jmp
 31:    LDC  0,1(0) 	true case
 32:   PUSH  0,0(6) 	op: load left
* <- Op
 33:    POP  0,0(6) 	pop from the mp
 34:    JNE  0,1,7 	true case:, execute if part
 35:     GO  0,0,0 	go to label
* -> Const
 36:    LDC  0,10(0) 	load integer const
 37:   PUSH  0,0(6) 	store exp
* <- Const
 38:    POP  0,0(6) 	move result to register
 39:    OUT  0,0,0 	output value in register[ac / fac]
* -> if
* -> Op
* -> Id
 40:     LD  0,-2(2) 	load id value
 41:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 42:    LDC  0,11(0) 	load integer const
 43:   PUSH  0,0(6) 	store exp
* <- Const
 44:    POP  1,0(6) 	pop right
 45:    POP  0,0(6) 	pop left
 46:    SUB  0,0,1 	op <
 47:    JLT  0,2(7) 	br if true
 48:    LDC  0,0(0) 	false case
 49:    LDA  7,1(7) 	unconditional jmp
 50:    LDC  0,1(0) 	true case
 51:   PUSH  0,0(6) 	op: load left
* <- Op
 52:    POP  0,0(6) 	pop from the mp
 53:    JNE  0,1,7 	true case:, execute if part
 54:     GO  2,0,0 	go to label
* -> Const
 55:    LDC  0,100(0) 	load integer const
 56:   PUSH  0,0(6) 	store exp
* <- Const
 57:    POP  0,0(6) 	move result to register
 58:    OUT  0,0,0 	output value in register[ac / fac]
 59:     GO  3,0,0 	go to label
 60:  LABEL  2,0,0 	generate label
* if: jump to else
* -> Const
 61:    LDC  0,101(0) 	load integer const
 62:   PUSH  0,0(6) 	store exp
* <- Const
 63:    POP  0,0(6) 	move result to register
 64:    OUT  0,0,0 	output value in register[ac / fac]
 65:  LABEL  3,0,0 	generate label
* <- if
 66:     GO  1,0,0 	go to label
 67:  LABEL  0,0,0 	generate label
* if: jump to else
* -> Const
 68:    LDC  0,20(0) 	load integer const
 69:   PUSH  0,0(6) 	store exp
* <- Const
 70:    POP  0,0(6) 	move result to register
 71:    OUT  0,0,0 	output value in register[ac / fac]
 72:  LABEL  1,0,0 	generate label
* <- if
 73:    MOV  3,2,0 	restore the caller sp
 74:     LD  2,0(2) 	resotre the caller fp
 75:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 10:    LDA  7,65(7) 	skip the function body
* call main function
 76:     LD  1,0(5) 	get main function adress
 77:    LDC  0,79(0) 	store the return adress
 78:    LDA  7,0(1) 	ujp to the function body
 79:   HALT  0,0,0 	
