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
  7:    LDC  9,10.000000(0)
   8:   PUSH  9,0(6) 	store exp
* <- Const
  9:    POP  9,0(6) 	copy bytes
 10:     ST  9,0(5) 	copy bytes 
* <- assign
* function entry
 12:    MOV  1,2,0 	store the caller fp temporarily
 13:    MOV  2,3,0 	exchang the stack(context)
 14:   PUSH  1,0(3) 	push the caller fp
 15:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
 16:     LD  0,1(2) 	load id value
 17:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 18:    LDC  0,2(0) 	load integer const
 19:   PUSH  0,0(6) 	store exp
* <- Const
 20:    POP  1,0(6) 	pop right
 21:    POP  0,0(6) 	pop left
 22:    SUB  0,0,1 	op <
 23:    JLE  0,2(7) 	br if true
 24:    LDC  0,0(0) 	false case
 25:    LDA  7,1(7) 	unconditional jmp
 26:    LDC  0,1(0) 	true case
 27:   PUSH  0,0(6) 	op: load left
* <- Op
* if: jump to else belongs here
* -> Const
 29:    LDC  0,1(0) 	load integer const
 30:   PUSH  0,0(6) 	store exp
* <- Const
 31:    POP  0,0(6) 	op: POP left
 32:    MOV  9,0,0 	move register reg(s) tp reg(r)
 33:   PUSH  9,0(6) 	op: push left
 34:    MOV  3,2,0 	restore the caller sp
 35:     LD  2,0(2) 	resotre the caller fp
 36:  RETURN  0,-1,3 	return to the caller
* if: jump to end belongs here
 28:    POP  0,0(6) 	pop the condition value
 29:    JEQ  0,8(7) 	if: jmp to else
* -> Op
* -> Op
* -> Id
 38:     LD  0,1(2) 	load id value
 39:    MOV  9,0,0 	move from one reg(s) to reg(r)
 40:   PUSH  9,0(6) 	store exp
* <- Id
* -> Const
 41:    LDC  9,1.000000(0)
  42:   PUSH  9,0(6) 	store exp
* <- Const
 43:    POP  10,0(6) 	pop right
 44:    POP  9,0(6) 	pop left
 45:    SUB  9,9,10 	op -
 46:   PUSH  9,0(6) 	op: load left
* <- Op
 47:    POP  9,0(6) 	pop exp 
 48:    MOV  0,9,0 	
 49:   PUSH  0,0(3) 	push parameter into stack
 50:    LDA  0,1(7) 	store the return adress
 51:    LDC  7,12(0) 	ujp to the function body
 52:    LDA  3,1(3) 	pop parameters
* -> Op
* -> Id
 53:     LD  0,1(2) 	load id value
 54:    MOV  9,0,0 	move from one reg(s) to reg(r)
 55:   PUSH  9,0(6) 	store exp
* <- Id
* -> Const
 56:    LDC  9,2.000000(0)
  57:   PUSH  9,0(6) 	store exp
* <- Const
 58:    POP  10,0(6) 	pop right
 59:    POP  9,0(6) 	pop left
 60:    SUB  9,9,10 	op -
 61:   PUSH  9,0(6) 	op: load left
* <- Op
 62:    POP  9,0(6) 	pop exp 
 63:    MOV  0,9,0 	
 64:   PUSH  0,0(3) 	push parameter into stack
 65:    LDA  0,1(7) 	store the return adress
 66:    LDC  7,12(0) 	ujp to the function body
 67:    LDA  3,1(3) 	pop parameters
 68:    POP  10,0(6) 	pop right
 69:    POP  9,0(6) 	pop left
 70:    ADD  9,9,10 	op +
 71:   PUSH  9,0(6) 	op: load left
* <- Op
 72:    POP  9,0(6) 	op: POP left
 73:   PUSH  9,0(6) 	op: push left
 74:    MOV  3,2,0 	restore the caller sp
 75:     LD  2,0(2) 	resotre the caller fp
 76:  RETURN  0,-1,3 	return to the caller
 37:    LDA  7,39(7) 	jmp to end
* <- if
 77:    MOV  3,2,0 	restore the caller sp
 78:     LD  2,0(2) 	resotre the caller fp
 79:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 11:    LDA  7,68(7) 	skip the function body
* function entry
 81:    MOV  1,2,0 	store the caller fp temporarily
 82:    MOV  2,3,0 	exchang the stack(context)
 83:   PUSH  1,0(3) 	push the caller fp
 84:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Op
