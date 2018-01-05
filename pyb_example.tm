* File: pyb_example.tm
* Standard prelude:
  0:    LDC  6,65535(0) 	load mp adress
  1:     ST  0,0(0) 	clear location 0
  2:    LDC  5,4095(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:    LDC  2,60000(0) 	load first fp from location 2
  5:    LDC  3,60000(0) 	load first sp from location 2
  6:     ST  0,2(0) 	clear location 2
* End of standard prelude.
  7:    LDA  3,-1(3) 	stack expand
  8:    MOV  3,2,0 	resotre stack in struct
* function entry:
* g
  9:    LDC  0,12(0) 	get function adress
 10:     ST  0,0(5) 	set function adress
 12:    MOV  1,2,0 	store the caller fp temporarily
 13:    MOV  2,3,0 	exchang the stack(context)
 14:   PUSH  1,0(3) 	push the caller fp
 15:   PUSH  0,0(3) 	push the return adress
* -> Const
 16:    LDC  0,10086(0) 	load integer const
 17:   PUSH  0,0(6) 	store exp
* <- Const
 18:    MOV  3,2,0 	restore the caller sp
 19:     LD  2,0(2) 	resotre the caller fp
 20:  RETURN  0,-1,3 	return to the caller
 21:    MOV  3,2,0 	restore the caller sp
 22:     LD  2,0(2) 	resotre the caller fp
 23:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 11:    LDA  7,12(7) 	skip the function body
* function entry:
* malloc
 24:    LDC  0,27(0) 	get function adress
 25:     ST  0,-1(5) 	set function adress
 27:    MOV  1,2,0 	store the caller fp temporarily
 28:    MOV  2,3,0 	exchang the stack(context)
 29:   PUSH  1,0(3) 	push the caller fp
 30:   PUSH  0,0(3) 	push the return adress
* -> Id
 31:     LD  0,1(2) 	load id value
 32:   PUSH  0,0(6) 	store exp
* <- Id
 33:    POP  0,0(6) 	get malloc parameters
 34:  MALLOC  0,0(0) 	system call for malloc
 35:    MOV  3,2,0 	restore the caller sp
 36:     LD  2,0(2) 	resotre the caller fp
 37:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 26:    LDA  7,11(7) 	skip the function body
* function entry:
* free
 38:    LDC  0,41(0) 	get function adress
 39:     ST  0,-2(5) 	set function adress
 41:    MOV  1,2,0 	store the caller fp temporarily
 42:    MOV  2,3,0 	exchang the stack(context)
 43:   PUSH  1,0(3) 	push the caller fp
 44:   PUSH  0,0(3) 	push the return adress
* -> Id
 45:     LD  0,1(2) 	load id value
 46:   PUSH  0,0(6) 	store exp
* <- Id
 47:    POP  0,0(6) 	get free parameters
 48:  FREE  0,0(0) 	system call for free
 49:    MOV  3,2,0 	restore the caller sp
 50:     LD  2,0(2) 	resotre the caller fp
 51:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 40:    LDA  7,11(7) 	skip the function body
* call main function
* File: pyb_example.tm
* Standard prelude:
 52:    LDC  6,65535(0) 	load mp adress
 53:     ST  0,0(0) 	clear location 0
 54:    LDC  5,4095(0) 	load gp adress from location 1
 55:     ST  0,1(0) 	clear location 1
 56:    LDC  2,60000(0) 	load first fp from location 2
 57:    LDC  3,60000(0) 	load first sp from location 2
 58:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* s
 59:    LDC  0,62(0) 	get function adress
 60:     ST  0,-3(5) 	set function adress
 62:    MOV  1,2,0 	store the caller fp temporarily
 63:    MOV  2,3,0 	exchang the stack(context)
 64:   PUSH  1,0(3) 	push the caller fp
 65:   PUSH  0,0(3) 	push the return adress
* -> Const
 66:    LDC  0,1002(0) 	load integer const
 67:   PUSH  0,0(6) 	store exp
* <- Const
 68:    POP  0,0(6) 	move result to register
 69:    OUT  0,0,0 	output value in register[ac / fac]
 70:    MOV  3,2,0 	restore the caller sp
 71:     LD  2,0(2) 	resotre the caller fp
 72:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 61:    LDA  7,11(7) 	skip the function body
* function entry:
* main
 73:    LDC  0,76(0) 	get function adress
 74:     ST  0,-4(5) 	set function adress
 76:    MOV  1,2,0 	store the caller fp temporarily
 77:    MOV  2,3,0 	exchang the stack(context)
 78:   PUSH  1,0(3) 	push the caller fp
 79:   PUSH  0,0(3) 	push the return adress
 80:    LDA  3,-1(3) 	stack expand
* -> Const
 81:    LDC  0,98(0) 	load char const
 82:   PUSH  0,0(6) 	store exp
* <- Const
 83:    LDA  1,-2(2) 	move the adress of ID
 84:    POP  0,0(6) 	copy bytes
 85:     ST  0,0(1) 	copy bytes
 86:    LDA  3,-1(3) 	stack expand
* -> Const
 87:    LDC  0,98(0) 	load char const
 88:   PUSH  0,0(6) 	store exp
* <- Const
 89:    LDA  1,-3(2) 	move the adress of ID
 90:    POP  0,0(6) 	copy bytes
 91:     ST  0,0(1) 	copy bytes
* -> Op
* -> Id
 92:     LD  0,-2(2) 	load id value
 93:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 94:     LD  0,-3(2) 	load id value
 95:   PUSH  0,0(6) 	store exp
* <- Id
 96:    POP  1,0(6) 	pop right
 97:    POP  0,0(6) 	pop left
 98:    SUB  0,0,1 	op <
 99:    JLT  0,2(7) 	br if true
100:    LDC  0,0(0) 	false case
101:    LDA  7,1(7) 	unconditional jmp
102:    LDC  0,1(0) 	true case
103:   PUSH  0,0(6) 	op: load left
* <- Op
104:    POP  0,0(6) 	move result to register
105:    OUT  0,0,0 	output value in register[ac / fac]
106:    MOV  3,2,0 	restore the caller sp
107:     LD  2,0(2) 	resotre the caller fp
108:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 75:    LDA  7,33(7) 	skip the function body
* function entry:
* f
109:    LDC  0,112(0) 	get function adress
110:     ST  0,-5(5) 	set function adress
112:    MOV  1,2,0 	store the caller fp temporarily
113:    MOV  2,3,0 	exchang the stack(context)
114:   PUSH  1,0(3) 	push the caller fp
115:   PUSH  0,0(3) 	push the return adress
116:    MOV  3,2,0 	restore the caller sp
117:     LD  2,0(2) 	resotre the caller fp
118:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
111:    LDA  7,7(7) 	skip the function body
* call main function
119:     LD  1,-4(5) 	get main function adress
120:    LDC  0,122(0) 	store the return adress
121:    LDA  7,0(1) 	ujp to the function body
122:   HALT  0,0,0 	
