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
* -> Op
* -> Op
* -> Const
 15:    LDC  0,1(0) 	load integer const
 16:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 17:    LDC  0,5(0) 	load integer const
 18:   PUSH  0,0(6) 	store exp
* <- Const
 19:    POP  1,0(6) 	pop right
 20:    POP  0,0(6) 	pop left
 21:    SUB  0,0,1 	op <
 22:    JGT  0,2(7) 	br if true
 23:    LDC  0,0(0) 	false case
 24:    LDA  7,1(7) 	unconditional jmp
 25:    LDC  0,1(0) 	true case
 26:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Const
 27:    LDC  0,8(0) 	load integer const
 28:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 29:    LDC  0,3(0) 	load integer const
 30:   PUSH  0,0(6) 	store exp
* <- Const
 31:    POP  1,0(6) 	pop right
 32:    POP  0,0(6) 	pop left
 33:    SUB  0,0,1 	op <
 34:    JLT  0,2(7) 	br if true
 35:    LDC  0,0(0) 	false case
 36:    LDA  7,1(7) 	unconditional jmp
 37:    LDC  0,1(0) 	true case
 38:   PUSH  0,0(6) 	
* <- Op
 39:    POP  1,0(6) 	pop right
 40:    POP  0,0(6) 	pop left
 41:    JNE  0,3(7) 	br if true
 42:    JNE  1,2(7) 	br if true
 43:    LDC  0,0(0) 	false case
 44:    LDA  7,1(7) 	unconditional jmp
 45:    LDC  0,1(0) 	true case
 46:   PUSH  0,0(6) 	
* <- Op
 47:    POP  0,0(6) 	move result to register
 48:    OUT  0,0,0 	output value in register[ac / fac]
 49:    MOV  3,2,0 	restore the caller sp
 50:     LD  2,0(2) 	resotre the caller fp
 51:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 10:    LDA  7,41(7) 	skip the function body
* call main function
 52:     LD  1,0(5) 	get main function adress
 53:    LDC  0,55(0) 	store the return adress
 54:    LDA  7,0(1) 	ujp to the function body
 55:   HALT  0,0,0 	
