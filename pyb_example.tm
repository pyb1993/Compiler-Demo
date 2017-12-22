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
  7:    LDA  3,-1(3) 	stack expand
* function entry:
* f
  9:    MOV  1,2,0 	store the caller fp temporarily
 10:    MOV  2,3,0 	exchang the stack(context)
 11:   PUSH  1,0(3) 	push the caller fp
 12:   PUSH  0,0(3) 	push the return adress
 13:    MOV  3,2,0 	restore the caller sp
 14:     LD  2,0(2) 	resotre the caller fp
 15:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  8:    LDA  7,7(7) 	skip the function body
* function entry:
* f
 16:    LDC  0,19(0) 	get function adress
 17:     ST  0,0(5) 	set function adress
 19:    MOV  1,2,0 	store the caller fp temporarily
 20:    MOV  2,3,0 	exchang the stack(context)
 21:   PUSH  1,0(3) 	push the caller fp
 22:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Const
 23:    LDC  0,100(0) 	load integer const
 24:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 25:    LDC  0,100(0) 	load integer const
 26:   PUSH  0,0(6) 	store exp
* <- Const
 27:    POP  1,0(6) 	pop right
 28:    POP  0,0(6) 	pop left
 29:    MUL  0,0,1 	op *
 30:   PUSH  0,0(6) 	op: load left
* <- Op
 31:    MOV  3,2,0 	restore the caller sp
 32:     LD  2,0(2) 	resotre the caller fp
 33:  RETURN  0,-1,3 	return to the caller
 34:    MOV  3,2,0 	restore the caller sp
 35:     LD  2,0(2) 	resotre the caller fp
 36:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 18:    LDA  7,18(7) 	skip the function body
* function entry:
* g
 37:    LDC  0,40(0) 	get function adress
 38:     ST  0,-1(5) 	set function adress
 40:    MOV  1,2,0 	store the caller fp temporarily
 41:    MOV  2,3,0 	exchang the stack(context)
 42:   PUSH  1,0(3) 	push the caller fp
 43:   PUSH  0,0(3) 	push the return adress
* -> Const
 44:    LDC  0,200(0) 	load integer const
 45:   PUSH  0,0(6) 	store exp
* <- Const
 46:    MOV  3,2,0 	restore the caller sp
 47:     LD  2,0(2) 	resotre the caller fp
 48:  RETURN  0,-1,3 	return to the caller
 49:    MOV  3,2,0 	restore the caller sp
 50:     LD  2,0(2) 	resotre the caller fp
 51:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 39:    LDA  7,12(7) 	skip the function body
* function entry:
* main
 52:    LDC  0,55(0) 	get function adress
 53:     ST  0,-2(5) 	set function adress
 55:    MOV  1,2,0 	store the caller fp temporarily
 56:    MOV  2,3,0 	exchang the stack(context)
 57:   PUSH  1,0(3) 	push the caller fp
 58:   PUSH  0,0(3) 	push the return adress
 59:    LDA  3,-2(3) 	stack expand
* -> assign
* -> Id
 60:     LD  0,-1(5) 	load id value
 61:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 62:    LDA  0,-4(2) 	load id adress
 63:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 64:    POP  1,0,6 	load adress of lhs struct
 65:    LDC  0,1,0 	load offset of member
 66:    ADD  0,0,1 	compute the real adress if pointK
 67:   PUSH  0,0(6) 	
 68:    POP  1,0(6) 	move the adress of referenced
 69:    POP  0,0(6) 	copy bytes
 70:     ST  0,0(1) 	copy bytes
* <- assign
* call function: 
* f
* -> Id
 71:    LDA  0,-4(2) 	load id adress
 72:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 73:    POP  1,0,6 	load adress of lhs struct
 74:    LDC  0,1,0 	load offset of member
 75:    ADD  0,0,1 	compute the real adress if pointK
 76:   PUSH  0,0(6) 	
 77:    POP  0,0(6) 	load adress from mp
 78:     LD  1,0(0) 	copy bytes
 79:   PUSH  1,0(6) 	push a.x value into tmp
 80:    LDC  0,82(0) 	store the return adress
 81:    POP  7,0(6) 	ujp to the function body
 82:    LDA  3,0(3) 	pop parameters
 83:    POP  0,0(6) 	move result to register
 84:    OUT  0,0,0 	output value in register[ac / fac]
 85:    MOV  3,2,0 	restore the caller sp
 86:     LD  2,0(2) 	resotre the caller fp
 87:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 54:    LDA  7,33(7) 	skip the function body
* call main function
 88:     LD  1,-2(5) 	get main function adress
 89:    LDC  0,91(0) 	store the return adress
 90:    LDA  7,0(1) 	ujp to the function body
 91:   HALT  0,0,0 	
