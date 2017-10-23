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
* ->Single Op
* -> Id
 12:     LD  0,1(2) 	load id value
 13:   PUSH  0,0(6) 	store exp
* <- Id
 14:    POP  0,0(6) 	pop the adress
 15:     LD  1,0(0) 	load bytes
 16:   PUSH  1,0(6) 	push bytes 
 17:    POP  0,0(6) 	move result to register
 18:    OUT  0,0,0 	output value in register[ac / fac]
* ->Single Op
* -> Id
 19:     LD  0,2(2) 	load id value
 20:   PUSH  0,0(6) 	store exp
* <- Id
 21:    POP  0,0(6) 	pop the adress
 22:     LD  1,0(0) 	load bytes
 23:   PUSH  1,0(6) 	push bytes 
 24:    POP  0,0(6) 	move result to register
 25:    OUT  0,0,0 	output value in register[ac / fac]
* ->Single Op
* ->Single Op
* -> Id
 26:     LD  0,1(2) 	load id value
 27:   PUSH  0,0(6) 	store exp
* <- Id
 28:    POP  0,0(6) 	pop the adress
 29:     LD  1,0(0) 	load bytes
 30:   PUSH  1,0(6) 	push bytes 
 31:    POP  0,0(6) 	pop the adress
 32:     LD  1,0(0) 	load bytes
 33:   PUSH  1,0(6) 	push bytes 
 34:    POP  0,0(6) 	move result to register
 35:    OUT  0,0,0 	output value in register[ac / fac]
* ->Single Op
* ->Single Op
* -> Id
 36:     LD  0,2(2) 	load id value
 37:   PUSH  0,0(6) 	store exp
* <- Id
 38:    POP  0,0(6) 	pop the adress
 39:     LD  1,0(0) 	load bytes
 40:   PUSH  1,0(6) 	push bytes 
 41:    POP  0,0(6) 	pop the adress
 42:     LD  1,0(0) 	load bytes
 43:   PUSH  1,0(6) 	push bytes 
 44:    POP  0,0(6) 	move result to register
 45:    OUT  0,0,0 	output value in register[ac / fac]
 46:    MOV  3,2,0 	restore the caller sp
 47:     LD  2,0(2) 	resotre the caller fp
 48:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,41(7) 	skip the function body
* function entry
 50:    MOV  1,2,0 	store the caller fp temporarily
 51:    MOV  2,3,0 	exchang the stack(context)
 52:   PUSH  1,0(3) 	push the caller fp
 53:   PUSH  0,0(3) 	push the return adress
 54:   PUSH  0,0(3) 	stack expand
 55:   PUSH  0,0(3) 	stack expand
* -> assign
* -> Const
 56:    LDC  0,1(0) 	load integer const
 57:   PUSH  0,0(6) 	store exp
* <- Const
 58:    POP  0,0(6) 	copy bytes
 59:     ST  0,-2(2) 	copy bytes 
* <- assign
* -> assign
* -> Const
 60:    LDC  0,2(0) 	load integer const
 61:   PUSH  0,0(6) 	store exp
* <- Const
 62:    POP  0,0(6) 	copy bytes
 63:     ST  0,-3(2) 	copy bytes 
* <- assign
 64:   PUSH  0,0(3) 	stack expand
* -> assign
* ->Single Op
 65:    LDA  0,-2,2 	LDA the var adress
 66:   PUSH  0,0(6) 	op: load left
 67:    POP  0,0(6) 	copy bytes
 68:     ST  0,-4(2) 	copy bytes 
* <- assign
 69:   PUSH  0,0(3) 	stack expand
* -> assign
* ->Single Op
 70:    LDA  0,-3,2 	LDA the var adress
 71:   PUSH  0,0(6) 	op: load left
 72:    POP  0,0(6) 	copy bytes
 73:     ST  0,-5(2) 	copy bytes 
* <- assign
* ->Single Op
 74:    LDA  0,-5,2 	LDA the var adress
 75:   PUSH  0,0(6) 	op: load left
 76:    POP  0,0(6) 	pop exp 
 77:   PUSH  0,0(3) 	push parameter into stack
* ->Single Op
 78:    LDA  0,-4,2 	LDA the var adress
 79:   PUSH  0,0(6) 	op: load left
 80:    POP  0,0(6) 	pop exp 
 81:   PUSH  0,0(3) 	push parameter into stack
 82:    LDA  0,1(7) 	store the return adress
 83:    LDC  7,8(0) 	ujp to the function body
 84:    LDA  3,2(3) 	pop parameters
 85:    MOV  3,2,0 	restore the caller sp
 86:     LD  2,0(2) 	resotre the caller fp
 87:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 49:    LDA  7,38(7) 	skip the function body
* call main function
 88:    LDC  0,90(0) 	store the return adress
 89:    LDC  7,50(0) 	ujp to the function body
 90:   HALT  0,0,0 	
