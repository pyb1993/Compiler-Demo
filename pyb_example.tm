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
* -> assign
* -> Const
  7:    LDC  0,10(0) 	load integer const
  8:   PUSH  0,0(6) 	store exp
* <- Const
  9:    POP  0,0(6) 	copy bytes
 10:    MOV  9,0,0 	move register 
 11:     ST  9,0(5) 	copy bytes 
* <- assign
* function entry
 13:    MOV  1,2,0 	store the caller fp temporarily
 14:    MOV  2,3,0 	exchang the stack(context)
 15:   PUSH  1,0(3) 	push the caller fp
 16:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Id
 17:     LD  0,1(2) 	load id value
 18:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 19:     LD  0,2(2) 	load id value
 20:   PUSH  0,0(6) 	store exp
* <- Id
 21:    POP  1,0(6) 	pop right
 22:    POP  0,0(6) 	pop left
 23:    MUL  0,0,1 	op *
 24:   PUSH  0,0(6) 	op: load left
* <- Op
 25:    POP  0,0(6) 	op: POP left
 26:   PUSH  0,0(6) 	op: push left
 27:    MOV  3,2,0 	restore the caller sp
 28:     LD  2,0(2) 	resotre the caller fp
 29:  RETURN  0,-1,3 	return to the caller
 30:    MOV  3,2,0 	restore the caller sp
 31:     LD  2,0(2) 	resotre the caller fp
 32:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,20(7) 	skip the function body
* function entry
 34:    MOV  1,2,0 	store the caller fp temporarily
 35:    MOV  2,3,0 	exchang the stack(context)
 36:   PUSH  1,0(3) 	push the caller fp
 37:   PUSH  0,0(3) 	push the return adress
* -> Const
 38:    LDC  0,4(0) 	load integer const
 39:   PUSH  0,0(6) 	store exp
* <- Const
 40:    POP  0,0(6) 	pop exp 
 41:   PUSH  0,0(3) 	push parameter into stack
* -> Const
 42:    LDC  0,2(0) 	load integer const
 43:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 44:    LDC  0,4(0) 	load integer const
 45:   PUSH  0,0(6) 	store exp
* <- Const
 46:    POP  0,0(6) 	pop exp 
 47:   PUSH  0,0(3) 	push parameter into stack
 48:    LDA  0,1(7) 	store the return adress
 49:    LDC  7,13(0) 	ujp to the function body
 50:    POP  0,0(6) 	
 51:   PUSH  0,0(6) 	store exp
 52:    POP  0,0(6) 	move result to register
 53:    OUT  0,0,0 	output value in register[ac / fac]
 54:    MOV  3,2,0 	restore the caller sp
 55:     LD  2,0(2) 	resotre the caller fp
 56:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 33:    LDA  7,23(7) 	skip the function body
* call main function
 57:    LDC  0,59(0) 	store the return adress
 58:    LDC  7,34(0) 	ujp to the function body
 59:   HALT  0,0,0 	
