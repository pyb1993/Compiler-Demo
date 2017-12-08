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
 12:    LDA  3,-5(3) 	stack expand
* -> assign
* -> Id
 13:     LD  0,1(2) 	load id value
 14:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 15:    LDA  0,-6(2) 	load id adress
 16:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 17:    POP  1,0,6 	load adress of lhs struct
 18:    LDC  0,3,0 	load offset of member
 19:    ADD  0,0,1 	compute the real adress if pointK
 20:   PUSH  0,0(6) 	
 21:    POP  1,0(6) 	move the adress of referenced
 22:    POP  0,0(6) 	copy bytes
 23:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Const
 24:    LDC  0,111(0) 	load integer const
 25:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 26:    LDA  0,-6(2) 	load id adress
 27:   PUSH  0,0(6) 	push array adress to mp
* <- Id
 28:    POP  1,0,6 	load adress of lhs struct
 29:    LDC  0,0,0 	load offset of member
 30:    ADD  0,0,1 	compute the real adress if pointK
 31:   PUSH  0,0(6) 	
* -> Const
 32:    LDC  0,2(0) 	load integer const
 33:   PUSH  0,0(6) 	store exp
* <- Const
 34:    POP  0,0(6) 	load index value to ac
 35:    LDC  1,1,0 	load array size
 36:    MUL  0,1,0 	compute the offset
 37:    POP  1,0(6) 	load lhs adress to ac1
 38:    ADD  0,0,1 	compute the real index adress a[index]
 39:   PUSH  0,0(6) 	push the adress mode into mp
 40:    POP  1,0(6) 	move the adress of referenced
 41:    POP  0,0(6) 	copy bytes
 42:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
 43:     LD  0,-6(2) 	load id value
 44:   PUSH  0,0(6) 	store exp
 45:     LD  0,-5(2) 	load id value
 46:   PUSH  0,0(6) 	store exp
 47:     LD  0,-4(2) 	load id value
 48:   PUSH  0,0(6) 	store exp
 49:     LD  0,-3(2) 	load id value
 50:   PUSH  0,0(6) 	store exp
 51:     LD  0,-2(2) 	load id value
 52:   PUSH  0,0(6) 	store exp
* <- Id
 53:    MOV  3,2,0 	restore the caller sp
 54:     LD  2,0(2) 	resotre the caller fp
 55:  RETURN  0,-1,3 	return to the caller
 56:    MOV  3,2,0 	restore the caller sp
 57:     LD  2,0(2) 	resotre the caller fp
 58:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,51(7) 	skip the function body
* function entry
 60:    MOV  1,2,0 	store the caller fp temporarily
 61:    MOV  2,3,0 	exchang the stack(context)
 62:   PUSH  1,0(3) 	push the caller fp
 63:   PUSH  0,0(3) 	push the return adress
* -> Const
 64:    LDC  9,2.300000(0)
  65:   PUSH  9,0(6) 	store exp
* <- Const
 66:    POP  9,0(6) 	op: POP left
 67:    MOV  0,9,0 	move register reg(s) tp reg(r)
 68:   PUSH  0,0(6) 	op: push left
 69:    MOV  3,2,0 	restore the caller sp
 70:     LD  2,0(2) 	resotre the caller fp
 71:  RETURN  0,-1,3 	return to the caller
 72:    MOV  3,2,0 	restore the caller sp
 73:     LD  2,0(2) 	resotre the caller fp
 74:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 59:    LDA  7,15(7) 	skip the function body
* function entry
 76:    MOV  1,2,0 	store the caller fp temporarily
 77:    MOV  2,3,0 	exchang the stack(context)
 78:   PUSH  1,0(3) 	push the caller fp
 79:   PUSH  0,0(3) 	push the return adress
 80:    LDA  0,1(7) 	store the return adress
 81:    LDC  7,60(0) 	ujp to the function body
 82:    LDA  3,0(3) 	pop parameters
 83:    POP  0,0(6) 	move result to register
 84:    OUT  0,0,0 	output value in register[ac / fac]
 85:    LDA  3,-5(3) 	stack expand
* -> Const
 86:    LDC  0,22(0) 	load integer const
 87:   PUSH  0,0(6) 	store exp
* <- Const
 88:    POP  0,0(6) 	copy bytes
 89:   PUSH  0,0(3) 	PUSH bytes
 90:    LDA  0,1(7) 	store the return adress
 91:    LDC  7,8(0) 	ujp to the function body
 92:    LDA  3,1(3) 	pop parameters
 93:    LDA  1,-6(2) 	move the adress of ID
 94:    POP  0,0(6) 	copy bytes
 95:     ST  0,4(1) 	copy bytes
 96:    POP  0,0(6) 	copy bytes
 97:     ST  0,3(1) 	copy bytes
 98:    POP  0,0(6) 	copy bytes
 99:     ST  0,2(1) 	copy bytes
100:    POP  0,0(6) 	copy bytes
101:     ST  0,1(1) 	copy bytes
102:    POP  0,0(6) 	copy bytes
103:     ST  0,0(1) 	copy bytes
* -> Id
104:    LDA  0,-6(2) 	load id adress
105:   PUSH  0,0(6) 	push array adress to mp
* <- Id
106:    POP  1,0,6 	load adress of lhs struct
107:    LDC  0,3,0 	load offset of member
108:    ADD  0,0,1 	compute the real adress if pointK
109:   PUSH  0,0(6) 	
110:    POP  0,0(6) 	load adress from mp
111:     LD  1,0(0) 	copy bytes
112:   PUSH  1,0(6) 	push a.x value into tmp
113:    POP  0,0(6) 	move result to register
114:    OUT  0,0,0 	output value in register[ac / fac]
* ->index k
* -> Id
115:    LDA  0,-6(2) 	load id adress
116:   PUSH  0,0(6) 	push array adress to mp
* <- Id
117:    POP  1,0,6 	load adress of lhs struct
118:    LDC  0,0,0 	load offset of member
119:    ADD  0,0,1 	compute the real adress if pointK
120:   PUSH  0,0(6) 	
* -> Const
121:    LDC  0,2(0) 	load integer const
122:   PUSH  0,0(6) 	store exp
* <- Const
123:    POP  0,0(6) 	load index value to ac
124:    LDC  1,1,0 	load array size
125:    MUL  0,1,0 	compute the offset
126:    POP  1,0(6) 	load lhs adress to ac1
127:    ADD  0,0,1 	compute the real index adress a[index]
128:     LD  1,0(0) 	load bytes
129:   PUSH  1,0(6) 	push bytes 
130:    POP  0,0(6) 	move result to register
131:    OUT  0,0,0 	output value in register[ac / fac]
132:    MOV  3,2,0 	restore the caller sp
133:     LD  2,0(2) 	resotre the caller fp
134:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 75:    LDA  7,59(7) 	skip the function body
* call main function
135:    LDC  0,137(0) 	store the return adress
136:    LDC  7,76(0) 	ujp to the function body
137:   HALT  0,0,0 	