* -> Id
 85:     LD  0,1(2) 	load id value
 86:    MOV  9,0,0 	move from one reg(s) to reg(r)
 87:   PUSH  9,0(6) 	store exp
* <- Id
* -> Id
 88:     LD  0,2(2) 	load id value
 89:    MOV  9,0,0 	move from one reg(s) to reg(r)
 90:   PUSH  9,0(6) 	store exp
* <- Id
 91:    POP  10,0(6) 	pop right
 92:    POP  9,0(6) 	pop left
 93:    MUL  9,9,10 	op *
 94:   PUSH  9,0(6) 	op: load left
* <- Op
* -> Id
 95:     LD  9,3(2) 	load id value
 96:   PUSH  9,0(6) 	store exp
* <- Id
 97:    POP  10,0(6) 	pop right
 98:    POP  9,0(6) 	pop left
 99:    MUL  9,9,10 	op *
100:   PUSH  9,0(6) 	op: load left
* <- Op
101:    POP  9,0(6) 	op: POP left
102:   PUSH  9,0(6) 	op: push left
103:    MOV  3,2,0 	restore the caller sp
104:     LD  2,0(2) 	resotre the caller fp
105:  RETURN  0,-1,3 	return to the caller
106:    MOV  3,2,0 	restore the caller sp
107:     LD  2,0(2) 	resotre the caller fp
108:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 80:    LDA  7,28(7) 	skip the function body
* function entry
110:    MOV  1,2,0 	store the caller fp temporarily
111:    MOV  2,3,0 	exchang the stack(context)
112:   PUSH  1,0(3) 	push the caller fp
113:   PUSH  0,0(3) 	push the return adress
* -> Const
114:    LDC  0,1(0) 	load integer const
115:   PUSH  0,0(6) 	store exp
* <- Const
116:    POP  0,0(6) 	pop exp 
117:    MOV  9,0,0 	
118:   PUSH  9,0(3) 	push parameter into stack
* -> Const
119:    LDC  0,1(0) 	load integer const
120:   PUSH  0,0(6) 	store exp
* <- Const
121:    POP  0,0(6) 	pop exp 
122:   PUSH  0,0(3) 	push parameter into stack
* -> Const
123:    LDC  9,0.400000(0)
 124:   PUSH  9,0(6) 	store exp
* <- Const
125:    POP  9,0(6) 	pop exp 
126:   PUSH  9,0(3) 	push parameter into stack
* -> Const
127:    LDC  9,4.000000(0)
 128:   PUSH  9,0(6) 	store exp
* <- Const
129:    POP  9,0(6) 	pop exp 
130:    MOV  0,9,0 	
131:   PUSH  0,0(3) 	push parameter into stack
132:    LDA  0,1(7) 	store the return adress
133:    LDC  7,12(0) 	ujp to the function body
134:    LDA  3,1(3) 	pop parameters
135:    POP  9,0(6) 	pop exp 
136:    MOV  0,9,0 	
137:   PUSH  0,0(3) 	push parameter into stack
* -> Const
138:    LDC  9,4.000000(0)
 139:   PUSH  9,0(6) 	store exp
* <- Const
140:    POP  9,0(6) 	pop exp 
141:    MOV  0,9,0 	
142:   PUSH  0,0(3) 	push parameter into stack
143:    LDA  0,1(7) 	store the return adress
144:    LDC  7,81(0) 	ujp to the function body
145:    LDA  3,3(3) 	pop parameters
146:    POP  9,0(6) 	pop exp 
147:    MOV  0,9,0 	
148:   PUSH  0,0(3) 	push parameter into stack
149:    LDA  0,1(7) 	store the return adress
150:    LDC  7,81(0) 	ujp to the function body
151:    LDA  3,3(3) 	pop parameters
152:    POP  9,0(6) 	pop exp 
153:    MOV  0,9,0 	
154:   PUSH  0,0(3) 	push parameter into stack
155:    LDA  0,1(7) 	store the return adress
156:    LDC  7,12(0) 	ujp to the function body
157:    LDA  3,1(3) 	pop parameters
158:    POP  9,0(6) 	move result to register
159:    OUT  9,0,0 	output value in register[ac / fac]
160:    MOV  3,2,0 	restore the caller sp
161:     LD  2,0(2) 	resotre the caller fp
162:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
109:    LDA  7,53(7) 	skip the function body
* call main function
163:    LDC  0,165(0) 	store the return adress
164:    LDC  7,110(0) 	ujp to the function body
165:   HALT  0,0,0 	
