* ð­ºð­ºð­ºð­ºð­ºî««««««««þîþîþîþîþîþpyb_example.tm
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
 12:   PUSH  0,0(3) 	stack expand
 13:   PUSH  0,0(3) 	stack expand
* -> assign
* -> Const
 14:    LDC  0,1(0) 	load integer const
 15:   PUSH  0,0(6) 	store exp
* <- Const
 16:    POP  0,0(6) 	copy bytes
 17:     ST  0,-202(2) 	copy bytes 
* <- assign
* -> assign
* -> Const
 18:    LDC  0,1(0) 	load integer const
 19:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 20:    LDA  0,-201(2) 	load id value
 21:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 22:    LDC  0,0(0) 	load integer const
 23:   PUSH  0,0(6) 	store exp
* <- Const
 24:    POP  0,0(6) 	load index value to ac
 25:    LDC  1,10,0 	load array size
 26:    MUL  0,1,0 	compute the offset
 27:    POP  1,0(6) 	load lhs adress to ac1
 28:    ADD  0,0,1 	compute the real index adress a[index]
 29:   PUSH  0,0(6) 	
* -> Const
 30:    LDC  0,0(0) 	load integer const
 31:   PUSH  0,0(6) 	store exp
* <- Const
 32:    POP  0,0(6) 	load index value to ac
 33:    LDC  1,1,0 	load array size
 34:    MUL  0,1,0 	compute the offset
 35:    POP  1,0(6) 	load lhs adress to ac1
 36:    ADD  0,0,1 	compute the real index adress a[index]
 37:    POP  1,0(6) 	load exp value
 38:     ST  1,0(0) 	store value
* <- assign
* -> assign
* -> Const
 39:    LDC  0,1(0) 	load integer const
 40:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 41:    LDA  0,-201(2) 	load id value
 42:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 43:    LDC  0,0(0) 	load integer const
 44:   PUSH  0,0(6) 	store exp
* <- Const
 45:    POP  0,0(6) 	load index value to ac
 46:    LDC  1,10,0 	load array size
 47:    MUL  0,1,0 	compute the offset
 48:    POP  1,0(6) 	load lhs adress to ac1
 49:    ADD  0,0,1 	compute the real index adress a[index]
 50:   PUSH  0,0(6) 	
* -> Const
 51:    LDC  0,1(0) 	load integer const
 52:   PUSH  0,0(6) 	store exp
* <- Const
 53:    POP  0,0(6) 	load index value to ac
 54:    LDC  1,1,0 	load array size
 55:    MUL  0,1,0 	compute the offset
 56:    POP  1,0(6) 	load lhs adress to ac1
 57:    ADD  0,0,1 	compute the real index adress a[index]
 58:    POP  1,0(6) 	load exp value
 59:     ST  1,0(0) 	store value
* <- assign
* -> repeat
* repeat: jump after body comes back here
* -> Op
* -> Id
 60:     LD  0,-202(2) 	load id value
 61:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 62:    LDC  0,20(0) 	load integer const
 63:   PUSH  0,0(6) 	store exp
* <- Const
 64:    POP  1,0(6) 	pop right
 65:    POP  0,0(6) 	pop left
 66:    SUB  0,0,1 	op <
 67:    JLT  0,2(7) 	br if true
 68:    LDC  0,0(0) 	false case
 69:    LDA  7,1(7) 	unconditional jmp
 70:    LDC  0,1(0) 	true case
 71:   PUSH  0,0(6) 	op: load left
* <- Op
* -> assign
* -> Op
* ->index k
* ->index k
* -> Id
 73:    LDA  0,-201(2) 	load id value
 74:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 75:    LDC  0,0(0) 	load integer const
 76:   PUSH  0,0(6) 	store exp
* <- Const
 77:    POP  0,0(6) 	load index value to ac
 78:    LDC  1,10,0 	load array size
 79:    MUL  0,1,0 	compute the offset
 80:    POP  1,0(6) 	load lhs adress to ac1
 81:    ADD  0,0,1 	compute the real index adress a[index]
 82:   PUSH  0,0(6) 	
* -> Op
* -> Id
 83:     LD  0,-202(2) 	load id value
 84:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 85:    LDC  0,1(0) 	load integer const
 86:   PUSH  0,0(6) 	store exp
