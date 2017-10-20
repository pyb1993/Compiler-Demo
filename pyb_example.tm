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
 51:    LDA  3,1(3) 	pop parameters
* -> Op
* -> Id
 52:     LD  0,1(2) 	load id value
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
 60:    POP  0,0(6) 	pop exp 
 61:   PUSH  0,0(3) 	push parameter into stack
 62:    LDA  0,1(7) 	store the return adress
 63:    LDC  7,13(0) 	ujp to the function body
 64:    LDA  3,1(3) 	pop parameters
 65:    POP  10,0(6) 	pop right
 66:    POP  9,0(6) 	pop left
 67:    ADD  9,9,10 	op +
 68:   PUSH  9,0(6) 	op: load left
* <- Op
 69:    POP  9,0(6) 	op: POP left
 70:   PUSH  9,0(6) 	op: push left
 71:    MOV  3,2,0 	restore the caller sp
 72:     LD  2,0(2) 	resotre the caller fp
 73:  RETURN  0,-1,3 	return to the caller
 38:    LDA  7,35(7) 	jmp to end
* <- if
 74:    MOV  3,2,0 	restore the caller sp
 75:     LD  2,0(2) 	resotre the caller fp
 76:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,64(7) 	skip the function body
* function entry
 78:    MOV  1,2,0 	store the caller fp temporarily
 79:    MOV  2,3,0 	exchang the stack(context)
 80:   PUSH  1,0(3) 	push the caller fp
 81:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Op
* -> Id
 82:     LD  0,1(2) 	load id value
 83:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
 84:     LD  0,2(2) 	load id value
 85:   PUSH  0,0(6) 	store exp
* <- Id
 86:    POP  1,0(6) 	pop right
 87:    POP  0,0(6) 	pop left
 88:    MUL  0,0,1 	op *
 89:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
 90:     LD  9,3(2) 	load id value
 91:   PUSH  9,0(6) 	store exp
* <- Id
 92:    POP  10,0(6) 	pop right
 93:    POP  0,0(6) 	pop left
 94:    MOV  9,0,0 	convert type
 95:    MUL  9,9,10 	op *
 96:   PUSH  9,0(6) 	op: load left
* <- Op
 97:    POP  9,0(6) 	op: POP left
 98:   PUSH  9,0(6) 	op: push left
 99:    MOV  3,2,0 	restore the caller sp
100:     LD  2,0(2) 	resotre the caller fp
101:  RETURN  0,-1,3 	return to the caller
102:    MOV  3,2,0 	restore the caller sp
103:     LD  2,0(2) 	resotre the caller fp
104:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 77:    LDA  7,27(7) 	skip the function body
* function entry
106:    MOV  1,2,0 	store the caller fp temporarily
107:    MOV  2,3,0 	exchang the stack(context)
108:   PUSH  1,0(3) 	push the caller fp
109:   PUSH  0,0(3) 	push the return adress
* -> Const
110:    LDC  0,1(0) 	load integer const
111:   PUSH  0,0(6) 	store exp
* <- Const
112:    POP  0,0(6) 	pop exp 
113:    MOV  9,0,0 	
114:   PUSH  9,0(3) 	push parameter into stack
* -> Const
115:    LDC  0,1(0) 	load integer const
116:   PUSH  0,0(6) 	store exp
* <- Const
117:    POP  0,0(6) 	pop exp 
118:   PUSH  0,0(3) 	push parameter into stack
* -> Const
119:    LDC  9,0.400000(0)
 120:   PUSH  9,0(6) 	store exp
* <- Const
121:    POP  9,0(6) 	pop exp 
122:   PUSH  9,0(3) 	push parameter into stack
* -> Const
123:    LDC  0,4(0) 	load integer const
124:   PUSH  0,0(6) 	store exp
* <- Const
125:    POP  0,0(6) 	pop exp 
126:   PUSH  0,0(3) 	push parameter into stack
127:    LDA  0,1(7) 	store the return adress
128:    LDC  7,13(0) 	ujp to the function body
129:    LDA  3,1(3) 	pop parameters
130:    POP  9,0(6) 	pop exp 
131:    MOV  0,9,0 	
132:   PUSH  0,0(3) 	push parameter into stack
* -> Const
133:    LDC  0,4(0) 	load integer const
134:   PUSH  0,0(6) 	store exp
* <- Const
135:    POP  0,0(6) 	pop exp 
136:   PUSH  0,0(3) 	push parameter into stack
137:    LDA  0,1(7) 	store the return adress
138:    LDC  7,78(0) 	ujp to the function body
139:    LDA  3,3(3) 	pop parameters
140:    POP  9,0(6) 	pop exp 
141:    MOV  0,9,0 	
142:   PUSH  0,0(3) 	push parameter into stack
143:    LDA  0,1(7) 	store the return adress
144:    LDC  7,78(0) 	ujp to the function body
145:    LDA  3,3(3) 	pop parameters
146:    POP  9,0(6) 	pop exp 
147:    MOV  0,9,0 	
148:   PUSH  0,0(3) 	push parameter into stack
149:    LDA  0,1(7) 	store the return adress
150:    LDC  7,13(0) 	ujp to the function body
151:    LDA  3,1(3) 	pop parameters
152:    POP  9,0(6) 	move result to register
153:    OUT  9,0,0 	output value in register[ac / fac]
154:    MOV  3,2,0 	restore the caller sp
155:     LD  2,0(2) 	resotre the caller fp
156:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
105:    LDA  7,51(7) 	skip the function body
* call main function
157:    LDC  0,159(0) 	store the return adress
158:    LDC  7,106(0) 	ujp to the function body
159:   HALT  0,0,0 	
