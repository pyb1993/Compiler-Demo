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
 40:    MOV  9,0,0 	move from one reg(s) to reg(r)
 41:   PUSH  9,0(6) 	store exp
* <- Id
* -> Const
 42:    LDC  9,1.000000(0)
  43:   PUSH  9,0(6) 	store exp
* <- Const
 44:    POP  10,0(6) 	pop right
 45:    POP  9,0(6) 	pop left
 46:    SUB  9,9,10 	op -
 47:   PUSH  9,0(6) 	op: load left
* <- Op
 48:    POP  9,0(6) 	pop exp 
 49:    MOV  0,9,0 	
 50:   PUSH  0,0(3) 	push parameter into stack
 51:    LDA  0,1(7) 	store the return adress
 52:    LDC  7,13(0) 	ujp to the function body
 53:    LDA  3,1(3) 	pop parameters
* -> Op
* -> Id
 54:     LD  0,1(2) 	load id value
 55:    MOV  9,0,0 	move from one reg(s) to reg(r)
 56:   PUSH  9,0(6) 	store exp
* <- Id
* -> Const
 57:    LDC  9,2.000000(0)
  58:   PUSH  9,0(6) 	store exp
* <- Const
 59:    POP  10,0(6) 	pop right
 60:    POP  9,0(6) 	pop left
 61:    SUB  9,9,10 	op -
 62:   PUSH  9,0(6) 	op: load left
* <- Op
 63:    POP  9,0(6) 	pop exp 
 64:    MOV  0,9,0 	
 65:   PUSH  0,0(3) 	push parameter into stack
 66:    LDA  0,1(7) 	store the return adress
 67:    LDC  7,13(0) 	ujp to the function body
 68:    LDA  3,1(3) 	pop parameters
 69:    POP  10,0(6) 	pop right
 70:    POP  9,0(6) 	pop left
 71:    ADD  9,9,10 	op +
 72:   PUSH  9,0(6) 	op: load left
* <- Op
 73:    POP  9,0(6) 	op: POP left
 74:   PUSH  9,0(6) 	op: push left
 75:    MOV  3,2,0 	restore the caller sp
 76:     LD  2,0(2) 	resotre the caller fp
 77:  RETURN  0,-1,3 	return to the caller
 38:    LDA  7,39(7) 	jmp to end
* <- if
 78:    MOV  3,2,0 	restore the caller sp
 79:     LD  2,0(2) 	resotre the caller fp
 80:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,68(7) 	skip the function body
* function entry
 82:    MOV  1,2,0 	store the caller fp temporarily
 83:    MOV  2,3,0 	exchang the stack(context)
 84:   PUSH  1,0(3) 	push the caller fp
 85:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Op
* -> Id
 86:     LD  0,1(2) 	load id value
 87:    MOV  9,0,0 	move from one reg(s) to reg(r)
 88:   PUSH  9,0(6) 	store exp
* <- Id
* -> Id
 89:     LD  0,2(2) 	load id value
 90:    MOV  9,0,0 	move from one reg(s) to reg(r)
 91:   PUSH  9,0(6) 	store exp
* <- Id
 92:    POP  10,0(6) 	pop right
 93:    POP  9,0(6) 	pop left
 94:    MUL  9,9,10 	op *
 95:   PUSH  9,0(6) 	op: load left
* <- Op
* -> Id
 96:     LD  9,3(2) 	load id value
 97:   PUSH  9,0(6) 	store exp
* <- Id
 98:    POP  10,0(6) 	pop right
 99:    POP  9,0(6) 	pop left
100:    MUL  9,9,10 	op *
101:   PUSH  9,0(6) 	op: load left
* <- Op
102:    POP  9,0(6) 	op: POP left
103:   PUSH  9,0(6) 	op: push left
104:    MOV  3,2,0 	restore the caller sp
105:     LD  2,0(2) 	resotre the caller fp
106:  RETURN  0,-1,3 	return to the caller
107:    MOV  3,2,0 	restore the caller sp
108:     LD  2,0(2) 	resotre the caller fp
109:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 81:    LDA  7,28(7) 	skip the function body
* function entry
111:    MOV  1,2,0 	store the caller fp temporarily
112:    MOV  2,3,0 	exchang the stack(context)
113:   PUSH  1,0(3) 	push the caller fp
114:   PUSH  0,0(3) 	push the return adress
* -> Const
115:    LDC  0,1(0) 	load integer const
116:   PUSH  0,0(6) 	store exp
* <- Const
117:    POP  0,0(6) 	pop exp 
118:    MOV  9,0,0 	
119:   PUSH  9,0(3) 	push parameter into stack
* -> Const
120:    LDC  0,1(0) 	load integer const
121:   PUSH  0,0(6) 	store exp
* <- Const
122:    POP  0,0(6) 	pop exp 
123:   PUSH  0,0(3) 	push parameter into stack
* -> Const
124:    LDC  9,0.400000(0)
 125:   PUSH  9,0(6) 	store exp