* <- Const
 87:    POP  1,0(6) 	pop right
 88:    POP  0,0(6) 	pop left
 89:    SUB  0,0,1 	op -
 90:   PUSH  0,0(6) 	op: load left
* <- Op
 91:    POP  0,0(6) 	load index value to ac
 92:    LDC  1,1,0 	load array size
 93:    MUL  0,1,0 	compute the offset
 94:    POP  1,0(6) 	load lhs adress to ac1
 95:    ADD  0,0,1 	compute the real index adress a[index]
 96:     LD  1,0(0) 	load value
 97:   PUSH  1,0(6) 	
* ->index k
* ->index k
* -> Id
 98:    LDA  0,-201(2) 	load id value
 99:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
100:    LDC  0,0(0) 	load integer const
101:   PUSH  0,0(6) 	store exp
* <- Const
102:    POP  0,0(6) 	load index value to ac
103:    LDC  1,10,0 	load array size
104:    MUL  0,1,0 	compute the offset
105:    POP  1,0(6) 	load lhs adress to ac1
106:    ADD  0,0,1 	compute the real index adress a[index]
107:   PUSH  0,0(6) 	
* -> Op
* -> Id
108:     LD  0,-202(2) 	load id value
109:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
110:    LDC  0,2(0) 	load integer const
111:   PUSH  0,0(6) 	store exp
* <- Const
112:    POP  1,0(6) 	pop right
113:    POP  0,0(6) 	pop left
114:    SUB  0,0,1 	op -
115:   PUSH  0,0(6) 	op: load left
* <- Op
116:    POP  0,0(6) 	load index value to ac
117:    LDC  1,1,0 	load array size
118:    MUL  0,1,0 	compute the offset
119:    POP  1,0(6) 	load lhs adress to ac1
120:    ADD  0,0,1 	compute the real index adress a[index]
121:     LD  1,0(0) 	load value
122:   PUSH  1,0(6) 	
123:    POP  1,0(6) 	pop right
124:    POP  0,0(6) 	pop left
125:    ADD  0,0,1 	op +
126:   PUSH  0,0(6) 	op: load left
* <- Op
* ->index k
* -> Id
127:    LDA  0,-201(2) 	load id value
128:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
129:    LDC  0,0(0) 	load integer const
130:   PUSH  0,0(6) 	store exp
* <- Const
131:    POP  0,0(6) 	load index value to ac
132:    LDC  1,10,0 	load array size
133:    MUL  0,1,0 	compute the offset
134:    POP  1,0(6) 	load lhs adress to ac1
135:    ADD  0,0,1 	compute the real index adress a[index]
136:   PUSH  0,0(6) 	
* -> Id
137:     LD  0,-202(2) 	load id value
138:   PUSH  0,0(6) 	store exp
* <- Id
139:    POP  0,0(6) 	load index value to ac
140:    LDC  1,1,0 	load array size
141:    MUL  0,1,0 	compute the offset
142:    POP  1,0(6) 	load lhs adress to ac1
143:    ADD  0,0,1 	compute the real index adress a[index]
144:    POP  1,0(6) 	load exp value
145:     ST  1,0(0) 	store value
* <- assign
* -> assign
* -> Op
* -> Id
146:     LD  0,-202(2) 	load id value
147:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
148:    LDC  0,1(0) 	load integer const
149:   PUSH  0,0(6) 	store exp
* <- Const
150:    POP  1,0(6) 	pop right
151:    POP  0,0(6) 	pop left
152:    ADD  0,0,1 	op +
153:   PUSH  0,0(6) 	op: load left
* <- Op
154:    POP  0,0(6) 	copy bytes
155:     ST  0,-202(2) 	copy bytes 
* <- assign
156:    LDA  7,-97(7) 	unconditional jmp
 72:    JEQ  0,84(7) 	repeat: jmp to the out of while
