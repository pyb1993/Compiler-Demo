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
* -> if
* -> Op
* -> Id
 17:     LD  0,1(2) 	load id value
 18:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 19:    LDC  0,2(0) 	load integer const
 20:   PUSH  0,0(6) 	store exp
* <- Const
 21:    POP  1,0(6) 	pop right
 22:    POP  0,0(6) 	pop left
 23:    SUB  0,0,1 	op <
 24:    JLE  0,2(7) 	br if true
 25:    LDC  0,0(0) 	false case
 26:    LDA  7,1(7) 	unconditional jmp
 27:    LDC  0,1(0) 	true case
 28:   PUSH  0,0(6) 	op: load left
* <- Op
* if: jump to else belongs here
* -> Const
 30:    LDC  0,1(0) 	load integer const
 31:   PUSH  0,0(6) 	store exp
* <- Const
 32:    POP  0,0(6) 	op: POP left
 33:    MOV  9,0,0 	move register reg(s) tp reg(r)
 34:   PUSH  9,0(6) 	op: push left
 35:    MOV  3,2,0 	restore the caller sp
 36:     LD  2,0(2) 	resotre the caller fp
 37:  RETURN  0,-1,3 	return to the caller
* if: jump to end belongs here
 29:    POP  0,0(6) 	pop the condition value
 30:    JEQ  0,8(7) 	if: jmp to else
* -> Op
* -> Op
* -> Id
 39:     LD  0,1(2) 	load id value
 40:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 41:    LDC  0,1(0) 	load integer const
 42:   PUSH  0,0(6) 	store exp
* <- Const
 43:    POP  1,0(6) 	pop right
 44:    POP  0,0(6) 	pop left
 45:    SUB  0,0,1 	op -
 46:   PUSH  0,0(6) 	op: load left
* <- Op
 47:    POP  0,0(6) 	pop exp 
 48:   PUSH  0,0(3) 	push parameter into stack
 49:    LDA  0,1(7) 	store the return adress
 50:    LDC  7,13(0) 	ujp to the function body
* -> Op
* -> Id
 51:     LD  0,1(2) 	load id value
 52:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 53:    LDC  0,2(0) 	load integer const
 54:   PUSH  0,0(6) 	store exp
* <- Const
 55:    POP  1,0(6) 	pop right
 56:    POP  0,0(6) 	pop left
 57:    SUB  0,0,1 	op -
 58:   PUSH  0,0(6) 	op: load left
* <- Op
 59:    POP  0,0(6) 	pop exp 
 60:   PUSH  0,0(3) 	push parameter into stack
 61:    LDA  0,1(7) 	store the return adress
 62:    LDC  7,13(0) 	ujp to the function body
 63:    POP  10,0(6) 	pop right
 64:    POP  9,0(6) 	pop left
 65:    ADD  9,9,10 	op +
 66:   PUSH  9,0(6) 	op: load left
* <- Op
 67:    POP  9,0(6) 	op: POP left
 68:   PUSH  9,0(6) 	op: push left
 69:    MOV  3,2,0 	restore the caller sp
 70:     LD  2,0(2) 	resotre the caller fp
 71:  RETURN  0,-1,3 	return to the caller
 38:    LDA  7,33(7) 	jmp to end
* <- if
 72:    MOV  3,2,0 	restore the caller sp
 73:     LD  2,0(2) 	resotre the caller fp
 74:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,62(7) 	skip the function body
* function entry
 76:    MOV  1,2,0 	store the caller fp temporarily
 77:    MOV  2,3,0 	exchang the stack(context)
 78:   PUSH  1,0(3) 	push the caller fp
 79:   PUSH  0,0(3) 	push the return adress
* -> Id
 80:     LD  0,1(2) 	load id value
 81:   PUSH  0,0(6) 	store exp
* <- Id
 82:    POP  0,0(6) 	move result to register
 83:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
 84:     LD  0,2(2) 	load id value
 85:   PUSH  0,0(6) 	store exp
* <- Id
 86:    POP  0,0(6) 	move result to register
 87:    OUT  0,0,0 	output value in register[ac / fac]
* -> Op
* -> Id
 88:     LD  0,1(2) 	load id value
 89:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 90:     LD  0,2(2) 	load id value
 91:   PUSH  0,0(6) 	store exp
* <- Id
 92:    POP  1,0(6) 	pop right
 93:    POP  0,0(6) 	pop left
 94:    MUL  0,0,1 	op *
 95:   PUSH  0,0(6) 	op: load left
* <- Op
 96:    POP  0,0(6) 	op: POP left
 97:   PUSH  0,0(6) 	op: push left
 98:    MOV  3,2,0 	restore the caller sp
 99:     LD  2,0(2) 	resotre the caller fp
100:  RETURN  0,-1,3 	return to the caller
101:    MOV  3,2,0 	restore the caller sp
102:     LD  2,0(2) 	resotre the caller fp
103:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 75:    LDA  7,28(7) 	skip the function body
* function entry
105:    MOV  1,2,0 	store the caller fp temporarily
106:    MOV  2,3,0 	exchang the stack(context)
107:   PUSH  1,0(3) 	push the caller fp
108:   PUSH  0,0(3) 	push the return adress
* -> Const
109:    LDC  0,2(0) 	load integer const
110:   PUSH  0,0(6) 	store exp
* <- Const
111:    POP  0,0(6) 	pop exp 
112:   PUSH  0,0(3) 	push parameter into stack
* -> Const
113:    LDC  0,3(0) 	load integer const
114:   PUSH  0,0(6) 	store exp
* <- Const
115:    POP  0,0(6) 	pop exp 
116:   PUSH  0,0(3) 	push parameter into stack
117:    LDA  0,1(7) 	store the return adress
118:    LDC  7,13(0) 	ujp to the function body
119:    POP  9,0(6) 	pop exp 
120:    MOV  0,9,0 	
121:   PUSH  0,0(3) 	push parameter into stack
122:    LDA  0,1(7) 	store the return adress
123:    LDC  7,76(0) 	ujp to the function body
124:    POP  0,0(6) 	move result to register
125:    OUT  0,0,0 	output value in register[ac / fac]
126:    MOV  3,2,0 	restore the caller sp
127:     LD  2,0(2) 	resotre the caller fp
128:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
104:    LDA  7,24(7) 	skip the function body
* call main function
129:    LDC  0,131(0) 	store the return adress
130:    LDC  7,105(0) 	ujp to the function body
131:   HALT  0,0,0 	