* <- Const
126:    POP  9,0(6) 	pop exp 
127:   PUSH  9,0(3) 	push parameter into stack
* -> Const
128:    LDC  9,4.000000(0)
 129:   PUSH  9,0(6) 	store exp
* <- Const
130:    POP  9,0(6) 	pop exp 
131:    MOV  0,9,0 	
132:   PUSH  0,0(3) 	push parameter into stack
133:    LDA  0,1(7) 	store the return adress
134:    LDC  7,13(0) 	ujp to the function body
135:    LDA  3,1(3) 	pop parameters
136:    POP  9,0(6) 	pop exp 
137:    MOV  0,9,0 	
138:   PUSH  0,0(3) 	push parameter into stack
* -> Const
139:    LDC  9,4.000000(0)
 140:   PUSH  9,0(6) 	store exp
* <- Const
141:    POP  9,0(6) 	pop exp 
142:    MOV  0,9,0 	
143:   PUSH  0,0(3) 	push parameter into stack
144:    LDA  0,1(7) 	store the return adress
145:    LDC  7,82(0) 	ujp to the function body
146:    LDA  3,3(3) 	pop parameters
147:    POP  9,0(6) 	pop exp 
148:    MOV  0,9,0 	
149:   PUSH  0,0(3) 	push parameter into stack
150:    LDA  0,1(7) 	store the return adress
151:    LDC  7,82(0) 	ujp to the function body
152:    LDA  3,3(3) 	pop parameters
153:    POP  9,0(6) 	pop exp 
154:    MOV  0,9,0 	
155:   PUSH  0,0(3) 	push parameter into stack
156:    LDA  0,1(7) 	store the return adress
157:    LDC  7,13(0) 	ujp to the function body
158:    LDA  3,1(3) 	pop parameters
159:    POP  9,0(6) 	move result to register
160:    OUT  9,0,0 	output value in register[ac / fac]
* -> Op
* -> Const
161:    LDC  9,8.000000(0)
 162:   PUSH  9,0(6) 	store exp
* <- Const
163:    POP  9,0(6) 	pop exp 
164:    MOV  0,9,0 	
165:   PUSH  0,0(3) 	push parameter into stack
166:    LDA  0,1(7) 	store the return adress
167:    LDC  7,13(0) 	ujp to the function body
168:    LDA  3,1(3) 	pop parameters
* -> Const
169:    LDC  0,6(0) 	load integer const
170:   PUSH  0,0(6) 	store exp
* <- Const
171:    POP  0,0(6) 	pop exp 
172:    MOV  9,0,0 	
173:   PUSH  9,0(3) 	push parameter into stack
* -> Const
174:    LDC  0,2(0) 	load integer const
175:   PUSH  0,0(6) 	store exp
* <- Const
176:    POP  0,0(6) 	pop exp 
177:   PUSH  0,0(3) 	push parameter into stack
* -> Const
178:    LDC  9,1.000000(0)
 179:   PUSH  9,0(6) 	store exp
* <- Const
180:    POP  9,0(6) 	pop exp 
181:    MOV  0,9,0 	
182:   PUSH  0,0(3) 	push parameter into stack
183:    LDA  0,1(7) 	store the return adress
184:    LDC  7,82(0) 	ujp to the function body
185:    LDA  3,3(3) 	pop parameters
186:    POP  10,0(6) 	pop right
187:    POP  9,0(6) 	pop left
188:    ADD  9,9,10 	op +
189:   PUSH  9,0(6) 	op: load left
* <- Op
190:    POP  9,0(6) 	move result to register
191:    OUT  9,0,0 	output value in register[ac / fac]
192:    MOV  3,2,0 	restore the caller sp
193:     LD  2,0(2) 	resotre the caller fp
194:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
110:    LDA  7,84(7) 	skip the function body
* call main function
195:    LDC  0,197(0) 	store the return adress
196:    LDC  7,111(0) 	ujp to the function body
197:   HALT  0,0,0 	