* <- repeat
* ->index k
* ->index k
* -> Id
157:    LDA  0,-201(2) 	load id value
158:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
159:    LDC  0,0(0) 	load integer const
160:   PUSH  0,0(6) 	store exp
* <- Const
161:    POP  0,0(6) 	load index value to ac
162:    LDC  1,10,0 	load array size
163:    MUL  0,1,0 	compute the offset
164:    POP  1,0(6) 	load lhs adress to ac1
165:    ADD  0,0,1 	compute the real index adress a[index]
166:   PUSH  0,0(6) 	
* -> Const
167:    LDC  0,6(0) 	load integer const
168:   PUSH  0,0(6) 	store exp
* <- Const
169:    POP  0,0(6) 	load index value to ac
170:    LDC  1,1,0 	load array size
171:    MUL  0,1,0 	compute the offset
172:    POP  1,0(6) 	load lhs adress to ac1
173:    ADD  0,0,1 	compute the real index adress a[index]
174:     LD  1,0(0) 	load value
175:   PUSH  1,0(6) 	
176:    POP  0,0(6) 	move result to register
177:    OUT  0,0,0 	output value in register[ac / fac]
* -> assign
* ->index k
* ->index k
* -> Id
178:    LDA  0,-201(2) 	load id value
179:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
180:    LDC  0,0(0) 	load integer const
181:   PUSH  0,0(6) 	store exp
* <- Const
182:    POP  0,0(6) 	load index value to ac
183:    LDC  1,10,0 	load array size
184:    MUL  0,1,0 	compute the offset
185:    POP  1,0(6) 	load lhs adress to ac1
186:    ADD  0,0,1 	compute the real index adress a[index]
187:   PUSH  0,0(6) 	
* -> Const
188:    LDC  0,15(0) 	load integer const
189:   PUSH  0,0(6) 	store exp
* <- Const
190:    POP  0,0(6) 	load index value to ac
191:    LDC  1,1,0 	load array size
192:    MUL  0,1,0 	compute the offset
193:    POP  1,0(6) 	load lhs adress to ac1
194:    ADD  0,0,1 	compute the real index adress a[index]
195:     LD  1,0(0) 	load value
196:   PUSH  1,0(6) 	
* ->index k
* -> Id
197:    LDA  0,-201(2) 	load id value
198:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
199:    LDC  0,1(0) 	load integer const
200:   PUSH  0,0(6) 	store exp
* <- Const
201:    POP  0,0(6) 	load index value to ac
202:    LDC  1,10,0 	load array size
203:    MUL  0,1,0 	compute the offset
204:    POP  1,0(6) 	load lhs adress to ac1
205:    ADD  0,0,1 	compute the real index adress a[index]
206:   PUSH  0,0(6) 	
* -> Const
207:    LDC  0,2(0) 	load integer const
208:   PUSH  0,0(6) 	store exp
* <- Const
209:    POP  0,0(6) 	load index value to ac
210:    LDC  1,1,0 	load array size
211:    MUL  0,1,0 	compute the offset
212:    POP  1,0(6) 	load lhs adress to ac1
213:    ADD  0,0,1 	compute the real index adress a[index]
214:    POP  1,0(6) 	load exp value
215:     ST  1,0(0) 	store value
* <- assign
* ->index k
* ->index k
* -> Id
216:    LDA  0,-201(2) 	load id value
217:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
218:    LDC  0,10(0) 	load integer const
219:   PUSH  0,0(6) 	store exp
* <- Const
220:    POP  0,0(6) 	load index value to ac
221:    LDC  1,10,0 	load array size
222:    MUL  0,1,0 	compute the offset
223:    POP  1,0(6) 	load lhs adress to ac1
224:    ADD  0,0,1 	compute the real index adress a[index]
225:   PUSH  0,0(6) 	
* -> Const
226:    LDC  0,2(0) 	load integer const
227:   PUSH  0,0(6) 	store exp
* <- Const
228:    POP  0,0(6) 	load index value to ac
229:    LDC  1,1,0 	load array size
230:    MUL  0,1,0 	compute the offset
231:    POP  1,0(6) 	load lhs adress to ac1
232:    ADD  0,0,1 	compute the real index adress a[index]
233:     LD  1,0(0) 	load value
234:   PUSH  1,0(6) 	
235:    POP  0,0(6) 	move result to register
236:    OUT  0,0,0 	output value in register[ac / fac]
237:    MOV  3,2,0 	restore the caller sp
238:     LD  2,0(2) 	resotre the caller fp
239:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,232(7) 	skip the function body
* call main function
240:    LDC  0,242(0) 	store the return adress
241:    LDC  7,8(0) 	ujp to the function body
242:   HALT  0,0,0 	
