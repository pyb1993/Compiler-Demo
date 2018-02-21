* File: pyb_example.tm
* Standard prelude:
  0:    LDC  6,65535(0) 	load mp adress
  1:     ST  0,0(0) 	clear location 0
  2:    LDC  5,4095(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:    LDC  4,2000(0) 	load gp adress from location 1
  5:    LDC  2,60000(0) 	load first fp from location 2
  6:    LDC  3,60000(0) 	load first sp from location 2
  7:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* malloc
  8:    LDA  3,-1(3) 	stack expand for function variable
  9:    LDC  0,12(0) 	get function adress
 10:     ST  0,0(5) 	set function adress
 11:     GO  0,0,0 	go to label
 12:    MOV  1,2,0 	store the caller fp temporarily
 13:    MOV  2,3,0 	exchang the stack(context)
 14:   PUSH  1,0(3) 	push the caller fp
 15:   PUSH  0,0(3) 	push the return adress
* -> Id
 16:     LD  0,1(2) 	load id value
 17:   PUSH  0,0(6) 	store exp
* <- Id
 18:    POP  0,0(6) 	get malloc parameters
 19:  MALLOC  0,0(0) 	system call for malloc
 20:    MOV  3,2,0 	restore the caller sp
 21:     LD  2,0(2) 	resotre the caller fp
 22:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 23:  LABEL  0,0,0 	generate label
* function entry:
* free
 24:    LDA  3,-1(3) 	stack expand for function variable
 25:    LDC  0,28(0) 	get function adress
 26:     ST  0,-1(5) 	set function adress
 27:     GO  1,0,0 	go to label
 28:    MOV  1,2,0 	store the caller fp temporarily
 29:    MOV  2,3,0 	exchang the stack(context)
 30:   PUSH  1,0(3) 	push the caller fp
 31:   PUSH  0,0(3) 	push the return adress
* -> Id
 32:     LD  0,1(2) 	load id value
 33:   PUSH  0,0(6) 	store exp
* <- Id
 34:    POP  0,0(6) 	get free parameters
 35:  FREE  0,0(0) 	system call for free
 36:    MOV  3,2,0 	restore the caller sp
 37:     LD  2,0(2) 	resotre the caller fp
 38:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 39:  LABEL  1,0,0 	generate label
* call main function
* File: pyb_example.tm
* Standard prelude:
 40:    LDC  6,65535(0) 	load mp adress
 41:     ST  0,0(0) 	clear location 0
 42:    LDC  5,4095(0) 	load gp adress from location 1
 43:     ST  0,1(0) 	clear location 1
 44:    LDC  4,2000(0) 	load gp adress from location 1
 45:    LDC  2,60000(0) 	load first fp from location 2
 46:    LDC  3,60000(0) 	load first sp from location 2
 47:     ST  0,2(0) 	clear location 2
* End of standard prelude.
 48:    LDA  3,-1(3) 	stack expand
* -> Const
 49:    LDC  0,0(0) 	load integer const
 50:   PUSH  0,0(6) 	store exp
* <- Const
 51:    LDA  1,-2(5) 	move the adress of ID
 52:    POP  0,0(6) 	copy bytes
 53:     ST  0,0(1) 	copy bytes
 54:    LDA  3,-1(3) 	stack expand
 55:    LDA  3,-1(3) 	stack expand
 56:    LDA  3,-1(3) 	stack expand
 57:    LDA  3,-1(3) 	stack expand
 58:    LDA  3,-1(3) 	stack expand
 59:    LDA  3,-1(3) 	stack expand
* function entry:
* dup
 60:    LDA  3,-1(3) 	stack expand for function variable
 61:     GO  2,0,0 	go to label
 62:    MOV  1,2,0 	store the caller fp temporarily
 63:    MOV  2,3,0 	exchang the stack(context)
 64:   PUSH  1,0(3) 	push the caller fp
 65:   PUSH  0,0(3) 	push the return adress
 66:    MOV  3,2,0 	restore the caller sp
 67:     LD  2,0(2) 	resotre the caller fp
 68:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 69:  LABEL  2,0,0 	generate label
* function entry:
* freeList
 70:    LDA  3,-1(3) 	stack expand for function variable
 71:     GO  3,0,0 	go to label
 72:    MOV  1,2,0 	store the caller fp temporarily
 73:    MOV  2,3,0 	exchang the stack(context)
 74:   PUSH  1,0(3) 	push the caller fp
 75:   PUSH  0,0(3) 	push the return adress
 76:    MOV  3,2,0 	restore the caller sp
 77:     LD  2,0(2) 	resotre the caller fp
 78:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 79:  LABEL  3,0,0 	generate label
* function entry:
* match
 80:    LDA  3,-1(3) 	stack expand for function variable
 81:     GO  4,0,0 	go to label
 82:    MOV  1,2,0 	store the caller fp temporarily
 83:    MOV  2,3,0 	exchang the stack(context)
 84:   PUSH  1,0(3) 	push the caller fp
 85:   PUSH  0,0(3) 	push the return adress
 86:    MOV  3,2,0 	restore the caller sp
 87:     LD  2,0(2) 	resotre the caller fp
 88:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 89:  LABEL  4,0,0 	generate label
* function entry:
* self__removeList
 90:    LDA  3,-1(3) 	stack expand for function variable
 91:     GO  5,0,0 	go to label
 92:    MOV  1,2,0 	store the caller fp temporarily
 93:    MOV  2,3,0 	exchang the stack(context)
 94:   PUSH  1,0(3) 	push the caller fp
 95:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
 96:     LD  0,1(2) 	load id value
 97:   PUSH  0,0(6) 	store exp
* <- Id
 98:    POP  1,0,6 	load adress of lhs struct
 99:    LDC  0,2,0 	load offset of member
100:    ADD  0,0,1 	compute the real adress if pointK
101:   PUSH  0,0(6) 	
102:    POP  0,0(6) 	load adress from mp
103:     LD  1,0(0) 	copy bytes
104:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
105:    LDC  0,0(0) 	load integer const
106:   PUSH  0,0(6) 	store exp
* <- Const
107:    POP  1,0(6) 	pop right
108:    POP  0,0(6) 	pop left
109:    SUB  0,0,1 	op <
110:    JLE  0,2(7) 	br if true
111:    LDC  0,0(0) 	false case
112:    LDA  7,1(7) 	unconditional jmp
113:    LDC  0,1(0) 	true case
114:   PUSH  0,0(6) 	
* <- Op
115:    POP  0,0(6) 	pop from the mp
116:    JNE  0,1,7 	true case:, execute if part
117:     GO  6,0,0 	go to label
118:    MOV  3,2,0 	restore the caller sp
119:     LD  2,0(2) 	resotre the caller fp
120:  RETURN  0,-1,3 	return to the caller
121:     GO  7,0,0 	go to label
122:  LABEL  6,0,0 	generate label
* if: jump to else
123:  LABEL  7,0,0 	generate label
* <- if
* ->Single Op
* -> Id
124:     LD  0,1(2) 	load id value
125:   PUSH  0,0(6) 	store exp
* <- Id
126:    POP  1,0,6 	load adress of lhs struct
127:    LDC  0,2,0 	load offset of member
128:    ADD  0,0,1 	compute the real adress if pointK
129:   PUSH  0,0(6) 	
130:    POP  0,0(6) 	load adress from mp
131:     LD  1,0(0) 	copy bytes
132:   PUSH  1,0(6) 	push a.x value into tmp
133:    POP  0,0(6) 	pop right
* -> Op
* -> Id
134:     LD  0,1(2) 	load id value
135:   PUSH  0,0(6) 	store exp
* <- Id
136:    POP  1,0,6 	load adress of lhs struct
137:    LDC  0,2,0 	load offset of member
138:    ADD  0,0,1 	compute the real adress if pointK
139:   PUSH  0,0(6) 	
140:    POP  0,0(6) 	load adress from mp
141:     LD  1,0(0) 	copy bytes
142:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
143:    LDC  0,1(0) 	load integer const
144:   PUSH  0,0(6) 	store exp
* <- Const
145:    POP  1,0(6) 	pop right
146:    POP  0,0(6) 	pop left
147:    SUB  0,0,1 	op -
148:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
149:     LD  0,1(2) 	load id value
150:   PUSH  0,0(6) 	store exp
* <- Id
151:    POP  1,0,6 	load adress of lhs struct
152:    LDC  0,2,0 	load offset of member
153:    ADD  0,0,1 	compute the real adress if pointK
154:   PUSH  0,0(6) 	
155:    POP  1,0(6) 	move the adress of referenced
156:    POP  0,0(6) 	copy bytes
157:     ST  0,0(1) 	copy bytes
* <-Single Op
158:    LDA  3,-1(3) 	stack expand
* -> Id
159:     LD  0,1(2) 	load id value
160:   PUSH  0,0(6) 	store exp
* <- Id
161:    POP  1,0,6 	load adress of lhs struct
162:    LDC  0,0,0 	load offset of member
163:    ADD  0,0,1 	compute the real adress if pointK
164:   PUSH  0,0(6) 	
165:    POP  0,0(6) 	load adress from mp
166:     LD  1,0(0) 	copy bytes
167:   PUSH  1,0(6) 	push a.x value into tmp
168:    POP  1,0,6 	load adress of lhs struct
169:    LDC  0,1,0 	load offset of member
170:    ADD  0,0,1 	compute the real adress if pointK
171:   PUSH  0,0(6) 	
172:    POP  0,0(6) 	load adress from mp
173:     LD  1,0(0) 	copy bytes
174:   PUSH  1,0(6) 	push a.x value into tmp
175:    LDA  1,-2(2) 	move the adress of ID
176:    POP  0,0(6) 	copy bytes
177:     ST  0,0(1) 	copy bytes
* -> repeat
* while stmt:
178:  LABEL  8,0,0 	generate label
* -> Op
* -> Op
* -> Id
179:     LD  0,-2(2) 	load id value
180:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
181:     LD  0,-2(5) 	load id value
182:   PUSH  0,0(6) 	store exp
* <- Id
183:    POP  1,0(6) 	pop right
184:    POP  0,0(6) 	pop left
185:    SUB  0,0,1 	op ==, convertd_type
186:    JNE  0,2(7) 	br if true
187:    LDC  0,0(0) 	false case
188:    LDA  7,1(7) 	unconditional jmp
189:    LDC  0,1(0) 	true case
190:   PUSH  0,0(6) 	
* <- Op
* -> Op
* push function parameters
* -> Id
191:     LD  0,2(2) 	load id value
192:   PUSH  0,0(6) 	store exp
* <- Id
193:    POP  0,0(6) 	copy bytes
194:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
* -> Id
195:     LD  0,-2(2) 	load id value
196:   PUSH  0,0(6) 	store exp
* <- Id
197:    POP  1,0,6 	load adress of lhs struct
198:    LDC  0,2,0 	load offset of member
199:    ADD  0,0,1 	compute the real adress if pointK
200:   PUSH  0,0(6) 	
201:    POP  0,0(6) 	load adress from mp
202:     LD  1,0(0) 	copy bytes
203:   PUSH  1,0(6) 	push a.x value into tmp
204:    POP  0,0(6) 	copy bytes
205:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* match
* -> Id
206:     LD  0,1(2) 	load id value
207:   PUSH  0,0(6) 	store exp
* <- Id
208:    POP  1,0,6 	load adress of lhs struct
209:    LDC  0,5,0 	load offset of member
210:    ADD  0,0,1 	compute the real adress if pointK
211:   PUSH  0,0(6) 	
212:    POP  0,0(6) 	load adress from mp
213:     LD  1,0(0) 	copy bytes
214:   PUSH  1,0(6) 	push a.x value into tmp
215:    LDC  0,217(0) 	store the return adress
216:    POP  7,0(6) 	ujp to the function body
217:    LDA  3,2(3) 	pop parameters
* -> Const
218:    LDC  0,0(0) 	load integer const
219:   PUSH  0,0(6) 	store exp
* <- Const
220:    POP  1,0(6) 	pop right
221:    POP  0,0(6) 	pop left
222:    SUB  0,0,1 	op ==, convertd_type
223:    JNE  0,2(7) 	br if true
224:    LDC  0,0(0) 	false case
225:    LDA  7,1(7) 	unconditional jmp
226:    LDC  0,1(0) 	true case
227:   PUSH  0,0(6) 	
* <- Op
228:    POP  1,0(6) 	pop right
229:    POP  0,0(6) 	pop left
230:    JEQ  0,3(7) 	br if false
231:    JEQ  1,2(7) 	br if false
232:    LDC  0,1(0) 	true case
233:    LDA  7,1(7) 	unconditional jmp
234:    LDC  0,0(0) 	false case
235:   PUSH  0,0(6) 	
* <- Op
236:    POP  0,0(6) 	pop from the mp
237:    JNE  0,1,7 	true case:, skip the break, execute the block code
238:     GO  9,0,0 	go to label
* -> assign
* -> Id
239:     LD  0,-2(2) 	load id value
240:   PUSH  0,0(6) 	store exp
* <- Id
241:    POP  1,0,6 	load adress of lhs struct
242:    LDC  0,1,0 	load offset of member
243:    ADD  0,0,1 	compute the real adress if pointK
244:   PUSH  0,0(6) 	
245:    POP  0,0(6) 	load adress from mp
246:     LD  1,0(0) 	copy bytes
247:   PUSH  1,0(6) 	push a.x value into tmp
248:    LDA  1,-2(2) 	move the adress of ID
249:    POP  0,0(6) 	copy bytes
250:     ST  0,0(1) 	copy bytes
* <- assign
251:     GO  8,0,0 	go to label
252:  LABEL  9,0,0 	generate label
* <- repeat
* -> if
* -> Op
* -> Id
253:     LD  0,-2(2) 	load id value
254:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
255:     LD  0,-2(5) 	load id value
256:   PUSH  0,0(6) 	store exp
* <- Id
257:    POP  1,0(6) 	pop right
258:    POP  0,0(6) 	pop left
259:    SUB  0,0,1 	op ==, convertd_type
260:    JEQ  0,2(7) 	br if true
261:    LDC  0,0(0) 	false case
262:    LDA  7,1(7) 	unconditional jmp
263:    LDC  0,1(0) 	true case
264:   PUSH  0,0(6) 	
* <- Op
265:    POP  0,0(6) 	pop from the mp
266:    JNE  0,1,7 	true case:, execute if part
267:     GO  10,0,0 	go to label
268:    MOV  3,2,0 	restore the caller sp
269:     LD  2,0(2) 	resotre the caller fp
270:  RETURN  0,-1,3 	return to the caller
271:     GO  11,0,0 	go to label
272:  LABEL  10,0,0 	generate label
* if: jump to else
273:  LABEL  11,0,0 	generate label
* <- if
274:    LDA  3,-1(3) 	stack expand
* -> Id
275:     LD  0,-2(2) 	load id value
276:   PUSH  0,0(6) 	store exp
* <- Id
277:    POP  1,0,6 	load adress of lhs struct
278:    LDC  0,0,0 	load offset of member
279:    ADD  0,0,1 	compute the real adress if pointK
280:   PUSH  0,0(6) 	
281:    POP  0,0(6) 	load adress from mp
282:     LD  1,0(0) 	copy bytes
283:   PUSH  1,0(6) 	push a.x value into tmp
284:    LDA  1,-3(2) 	move the adress of ID
285:    POP  0,0(6) 	copy bytes
286:     ST  0,0(1) 	copy bytes
287:    LDA  3,-1(3) 	stack expand
* -> Id
288:     LD  0,-2(2) 	load id value
289:   PUSH  0,0(6) 	store exp
* <- Id
290:    POP  1,0,6 	load adress of lhs struct
291:    LDC  0,1,0 	load offset of member
292:    ADD  0,0,1 	compute the real adress if pointK
293:   PUSH  0,0(6) 	
294:    POP  0,0(6) 	load adress from mp
295:     LD  1,0(0) 	copy bytes
296:   PUSH  1,0(6) 	push a.x value into tmp
297:    LDA  1,-4(2) 	move the adress of ID
298:    POP  0,0(6) 	copy bytes
299:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
300:     LD  0,-4(2) 	load id value
301:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
302:     LD  0,-3(2) 	load id value
303:   PUSH  0,0(6) 	store exp
* <- Id
304:    POP  1,0,6 	load adress of lhs struct
305:    LDC  0,1,0 	load offset of member
306:    ADD  0,0,1 	compute the real adress if pointK
307:   PUSH  0,0(6) 	
308:    POP  1,0(6) 	move the adress of referenced
309:    POP  0,0(6) 	copy bytes
310:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
311:     LD  0,-4(2) 	load id value
312:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
313:     LD  0,-2(5) 	load id value
314:   PUSH  0,0(6) 	store exp
* <- Id
315:    POP  1,0(6) 	pop right
316:    POP  0,0(6) 	pop left
317:    SUB  0,0,1 	op ==, convertd_type
318:    JNE  0,2(7) 	br if true
319:    LDC  0,0(0) 	false case
320:    LDA  7,1(7) 	unconditional jmp
321:    LDC  0,1(0) 	true case
322:   PUSH  0,0(6) 	
* <- Op
323:    POP  0,0(6) 	pop from the mp
324:    JNE  0,1,7 	true case:, execute if part
325:     GO  12,0,0 	go to label
* -> assign
* -> Id
326:     LD  0,-3(2) 	load id value
327:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
328:     LD  0,-4(2) 	load id value
329:   PUSH  0,0(6) 	store exp
* <- Id
330:    POP  1,0,6 	load adress of lhs struct
331:    LDC  0,0,0 	load offset of member
332:    ADD  0,0,1 	compute the real adress if pointK
333:   PUSH  0,0(6) 	
334:    POP  1,0(6) 	move the adress of referenced
335:    POP  0,0(6) 	copy bytes
336:     ST  0,0(1) 	copy bytes
* <- assign
337:     GO  13,0,0 	go to label
338:  LABEL  12,0,0 	generate label
* if: jump to else
339:  LABEL  13,0,0 	generate label
* <- if
* -> if
* -> Op
* -> Id
340:     LD  0,-2(2) 	load id value
341:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
342:     LD  0,1(2) 	load id value
343:   PUSH  0,0(6) 	store exp
* <- Id
344:    POP  1,0,6 	load adress of lhs struct
345:    LDC  0,1,0 	load offset of member
346:    ADD  0,0,1 	compute the real adress if pointK
347:   PUSH  0,0(6) 	
348:    POP  0,0(6) 	load adress from mp
349:     LD  1,0(0) 	copy bytes
350:   PUSH  1,0(6) 	push a.x value into tmp
351:    POP  1,0(6) 	pop right
352:    POP  0,0(6) 	pop left
353:    SUB  0,0,1 	op ==, convertd_type
354:    JEQ  0,2(7) 	br if true
355:    LDC  0,0(0) 	false case
356:    LDA  7,1(7) 	unconditional jmp
357:    LDC  0,1(0) 	true case
358:   PUSH  0,0(6) 	
* <- Op
359:    POP  0,0(6) 	pop from the mp
360:    JNE  0,1,7 	true case:, execute if part
361:     GO  14,0,0 	go to label
* -> assign
* -> Id
362:     LD  0,-3(2) 	load id value
363:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
364:     LD  0,1(2) 	load id value
365:   PUSH  0,0(6) 	store exp
* <- Id
366:    POP  1,0,6 	load adress of lhs struct
367:    LDC  0,1,0 	load offset of member
368:    ADD  0,0,1 	compute the real adress if pointK
369:   PUSH  0,0(6) 	
370:    POP  1,0(6) 	move the adress of referenced
371:    POP  0,0(6) 	copy bytes
372:     ST  0,0(1) 	copy bytes
* <- assign
373:     GO  15,0,0 	go to label
374:  LABEL  14,0,0 	generate label
* if: jump to else
375:  LABEL  15,0,0 	generate label
* <- if
* push function parameters
* -> Id
376:     LD  0,-2(2) 	load id value
377:   PUSH  0,0(6) 	store exp
* <- Id
378:    POP  0,0(6) 	copy bytes
379:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* free
* -> Id
380:     LD  0,-1(5) 	load id value
381:   PUSH  0,0(6) 	store exp
* <- Id
382:    LDC  0,384(0) 	store the return adress
383:    POP  7,0(6) 	ujp to the function body
384:    LDA  3,1(3) 	pop parameters
385:    MOV  3,2,0 	restore the caller sp
386:     LD  2,0(2) 	resotre the caller fp
387:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
388:  LABEL  5,0,0 	generate label
* function entry:
* createListNode
389:    LDA  3,-1(3) 	stack expand for function variable
390:    LDC  0,393(0) 	get function adress
391:     ST  0,-3(5) 	set function adress
392:     GO  16,0,0 	go to label
393:    MOV  1,2,0 	store the caller fp temporarily
394:    MOV  2,3,0 	exchang the stack(context)
395:   PUSH  1,0(3) 	push the caller fp
396:   PUSH  0,0(3) 	push the return adress
397:    LDA  3,-1(3) 	stack expand
* push function parameters
* ->Single Op
398:    LDC  0,3,0 	load size of exp
399:   PUSH  0,0(6) 	
* <-Single Op
400:    POP  0,0(6) 	copy bytes
401:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* malloc
* -> Id
402:     LD  0,0(5) 	load id value
403:   PUSH  0,0(6) 	store exp
* <- Id
404:    LDC  0,406(0) 	store the return adress
405:    POP  7,0(6) 	ujp to the function body
406:    LDA  3,1(3) 	pop parameters
407:    LDA  1,-2(2) 	move the adress of ID
408:    POP  0,0(6) 	copy bytes
409:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
410:     LD  0,-2(5) 	load id value
411:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
412:     LD  0,-2(2) 	load id value
413:   PUSH  0,0(6) 	store exp
* <- Id
414:    POP  1,0,6 	load adress of lhs struct
415:    LDC  0,0,0 	load offset of member
416:    ADD  0,0,1 	compute the real adress if pointK
417:   PUSH  0,0(6) 	
418:    POP  1,0(6) 	move the adress of referenced
419:    POP  0,0(6) 	copy bytes
420:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
421:     LD  0,-2(5) 	load id value
422:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
423:     LD  0,-2(2) 	load id value
424:   PUSH  0,0(6) 	store exp
* <- Id
425:    POP  1,0,6 	load adress of lhs struct
426:    LDC  0,1,0 	load offset of member
427:    ADD  0,0,1 	compute the real adress if pointK
428:   PUSH  0,0(6) 	
429:    POP  1,0(6) 	move the adress of referenced
430:    POP  0,0(6) 	copy bytes
431:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
432:     LD  0,-2(5) 	load id value
433:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
434:     LD  0,-2(2) 	load id value
435:   PUSH  0,0(6) 	store exp
* <- Id
436:    POP  1,0,6 	load adress of lhs struct
437:    LDC  0,2,0 	load offset of member
438:    ADD  0,0,1 	compute the real adress if pointK
439:   PUSH  0,0(6) 	
440:    POP  1,0(6) 	move the adress of referenced
441:    POP  0,0(6) 	copy bytes
442:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
443:     LD  0,-2(2) 	load id value
444:   PUSH  0,0(6) 	store exp
* <- Id
445:    MOV  3,2,0 	restore the caller sp
446:     LD  2,0(2) 	resotre the caller fp
447:  RETURN  0,-1,3 	return to the caller
448:    MOV  3,2,0 	restore the caller sp
449:     LD  2,0(2) 	resotre the caller fp
450:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
451:  LABEL  16,0,0 	generate label
* function entry:
* createList
452:    LDA  3,-1(3) 	stack expand for function variable
453:    LDC  0,456(0) 	get function adress
454:     ST  0,-4(5) 	set function adress
455:     GO  17,0,0 	go to label
456:    MOV  1,2,0 	store the caller fp temporarily
457:    MOV  2,3,0 	exchang the stack(context)
458:   PUSH  1,0(3) 	push the caller fp
459:   PUSH  0,0(3) 	push the return adress
460:    LDA  3,-7(3) 	stack expand
461:    LDC  1,62(0) 	get function adress from struct
462:     ST  1,4(3) 	Init Struct Instance
463:    LDC  1,72(0) 	get function adress from struct
464:     ST  1,5(3) 	Init Struct Instance
465:    LDC  1,82(0) 	get function adress from struct
466:     ST  1,6(3) 	Init Struct Instance
467:    LDC  1,92(0) 	get function adress from struct
468:     ST  1,7(3) 	Init Struct Instance
469:    LDA  3,-1(3) 	stack expand
* -> Const
470:    LDC  0,0(0) 	load integer const
471:   PUSH  0,0(6) 	store exp
* <- Const
472:    LDA  1,-9(2) 	move the adress of ID
473:    POP  0,0(6) 	copy bytes
474:     ST  0,0(1) 	copy bytes
* -> assign
* call function: 
* createListNode
* -> Id
475:     LD  0,-3(5) 	load id value
476:   PUSH  0,0(6) 	store exp
* <- Id
477:    LDC  0,479(0) 	store the return adress
478:    POP  7,0(6) 	ujp to the function body
479:    LDA  3,0(3) 	pop parameters
* -> Id
480:    LDA  0,-8(2) 	load id adress
481:   PUSH  0,0(6) 	push array adress to mp
* <- Id
482:    POP  1,0,6 	load adress of lhs struct
483:    LDC  0,0,0 	load offset of member
484:    ADD  0,0,1 	compute the real adress if pointK
485:   PUSH  0,0(6) 	
486:    POP  1,0(6) 	move the adress of referenced
487:    POP  0,0(6) 	copy bytes
488:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
489:    LDA  0,-8(2) 	load id adress
490:   PUSH  0,0(6) 	push array adress to mp
* <- Id
491:    POP  1,0,6 	load adress of lhs struct
492:    LDC  0,0,0 	load offset of member
493:    ADD  0,0,1 	compute the real adress if pointK
494:   PUSH  0,0(6) 	
495:    POP  0,0(6) 	load adress from mp
496:     LD  1,0(0) 	copy bytes
497:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
498:    LDA  0,-8(2) 	load id adress
499:   PUSH  0,0(6) 	push array adress to mp
* <- Id
500:    POP  1,0,6 	load adress of lhs struct
501:    LDC  0,1,0 	load offset of member
502:    ADD  0,0,1 	compute the real adress if pointK
503:   PUSH  0,0(6) 	
504:    POP  1,0(6) 	move the adress of referenced
505:    POP  0,0(6) 	copy bytes
506:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Const
507:    LDC  0,0(0) 	load integer const
508:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
509:    LDA  0,-8(2) 	load id adress
510:   PUSH  0,0(6) 	push array adress to mp
* <- Id
511:    POP  1,0,6 	load adress of lhs struct
512:    LDC  0,2,0 	load offset of member
513:    ADD  0,0,1 	compute the real adress if pointK
514:   PUSH  0,0(6) 	
515:    POP  1,0(6) 	move the adress of referenced
516:    POP  0,0(6) 	copy bytes
517:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
518:     LD  0,-8(2) 	load id value
519:   PUSH  0,0(6) 	store exp
520:     LD  0,-7(2) 	load id value
521:   PUSH  0,0(6) 	store exp
522:     LD  0,-6(2) 	load id value
523:   PUSH  0,0(6) 	store exp
524:     LD  0,-5(2) 	load id value
525:   PUSH  0,0(6) 	store exp
526:     LD  0,-4(2) 	load id value
527:   PUSH  0,0(6) 	store exp
528:     LD  0,-3(2) 	load id value
529:   PUSH  0,0(6) 	store exp
530:     LD  0,-2(2) 	load id value
531:   PUSH  0,0(6) 	store exp
* <- Id
532:    MOV  3,2,0 	restore the caller sp
533:     LD  2,0(2) 	resotre the caller fp
534:  RETURN  0,-1,3 	return to the caller
535:    MOV  3,2,0 	restore the caller sp
536:     LD  2,0(2) 	resotre the caller fp
537:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
538:  LABEL  17,0,0 	generate label
* function entry:
* insertSortedList
539:    LDA  3,-1(3) 	stack expand for function variable
540:    LDC  0,543(0) 	get function adress
541:     ST  0,-5(5) 	set function adress
542:     GO  18,0,0 	go to label
543:    MOV  1,2,0 	store the caller fp temporarily
544:    MOV  2,3,0 	exchang the stack(context)
545:   PUSH  1,0(3) 	push the caller fp
546:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
547:     LD  0,2(2) 	load id value
548:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
549:     LD  0,-2(5) 	load id value
550:   PUSH  0,0(6) 	store exp
* <- Id
551:    POP  1,0(6) 	pop right
552:    POP  0,0(6) 	pop left
553:    SUB  0,0,1 	op ==, convertd_type
554:    JEQ  0,2(7) 	br if true
555:    LDC  0,0(0) 	false case
556:    LDA  7,1(7) 	unconditional jmp
557:    LDC  0,1(0) 	true case
558:   PUSH  0,0(6) 	
* <- Op
559:    POP  0,0(6) 	pop from the mp
560:    JNE  0,1,7 	true case:, execute if part
561:     GO  19,0,0 	go to label
562:    MOV  3,2,0 	restore the caller sp
563:     LD  2,0(2) 	resotre the caller fp
564:  RETURN  0,-1,3 	return to the caller
565:     GO  20,0,0 	go to label
566:  LABEL  19,0,0 	generate label
* if: jump to else
567:  LABEL  20,0,0 	generate label
* <- if
568:    LDA  3,-1(3) 	stack expand
* -> Const
569:    LDC  0,10(0) 	load integer const
570:   PUSH  0,0(6) 	store exp
* <- Const
571:    LDA  1,-2(2) 	move the adress of ID
572:    POP  0,0(6) 	copy bytes
573:     ST  0,0(1) 	copy bytes
* -> assign
* -> Op
* -> Id
574:     LD  0,1(2) 	load id value
575:   PUSH  0,0(6) 	store exp
* <- Id
576:    POP  1,0,6 	load adress of lhs struct
577:    LDC  0,2,0 	load offset of member
578:    ADD  0,0,1 	compute the real adress if pointK
579:   PUSH  0,0(6) 	
580:    POP  0,0(6) 	load adress from mp
581:     LD  1,0(0) 	copy bytes
582:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
583:    LDC  0,1(0) 	load integer const
584:   PUSH  0,0(6) 	store exp
* <- Const
585:    POP  1,0(6) 	pop right
586:    POP  0,0(6) 	pop left
587:    ADD  0,0,1 	op +
588:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
589:     LD  0,1(2) 	load id value
590:   PUSH  0,0(6) 	store exp
* <- Id
591:    POP  1,0,6 	load adress of lhs struct
592:    LDC  0,2,0 	load offset of member
593:    ADD  0,0,1 	compute the real adress if pointK
594:   PUSH  0,0(6) 	
595:    POP  1,0(6) 	move the adress of referenced
596:    POP  0,0(6) 	copy bytes
597:     ST  0,0(1) 	copy bytes
* <- assign
598:    LDA  3,-1(3) 	stack expand
* -> Id
599:     LD  0,1(2) 	load id value
600:   PUSH  0,0(6) 	store exp
* <- Id
601:    POP  1,0,6 	load adress of lhs struct
602:    LDC  0,0,0 	load offset of member
603:    ADD  0,0,1 	compute the real adress if pointK
604:   PUSH  0,0(6) 	
605:    POP  0,0(6) 	load adress from mp
606:     LD  1,0(0) 	copy bytes
607:   PUSH  1,0(6) 	push a.x value into tmp
608:    LDA  1,-3(2) 	move the adress of ID
609:    POP  0,0(6) 	copy bytes
610:     ST  0,0(1) 	copy bytes
* -> repeat
* while stmt:
611:  LABEL  21,0,0 	generate label
* -> Op
* -> Id
612:     LD  0,-3(2) 	load id value
613:   PUSH  0,0(6) 	store exp
* <- Id
614:    POP  1,0,6 	load adress of lhs struct
615:    LDC  0,1,0 	load offset of member
616:    ADD  0,0,1 	compute the real adress if pointK
617:   PUSH  0,0(6) 	
618:    POP  0,0(6) 	load adress from mp
619:     LD  1,0(0) 	copy bytes
620:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
621:     LD  0,-2(5) 	load id value
622:   PUSH  0,0(6) 	store exp
* <- Id
623:    POP  1,0(6) 	pop right
624:    POP  0,0(6) 	pop left
625:    SUB  0,0,1 	op ==, convertd_type
626:    JNE  0,2(7) 	br if true
627:    LDC  0,0(0) 	false case
628:    LDA  7,1(7) 	unconditional jmp
629:    LDC  0,1(0) 	true case
630:   PUSH  0,0(6) 	
* <- Op
631:    POP  0,0(6) 	pop from the mp
632:    JNE  0,1,7 	true case:, skip the break, execute the block code
633:     GO  22,0,0 	go to label
* -> if
* -> Op
* push function parameters
* -> Id
634:     LD  0,2(2) 	load id value
635:   PUSH  0,0(6) 	store exp
* <- Id
636:    POP  1,0,6 	load adress of lhs struct
637:    LDC  0,2,0 	load offset of member
638:    ADD  0,0,1 	compute the real adress if pointK
639:   PUSH  0,0(6) 	
640:    POP  0,0(6) 	load adress from mp
641:     LD  1,0(0) 	copy bytes
642:   PUSH  1,0(6) 	push a.x value into tmp
643:    POP  0,0(6) 	copy bytes
644:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
* -> Id
645:     LD  0,-3(2) 	load id value
646:   PUSH  0,0(6) 	store exp
* <- Id
647:    POP  1,0,6 	load adress of lhs struct
648:    LDC  0,1,0 	load offset of member
649:    ADD  0,0,1 	compute the real adress if pointK
650:   PUSH  0,0(6) 	
651:    POP  0,0(6) 	load adress from mp
652:     LD  1,0(0) 	copy bytes
653:   PUSH  1,0(6) 	push a.x value into tmp
654:    POP  1,0,6 	load adress of lhs struct
655:    LDC  0,2,0 	load offset of member
656:    ADD  0,0,1 	compute the real adress if pointK
657:   PUSH  0,0(6) 	
658:    POP  0,0(6) 	load adress from mp
659:     LD  1,0(0) 	copy bytes
660:   PUSH  1,0(6) 	push a.x value into tmp
661:    POP  0,0(6) 	copy bytes
662:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* match
* -> Id
663:     LD  0,1(2) 	load id value
664:   PUSH  0,0(6) 	store exp
* <- Id
665:    POP  1,0,6 	load adress of lhs struct
666:    LDC  0,5,0 	load offset of member
667:    ADD  0,0,1 	compute the real adress if pointK
668:   PUSH  0,0(6) 	
669:    POP  0,0(6) 	load adress from mp
670:     LD  1,0(0) 	copy bytes
671:   PUSH  1,0(6) 	push a.x value into tmp
672:    LDC  0,674(0) 	store the return adress
673:    POP  7,0(6) 	ujp to the function body
674:    LDA  3,2(3) 	pop parameters
* -> Const
675:    LDC  0,0(0) 	load integer const
676:   PUSH  0,0(6) 	store exp
* <- Const
677:    POP  1,0(6) 	pop right
678:    POP  0,0(6) 	pop left
679:    SUB  0,0,1 	op <
680:    JGE  0,2(7) 	br if true
681:    LDC  0,0(0) 	false case
682:    LDA  7,1(7) 	unconditional jmp
683:    LDC  0,1(0) 	true case
684:   PUSH  0,0(6) 	
* <- Op
685:    POP  0,0(6) 	pop from the mp
686:    JNE  0,1,7 	true case:, execute if part
687:     GO  23,0,0 	go to label
688:     GO  22,0,0 	go to label
689:     GO  24,0,0 	go to label
690:  LABEL  23,0,0 	generate label
* if: jump to else
691:  LABEL  24,0,0 	generate label
* <- if
* -> assign
* -> Id
692:     LD  0,-3(2) 	load id value
693:   PUSH  0,0(6) 	store exp
* <- Id
694:    POP  1,0,6 	load adress of lhs struct
695:    LDC  0,1,0 	load offset of member
696:    ADD  0,0,1 	compute the real adress if pointK
697:   PUSH  0,0(6) 	
698:    POP  0,0(6) 	load adress from mp
699:     LD  1,0(0) 	copy bytes
700:   PUSH  1,0(6) 	push a.x value into tmp
701:    LDA  1,-3(2) 	move the adress of ID
702:    POP  0,0(6) 	copy bytes
703:     ST  0,0(1) 	copy bytes
* -> Id
704:     LD  0,-3(2) 	load id value
705:   PUSH  0,0(6) 	store exp
* <- Id
* <- assign
706:     GO  21,0,0 	go to label
707:  LABEL  22,0,0 	generate label
* <- repeat
708:    LDA  3,-1(3) 	stack expand
* -> Id
709:     LD  0,-3(2) 	load id value
710:   PUSH  0,0(6) 	store exp
* <- Id
711:    POP  1,0,6 	load adress of lhs struct
712:    LDC  0,1,0 	load offset of member
713:    ADD  0,0,1 	compute the real adress if pointK
714:   PUSH  0,0(6) 	
715:    POP  0,0(6) 	load adress from mp
716:     LD  1,0(0) 	copy bytes
717:   PUSH  1,0(6) 	push a.x value into tmp
718:    LDA  1,-4(2) 	move the adress of ID
719:    POP  0,0(6) 	copy bytes
720:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
721:     LD  0,2(2) 	load id value
722:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
723:     LD  0,-3(2) 	load id value
724:   PUSH  0,0(6) 	store exp
* <- Id
725:    POP  1,0,6 	load adress of lhs struct
726:    LDC  0,1,0 	load offset of member
727:    ADD  0,0,1 	compute the real adress if pointK
728:   PUSH  0,0(6) 	
729:    POP  1,0(6) 	move the adress of referenced
730:    POP  0,0(6) 	copy bytes
731:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
732:     LD  0,-4(2) 	load id value
733:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
734:     LD  0,2(2) 	load id value
735:   PUSH  0,0(6) 	store exp
* <- Id
736:    POP  1,0,6 	load adress of lhs struct
737:    LDC  0,1,0 	load offset of member
738:    ADD  0,0,1 	compute the real adress if pointK
739:   PUSH  0,0(6) 	
740:    POP  1,0(6) 	move the adress of referenced
741:    POP  0,0(6) 	copy bytes
742:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
743:     LD  0,-3(2) 	load id value
744:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
745:     LD  0,2(2) 	load id value
746:   PUSH  0,0(6) 	store exp
* <- Id
747:    POP  1,0,6 	load adress of lhs struct
748:    LDC  0,0,0 	load offset of member
749:    ADD  0,0,1 	compute the real adress if pointK
750:   PUSH  0,0(6) 	
751:    POP  1,0(6) 	move the adress of referenced
752:    POP  0,0(6) 	copy bytes
753:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
754:     LD  0,-4(2) 	load id value
755:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
756:     LD  0,-2(5) 	load id value
757:   PUSH  0,0(6) 	store exp
* <- Id
758:    POP  1,0(6) 	pop right
759:    POP  0,0(6) 	pop left
760:    SUB  0,0,1 	op ==, convertd_type
761:    JNE  0,2(7) 	br if true
762:    LDC  0,0(0) 	false case
763:    LDA  7,1(7) 	unconditional jmp
764:    LDC  0,1(0) 	true case
765:   PUSH  0,0(6) 	
* <- Op
766:    POP  0,0(6) 	pop from the mp
767:    JNE  0,1,7 	true case:, execute if part
768:     GO  25,0,0 	go to label
* -> assign
* -> Id
769:     LD  0,2(2) 	load id value
770:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
771:     LD  0,-4(2) 	load id value
772:   PUSH  0,0(6) 	store exp
* <- Id
773:    POP  1,0,6 	load adress of lhs struct
774:    LDC  0,0,0 	load offset of member
775:    ADD  0,0,1 	compute the real adress if pointK
776:   PUSH  0,0(6) 	
777:    POP  1,0(6) 	move the adress of referenced
778:    POP  0,0(6) 	copy bytes
779:     ST  0,0(1) 	copy bytes
* <- assign
780:     GO  26,0,0 	go to label
781:  LABEL  25,0,0 	generate label
* if: jump to else
* -> assign
* -> Id
782:     LD  0,2(2) 	load id value
783:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
784:     LD  0,1(2) 	load id value
785:   PUSH  0,0(6) 	store exp
* <- Id
786:    POP  1,0,6 	load adress of lhs struct
787:    LDC  0,1,0 	load offset of member
788:    ADD  0,0,1 	compute the real adress if pointK
789:   PUSH  0,0(6) 	
790:    POP  1,0(6) 	move the adress of referenced
791:    POP  0,0(6) 	copy bytes
792:     ST  0,0(1) 	copy bytes
* <- assign
793:  LABEL  26,0,0 	generate label
* <- if
794:    MOV  3,2,0 	restore the caller sp
795:     LD  2,0(2) 	resotre the caller fp
796:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
797:  LABEL  18,0,0 	generate label
* function entry:
* append
798:    LDA  3,-1(3) 	stack expand for function variable
799:    LDC  0,802(0) 	get function adress
800:     ST  0,-6(5) 	set function adress
801:     GO  27,0,0 	go to label
802:    MOV  1,2,0 	store the caller fp temporarily
803:    MOV  2,3,0 	exchang the stack(context)
804:   PUSH  1,0(3) 	push the caller fp
805:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
806:     LD  0,1(2) 	load id value
807:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
808:     LD  0,-2(5) 	load id value
809:   PUSH  0,0(6) 	store exp
* <- Id
810:    POP  1,0(6) 	pop right
811:    POP  0,0(6) 	pop left
812:    SUB  0,0,1 	op ==, convertd_type
813:    JEQ  0,2(7) 	br if true
814:    LDC  0,0(0) 	false case
815:    LDA  7,1(7) 	unconditional jmp
816:    LDC  0,1(0) 	true case
817:   PUSH  0,0(6) 	
* <- Op
818:    POP  0,0(6) 	pop from the mp
819:    JNE  0,1,7 	true case:, execute if part
820:     GO  28,0,0 	go to label
821:    MOV  3,2,0 	restore the caller sp
822:     LD  2,0(2) 	resotre the caller fp
823:  RETURN  0,-1,3 	return to the caller
824:     GO  29,0,0 	go to label
825:  LABEL  28,0,0 	generate label
* if: jump to else
826:  LABEL  29,0,0 	generate label
* <- if
* -> if
* -> Op
* -> Id
827:     LD  0,2(2) 	load id value
828:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
829:     LD  0,-2(5) 	load id value
830:   PUSH  0,0(6) 	store exp
* <- Id
831:    POP  1,0(6) 	pop right
832:    POP  0,0(6) 	pop left
833:    SUB  0,0,1 	op ==, convertd_type
834:    JEQ  0,2(7) 	br if true
835:    LDC  0,0(0) 	false case
836:    LDA  7,1(7) 	unconditional jmp
837:    LDC  0,1(0) 	true case
838:   PUSH  0,0(6) 	
* <- Op
839:    POP  0,0(6) 	pop from the mp
840:    JNE  0,1,7 	true case:, execute if part
841:     GO  30,0,0 	go to label
842:    MOV  3,2,0 	restore the caller sp
843:     LD  2,0(2) 	resotre the caller fp
844:  RETURN  0,-1,3 	return to the caller
845:     GO  31,0,0 	go to label
846:  LABEL  30,0,0 	generate label
* if: jump to else
847:  LABEL  31,0,0 	generate label
* <- if
* ->Single Op
* -> Id
848:     LD  0,1(2) 	load id value
849:   PUSH  0,0(6) 	store exp
* <- Id
850:    POP  1,0,6 	load adress of lhs struct
851:    LDC  0,2,0 	load offset of member
852:    ADD  0,0,1 	compute the real adress if pointK
853:   PUSH  0,0(6) 	
854:    POP  0,0(6) 	load adress from mp
855:     LD  1,0(0) 	copy bytes
856:   PUSH  1,0(6) 	push a.x value into tmp
857:    POP  0,0(6) 	pop right
* -> Op
* -> Id
858:     LD  0,1(2) 	load id value
859:   PUSH  0,0(6) 	store exp
* <- Id
860:    POP  1,0,6 	load adress of lhs struct
861:    LDC  0,2,0 	load offset of member
862:    ADD  0,0,1 	compute the real adress if pointK
863:   PUSH  0,0(6) 	
864:    POP  0,0(6) 	load adress from mp
865:     LD  1,0(0) 	copy bytes
866:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
867:    LDC  0,1(0) 	load integer const
868:   PUSH  0,0(6) 	store exp
* <- Const
869:    POP  1,0(6) 	pop right
870:    POP  0,0(6) 	pop left
871:    ADD  0,0,1 	op +
872:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
873:     LD  0,1(2) 	load id value
874:   PUSH  0,0(6) 	store exp
* <- Id
875:    POP  1,0,6 	load adress of lhs struct
876:    LDC  0,2,0 	load offset of member
877:    ADD  0,0,1 	compute the real adress if pointK
878:   PUSH  0,0(6) 	
879:    POP  1,0(6) 	move the adress of referenced
880:    POP  0,0(6) 	copy bytes
881:     ST  0,0(1) 	copy bytes
* <-Single Op
* -> assign
* -> Id
882:     LD  0,2(2) 	load id value
883:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
884:     LD  0,1(2) 	load id value
885:   PUSH  0,0(6) 	store exp
* <- Id
886:    POP  1,0,6 	load adress of lhs struct
887:    LDC  0,1,0 	load offset of member
888:    ADD  0,0,1 	compute the real adress if pointK
889:   PUSH  0,0(6) 	
890:    POP  0,0(6) 	load adress from mp
891:     LD  1,0(0) 	copy bytes
892:   PUSH  1,0(6) 	push a.x value into tmp
893:    POP  1,0,6 	load adress of lhs struct
894:    LDC  0,1,0 	load offset of member
895:    ADD  0,0,1 	compute the real adress if pointK
896:   PUSH  0,0(6) 	
897:    POP  1,0(6) 	move the adress of referenced
898:    POP  0,0(6) 	copy bytes
899:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
900:     LD  0,1(2) 	load id value
901:   PUSH  0,0(6) 	store exp
* <- Id
902:    POP  1,0,6 	load adress of lhs struct
903:    LDC  0,1,0 	load offset of member
904:    ADD  0,0,1 	compute the real adress if pointK
905:   PUSH  0,0(6) 	
906:    POP  0,0(6) 	load adress from mp
907:     LD  1,0(0) 	copy bytes
908:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
909:     LD  0,2(2) 	load id value
910:   PUSH  0,0(6) 	store exp
* <- Id
911:    POP  1,0,6 	load adress of lhs struct
912:    LDC  0,0,0 	load offset of member
913:    ADD  0,0,1 	compute the real adress if pointK
914:   PUSH  0,0(6) 	
915:    POP  1,0(6) 	move the adress of referenced
916:    POP  0,0(6) 	copy bytes
917:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
918:     LD  0,-2(5) 	load id value
919:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
920:     LD  0,2(2) 	load id value
921:   PUSH  0,0(6) 	store exp
* <- Id
922:    POP  1,0,6 	load adress of lhs struct
923:    LDC  0,1,0 	load offset of member
924:    ADD  0,0,1 	compute the real adress if pointK
925:   PUSH  0,0(6) 	
926:    POP  1,0(6) 	move the adress of referenced
927:    POP  0,0(6) 	copy bytes
928:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
929:     LD  0,2(2) 	load id value
930:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
931:     LD  0,1(2) 	load id value
932:   PUSH  0,0(6) 	store exp
* <- Id
933:    POP  1,0,6 	load adress of lhs struct
934:    LDC  0,1,0 	load offset of member
935:    ADD  0,0,1 	compute the real adress if pointK
936:   PUSH  0,0(6) 	
937:    POP  1,0(6) 	move the adress of referenced
938:    POP  0,0(6) 	copy bytes
939:     ST  0,0(1) 	copy bytes
* <- assign
940:    MOV  3,2,0 	restore the caller sp
941:     LD  2,0(2) 	resotre the caller fp
942:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
943:  LABEL  27,0,0 	generate label
* function entry:
* popRight
944:    LDA  3,-1(3) 	stack expand for function variable
945:    LDC  0,948(0) 	get function adress
946:     ST  0,-7(5) 	set function adress
947:     GO  32,0,0 	go to label
948:    MOV  1,2,0 	store the caller fp temporarily
949:    MOV  2,3,0 	exchang the stack(context)
950:   PUSH  1,0(3) 	push the caller fp
951:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Op
* -> Id
952:     LD  0,1(2) 	load id value
953:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
954:     LD  0,-2(5) 	load id value
955:   PUSH  0,0(6) 	store exp
* <- Id
956:    POP  1,0(6) 	pop right
957:    POP  0,0(6) 	pop left
958:    SUB  0,0,1 	op ==, convertd_type
959:    JEQ  0,2(7) 	br if true
960:    LDC  0,0(0) 	false case
961:    LDA  7,1(7) 	unconditional jmp
962:    LDC  0,1(0) 	true case
963:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Id
964:     LD  0,1(2) 	load id value
965:   PUSH  0,0(6) 	store exp
* <- Id
966:    POP  1,0,6 	load adress of lhs struct
967:    LDC  0,2,0 	load offset of member
968:    ADD  0,0,1 	compute the real adress if pointK
969:   PUSH  0,0(6) 	
970:    POP  0,0(6) 	load adress from mp
971:     LD  1,0(0) 	copy bytes
972:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
973:    LDC  0,0(0) 	load integer const
974:   PUSH  0,0(6) 	store exp
* <- Const
975:    POP  1,0(6) 	pop right
976:    POP  0,0(6) 	pop left
977:    SUB  0,0,1 	op <
978:    JLE  0,2(7) 	br if true
979:    LDC  0,0(0) 	false case
980:    LDA  7,1(7) 	unconditional jmp
981:    LDC  0,1(0) 	true case
982:   PUSH  0,0(6) 	
* <- Op
983:    POP  1,0(6) 	pop right
984:    POP  0,0(6) 	pop left
985:    JNE  0,3(7) 	br if true
986:    JNE  1,2(7) 	br if true
987:    LDC  0,0(0) 	false case
988:    LDA  7,1(7) 	unconditional jmp
989:    LDC  0,1(0) 	true case
990:   PUSH  0,0(6) 	
* <- Op
991:    POP  0,0(6) 	pop from the mp
992:    JNE  0,1,7 	true case:, execute if part
993:     GO  33,0,0 	go to label
994:    MOV  3,2,0 	restore the caller sp
995:     LD  2,0(2) 	resotre the caller fp
996:  RETURN  0,-1,3 	return to the caller
997:     GO  34,0,0 	go to label
998:  LABEL  33,0,0 	generate label
* if: jump to else
999:  LABEL  34,0,0 	generate label
* <- if
* ->Single Op
* -> Id
1000:     LD  0,1(2) 	load id value
1001:   PUSH  0,0(6) 	store exp
* <- Id
1002:    POP  1,0,6 	load adress of lhs struct
1003:    LDC  0,2,0 	load offset of member
1004:    ADD  0,0,1 	compute the real adress if pointK
1005:   PUSH  0,0(6) 	
1006:    POP  0,0(6) 	load adress from mp
1007:     LD  1,0(0) 	copy bytes
1008:   PUSH  1,0(6) 	push a.x value into tmp
1009:    POP  0,0(6) 	pop right
* -> Op
* -> Id
1010:     LD  0,1(2) 	load id value
1011:   PUSH  0,0(6) 	store exp
* <- Id
1012:    POP  1,0,6 	load adress of lhs struct
1013:    LDC  0,2,0 	load offset of member
1014:    ADD  0,0,1 	compute the real adress if pointK
1015:   PUSH  0,0(6) 	
1016:    POP  0,0(6) 	load adress from mp
1017:     LD  1,0(0) 	copy bytes
1018:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
1019:    LDC  0,1(0) 	load integer const
1020:   PUSH  0,0(6) 	store exp
* <- Const
1021:    POP  1,0(6) 	pop right
1022:    POP  0,0(6) 	pop left
1023:    SUB  0,0,1 	op -
1024:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
1025:     LD  0,1(2) 	load id value
1026:   PUSH  0,0(6) 	store exp
* <- Id
1027:    POP  1,0,6 	load adress of lhs struct
1028:    LDC  0,2,0 	load offset of member
1029:    ADD  0,0,1 	compute the real adress if pointK
1030:   PUSH  0,0(6) 	
1031:    POP  1,0(6) 	move the adress of referenced
1032:    POP  0,0(6) 	copy bytes
1033:     ST  0,0(1) 	copy bytes
* <-Single Op
1034:    LDA  3,-1(3) 	stack expand
* -> Id
1035:     LD  0,1(2) 	load id value
1036:   PUSH  0,0(6) 	store exp
* <- Id
1037:    POP  1,0,6 	load adress of lhs struct
1038:    LDC  0,1,0 	load offset of member
1039:    ADD  0,0,1 	compute the real adress if pointK
1040:   PUSH  0,0(6) 	
1041:    POP  0,0(6) 	load adress from mp
1042:     LD  1,0(0) 	copy bytes
1043:   PUSH  1,0(6) 	push a.x value into tmp
1044:    POP  1,0,6 	load adress of lhs struct
1045:    LDC  0,0,0 	load offset of member
1046:    ADD  0,0,1 	compute the real adress if pointK
1047:   PUSH  0,0(6) 	
1048:    POP  0,0(6) 	load adress from mp
1049:     LD  1,0(0) 	copy bytes
1050:   PUSH  1,0(6) 	push a.x value into tmp
1051:    LDA  1,-2(2) 	move the adress of ID
1052:    POP  0,0(6) 	copy bytes
1053:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
1054:     LD  0,-2(5) 	load id value
1055:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1056:     LD  0,-2(2) 	load id value
1057:   PUSH  0,0(6) 	store exp
* <- Id
1058:    POP  1,0,6 	load adress of lhs struct
1059:    LDC  0,1,0 	load offset of member
1060:    ADD  0,0,1 	compute the real adress if pointK
1061:   PUSH  0,0(6) 	
1062:    POP  1,0(6) 	move the adress of referenced
1063:    POP  0,0(6) 	copy bytes
1064:     ST  0,0(1) 	copy bytes
* <- assign
* push function parameters
* -> Id
1065:     LD  0,1(2) 	load id value
1066:   PUSH  0,0(6) 	store exp
* <- Id
1067:    POP  1,0,6 	load adress of lhs struct
1068:    LDC  0,1,0 	load offset of member
1069:    ADD  0,0,1 	compute the real adress if pointK
1070:   PUSH  0,0(6) 	
1071:    POP  0,0(6) 	load adress from mp
1072:     LD  1,0(0) 	copy bytes
1073:   PUSH  1,0(6) 	push a.x value into tmp
1074:    POP  0,0(6) 	copy bytes
1075:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* free
* -> Id
1076:     LD  0,-1(5) 	load id value
1077:   PUSH  0,0(6) 	store exp
* <- Id
1078:    LDC  0,1080(0) 	store the return adress
1079:    POP  7,0(6) 	ujp to the function body
1080:    LDA  3,1(3) 	pop parameters
* -> assign
* -> Id
1081:     LD  0,-2(2) 	load id value
1082:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1083:     LD  0,1(2) 	load id value
1084:   PUSH  0,0(6) 	store exp
* <- Id
1085:    POP  1,0,6 	load adress of lhs struct
1086:    LDC  0,1,0 	load offset of member
1087:    ADD  0,0,1 	compute the real adress if pointK
1088:   PUSH  0,0(6) 	
1089:    POP  1,0(6) 	move the adress of referenced
1090:    POP  0,0(6) 	copy bytes
1091:     ST  0,0(1) 	copy bytes
* <- assign
1092:    MOV  3,2,0 	restore the caller sp
1093:     LD  2,0(2) 	resotre the caller fp
1094:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1095:  LABEL  32,0,0 	generate label
* function entry:
* popLeft
1096:    LDA  3,-1(3) 	stack expand for function variable
1097:    LDC  0,1100(0) 	get function adress
1098:     ST  0,-8(5) 	set function adress
1099:     GO  35,0,0 	go to label
1100:    MOV  1,2,0 	store the caller fp temporarily
1101:    MOV  2,3,0 	exchang the stack(context)
1102:   PUSH  1,0(3) 	push the caller fp
1103:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Op
* -> Id
1104:     LD  0,1(2) 	load id value
1105:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1106:     LD  0,-2(5) 	load id value
1107:   PUSH  0,0(6) 	store exp
* <- Id
1108:    POP  1,0(6) 	pop right
1109:    POP  0,0(6) 	pop left
1110:    SUB  0,0,1 	op ==, convertd_type
1111:    JEQ  0,2(7) 	br if true
1112:    LDC  0,0(0) 	false case
1113:    LDA  7,1(7) 	unconditional jmp
1114:    LDC  0,1(0) 	true case
1115:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Id
1116:     LD  0,1(2) 	load id value
1117:   PUSH  0,0(6) 	store exp
* <- Id
1118:    POP  1,0,6 	load adress of lhs struct
1119:    LDC  0,2,0 	load offset of member
1120:    ADD  0,0,1 	compute the real adress if pointK
1121:   PUSH  0,0(6) 	
1122:    POP  0,0(6) 	load adress from mp
1123:     LD  1,0(0) 	copy bytes
1124:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
1125:    LDC  0,0(0) 	load integer const
1126:   PUSH  0,0(6) 	store exp
* <- Const
1127:    POP  1,0(6) 	pop right
1128:    POP  0,0(6) 	pop left
1129:    SUB  0,0,1 	op <
1130:    JLE  0,2(7) 	br if true
1131:    LDC  0,0(0) 	false case
1132:    LDA  7,1(7) 	unconditional jmp
1133:    LDC  0,1(0) 	true case
1134:   PUSH  0,0(6) 	
* <- Op
1135:    POP  1,0(6) 	pop right
1136:    POP  0,0(6) 	pop left
1137:    JNE  0,3(7) 	br if true
1138:    JNE  1,2(7) 	br if true
1139:    LDC  0,0(0) 	false case
1140:    LDA  7,1(7) 	unconditional jmp
1141:    LDC  0,1(0) 	true case
1142:   PUSH  0,0(6) 	
* <- Op
1143:    POP  0,0(6) 	pop from the mp
1144:    JNE  0,1,7 	true case:, execute if part
1145:     GO  36,0,0 	go to label
1146:    MOV  3,2,0 	restore the caller sp
1147:     LD  2,0(2) 	resotre the caller fp
1148:  RETURN  0,-1,3 	return to the caller
1149:     GO  37,0,0 	go to label
1150:  LABEL  36,0,0 	generate label
* if: jump to else
1151:  LABEL  37,0,0 	generate label
* <- if
* ->Single Op
* -> Id
1152:     LD  0,1(2) 	load id value
1153:   PUSH  0,0(6) 	store exp
* <- Id
1154:    POP  1,0,6 	load adress of lhs struct
1155:    LDC  0,2,0 	load offset of member
1156:    ADD  0,0,1 	compute the real adress if pointK
1157:   PUSH  0,0(6) 	
1158:    POP  0,0(6) 	load adress from mp
1159:     LD  1,0(0) 	copy bytes
1160:   PUSH  1,0(6) 	push a.x value into tmp
1161:    POP  0,0(6) 	pop right
* -> Op
* -> Id
1162:     LD  0,1(2) 	load id value
1163:   PUSH  0,0(6) 	store exp
* <- Id
1164:    POP  1,0,6 	load adress of lhs struct
1165:    LDC  0,2,0 	load offset of member
1166:    ADD  0,0,1 	compute the real adress if pointK
1167:   PUSH  0,0(6) 	
1168:    POP  0,0(6) 	load adress from mp
1169:     LD  1,0(0) 	copy bytes
1170:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
1171:    LDC  0,1(0) 	load integer const
1172:   PUSH  0,0(6) 	store exp
* <- Const
1173:    POP  1,0(6) 	pop right
1174:    POP  0,0(6) 	pop left
1175:    SUB  0,0,1 	op -
1176:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
1177:     LD  0,1(2) 	load id value
1178:   PUSH  0,0(6) 	store exp
* <- Id
1179:    POP  1,0,6 	load adress of lhs struct
1180:    LDC  0,2,0 	load offset of member
1181:    ADD  0,0,1 	compute the real adress if pointK
1182:   PUSH  0,0(6) 	
1183:    POP  1,0(6) 	move the adress of referenced
1184:    POP  0,0(6) 	copy bytes
1185:     ST  0,0(1) 	copy bytes
* <-Single Op
1186:    LDA  3,-1(3) 	stack expand
* -> Id
1187:     LD  0,1(2) 	load id value
1188:   PUSH  0,0(6) 	store exp
* <- Id
1189:    POP  1,0,6 	load adress of lhs struct
1190:    LDC  0,0,0 	load offset of member
1191:    ADD  0,0,1 	compute the real adress if pointK
1192:   PUSH  0,0(6) 	
1193:    POP  0,0(6) 	load adress from mp
1194:     LD  1,0(0) 	copy bytes
1195:   PUSH  1,0(6) 	push a.x value into tmp
1196:    POP  1,0,6 	load adress of lhs struct
1197:    LDC  0,1,0 	load offset of member
1198:    ADD  0,0,1 	compute the real adress if pointK
1199:   PUSH  0,0(6) 	
1200:    POP  0,0(6) 	load adress from mp
1201:     LD  1,0(0) 	copy bytes
1202:   PUSH  1,0(6) 	push a.x value into tmp
1203:    POP  1,0,6 	load adress of lhs struct
1204:    LDC  0,1,0 	load offset of member
1205:    ADD  0,0,1 	compute the real adress if pointK
1206:   PUSH  0,0(6) 	
1207:    POP  0,0(6) 	load adress from mp
1208:     LD  1,0(0) 	copy bytes
1209:   PUSH  1,0(6) 	push a.x value into tmp
1210:    LDA  1,-2(2) 	move the adress of ID
1211:    POP  0,0(6) 	copy bytes
1212:     ST  0,0(1) 	copy bytes
* push function parameters
* -> Id
1213:     LD  0,1(2) 	load id value
1214:   PUSH  0,0(6) 	store exp
* <- Id
1215:    POP  1,0,6 	load adress of lhs struct
1216:    LDC  0,0,0 	load offset of member
1217:    ADD  0,0,1 	compute the real adress if pointK
1218:   PUSH  0,0(6) 	
1219:    POP  0,0(6) 	load adress from mp
1220:     LD  1,0(0) 	copy bytes
1221:   PUSH  1,0(6) 	push a.x value into tmp
1222:    POP  1,0,6 	load adress of lhs struct
1223:    LDC  0,1,0 	load offset of member
1224:    ADD  0,0,1 	compute the real adress if pointK
1225:   PUSH  0,0(6) 	
1226:    POP  0,0(6) 	load adress from mp
1227:     LD  1,0(0) 	copy bytes
1228:   PUSH  1,0(6) 	push a.x value into tmp
1229:    POP  0,0(6) 	copy bytes
1230:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* free
* -> Id
1231:     LD  0,-1(5) 	load id value
1232:   PUSH  0,0(6) 	store exp
* <- Id
1233:    LDC  0,1235(0) 	store the return adress
1234:    POP  7,0(6) 	ujp to the function body
1235:    LDA  3,1(3) 	pop parameters
* -> assign
* -> Id
1236:     LD  0,-2(2) 	load id value
1237:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1238:     LD  0,1(2) 	load id value
1239:   PUSH  0,0(6) 	store exp
* <- Id
1240:    POP  1,0,6 	load adress of lhs struct
1241:    LDC  0,0,0 	load offset of member
1242:    ADD  0,0,1 	compute the real adress if pointK
1243:   PUSH  0,0(6) 	
1244:    POP  0,0(6) 	load adress from mp
1245:     LD  1,0(0) 	copy bytes
1246:   PUSH  1,0(6) 	push a.x value into tmp
1247:    POP  1,0,6 	load adress of lhs struct
1248:    LDC  0,1,0 	load offset of member
1249:    ADD  0,0,1 	compute the real adress if pointK
1250:   PUSH  0,0(6) 	
1251:    POP  1,0(6) 	move the adress of referenced
1252:    POP  0,0(6) 	copy bytes
1253:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
1254:     LD  0,-2(2) 	load id value
1255:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1256:     LD  0,-2(5) 	load id value
1257:   PUSH  0,0(6) 	store exp
* <- Id
1258:    POP  1,0(6) 	pop right
1259:    POP  0,0(6) 	pop left
1260:    SUB  0,0,1 	op ==, convertd_type
1261:    JNE  0,2(7) 	br if true
1262:    LDC  0,0(0) 	false case
1263:    LDA  7,1(7) 	unconditional jmp
1264:    LDC  0,1(0) 	true case
1265:   PUSH  0,0(6) 	
* <- Op
1266:    POP  0,0(6) 	pop from the mp
1267:    JNE  0,1,7 	true case:, execute if part
1268:     GO  38,0,0 	go to label
* -> assign
* -> Id
1269:     LD  0,1(2) 	load id value
1270:   PUSH  0,0(6) 	store exp
* <- Id
1271:    POP  1,0,6 	load adress of lhs struct
1272:    LDC  0,0,0 	load offset of member
1273:    ADD  0,0,1 	compute the real adress if pointK
1274:   PUSH  0,0(6) 	
1275:    POP  0,0(6) 	load adress from mp
1276:     LD  1,0(0) 	copy bytes
1277:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
1278:     LD  0,-2(2) 	load id value
1279:   PUSH  0,0(6) 	store exp
* <- Id
1280:    POP  1,0,6 	load adress of lhs struct
1281:    LDC  0,0,0 	load offset of member
1282:    ADD  0,0,1 	compute the real adress if pointK
1283:   PUSH  0,0(6) 	
1284:    POP  1,0(6) 	move the adress of referenced
1285:    POP  0,0(6) 	copy bytes
1286:     ST  0,0(1) 	copy bytes
* <- assign
1287:     GO  39,0,0 	go to label
1288:  LABEL  38,0,0 	generate label
* if: jump to else
1289:  LABEL  39,0,0 	generate label
* <- if
1290:    MOV  3,2,0 	restore the caller sp
1291:     LD  2,0(2) 	resotre the caller fp
1292:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1293:  LABEL  35,0,0 	generate label
* call main function
