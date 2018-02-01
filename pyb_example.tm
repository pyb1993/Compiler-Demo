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
  8:    LDA  3,-1(3) 	stack expand
  9:    LDC  0,12(0) 	get function adress
 10:     ST  0,0(5) 	set function adress
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
* function end
 11:    LDA  7,11(7) 	skip the function body
* function entry:
* free
 23:    LDA  3,-1(3) 	stack expand
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
 33:    POP  0,0(6) 	get free parameters
 34:  FREE  0,0(0) 	system call for free
 35:    MOV  3,2,0 	restore the caller sp
 36:     LD  2,0(2) 	resotre the caller fp
 37:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 26:    LDA  7,11(7) 	skip the function body
* call main function
* File: pyb_example.tm
* Standard prelude:
 38:    LDC  6,65535(0) 	load mp adress
 39:     ST  0,0(0) 	clear location 0
 40:    LDC  5,4095(0) 	load gp adress from location 1
 41:     ST  0,1(0) 	clear location 1
 42:    LDC  4,2000(0) 	load gp adress from location 1
 43:    LDC  2,60000(0) 	load first fp from location 2
 44:    LDC  3,60000(0) 	load first sp from location 2
 45:     ST  0,2(0) 	clear location 2
* End of standard prelude.
 46:    LDA  3,-1(3) 	stack expand
* -> Const
 47:    LDC  0,0(0) 	load integer const
 48:   PUSH  0,0(6) 	store exp
* <- Const
 49:    LDA  1,-2(5) 	move the adress of ID
 50:    POP  0,0(6) 	copy bytes
 51:     ST  0,0(1) 	copy bytes
 52:    LDA  3,-1(3) 	stack expand
 53:    LDA  3,-1(3) 	stack expand
 54:    LDA  3,-1(3) 	stack expand
 55:    MOV  3,2,0 	resotre stack in struct
 56:    LDA  3,-1(3) 	stack expand
 57:    LDA  3,-1(3) 	stack expand
 58:    LDA  3,-1(3) 	stack expand
* function entry:
* dup
 59:    LDA  3,-1(3) 	stack expand
 61:    MOV  1,2,0 	store the caller fp temporarily
 62:    MOV  2,3,0 	exchang the stack(context)
 63:   PUSH  1,0(3) 	push the caller fp
 64:   PUSH  0,0(3) 	push the return adress
 65:    MOV  3,2,0 	restore the caller sp
 66:     LD  2,0(2) 	resotre the caller fp
 67:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 60:    LDA  7,7(7) 	skip the function body
* function entry:
* free
 68:    LDA  3,-1(3) 	stack expand
 70:    MOV  1,2,0 	store the caller fp temporarily
 71:    MOV  2,3,0 	exchang the stack(context)
 72:   PUSH  1,0(3) 	push the caller fp
 73:   PUSH  0,0(3) 	push the return adress
 74:    MOV  3,2,0 	restore the caller sp
 75:     LD  2,0(2) 	resotre the caller fp
 76:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 69:    LDA  7,7(7) 	skip the function body
* function entry:
* match
 77:    LDA  3,-1(3) 	stack expand
 79:    MOV  1,2,0 	store the caller fp temporarily
 80:    MOV  2,3,0 	exchang the stack(context)
 81:   PUSH  1,0(3) 	push the caller fp
 82:   PUSH  0,0(3) 	push the return adress
 83:    MOV  3,2,0 	restore the caller sp
 84:     LD  2,0(2) 	resotre the caller fp
 85:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 78:    LDA  7,7(7) 	skip the function body
 86:    MOV  3,2,0 	resotre stack in struct
* function entry:
* createListNode
 87:    LDA  3,-1(3) 	stack expand
 88:    LDC  0,91(0) 	get function adress
 89:     ST  0,-3(5) 	set function adress
 91:    MOV  1,2,0 	store the caller fp temporarily
 92:    MOV  2,3,0 	exchang the stack(context)
 93:   PUSH  1,0(3) 	push the caller fp
 94:   PUSH  0,0(3) 	push the return adress
 95:    LDA  3,-1(3) 	stack expand
* ->Single Op
 96:    LDC  0,3,0 	load size of exp
 97:   PUSH  0,0(6) 	
* <-Single Op
 98:    POP  0,0(6) 	copy bytes
 99:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* malloc
* -> Id
100:     LD  0,0(5) 	load id value
101:   PUSH  0,0(6) 	store exp
* <- Id
102:    LDC  0,104(0) 	store the return adress
103:    POP  7,0(6) 	ujp to the function body
104:    LDA  3,1(3) 	pop parameters
105:    LDA  1,-2(2) 	move the adress of ID
106:    POP  0,0(6) 	copy bytes
107:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
108:     LD  0,-2(5) 	load id value
109:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
110:     LD  0,-2(2) 	load id value
111:   PUSH  0,0(6) 	store exp
* <- Id
112:    POP  1,0,6 	load adress of lhs struct
113:    LDC  0,0,0 	load offset of member
114:    ADD  0,0,1 	compute the real adress if pointK
115:   PUSH  0,0(6) 	
116:    POP  1,0(6) 	move the adress of referenced
117:    POP  0,0(6) 	copy bytes
118:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
119:     LD  0,-2(5) 	load id value
120:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
121:     LD  0,-2(2) 	load id value
122:   PUSH  0,0(6) 	store exp
* <- Id
123:    POP  1,0,6 	load adress of lhs struct
124:    LDC  0,1,0 	load offset of member
125:    ADD  0,0,1 	compute the real adress if pointK
126:   PUSH  0,0(6) 	
127:    POP  1,0(6) 	move the adress of referenced
128:    POP  0,0(6) 	copy bytes
129:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
130:     LD  0,-2(5) 	load id value
131:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
132:     LD  0,-2(2) 	load id value
133:   PUSH  0,0(6) 	store exp
* <- Id
134:    POP  1,0,6 	load adress of lhs struct
135:    LDC  0,2,0 	load offset of member
136:    ADD  0,0,1 	compute the real adress if pointK
137:   PUSH  0,0(6) 	
138:    POP  1,0(6) 	move the adress of referenced
139:    POP  0,0(6) 	copy bytes
140:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
141:     LD  0,-2(2) 	load id value
142:   PUSH  0,0(6) 	store exp
* <- Id
143:    MOV  3,2,0 	restore the caller sp
144:     LD  2,0(2) 	resotre the caller fp
145:  RETURN  0,-1,3 	return to the caller
146:    MOV  3,2,0 	restore the caller sp
147:     LD  2,0(2) 	resotre the caller fp
148:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 90:    LDA  7,58(7) 	skip the function body
* function entry:
* createList
149:    LDA  3,-1(3) 	stack expand
150:    LDC  0,153(0) 	get function adress
151:     ST  0,-4(5) 	set function adress
153:    MOV  1,2,0 	store the caller fp temporarily
154:    MOV  2,3,0 	exchang the stack(context)
155:   PUSH  1,0(3) 	push the caller fp
156:   PUSH  0,0(3) 	push the return adress
157:    LDA  3,-6(3) 	stack expand
158:    LDC  1,61(0) 	get function adress from struct
159:     ST  1,4(3) 	Init Struct Instance
160:    LDC  1,70(0) 	get function adress from struct
161:     ST  1,5(3) 	Init Struct Instance
162:    LDC  1,79(0) 	get function adress from struct
163:     ST  1,6(3) 	Init Struct Instance
164:    LDA  3,-1(3) 	stack expand
* -> Const
165:    LDC  0,0(0) 	load integer const
166:   PUSH  0,0(6) 	store exp
* <- Const
167:    LDA  1,-8(2) 	move the adress of ID
168:    POP  0,0(6) 	copy bytes
169:     ST  0,0(1) 	copy bytes
* -> assign
* call function: 
* createListNode
* -> Id
170:     LD  0,-3(5) 	load id value
171:   PUSH  0,0(6) 	store exp
* <- Id
172:    LDC  0,174(0) 	store the return adress
173:    POP  7,0(6) 	ujp to the function body
174:    LDA  3,0(3) 	pop parameters
* -> Id
175:    LDA  0,-7(2) 	load id adress
176:   PUSH  0,0(6) 	push array adress to mp
* <- Id
177:    POP  1,0,6 	load adress of lhs struct
178:    LDC  0,0,0 	load offset of member
179:    ADD  0,0,1 	compute the real adress if pointK
180:   PUSH  0,0(6) 	
181:    POP  1,0(6) 	move the adress of referenced
182:    POP  0,0(6) 	copy bytes
183:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
184:    LDA  0,-7(2) 	load id adress
185:   PUSH  0,0(6) 	push array adress to mp
* <- Id
186:    POP  1,0,6 	load adress of lhs struct
187:    LDC  0,0,0 	load offset of member
188:    ADD  0,0,1 	compute the real adress if pointK
189:   PUSH  0,0(6) 	
190:    POP  0,0(6) 	load adress from mp
191:     LD  1,0(0) 	copy bytes
192:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
193:    LDA  0,-7(2) 	load id adress
194:   PUSH  0,0(6) 	push array adress to mp
* <- Id
195:    POP  1,0,6 	load adress of lhs struct
196:    LDC  0,1,0 	load offset of member
197:    ADD  0,0,1 	compute the real adress if pointK
198:   PUSH  0,0(6) 	
199:    POP  1,0(6) 	move the adress of referenced
200:    POP  0,0(6) 	copy bytes
201:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Const
202:    LDC  0,0(0) 	load integer const
203:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
204:    LDA  0,-7(2) 	load id adress
205:   PUSH  0,0(6) 	push array adress to mp
* <- Id
206:    POP  1,0,6 	load adress of lhs struct
207:    LDC  0,2,0 	load offset of member
208:    ADD  0,0,1 	compute the real adress if pointK
209:   PUSH  0,0(6) 	
210:    POP  1,0(6) 	move the adress of referenced
211:    POP  0,0(6) 	copy bytes
212:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
213:     LD  0,-7(2) 	load id value
214:   PUSH  0,0(6) 	store exp
215:     LD  0,-6(2) 	load id value
216:   PUSH  0,0(6) 	store exp
217:     LD  0,-5(2) 	load id value
218:   PUSH  0,0(6) 	store exp
219:     LD  0,-4(2) 	load id value
220:   PUSH  0,0(6) 	store exp
221:     LD  0,-3(2) 	load id value
222:   PUSH  0,0(6) 	store exp
223:     LD  0,-2(2) 	load id value
224:   PUSH  0,0(6) 	store exp
* <- Id
225:    MOV  3,2,0 	restore the caller sp
226:     LD  2,0(2) 	resotre the caller fp
227:  RETURN  0,-1,3 	return to the caller
228:    MOV  3,2,0 	restore the caller sp
229:     LD  2,0(2) 	resotre the caller fp
230:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
152:    LDA  7,78(7) 	skip the function body
* function entry:
* insertSortedList
231:    LDA  3,-1(3) 	stack expand
232:    LDC  0,235(0) 	get function adress
233:     ST  0,-5(5) 	set function adress
235:    MOV  1,2,0 	store the caller fp temporarily
236:    MOV  2,3,0 	exchang the stack(context)
237:   PUSH  1,0(3) 	push the caller fp
238:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
239:     LD  0,2(2) 	load id value
240:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
241:     LD  0,-2(5) 	load id value
242:   PUSH  0,0(6) 	store exp
* <- Id
243:    POP  1,0(6) 	pop right
244:    POP  0,0(6) 	pop left
245:    SUB  0,0,1 	op ==, convertd_type
246:    JEQ  0,2(7) 	br if true
247:    LDC  0,0(0) 	false case
248:    LDA  7,1(7) 	unconditional jmp
249:    LDC  0,1(0) 	true case
250:   PUSH  0,0(6) 	
* <- Op
251:    POP  0,0(6) 	pop from the mp
252:    JNE  0,1,7 	true case:, execute if part
253:     GO  0,0,0 	go to label
254:    MOV  3,2,0 	restore the caller sp
255:     LD  2,0(2) 	resotre the caller fp
256:  RETURN  0,-1,3 	return to the caller
257:     GO  1,0,0 	go to label
258:  LABEL  0,0,0 	generate label
* if: jump to else
259:  LABEL  1,0,0 	generate label
* <- if
* -> assign
* -> Op
* -> Id
260:     LD  0,1(2) 	load id value
261:   PUSH  0,0(6) 	store exp
* <- Id
262:    POP  1,0,6 	load adress of lhs struct
263:    LDC  0,2,0 	load offset of member
264:    ADD  0,0,1 	compute the real adress if pointK
265:   PUSH  0,0(6) 	
266:    POP  0,0(6) 	load adress from mp
267:     LD  1,0(0) 	copy bytes
268:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
269:    LDC  0,1(0) 	load integer const
270:   PUSH  0,0(6) 	store exp
* <- Const
271:    POP  1,0(6) 	pop right
272:    POP  0,0(6) 	pop left
273:    ADD  0,0,1 	op +
274:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
275:     LD  0,1(2) 	load id value
276:   PUSH  0,0(6) 	store exp
* <- Id
277:    POP  1,0,6 	load adress of lhs struct
278:    LDC  0,2,0 	load offset of member
279:    ADD  0,0,1 	compute the real adress if pointK
280:   PUSH  0,0(6) 	
281:    POP  1,0(6) 	move the adress of referenced
282:    POP  0,0(6) 	copy bytes
283:     ST  0,0(1) 	copy bytes
* <- assign
284:    LDA  3,-1(3) 	stack expand
* -> Id
285:     LD  0,1(2) 	load id value
286:   PUSH  0,0(6) 	store exp
* <- Id
287:    POP  1,0,6 	load adress of lhs struct
288:    LDC  0,0,0 	load offset of member
289:    ADD  0,0,1 	compute the real adress if pointK
290:   PUSH  0,0(6) 	
291:    POP  0,0(6) 	load adress from mp
292:     LD  1,0(0) 	copy bytes
293:   PUSH  1,0(6) 	push a.x value into tmp
294:    LDA  1,-2(2) 	move the adress of ID
295:    POP  0,0(6) 	copy bytes
296:     ST  0,0(1) 	copy bytes
* -> repeat
* while stmt:
297:  LABEL  2,0,0 	generate label
* -> Op
* -> Id
298:     LD  0,-2(2) 	load id value
299:   PUSH  0,0(6) 	store exp
* <- Id
300:    POP  1,0,6 	load adress of lhs struct
301:    LDC  0,1,0 	load offset of member
302:    ADD  0,0,1 	compute the real adress if pointK
303:   PUSH  0,0(6) 	
304:    POP  0,0(6) 	load adress from mp
305:     LD  1,0(0) 	copy bytes
306:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
307:     LD  0,-2(5) 	load id value
308:   PUSH  0,0(6) 	store exp
* <- Id
309:    POP  1,0(6) 	pop right
310:    POP  0,0(6) 	pop left
311:    SUB  0,0,1 	op ==, convertd_type
312:    JNE  0,2(7) 	br if true
313:    LDC  0,0(0) 	false case
314:    LDA  7,1(7) 	unconditional jmp
315:    LDC  0,1(0) 	true case
316:   PUSH  0,0(6) 	
* <- Op
317:    POP  0,0(6) 	pop from the mp
318:    JNE  0,1,7 	true case:, skip the break, execute the block code
319:     GO  3,0,0 	go to label
* -> if
* -> Op
* -> Id
320:     LD  0,2(2) 	load id value
321:   PUSH  0,0(6) 	store exp
* <- Id
322:    POP  1,0,6 	load adress of lhs struct
323:    LDC  0,2,0 	load offset of member
324:    ADD  0,0,1 	compute the real adress if pointK
325:   PUSH  0,0(6) 	
326:    POP  0,0(6) 	load adress from mp
327:     LD  1,0(0) 	copy bytes
328:   PUSH  1,0(6) 	push a.x value into tmp
329:    POP  0,0(6) 	copy bytes
330:   PUSH  0,0(3) 	PUSH bytes
* -> Id
331:     LD  0,-2(2) 	load id value
332:   PUSH  0,0(6) 	store exp
* <- Id
333:    POP  1,0,6 	load adress of lhs struct
334:    LDC  0,1,0 	load offset of member
335:    ADD  0,0,1 	compute the real adress if pointK
336:   PUSH  0,0(6) 	
337:    POP  0,0(6) 	load adress from mp
338:     LD  1,0(0) 	copy bytes
339:   PUSH  1,0(6) 	push a.x value into tmp
340:    POP  1,0,6 	load adress of lhs struct
341:    LDC  0,2,0 	load offset of member
342:    ADD  0,0,1 	compute the real adress if pointK
343:   PUSH  0,0(6) 	
344:    POP  0,0(6) 	load adress from mp
345:     LD  1,0(0) 	copy bytes
346:   PUSH  1,0(6) 	push a.x value into tmp
347:    POP  0,0(6) 	copy bytes
348:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* match
* -> Id
349:     LD  0,1(2) 	load id value
350:   PUSH  0,0(6) 	store exp
* <- Id
351:    POP  1,0,6 	load adress of lhs struct
352:    LDC  0,5,0 	load offset of member
353:    ADD  0,0,1 	compute the real adress if pointK
354:   PUSH  0,0(6) 	
355:    POP  0,0(6) 	load adress from mp
356:     LD  1,0(0) 	copy bytes
357:   PUSH  1,0(6) 	push a.x value into tmp
358:    LDC  0,360(0) 	store the return adress
359:    POP  7,0(6) 	ujp to the function body
360:    LDA  3,2(3) 	pop parameters
* -> Const
361:    LDC  0,0(0) 	load integer const
362:   PUSH  0,0(6) 	store exp
* <- Const
363:    POP  1,0(6) 	pop right
364:    POP  0,0(6) 	pop left
365:    SUB  0,0,1 	op <
366:    JGE  0,2(7) 	br if true
367:    LDC  0,0(0) 	false case
368:    LDA  7,1(7) 	unconditional jmp
369:    LDC  0,1(0) 	true case
370:   PUSH  0,0(6) 	
* <- Op
371:    POP  0,0(6) 	pop from the mp
372:    JNE  0,1,7 	true case:, execute if part
373:     GO  4,0,0 	go to label
374:     GO  3,0,0 	go to label
375:     GO  5,0,0 	go to label
376:  LABEL  4,0,0 	generate label
* if: jump to else
377:  LABEL  5,0,0 	generate label
* <- if
* -> assign
* -> Id
378:     LD  0,-2(2) 	load id value
379:   PUSH  0,0(6) 	store exp
* <- Id
380:    POP  1,0,6 	load adress of lhs struct
381:    LDC  0,1,0 	load offset of member
382:    ADD  0,0,1 	compute the real adress if pointK
383:   PUSH  0,0(6) 	
384:    POP  0,0(6) 	load adress from mp
385:     LD  1,0(0) 	copy bytes
386:   PUSH  1,0(6) 	push a.x value into tmp
387:    LDA  1,-2(2) 	move the adress of ID
388:    POP  0,0(6) 	copy bytes
389:     ST  0,0(1) 	copy bytes
* -> Id
390:     LD  0,-2(2) 	load id value
391:   PUSH  0,0(6) 	store exp
* <- Id
* <- assign
392:     GO  2,0,0 	go to label
393:  LABEL  3,0,0 	generate label
* <- repeat
394:    LDA  3,-1(3) 	stack expand
* -> Id
395:     LD  0,-2(2) 	load id value
396:   PUSH  0,0(6) 	store exp
* <- Id
397:    POP  1,0,6 	load adress of lhs struct
398:    LDC  0,1,0 	load offset of member
399:    ADD  0,0,1 	compute the real adress if pointK
400:   PUSH  0,0(6) 	
401:    POP  0,0(6) 	load adress from mp
402:     LD  1,0(0) 	copy bytes
403:   PUSH  1,0(6) 	push a.x value into tmp
404:    LDA  1,-3(2) 	move the adress of ID
405:    POP  0,0(6) 	copy bytes
406:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
407:     LD  0,2(2) 	load id value
408:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
409:     LD  0,-2(2) 	load id value
410:   PUSH  0,0(6) 	store exp
* <- Id
411:    POP  1,0,6 	load adress of lhs struct
412:    LDC  0,1,0 	load offset of member
413:    ADD  0,0,1 	compute the real adress if pointK
414:   PUSH  0,0(6) 	
415:    POP  1,0(6) 	move the adress of referenced
416:    POP  0,0(6) 	copy bytes
417:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
418:     LD  0,-3(2) 	load id value
419:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
420:     LD  0,2(2) 	load id value
421:   PUSH  0,0(6) 	store exp
* <- Id
422:    POP  1,0,6 	load adress of lhs struct
423:    LDC  0,1,0 	load offset of member
424:    ADD  0,0,1 	compute the real adress if pointK
425:   PUSH  0,0(6) 	
426:    POP  1,0(6) 	move the adress of referenced
427:    POP  0,0(6) 	copy bytes
428:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
429:     LD  0,-2(2) 	load id value
430:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
431:     LD  0,2(2) 	load id value
432:   PUSH  0,0(6) 	store exp
* <- Id
433:    POP  1,0,6 	load adress of lhs struct
434:    LDC  0,0,0 	load offset of member
435:    ADD  0,0,1 	compute the real adress if pointK
436:   PUSH  0,0(6) 	
437:    POP  1,0(6) 	move the adress of referenced
438:    POP  0,0(6) 	copy bytes
439:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
440:     LD  0,-3(2) 	load id value
441:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
442:     LD  0,-2(5) 	load id value
443:   PUSH  0,0(6) 	store exp
* <- Id
444:    POP  1,0(6) 	pop right
445:    POP  0,0(6) 	pop left
446:    SUB  0,0,1 	op ==, convertd_type
447:    JNE  0,2(7) 	br if true
448:    LDC  0,0(0) 	false case
449:    LDA  7,1(7) 	unconditional jmp
450:    LDC  0,1(0) 	true case
451:   PUSH  0,0(6) 	
* <- Op
452:    POP  0,0(6) 	pop from the mp
453:    JNE  0,1,7 	true case:, execute if part
454:     GO  6,0,0 	go to label
* -> assign
* -> Id
455:     LD  0,2(2) 	load id value
456:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
457:     LD  0,-3(2) 	load id value
458:   PUSH  0,0(6) 	store exp
* <- Id
459:    POP  1,0,6 	load adress of lhs struct
460:    LDC  0,0,0 	load offset of member
461:    ADD  0,0,1 	compute the real adress if pointK
462:   PUSH  0,0(6) 	
463:    POP  1,0(6) 	move the adress of referenced
464:    POP  0,0(6) 	copy bytes
465:     ST  0,0(1) 	copy bytes
* <- assign
466:     GO  7,0,0 	go to label
467:  LABEL  6,0,0 	generate label
* if: jump to else
* -> assign
* -> Id
468:     LD  0,2(2) 	load id value
469:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
470:     LD  0,1(2) 	load id value
471:   PUSH  0,0(6) 	store exp
* <- Id
472:    POP  1,0,6 	load adress of lhs struct
473:    LDC  0,1,0 	load offset of member
474:    ADD  0,0,1 	compute the real adress if pointK
475:   PUSH  0,0(6) 	
476:    POP  1,0(6) 	move the adress of referenced
477:    POP  0,0(6) 	copy bytes
478:     ST  0,0(1) 	copy bytes
* <- assign
479:  LABEL  7,0,0 	generate label
* <- if
480:    MOV  3,2,0 	restore the caller sp
481:     LD  2,0(2) 	resotre the caller fp
482:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
234:    LDA  7,248(7) 	skip the function body
* function entry:
* append
483:    LDA  3,-1(3) 	stack expand
484:    LDC  0,487(0) 	get function adress
485:     ST  0,-6(5) 	set function adress
487:    MOV  1,2,0 	store the caller fp temporarily
488:    MOV  2,3,0 	exchang the stack(context)
489:   PUSH  1,0(3) 	push the caller fp
490:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
491:     LD  0,1(2) 	load id value
492:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
493:     LD  0,-2(5) 	load id value
494:   PUSH  0,0(6) 	store exp
* <- Id
495:    POP  1,0(6) 	pop right
496:    POP  0,0(6) 	pop left
497:    SUB  0,0,1 	op ==, convertd_type
498:    JEQ  0,2(7) 	br if true
499:    LDC  0,0(0) 	false case
500:    LDA  7,1(7) 	unconditional jmp
501:    LDC  0,1(0) 	true case
502:   PUSH  0,0(6) 	
* <- Op
503:    POP  0,0(6) 	pop from the mp
504:    JNE  0,1,7 	true case:, execute if part
505:     GO  8,0,0 	go to label
506:    MOV  3,2,0 	restore the caller sp
507:     LD  2,0(2) 	resotre the caller fp
508:  RETURN  0,-1,3 	return to the caller
509:     GO  9,0,0 	go to label
510:  LABEL  8,0,0 	generate label
* if: jump to else
511:  LABEL  9,0,0 	generate label
* <- if
* -> if
* -> Op
* -> Id
512:     LD  0,2(2) 	load id value
513:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
514:     LD  0,-2(5) 	load id value
515:   PUSH  0,0(6) 	store exp
* <- Id
516:    POP  1,0(6) 	pop right
517:    POP  0,0(6) 	pop left
518:    SUB  0,0,1 	op ==, convertd_type
519:    JEQ  0,2(7) 	br if true
520:    LDC  0,0(0) 	false case
521:    LDA  7,1(7) 	unconditional jmp
522:    LDC  0,1(0) 	true case
523:   PUSH  0,0(6) 	
* <- Op
524:    POP  0,0(6) 	pop from the mp
525:    JNE  0,1,7 	true case:, execute if part
526:     GO  10,0,0 	go to label
527:    MOV  3,2,0 	restore the caller sp
528:     LD  2,0(2) 	resotre the caller fp
529:  RETURN  0,-1,3 	return to the caller
530:     GO  11,0,0 	go to label
531:  LABEL  10,0,0 	generate label
* if: jump to else
532:  LABEL  11,0,0 	generate label
* <- if
* -> assign
* -> Id
533:     LD  0,2(2) 	load id value
534:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
535:     LD  0,1(2) 	load id value
536:   PUSH  0,0(6) 	store exp
* <- Id
537:    POP  1,0,6 	load adress of lhs struct
538:    LDC  0,1,0 	load offset of member
539:    ADD  0,0,1 	compute the real adress if pointK
540:   PUSH  0,0(6) 	
541:    POP  0,0(6) 	load adress from mp
542:     LD  1,0(0) 	copy bytes
543:   PUSH  1,0(6) 	push a.x value into tmp
544:    POP  1,0,6 	load adress of lhs struct
545:    LDC  0,1,0 	load offset of member
546:    ADD  0,0,1 	compute the real adress if pointK
547:   PUSH  0,0(6) 	
548:    POP  1,0(6) 	move the adress of referenced
549:    POP  0,0(6) 	copy bytes
550:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
551:     LD  0,1(2) 	load id value
552:   PUSH  0,0(6) 	store exp
* <- Id
553:    POP  1,0,6 	load adress of lhs struct
554:    LDC  0,1,0 	load offset of member
555:    ADD  0,0,1 	compute the real adress if pointK
556:   PUSH  0,0(6) 	
557:    POP  0,0(6) 	load adress from mp
558:     LD  1,0(0) 	copy bytes
559:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
560:     LD  0,2(2) 	load id value
561:   PUSH  0,0(6) 	store exp
* <- Id
562:    POP  1,0,6 	load adress of lhs struct
563:    LDC  0,0,0 	load offset of member
564:    ADD  0,0,1 	compute the real adress if pointK
565:   PUSH  0,0(6) 	
566:    POP  1,0(6) 	move the adress of referenced
567:    POP  0,0(6) 	copy bytes
568:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
569:     LD  0,-2(5) 	load id value
570:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
571:     LD  0,2(2) 	load id value
572:   PUSH  0,0(6) 	store exp
* <- Id
573:    POP  1,0,6 	load adress of lhs struct
574:    LDC  0,1,0 	load offset of member
575:    ADD  0,0,1 	compute the real adress if pointK
576:   PUSH  0,0(6) 	
577:    POP  1,0(6) 	move the adress of referenced
578:    POP  0,0(6) 	copy bytes
579:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
580:     LD  0,2(2) 	load id value
581:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
582:     LD  0,1(2) 	load id value
583:   PUSH  0,0(6) 	store exp
* <- Id
584:    POP  1,0,6 	load adress of lhs struct
585:    LDC  0,1,0 	load offset of member
586:    ADD  0,0,1 	compute the real adress if pointK
587:   PUSH  0,0(6) 	
588:    POP  1,0(6) 	move the adress of referenced
589:    POP  0,0(6) 	copy bytes
590:     ST  0,0(1) 	copy bytes
* <- assign
591:    MOV  3,2,0 	restore the caller sp
592:     LD  2,0(2) 	resotre the caller fp
593:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
486:    LDA  7,107(7) 	skip the function body
* function entry:
* popRight
594:    LDA  3,-1(3) 	stack expand
595:    LDC  0,598(0) 	get function adress
596:     ST  0,-7(5) 	set function adress
598:    MOV  1,2,0 	store the caller fp temporarily
599:    MOV  2,3,0 	exchang the stack(context)
600:   PUSH  1,0(3) 	push the caller fp
601:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Op
* -> Id
602:     LD  0,1(2) 	load id value
603:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
604:     LD  0,-2(5) 	load id value
605:   PUSH  0,0(6) 	store exp
* <- Id
606:    POP  1,0(6) 	pop right
607:    POP  0,0(6) 	pop left
608:    SUB  0,0,1 	op ==, convertd_type
609:    JEQ  0,2(7) 	br if true
610:    LDC  0,0(0) 	false case
611:    LDA  7,1(7) 	unconditional jmp
612:    LDC  0,1(0) 	true case
613:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Id
614:     LD  0,1(2) 	load id value
615:   PUSH  0,0(6) 	store exp
* <- Id
616:    POP  1,0,6 	load adress of lhs struct
617:    LDC  0,2,0 	load offset of member
618:    ADD  0,0,1 	compute the real adress if pointK
619:   PUSH  0,0(6) 	
620:    POP  0,0(6) 	load adress from mp
621:     LD  1,0(0) 	copy bytes
622:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
623:    LDC  0,0(0) 	load integer const
624:   PUSH  0,0(6) 	store exp
* <- Const
625:    POP  1,0(6) 	pop right
626:    POP  0,0(6) 	pop left
627:    SUB  0,0,1 	op <
628:    JLE  0,2(7) 	br if true
629:    LDC  0,0(0) 	false case
630:    LDA  7,1(7) 	unconditional jmp
631:    LDC  0,1(0) 	true case
632:   PUSH  0,0(6) 	
* <- Op
633:    POP  1,0(6) 	pop right
634:    POP  0,0(6) 	pop left
635:    JNE  0,3(7) 	br if true
636:    JNE  1,2(7) 	br if true
637:    LDC  0,0(0) 	false case
638:    LDA  7,1(7) 	unconditional jmp
639:    LDC  0,1(0) 	true case
640:   PUSH  0,0(6) 	
* <- Op
641:    POP  0,0(6) 	pop from the mp
642:    JNE  0,1,7 	true case:, execute if part
643:     GO  12,0,0 	go to label
644:    MOV  3,2,0 	restore the caller sp
645:     LD  2,0(2) 	resotre the caller fp
646:  RETURN  0,-1,3 	return to the caller
647:     GO  13,0,0 	go to label
648:  LABEL  12,0,0 	generate label
* if: jump to else
649:  LABEL  13,0,0 	generate label
* <- if
* ->Single Op
* -> Id
650:     LD  0,1(2) 	load id value
651:   PUSH  0,0(6) 	store exp
* <- Id
652:    POP  1,0,6 	load adress of lhs struct
653:    LDC  0,2,0 	load offset of member
654:    ADD  0,0,1 	compute the real adress if pointK
655:   PUSH  0,0(6) 	
656:    POP  0,0(6) 	load adress from mp
657:     LD  1,0(0) 	copy bytes
658:   PUSH  1,0(6) 	push a.x value into tmp
659:    POP  0,0(6) 	pop right
* -> Op
* -> Id
660:     LD  0,1(2) 	load id value
661:   PUSH  0,0(6) 	store exp
* <- Id
662:    POP  1,0,6 	load adress of lhs struct
663:    LDC  0,2,0 	load offset of member
664:    ADD  0,0,1 	compute the real adress if pointK
665:   PUSH  0,0(6) 	
666:    POP  0,0(6) 	load adress from mp
667:     LD  1,0(0) 	copy bytes
668:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
669:    LDC  0,1(0) 	load integer const
670:   PUSH  0,0(6) 	store exp
* <- Const
671:    POP  1,0(6) 	pop right
672:    POP  0,0(6) 	pop left
673:    SUB  0,0,1 	op -
674:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
675:     LD  0,1(2) 	load id value
676:   PUSH  0,0(6) 	store exp
* <- Id
677:    POP  1,0,6 	load adress of lhs struct
678:    LDC  0,2,0 	load offset of member
679:    ADD  0,0,1 	compute the real adress if pointK
680:   PUSH  0,0(6) 	
681:    POP  1,0(6) 	move the adress of referenced
682:    POP  0,0(6) 	copy bytes
683:     ST  0,0(1) 	copy bytes
* <-Single Op
684:    LDA  3,-1(3) 	stack expand
* -> Id
685:     LD  0,1(2) 	load id value
686:   PUSH  0,0(6) 	store exp
* <- Id
687:    POP  1,0,6 	load adress of lhs struct
688:    LDC  0,1,0 	load offset of member
689:    ADD  0,0,1 	compute the real adress if pointK
690:   PUSH  0,0(6) 	
691:    POP  0,0(6) 	load adress from mp
692:     LD  1,0(0) 	copy bytes
693:   PUSH  1,0(6) 	push a.x value into tmp
694:    POP  1,0,6 	load adress of lhs struct
695:    LDC  0,0,0 	load offset of member
696:    ADD  0,0,1 	compute the real adress if pointK
697:   PUSH  0,0(6) 	
698:    POP  0,0(6) 	load adress from mp
699:     LD  1,0(0) 	copy bytes
700:   PUSH  1,0(6) 	push a.x value into tmp
701:    LDA  1,-2(2) 	move the adress of ID
702:    POP  0,0(6) 	copy bytes
703:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
704:     LD  0,-2(5) 	load id value
705:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
706:     LD  0,-2(2) 	load id value
707:   PUSH  0,0(6) 	store exp
* <- Id
708:    POP  1,0,6 	load adress of lhs struct
709:    LDC  0,1,0 	load offset of member
710:    ADD  0,0,1 	compute the real adress if pointK
711:   PUSH  0,0(6) 	
712:    POP  1,0(6) 	move the adress of referenced
713:    POP  0,0(6) 	copy bytes
714:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
715:     LD  0,1(2) 	load id value
716:   PUSH  0,0(6) 	store exp
* <- Id
717:    POP  1,0,6 	load adress of lhs struct
718:    LDC  0,1,0 	load offset of member
719:    ADD  0,0,1 	compute the real adress if pointK
720:   PUSH  0,0(6) 	
721:    POP  0,0(6) 	load adress from mp
722:     LD  1,0(0) 	copy bytes
723:   PUSH  1,0(6) 	push a.x value into tmp
724:    POP  0,0(6) 	copy bytes
725:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* free
* -> Id
726:     LD  0,-1(5) 	load id value
727:   PUSH  0,0(6) 	store exp
* <- Id
728:    LDC  0,730(0) 	store the return adress
729:    POP  7,0(6) 	ujp to the function body
730:    LDA  3,1(3) 	pop parameters
* -> assign
* -> Id
731:     LD  0,-2(2) 	load id value
732:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
733:     LD  0,1(2) 	load id value
734:   PUSH  0,0(6) 	store exp
* <- Id
735:    POP  1,0,6 	load adress of lhs struct
736:    LDC  0,1,0 	load offset of member
737:    ADD  0,0,1 	compute the real adress if pointK
738:   PUSH  0,0(6) 	
739:    POP  1,0(6) 	move the adress of referenced
740:    POP  0,0(6) 	copy bytes
741:     ST  0,0(1) 	copy bytes
* <- assign
742:    MOV  3,2,0 	restore the caller sp
743:     LD  2,0(2) 	resotre the caller fp
744:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
597:    LDA  7,147(7) 	skip the function body
* function entry:
* popLeft
745:    LDA  3,-1(3) 	stack expand
746:    LDC  0,749(0) 	get function adress
747:     ST  0,-8(5) 	set function adress
749:    MOV  1,2,0 	store the caller fp temporarily
750:    MOV  2,3,0 	exchang the stack(context)
751:   PUSH  1,0(3) 	push the caller fp
752:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Op
* -> Id
753:     LD  0,1(2) 	load id value
754:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
755:     LD  0,-2(5) 	load id value
756:   PUSH  0,0(6) 	store exp
* <- Id
757:    POP  1,0(6) 	pop right
758:    POP  0,0(6) 	pop left
759:    SUB  0,0,1 	op ==, convertd_type
760:    JEQ  0,2(7) 	br if true
761:    LDC  0,0(0) 	false case
762:    LDA  7,1(7) 	unconditional jmp
763:    LDC  0,1(0) 	true case
764:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Id
765:     LD  0,1(2) 	load id value
766:   PUSH  0,0(6) 	store exp
* <- Id
767:    POP  1,0,6 	load adress of lhs struct
768:    LDC  0,2,0 	load offset of member
769:    ADD  0,0,1 	compute the real adress if pointK
770:   PUSH  0,0(6) 	
771:    POP  0,0(6) 	load adress from mp
772:     LD  1,0(0) 	copy bytes
773:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
774:    LDC  0,0(0) 	load integer const
775:   PUSH  0,0(6) 	store exp
* <- Const
776:    POP  1,0(6) 	pop right
777:    POP  0,0(6) 	pop left
778:    SUB  0,0,1 	op <
779:    JLE  0,2(7) 	br if true
780:    LDC  0,0(0) 	false case
781:    LDA  7,1(7) 	unconditional jmp
782:    LDC  0,1(0) 	true case
783:   PUSH  0,0(6) 	
* <- Op
784:    POP  1,0(6) 	pop right
785:    POP  0,0(6) 	pop left
786:    JNE  0,3(7) 	br if true
787:    JNE  1,2(7) 	br if true
788:    LDC  0,0(0) 	false case
789:    LDA  7,1(7) 	unconditional jmp
790:    LDC  0,1(0) 	true case
791:   PUSH  0,0(6) 	
* <- Op
792:    POP  0,0(6) 	pop from the mp
793:    JNE  0,1,7 	true case:, execute if part
794:     GO  14,0,0 	go to label
795:    MOV  3,2,0 	restore the caller sp
796:     LD  2,0(2) 	resotre the caller fp
797:  RETURN  0,-1,3 	return to the caller
798:     GO  15,0,0 	go to label
799:  LABEL  14,0,0 	generate label
* if: jump to else
800:  LABEL  15,0,0 	generate label
* <- if
* ->Single Op
* -> Id
801:     LD  0,1(2) 	load id value
802:   PUSH  0,0(6) 	store exp
* <- Id
803:    POP  1,0,6 	load adress of lhs struct
804:    LDC  0,2,0 	load offset of member
805:    ADD  0,0,1 	compute the real adress if pointK
806:   PUSH  0,0(6) 	
807:    POP  0,0(6) 	load adress from mp
808:     LD  1,0(0) 	copy bytes
809:   PUSH  1,0(6) 	push a.x value into tmp
810:    POP  0,0(6) 	pop right
* -> Op
* -> Id
811:     LD  0,1(2) 	load id value
812:   PUSH  0,0(6) 	store exp
* <- Id
813:    POP  1,0,6 	load adress of lhs struct
814:    LDC  0,2,0 	load offset of member
815:    ADD  0,0,1 	compute the real adress if pointK
816:   PUSH  0,0(6) 	
817:    POP  0,0(6) 	load adress from mp
818:     LD  1,0(0) 	copy bytes
819:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
820:    LDC  0,1(0) 	load integer const
821:   PUSH  0,0(6) 	store exp
* <- Const
822:    POP  1,0(6) 	pop right
823:    POP  0,0(6) 	pop left
824:    SUB  0,0,1 	op -
825:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
826:     LD  0,1(2) 	load id value
827:   PUSH  0,0(6) 	store exp
* <- Id
828:    POP  1,0,6 	load adress of lhs struct
829:    LDC  0,2,0 	load offset of member
830:    ADD  0,0,1 	compute the real adress if pointK
831:   PUSH  0,0(6) 	
832:    POP  1,0(6) 	move the adress of referenced
833:    POP  0,0(6) 	copy bytes
834:     ST  0,0(1) 	copy bytes
* <-Single Op
835:    LDA  3,-1(3) 	stack expand
* -> Id
836:     LD  0,1(2) 	load id value
837:   PUSH  0,0(6) 	store exp
* <- Id
838:    POP  1,0,6 	load adress of lhs struct
839:    LDC  0,0,0 	load offset of member
840:    ADD  0,0,1 	compute the real adress if pointK
841:   PUSH  0,0(6) 	
842:    POP  0,0(6) 	load adress from mp
843:     LD  1,0(0) 	copy bytes
844:   PUSH  1,0(6) 	push a.x value into tmp
845:    POP  1,0,6 	load adress of lhs struct
846:    LDC  0,1,0 	load offset of member
847:    ADD  0,0,1 	compute the real adress if pointK
848:   PUSH  0,0(6) 	
849:    POP  0,0(6) 	load adress from mp
850:     LD  1,0(0) 	copy bytes
851:   PUSH  1,0(6) 	push a.x value into tmp
852:    POP  1,0,6 	load adress of lhs struct
853:    LDC  0,1,0 	load offset of member
854:    ADD  0,0,1 	compute the real adress if pointK
855:   PUSH  0,0(6) 	
856:    POP  0,0(6) 	load adress from mp
857:     LD  1,0(0) 	copy bytes
858:   PUSH  1,0(6) 	push a.x value into tmp
859:    LDA  1,-2(2) 	move the adress of ID
860:    POP  0,0(6) 	copy bytes
861:     ST  0,0(1) 	copy bytes
* -> Id
862:     LD  0,1(2) 	load id value
863:   PUSH  0,0(6) 	store exp
* <- Id
864:    POP  1,0,6 	load adress of lhs struct
865:    LDC  0,0,0 	load offset of member
866:    ADD  0,0,1 	compute the real adress if pointK
867:   PUSH  0,0(6) 	
868:    POP  0,0(6) 	load adress from mp
869:     LD  1,0(0) 	copy bytes
870:   PUSH  1,0(6) 	push a.x value into tmp
871:    POP  1,0,6 	load adress of lhs struct
872:    LDC  0,1,0 	load offset of member
873:    ADD  0,0,1 	compute the real adress if pointK
874:   PUSH  0,0(6) 	
875:    POP  0,0(6) 	load adress from mp
876:     LD  1,0(0) 	copy bytes
877:   PUSH  1,0(6) 	push a.x value into tmp
878:    POP  0,0(6) 	copy bytes
879:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* free
* -> Id
880:     LD  0,-1(5) 	load id value
881:   PUSH  0,0(6) 	store exp
* <- Id
882:    LDC  0,884(0) 	store the return adress
883:    POP  7,0(6) 	ujp to the function body
884:    LDA  3,1(3) 	pop parameters
* -> assign
* -> Id
885:     LD  0,-2(2) 	load id value
886:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
887:     LD  0,1(2) 	load id value
888:   PUSH  0,0(6) 	store exp
* <- Id
889:    POP  1,0,6 	load adress of lhs struct
890:    LDC  0,0,0 	load offset of member
891:    ADD  0,0,1 	compute the real adress if pointK
892:   PUSH  0,0(6) 	
893:    POP  0,0(6) 	load adress from mp
894:     LD  1,0(0) 	copy bytes
895:   PUSH  1,0(6) 	push a.x value into tmp
896:    POP  1,0,6 	load adress of lhs struct
897:    LDC  0,1,0 	load offset of member
898:    ADD  0,0,1 	compute the real adress if pointK
899:   PUSH  0,0(6) 	
900:    POP  1,0(6) 	move the adress of referenced
901:    POP  0,0(6) 	copy bytes
902:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
903:     LD  0,-2(2) 	load id value
904:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
905:     LD  0,-2(5) 	load id value
906:   PUSH  0,0(6) 	store exp
* <- Id
907:    POP  1,0(6) 	pop right
908:    POP  0,0(6) 	pop left
909:    SUB  0,0,1 	op ==, convertd_type
910:    JNE  0,2(7) 	br if true
911:    LDC  0,0(0) 	false case
912:    LDA  7,1(7) 	unconditional jmp
913:    LDC  0,1(0) 	true case
914:   PUSH  0,0(6) 	
* <- Op
915:    POP  0,0(6) 	pop from the mp
916:    JNE  0,1,7 	true case:, execute if part
917:     GO  16,0,0 	go to label
* -> assign
* -> Id
918:     LD  0,1(2) 	load id value
919:   PUSH  0,0(6) 	store exp
* <- Id
920:    POP  1,0,6 	load adress of lhs struct
921:    LDC  0,0,0 	load offset of member
922:    ADD  0,0,1 	compute the real adress if pointK
923:   PUSH  0,0(6) 	
924:    POP  0,0(6) 	load adress from mp
925:     LD  1,0(0) 	copy bytes
926:   PUSH  1,0(6) 	push a.x value into tmp
* -> Id
927:     LD  0,-2(2) 	load id value
928:   PUSH  0,0(6) 	store exp
* <- Id
929:    POP  1,0,6 	load adress of lhs struct
930:    LDC  0,0,0 	load offset of member
931:    ADD  0,0,1 	compute the real adress if pointK
932:   PUSH  0,0(6) 	
933:    POP  1,0(6) 	move the adress of referenced
934:    POP  0,0(6) 	copy bytes
935:     ST  0,0(1) 	copy bytes
* <- assign
936:     GO  17,0,0 	go to label
937:  LABEL  16,0,0 	generate label
* if: jump to else
938:  LABEL  17,0,0 	generate label
* <- if
939:    MOV  3,2,0 	restore the caller sp
940:     LD  2,0(2) 	resotre the caller fp
941:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
748:    LDA  7,193(7) 	skip the function body
* function entry:
* removeList
942:    LDA  3,-1(3) 	stack expand
943:    LDC  0,946(0) 	get function adress
944:     ST  0,-9(5) 	set function adress
946:    MOV  1,2,0 	store the caller fp temporarily
947:    MOV  2,3,0 	exchang the stack(context)
948:   PUSH  1,0(3) 	push the caller fp
949:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Op
* -> Id
950:     LD  0,1(2) 	load id value
951:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
952:     LD  0,-2(5) 	load id value
953:   PUSH  0,0(6) 	store exp
* <- Id
954:    POP  1,0(6) 	pop right
955:    POP  0,0(6) 	pop left
956:    SUB  0,0,1 	op ==, convertd_type
957:    JEQ  0,2(7) 	br if true
958:    LDC  0,0(0) 	false case
959:    LDA  7,1(7) 	unconditional jmp
960:    LDC  0,1(0) 	true case
961:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Id
962:     LD  0,1(2) 	load id value
963:   PUSH  0,0(6) 	store exp
* <- Id
964:    POP  1,0,6 	load adress of lhs struct
965:    LDC  0,2,0 	load offset of member
966:    ADD  0,0,1 	compute the real adress if pointK
967:   PUSH  0,0(6) 	
968:    POP  0,0(6) 	load adress from mp
969:     LD  1,0(0) 	copy bytes
970:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
971:    LDC  0,0(0) 	load integer const
972:   PUSH  0,0(6) 	store exp
* <- Const
973:    POP  1,0(6) 	pop right
974:    POP  0,0(6) 	pop left
975:    SUB  0,0,1 	op <
976:    JLE  0,2(7) 	br if true
977:    LDC  0,0(0) 	false case
978:    LDA  7,1(7) 	unconditional jmp
979:    LDC  0,1(0) 	true case
980:   PUSH  0,0(6) 	
* <- Op
981:    POP  1,0(6) 	pop right
982:    POP  0,0(6) 	pop left
983:    JNE  0,3(7) 	br if true
984:    JNE  1,2(7) 	br if true
985:    LDC  0,0(0) 	false case
986:    LDA  7,1(7) 	unconditional jmp
987:    LDC  0,1(0) 	true case
988:   PUSH  0,0(6) 	
* <- Op
989:    POP  0,0(6) 	pop from the mp
990:    JNE  0,1,7 	true case:, execute if part
991:     GO  18,0,0 	go to label
992:    MOV  3,2,0 	restore the caller sp
993:     LD  2,0(2) 	resotre the caller fp
994:  RETURN  0,-1,3 	return to the caller
995:     GO  19,0,0 	go to label
996:  LABEL  18,0,0 	generate label
* if: jump to else
997:  LABEL  19,0,0 	generate label
* <- if
* ->Single Op
* -> Id
998:     LD  0,1(2) 	load id value
999:   PUSH  0,0(6) 	store exp
* <- Id
1000:    POP  1,0,6 	load adress of lhs struct
1001:    LDC  0,2,0 	load offset of member
1002:    ADD  0,0,1 	compute the real adress if pointK
1003:   PUSH  0,0(6) 	
1004:    POP  0,0(6) 	load adress from mp
1005:     LD  1,0(0) 	copy bytes
1006:   PUSH  1,0(6) 	push a.x value into tmp
1007:    POP  0,0(6) 	pop right
* -> Op
* -> Id
1008:     LD  0,1(2) 	load id value
1009:   PUSH  0,0(6) 	store exp
* <- Id
1010:    POP  1,0,6 	load adress of lhs struct
1011:    LDC  0,2,0 	load offset of member
1012:    ADD  0,0,1 	compute the real adress if pointK
1013:   PUSH  0,0(6) 	
1014:    POP  0,0(6) 	load adress from mp
1015:     LD  1,0(0) 	copy bytes
1016:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
1017:    LDC  0,1(0) 	load integer const
1018:   PUSH  0,0(6) 	store exp
* <- Const
1019:    POP  1,0(6) 	pop right
1020:    POP  0,0(6) 	pop left
1021:    SUB  0,0,1 	op -
1022:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
1023:     LD  0,1(2) 	load id value
1024:   PUSH  0,0(6) 	store exp
* <- Id
1025:    POP  1,0,6 	load adress of lhs struct
1026:    LDC  0,2,0 	load offset of member
1027:    ADD  0,0,1 	compute the real adress if pointK
1028:   PUSH  0,0(6) 	
1029:    POP  1,0(6) 	move the adress of referenced
1030:    POP  0,0(6) 	copy bytes
1031:     ST  0,0(1) 	copy bytes
* <-Single Op
1032:    LDA  3,-1(3) 	stack expand
* -> Id
1033:     LD  0,1(2) 	load id value
1034:   PUSH  0,0(6) 	store exp
* <- Id
1035:    POP  1,0,6 	load adress of lhs struct
1036:    LDC  0,0,0 	load offset of member
1037:    ADD  0,0,1 	compute the real adress if pointK
1038:   PUSH  0,0(6) 	
1039:    POP  0,0(6) 	load adress from mp
1040:     LD  1,0(0) 	copy bytes
1041:   PUSH  1,0(6) 	push a.x value into tmp
1042:    POP  1,0,6 	load adress of lhs struct
1043:    LDC  0,1,0 	load offset of member
1044:    ADD  0,0,1 	compute the real adress if pointK
1045:   PUSH  0,0(6) 	
1046:    POP  0,0(6) 	load adress from mp
1047:     LD  1,0(0) 	copy bytes
1048:   PUSH  1,0(6) 	push a.x value into tmp
1049:    LDA  1,-2(2) 	move the adress of ID
1050:    POP  0,0(6) 	copy bytes
1051:     ST  0,0(1) 	copy bytes
* -> repeat
* while stmt:
1052:  LABEL  20,0,0 	generate label
* -> Op
* -> Op
* -> Id
1053:     LD  0,-2(2) 	load id value
1054:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1055:     LD  0,-2(5) 	load id value
1056:   PUSH  0,0(6) 	store exp
* <- Id
1057:    POP  1,0(6) 	pop right
1058:    POP  0,0(6) 	pop left
1059:    SUB  0,0,1 	op ==, convertd_type
1060:    JNE  0,2(7) 	br if true
1061:    LDC  0,0(0) 	false case
1062:    LDA  7,1(7) 	unconditional jmp
1063:    LDC  0,1(0) 	true case
1064:   PUSH  0,0(6) 	
* <- Op
* -> Op
* -> Id
1065:     LD  0,2(2) 	load id value
1066:   PUSH  0,0(6) 	store exp
* <- Id
1067:    POP  0,0(6) 	copy bytes
1068:   PUSH  0,0(3) 	PUSH bytes
* -> Id
1069:     LD  0,-2(2) 	load id value
1070:   PUSH  0,0(6) 	store exp
* <- Id
1071:    POP  1,0,6 	load adress of lhs struct
1072:    LDC  0,2,0 	load offset of member
1073:    ADD  0,0,1 	compute the real adress if pointK
1074:   PUSH  0,0(6) 	
1075:    POP  0,0(6) 	load adress from mp
1076:     LD  1,0(0) 	copy bytes
1077:   PUSH  1,0(6) 	push a.x value into tmp
1078:    POP  0,0(6) 	copy bytes
1079:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* match
* -> Id
1080:     LD  0,1(2) 	load id value
1081:   PUSH  0,0(6) 	store exp
* <- Id
1082:    POP  1,0,6 	load adress of lhs struct
1083:    LDC  0,5,0 	load offset of member
1084:    ADD  0,0,1 	compute the real adress if pointK
1085:   PUSH  0,0(6) 	
1086:    POP  0,0(6) 	load adress from mp
1087:     LD  1,0(0) 	copy bytes
1088:   PUSH  1,0(6) 	push a.x value into tmp
1089:    LDC  0,1091(0) 	store the return adress
1090:    POP  7,0(6) 	ujp to the function body
1091:    LDA  3,2(3) 	pop parameters
* -> Const
1092:    LDC  0,0(0) 	load integer const
1093:   PUSH  0,0(6) 	store exp
* <- Const
1094:    POP  1,0(6) 	pop right
1095:    POP  0,0(6) 	pop left
1096:    SUB  0,0,1 	op ==, convertd_type
1097:    JNE  0,2(7) 	br if true
1098:    LDC  0,0(0) 	false case
1099:    LDA  7,1(7) 	unconditional jmp
1100:    LDC  0,1(0) 	true case
1101:   PUSH  0,0(6) 	
* <- Op
1102:    POP  1,0(6) 	pop right
1103:    POP  0,0(6) 	pop left
1104:    JEQ  0,3(7) 	br if false
1105:    JEQ  1,2(7) 	br if false
1106:    LDC  0,1(0) 	true case
1107:    LDA  7,1(7) 	unconditional jmp
1108:    LDC  0,0(0) 	false case
1109:   PUSH  0,0(6) 	
* <- Op
1110:    POP  0,0(6) 	pop from the mp
1111:    JNE  0,1,7 	true case:, skip the break, execute the block code
1112:     GO  21,0,0 	go to label
* -> assign
* -> Id
1113:     LD  0,-2(2) 	load id value
1114:   PUSH  0,0(6) 	store exp
* <- Id
1115:    POP  1,0,6 	load adress of lhs struct
1116:    LDC  0,1,0 	load offset of member
1117:    ADD  0,0,1 	compute the real adress if pointK
1118:   PUSH  0,0(6) 	
1119:    POP  0,0(6) 	load adress from mp
1120:     LD  1,0(0) 	copy bytes
1121:   PUSH  1,0(6) 	push a.x value into tmp
1122:    LDA  1,-2(2) 	move the adress of ID
1123:    POP  0,0(6) 	copy bytes
1124:     ST  0,0(1) 	copy bytes
* <- assign
1125:     GO  20,0,0 	go to label
1126:  LABEL  21,0,0 	generate label
* <- repeat
* -> if
* -> Op
* -> Id
1127:     LD  0,-2(2) 	load id value
1128:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1129:     LD  0,-2(5) 	load id value
1130:   PUSH  0,0(6) 	store exp
* <- Id
1131:    POP  1,0(6) 	pop right
1132:    POP  0,0(6) 	pop left
1133:    SUB  0,0,1 	op ==, convertd_type
1134:    JEQ  0,2(7) 	br if true
1135:    LDC  0,0(0) 	false case
1136:    LDA  7,1(7) 	unconditional jmp
1137:    LDC  0,1(0) 	true case
1138:   PUSH  0,0(6) 	
* <- Op
1139:    POP  0,0(6) 	pop from the mp
1140:    JNE  0,1,7 	true case:, execute if part
1141:     GO  22,0,0 	go to label
1142:    MOV  3,2,0 	restore the caller sp
1143:     LD  2,0(2) 	resotre the caller fp
1144:  RETURN  0,-1,3 	return to the caller
1145:     GO  23,0,0 	go to label
1146:  LABEL  22,0,0 	generate label
* if: jump to else
1147:  LABEL  23,0,0 	generate label
* <- if
1148:    LDA  3,-1(3) 	stack expand
* -> Id
1149:     LD  0,-2(2) 	load id value
1150:   PUSH  0,0(6) 	store exp
* <- Id
1151:    POP  1,0,6 	load adress of lhs struct
1152:    LDC  0,0,0 	load offset of member
1153:    ADD  0,0,1 	compute the real adress if pointK
1154:   PUSH  0,0(6) 	
1155:    POP  0,0(6) 	load adress from mp
1156:     LD  1,0(0) 	copy bytes
1157:   PUSH  1,0(6) 	push a.x value into tmp
1158:    LDA  1,-3(2) 	move the adress of ID
1159:    POP  0,0(6) 	copy bytes
1160:     ST  0,0(1) 	copy bytes
1161:    LDA  3,-1(3) 	stack expand
* -> Id
1162:     LD  0,-2(2) 	load id value
1163:   PUSH  0,0(6) 	store exp
* <- Id
1164:    POP  1,0,6 	load adress of lhs struct
1165:    LDC  0,1,0 	load offset of member
1166:    ADD  0,0,1 	compute the real adress if pointK
1167:   PUSH  0,0(6) 	
1168:    POP  0,0(6) 	load adress from mp
1169:     LD  1,0(0) 	copy bytes
1170:   PUSH  1,0(6) 	push a.x value into tmp
1171:    LDA  1,-4(2) 	move the adress of ID
1172:    POP  0,0(6) 	copy bytes
1173:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
1174:     LD  0,-4(2) 	load id value
1175:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1176:     LD  0,-3(2) 	load id value
1177:   PUSH  0,0(6) 	store exp
* <- Id
1178:    POP  1,0,6 	load adress of lhs struct
1179:    LDC  0,1,0 	load offset of member
1180:    ADD  0,0,1 	compute the real adress if pointK
1181:   PUSH  0,0(6) 	
1182:    POP  1,0(6) 	move the adress of referenced
1183:    POP  0,0(6) 	copy bytes
1184:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
1185:     LD  0,-4(2) 	load id value
1186:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1187:     LD  0,-2(5) 	load id value
1188:   PUSH  0,0(6) 	store exp
* <- Id
1189:    POP  1,0(6) 	pop right
1190:    POP  0,0(6) 	pop left
1191:    SUB  0,0,1 	op ==, convertd_type
1192:    JNE  0,2(7) 	br if true
1193:    LDC  0,0(0) 	false case
1194:    LDA  7,1(7) 	unconditional jmp
1195:    LDC  0,1(0) 	true case
1196:   PUSH  0,0(6) 	
* <- Op
1197:    POP  0,0(6) 	pop from the mp
1198:    JNE  0,1,7 	true case:, execute if part
1199:     GO  24,0,0 	go to label
* -> assign
* -> Id
1200:     LD  0,-3(2) 	load id value
1201:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1202:     LD  0,-4(2) 	load id value
1203:   PUSH  0,0(6) 	store exp
* <- Id
1204:    POP  1,0,6 	load adress of lhs struct
1205:    LDC  0,0,0 	load offset of member
1206:    ADD  0,0,1 	compute the real adress if pointK
1207:   PUSH  0,0(6) 	
1208:    POP  1,0(6) 	move the adress of referenced
1209:    POP  0,0(6) 	copy bytes
1210:     ST  0,0(1) 	copy bytes
* <- assign
1211:     GO  25,0,0 	go to label
1212:  LABEL  24,0,0 	generate label
* if: jump to else
1213:  LABEL  25,0,0 	generate label
* <- if
* -> if
* -> Op
* -> Id
1214:     LD  0,-2(2) 	load id value
1215:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1216:     LD  0,1(2) 	load id value
1217:   PUSH  0,0(6) 	store exp
* <- Id
1218:    POP  1,0,6 	load adress of lhs struct
1219:    LDC  0,1,0 	load offset of member
1220:    ADD  0,0,1 	compute the real adress if pointK
1221:   PUSH  0,0(6) 	
1222:    POP  0,0(6) 	load adress from mp
1223:     LD  1,0(0) 	copy bytes
1224:   PUSH  1,0(6) 	push a.x value into tmp
1225:    POP  1,0(6) 	pop right
1226:    POP  0,0(6) 	pop left
1227:    SUB  0,0,1 	op ==, convertd_type
1228:    JEQ  0,2(7) 	br if true
1229:    LDC  0,0(0) 	false case
1230:    LDA  7,1(7) 	unconditional jmp
1231:    LDC  0,1(0) 	true case
1232:   PUSH  0,0(6) 	
* <- Op
1233:    POP  0,0(6) 	pop from the mp
1234:    JNE  0,1,7 	true case:, execute if part
1235:     GO  26,0,0 	go to label
* -> assign
* -> Id
1236:     LD  0,-2(5) 	load id value
1237:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1238:     LD  0,1(2) 	load id value
1239:   PUSH  0,0(6) 	store exp
* <- Id
1240:    POP  1,0,6 	load adress of lhs struct
1241:    LDC  0,1,0 	load offset of member
1242:    ADD  0,0,1 	compute the real adress if pointK
1243:   PUSH  0,0(6) 	
1244:    POP  1,0(6) 	move the adress of referenced
1245:    POP  0,0(6) 	copy bytes
1246:     ST  0,0(1) 	copy bytes
* <- assign
1247:     GO  27,0,0 	go to label
1248:  LABEL  26,0,0 	generate label
* if: jump to else
1249:  LABEL  27,0,0 	generate label
* <- if
* -> Id
1250:     LD  0,-2(2) 	load id value
1251:   PUSH  0,0(6) 	store exp
* <- Id
1252:    POP  0,0(6) 	copy bytes
1253:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* free
* -> Id
1254:     LD  0,-1(5) 	load id value
1255:   PUSH  0,0(6) 	store exp
* <- Id
1256:    LDC  0,1258(0) 	store the return adress
1257:    POP  7,0(6) 	ujp to the function body
1258:    LDA  3,1(3) 	pop parameters
1259:    MOV  3,2,0 	restore the caller sp
1260:     LD  2,0(2) 	resotre the caller fp
1261:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
945:    LDA  7,316(7) 	skip the function body
* call main function
* File: pyb_example.tm
* Standard prelude:
1262:    LDC  6,65535(0) 	load mp adress
1263:     ST  0,0(0) 	clear location 0
1264:    LDC  5,4095(0) 	load gp adress from location 1
1265:     ST  0,1(0) 	clear location 1
1266:    LDC  4,2000(0) 	load gp adress from location 1
1267:    LDC  2,60000(0) 	load first fp from location 2
1268:    LDC  3,60000(0) 	load first sp from location 2
1269:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* makeNode
1270:    LDA  3,-1(3) 	stack expand
1271:    LDC  0,1274(0) 	get function adress
1272:     ST  0,-10(5) 	set function adress
1274:    MOV  1,2,0 	store the caller fp temporarily
1275:    MOV  2,3,0 	exchang the stack(context)
1276:   PUSH  1,0(3) 	push the caller fp
1277:   PUSH  0,0(3) 	push the return adress
1278:    LDA  3,-1(3) 	stack expand
* call function: 
* createListNode
* -> Id
1279:     LD  0,-3(5) 	load id value
1280:   PUSH  0,0(6) 	store exp
* <- Id
1281:    LDC  0,1283(0) 	store the return adress
1282:    POP  7,0(6) 	ujp to the function body
1283:    LDA  3,0(3) 	pop parameters
1284:    LDA  1,-2(2) 	move the adress of ID
1285:    POP  0,0(6) 	copy bytes
1286:     ST  0,0(1) 	copy bytes
* -> assign
* ->Single Op
1287:    LDC  0,1,0 	load size of exp
1288:   PUSH  0,0(6) 	
* <-Single Op
1289:    POP  0,0(6) 	copy bytes
1290:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* malloc
* -> Id
1291:     LD  0,0(5) 	load id value
1292:   PUSH  0,0(6) 	store exp
* <- Id
1293:    LDC  0,1295(0) 	store the return adress
1294:    POP  7,0(6) 	ujp to the function body
1295:    LDA  3,1(3) 	pop parameters
* -> Id
1296:     LD  0,-2(2) 	load id value
1297:   PUSH  0,0(6) 	store exp
* <- Id
1298:    POP  1,0,6 	load adress of lhs struct
1299:    LDC  0,2,0 	load offset of member
1300:    ADD  0,0,1 	compute the real adress if pointK
1301:   PUSH  0,0(6) 	
1302:    POP  1,0(6) 	move the adress of referenced
1303:    POP  0,0(6) 	copy bytes
1304:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
1305:     LD  0,1(2) 	load id value
1306:   PUSH  0,0(6) 	store exp
* <- Id
* ->Single Op
* -> Id
1307:     LD  0,-2(2) 	load id value
1308:   PUSH  0,0(6) 	store exp
* <- Id
1309:    POP  1,0,6 	load adress of lhs struct
1310:    LDC  0,2,0 	load offset of member
1311:    ADD  0,0,1 	compute the real adress if pointK
1312:   PUSH  0,0(6) 	
1313:    POP  0,0(6) 	load adress from mp
1314:     LD  1,0(0) 	copy bytes
1315:   PUSH  1,0(6) 	push a.x value into tmp
1316:    POP  0,0(6) 	pop right
1317:   PUSH  0,0(6) 	
* <-Single Op
1318:    POP  1,0(6) 	move the adress of referenced
1319:    POP  0,0(6) 	copy bytes
1320:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
1321:     LD  0,-2(2) 	load id value
1322:   PUSH  0,0(6) 	store exp
* <- Id
1323:    MOV  3,2,0 	restore the caller sp
1324:     LD  2,0(2) 	resotre the caller fp
1325:  RETURN  0,-1,3 	return to the caller
1326:    MOV  3,2,0 	restore the caller sp
1327:     LD  2,0(2) 	resotre the caller fp
1328:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1273:    LDA  7,55(7) 	skip the function body
1329:    LDA  3,-1(3) 	stack expand
* function entry:
* self__f
1330:    LDA  3,-1(3) 	stack expand
1332:    MOV  1,2,0 	store the caller fp temporarily
1333:    MOV  2,3,0 	exchang the stack(context)
1334:   PUSH  1,0(3) 	push the caller fp
1335:   PUSH  0,0(3) 	push the return adress
* -> Id
1336:     LD  0,1(2) 	load id value
1337:   PUSH  0,0(6) 	store exp
* <- Id
1338:    POP  1,0,6 	load adress of lhs struct
1339:    LDC  0,0,0 	load offset of member
1340:    ADD  0,0,1 	compute the real adress if pointK
1341:   PUSH  0,0(6) 	
1342:    POP  0,0(6) 	load adress from mp
1343:     LD  1,0(0) 	copy bytes
1344:   PUSH  1,0(6) 	push a.x value into tmp
1345:    POP  0,0(6) 	move result to register
1346:    OUT  0,0,0 	output value in register[ac / fac]
1347:    MOV  3,2,0 	restore the caller sp
1348:     LD  2,0(2) 	resotre the caller fp
1349:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1331:    LDA  7,18(7) 	skip the function body
1350:    MOV  3,2,0 	resotre stack in struct
* function entry:
* makeList
1351:    LDA  3,-1(3) 	stack expand
1352:    LDC  0,1355(0) 	get function adress
1353:     ST  0,-11(5) 	set function adress
1355:    MOV  1,2,0 	store the caller fp temporarily
1356:    MOV  2,3,0 	exchang the stack(context)
1357:   PUSH  1,0(3) 	push the caller fp
1358:   PUSH  0,0(3) 	push the return adress
* function entry:
* compare
1359:    LDA  3,-1(3) 	stack expand
1360:    LDC  0,1363(0) 	get function adress
1361:     ST  0,-2(2) 	set function adress
1363:    MOV  1,2,0 	store the caller fp temporarily
1364:    MOV  2,3,0 	exchang the stack(context)
1365:   PUSH  1,0(3) 	push the caller fp
1366:   PUSH  0,0(3) 	push the return adress
1367:    LDA  3,-1(3) 	stack expand
* ->Single Op
* ->Single Op
* -> Id
1368:     LD  0,1(2) 	load id value
1369:   PUSH  0,0(6) 	store exp
* <- Id
1370:    POP  0,0(6) 	pop right
1371:   PUSH  0,0(6) 	
* <-Single Op
1372:    POP  0,0(6) 	pop the adress
1373:     LD  1,0(0) 	load bytes
1374:   PUSH  1,0(6) 	push bytes 
* <-Single Op
1375:    LDA  1,-3(2) 	move the adress of ID
1376:    POP  0,0(6) 	copy bytes
1377:     ST  0,0(1) 	copy bytes
1378:    LDA  3,-1(3) 	stack expand
* ->Single Op
* ->Single Op
* -> Id
1379:     LD  0,2(2) 	load id value
1380:   PUSH  0,0(6) 	store exp
* <- Id
1381:    POP  0,0(6) 	pop right
1382:   PUSH  0,0(6) 	
* <-Single Op
1383:    POP  0,0(6) 	pop the adress
1384:     LD  1,0(0) 	load bytes
1385:   PUSH  1,0(6) 	push bytes 
* <-Single Op
1386:    LDA  1,-4(2) 	move the adress of ID
1387:    POP  0,0(6) 	copy bytes
1388:     ST  0,0(1) 	copy bytes
* -> if
* -> Op
* -> Id
1389:     LD  0,-3(2) 	load id value
1390:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1391:     LD  0,-4(2) 	load id value
1392:   PUSH  0,0(6) 	store exp
* <- Id
1393:    POP  1,0(6) 	pop right
1394:    POP  0,0(6) 	pop left
1395:    SUB  0,0,1 	op <
1396:    JLT  0,2(7) 	br if true
1397:    LDC  0,0(0) 	false case
1398:    LDA  7,1(7) 	unconditional jmp
1399:    LDC  0,1(0) 	true case
1400:   PUSH  0,0(6) 	
* <- Op
1401:    POP  0,0(6) 	pop from the mp
1402:    JNE  0,1,7 	true case:, execute if part
1403:     GO  28,0,0 	go to label
* ->Single Op
* -> Const
1404:    LDC  0,1(0) 	load integer const
1405:   PUSH  0,0(6) 	store exp
* <- Const
1406:    POP  0,0(6) 	pop right
1407:    NEG  0,0,0 	single op (-)
1408:   PUSH  0,0(6) 	op: load left
* <-Single Op
1409:    MOV  3,2,0 	restore the caller sp
1410:     LD  2,0(2) 	resotre the caller fp
1411:  RETURN  0,-1,3 	return to the caller
1412:     GO  29,0,0 	go to label
1413:  LABEL  28,0,0 	generate label
* if: jump to else
1414:  LABEL  29,0,0 	generate label
* <- if
* -> if
* -> Op
* -> Id
1415:     LD  0,-3(2) 	load id value
1416:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1417:     LD  0,-4(2) 	load id value
1418:   PUSH  0,0(6) 	store exp
* <- Id
1419:    POP  1,0(6) 	pop right
1420:    POP  0,0(6) 	pop left
1421:    SUB  0,0,1 	op <
1422:    JGT  0,2(7) 	br if true
1423:    LDC  0,0(0) 	false case
1424:    LDA  7,1(7) 	unconditional jmp
1425:    LDC  0,1(0) 	true case
1426:   PUSH  0,0(6) 	
* <- Op
1427:    POP  0,0(6) 	pop from the mp
1428:    JNE  0,1,7 	true case:, execute if part
1429:     GO  30,0,0 	go to label
* -> Const
1430:    LDC  0,1(0) 	load integer const
1431:   PUSH  0,0(6) 	store exp
* <- Const
1432:    MOV  3,2,0 	restore the caller sp
1433:     LD  2,0(2) 	resotre the caller fp
1434:  RETURN  0,-1,3 	return to the caller
1435:     GO  31,0,0 	go to label
1436:  LABEL  30,0,0 	generate label
* if: jump to else
1437:  LABEL  31,0,0 	generate label
* <- if
* -> Const
1438:    LDC  0,0(0) 	load integer const
1439:   PUSH  0,0(6) 	store exp
* <- Const
1440:    MOV  3,2,0 	restore the caller sp
1441:     LD  2,0(2) 	resotre the caller fp
1442:  RETURN  0,-1,3 	return to the caller
1443:    MOV  3,2,0 	restore the caller sp
1444:     LD  2,0(2) 	resotre the caller fp
1445:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1362:    LDA  7,83(7) 	skip the function body
1446:    LDA  3,-6(3) 	stack expand
1447:    LDC  1,61(0) 	get function adress from struct
1448:     ST  1,4(3) 	Init Struct Instance
1449:    LDC  1,70(0) 	get function adress from struct
1450:     ST  1,5(3) 	Init Struct Instance
1451:    LDC  1,79(0) 	get function adress from struct
1452:     ST  1,6(3) 	Init Struct Instance
* call function: 
* createList
* -> Id
1453:     LD  0,-4(5) 	load id value
1454:   PUSH  0,0(6) 	store exp
* <- Id
1455:    LDC  0,1457(0) 	store the return adress
1456:    POP  7,0(6) 	ujp to the function body
1457:    LDA  3,0(3) 	pop parameters
1458:    LDA  1,-8(2) 	move the adress of ID
1459:    POP  0,0(6) 	copy bytes
1460:     ST  0,5(1) 	copy bytes
1461:    POP  0,0(6) 	copy bytes
1462:     ST  0,4(1) 	copy bytes
1463:    POP  0,0(6) 	copy bytes
1464:     ST  0,3(1) 	copy bytes
1465:    POP  0,0(6) 	copy bytes
1466:     ST  0,2(1) 	copy bytes
1467:    POP  0,0(6) 	copy bytes
1468:     ST  0,1(1) 	copy bytes
1469:    POP  0,0(6) 	copy bytes
1470:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
1471:     LD  0,-2(2) 	load id value
1472:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1473:    LDA  0,-8(2) 	load id adress
1474:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1475:    POP  1,0,6 	load adress of lhs struct
1476:    LDC  0,5,0 	load offset of member
1477:    ADD  0,0,1 	compute the real adress if pointK
1478:   PUSH  0,0(6) 	
1479:    POP  1,0(6) 	move the adress of referenced
1480:    POP  0,0(6) 	copy bytes
1481:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
1482:     LD  0,-8(2) 	load id value
1483:   PUSH  0,0(6) 	store exp
1484:     LD  0,-7(2) 	load id value
1485:   PUSH  0,0(6) 	store exp
1486:     LD  0,-6(2) 	load id value
1487:   PUSH  0,0(6) 	store exp
1488:     LD  0,-5(2) 	load id value
1489:   PUSH  0,0(6) 	store exp
1490:     LD  0,-4(2) 	load id value
1491:   PUSH  0,0(6) 	store exp
1492:     LD  0,-3(2) 	load id value
1493:   PUSH  0,0(6) 	store exp
* <- Id
1494:    MOV  3,2,0 	restore the caller sp
1495:     LD  2,0(2) 	resotre the caller fp
1496:  RETURN  0,-1,3 	return to the caller
1497:    MOV  3,2,0 	restore the caller sp
1498:     LD  2,0(2) 	resotre the caller fp
1499:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1354:    LDA  7,145(7) 	skip the function body
* function entry:
* test
1500:    LDA  3,-1(3) 	stack expand
1501:    LDC  0,1504(0) 	get function adress
1502:     ST  0,-12(5) 	set function adress
1504:    MOV  1,2,0 	store the caller fp temporarily
1505:    MOV  2,3,0 	exchang the stack(context)
1506:   PUSH  1,0(3) 	push the caller fp
1507:   PUSH  0,0(3) 	push the return adress
* -> Id
1508:     LD  0,1(2) 	load id value
1509:   PUSH  0,0(6) 	store exp
* <- Id
1510:    POP  0,0(6) 	move result to register
1511:    OUT  0,0,0 	output value in register[ac / fac]
* -> Id
1512:     LD  0,1(2) 	load id value
1513:   PUSH  0,0(6) 	store exp
* <- Id
1514:    POP  1,0,6 	load adress of lhs struct
1515:    LDC  0,0,0 	load offset of member
1516:    ADD  0,0,1 	compute the real adress if pointK
1517:   PUSH  0,0(6) 	
1518:    POP  0,0(6) 	load adress from mp
1519:     LD  1,0(0) 	copy bytes
1520:   PUSH  1,0(6) 	push a.x value into tmp
1521:    POP  0,0(6) 	move result to register
1522:    OUT  0,0,0 	output value in register[ac / fac]
1523:    MOV  3,2,0 	restore the caller sp
1524:     LD  2,0(2) 	resotre the caller fp
1525:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1503:    LDA  7,22(7) 	skip the function body
* function entry:
* example
1526:    LDA  3,-1(3) 	stack expand
1527:    LDC  0,1530(0) 	get function adress
1528:     ST  0,-13(5) 	set function adress
1530:    MOV  1,2,0 	store the caller fp temporarily
1531:    MOV  2,3,0 	exchang the stack(context)
1532:   PUSH  1,0(3) 	push the caller fp
1533:   PUSH  0,0(3) 	push the return adress
* function entry:
* opera
1534:    LDA  3,-1(3) 	stack expand
1535:    LDC  0,1538(0) 	get function adress
1536:     ST  0,-2(2) 	set function adress
1538:    MOV  1,2,0 	store the caller fp temporarily
1539:    MOV  2,3,0 	exchang the stack(context)
1540:   PUSH  1,0(3) 	push the caller fp
1541:   PUSH  0,0(3) 	push the return adress
1542:    MOV  3,2,0 	restore the caller sp
1543:     LD  2,0(2) 	resotre the caller fp
1544:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1537:    LDA  7,7(7) 	skip the function body
* -> assign
* -> Id
1545:     LD  0,-5(5) 	load id value
1546:   PUSH  0,0(6) 	store exp
* <- Id
1547:    LDA  1,-2(2) 	move the adress of ID
1548:    POP  0,0(6) 	copy bytes
1549:     ST  0,0(1) 	copy bytes
* <- assign
1550:    LDA  3,-6(3) 	stack expand
1551:    LDC  1,61(0) 	get function adress from struct
1552:     ST  1,4(3) 	Init Struct Instance
1553:    LDC  1,70(0) 	get function adress from struct
1554:     ST  1,5(3) 	Init Struct Instance
1555:    LDC  1,79(0) 	get function adress from struct
1556:     ST  1,6(3) 	Init Struct Instance
* call function: 
* makeList
* -> Id
1557:     LD  0,-11(5) 	load id value
1558:   PUSH  0,0(6) 	store exp
* <- Id
1559:    LDC  0,1561(0) 	store the return adress
1560:    POP  7,0(6) 	ujp to the function body
1561:    LDA  3,0(3) 	pop parameters
1562:    LDA  1,-8(2) 	move the adress of ID
1563:    POP  0,0(6) 	copy bytes
1564:     ST  0,5(1) 	copy bytes
1565:    POP  0,0(6) 	copy bytes
1566:     ST  0,4(1) 	copy bytes
1567:    POP  0,0(6) 	copy bytes
1568:     ST  0,3(1) 	copy bytes
1569:    POP  0,0(6) 	copy bytes
1570:     ST  0,2(1) 	copy bytes
1571:    POP  0,0(6) 	copy bytes
1572:     ST  0,1(1) 	copy bytes
1573:    POP  0,0(6) 	copy bytes
1574:     ST  0,0(1) 	copy bytes
* -> Const
1575:    LDC  0,1(0) 	load integer const
1576:   PUSH  0,0(6) 	store exp
* <- Const
1577:    POP  0,0(6) 	copy bytes
1578:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* makeNode
* -> Id
1579:     LD  0,-10(5) 	load id value
1580:   PUSH  0,0(6) 	store exp
* <- Id
1581:    LDC  0,1583(0) 	store the return adress
1582:    POP  7,0(6) 	ujp to the function body
1583:    LDA  3,1(3) 	pop parameters
1584:    POP  0,0(6) 	copy bytes
1585:   PUSH  0,0(3) 	PUSH bytes
* ->Single Op
* -> Id
1586:    LDA  0,-8(2) 	load id adress
1587:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* <-Single Op
1588:    POP  0,0(6) 	copy bytes
1589:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* opera
* -> Id
1590:     LD  0,-2(2) 	load id value
1591:   PUSH  0,0(6) 	store exp
* <- Id
1592:    LDC  0,1594(0) 	store the return adress
1593:    POP  7,0(6) 	ujp to the function body
1594:    LDA  3,2(3) 	pop parameters
* ->Single Op
* -> Const
1595:    LDC  0,1(0) 	load integer const
1596:   PUSH  0,0(6) 	store exp
* <- Const
1597:    POP  0,0(6) 	pop right
1598:    NEG  0,0,0 	single op (-)
1599:   PUSH  0,0(6) 	op: load left
* <-Single Op
1600:    POP  0,0(6) 	copy bytes
1601:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* makeNode
* -> Id
1602:     LD  0,-10(5) 	load id value
1603:   PUSH  0,0(6) 	store exp
* <- Id
1604:    LDC  0,1606(0) 	store the return adress
1605:    POP  7,0(6) 	ujp to the function body
1606:    LDA  3,1(3) 	pop parameters
1607:    POP  0,0(6) 	copy bytes
1608:   PUSH  0,0(3) 	PUSH bytes
* ->Single Op
* -> Id
1609:    LDA  0,-8(2) 	load id adress
1610:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* <-Single Op
1611:    POP  0,0(6) 	copy bytes
1612:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* opera
* -> Id
1613:     LD  0,-2(2) 	load id value
1614:   PUSH  0,0(6) 	store exp
* <- Id
1615:    LDC  0,1617(0) 	store the return adress
1616:    POP  7,0(6) 	ujp to the function body
1617:    LDA  3,2(3) 	pop parameters
* ->Single Op
* -> Const
1618:    LDC  0,20(0) 	load integer const
1619:   PUSH  0,0(6) 	store exp
* <- Const
1620:    POP  0,0(6) 	pop right
1621:    NEG  0,0,0 	single op (-)
1622:   PUSH  0,0(6) 	op: load left
* <-Single Op
1623:    POP  0,0(6) 	copy bytes
1624:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* makeNode
* -> Id
1625:     LD  0,-10(5) 	load id value
1626:   PUSH  0,0(6) 	store exp
* <- Id
1627:    LDC  0,1629(0) 	store the return adress
1628:    POP  7,0(6) 	ujp to the function body
1629:    LDA  3,1(3) 	pop parameters
1630:    POP  0,0(6) 	copy bytes
1631:   PUSH  0,0(3) 	PUSH bytes
* ->Single Op
* -> Id
1632:    LDA  0,-8(2) 	load id adress
1633:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* <-Single Op
1634:    POP  0,0(6) 	copy bytes
1635:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* opera
* -> Id
1636:     LD  0,-2(2) 	load id value
1637:   PUSH  0,0(6) 	store exp
* <- Id
1638:    LDC  0,1640(0) 	store the return adress
1639:    POP  7,0(6) 	ujp to the function body
1640:    LDA  3,2(3) 	pop parameters
* -> Const
1641:    LDC  0,100(0) 	load integer const
1642:   PUSH  0,0(6) 	store exp
* <- Const
1643:    POP  0,0(6) 	copy bytes
1644:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* makeNode
* -> Id
1645:     LD  0,-10(5) 	load id value
1646:   PUSH  0,0(6) 	store exp
* <- Id
1647:    LDC  0,1649(0) 	store the return adress
1648:    POP  7,0(6) 	ujp to the function body
1649:    LDA  3,1(3) 	pop parameters
1650:    POP  0,0(6) 	copy bytes
1651:   PUSH  0,0(3) 	PUSH bytes
* ->Single Op
* -> Id
1652:    LDA  0,-8(2) 	load id adress
1653:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* <-Single Op
1654:    POP  0,0(6) 	copy bytes
1655:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* opera
* -> Id
1656:     LD  0,-2(2) 	load id value
1657:   PUSH  0,0(6) 	store exp
* <- Id
1658:    LDC  0,1660(0) 	store the return adress
1659:    POP  7,0(6) 	ujp to the function body
1660:    LDA  3,2(3) 	pop parameters
1661:    LDA  3,-1(3) 	stack expand
* -> Id
1662:    LDA  0,-8(2) 	load id adress
1663:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1664:    POP  1,0,6 	load adress of lhs struct
1665:    LDC  0,0,0 	load offset of member
1666:    ADD  0,0,1 	compute the real adress if pointK
1667:   PUSH  0,0(6) 	
1668:    POP  0,0(6) 	load adress from mp
1669:     LD  1,0(0) 	copy bytes
1670:   PUSH  1,0(6) 	push a.x value into tmp
1671:    POP  1,0,6 	load adress of lhs struct
1672:    LDC  0,1,0 	load offset of member
1673:    ADD  0,0,1 	compute the real adress if pointK
1674:   PUSH  0,0(6) 	
1675:    POP  0,0(6) 	load adress from mp
1676:     LD  1,0(0) 	copy bytes
1677:   PUSH  1,0(6) 	push a.x value into tmp
1678:    LDA  1,-9(2) 	move the adress of ID
1679:    POP  0,0(6) 	copy bytes
1680:     ST  0,0(1) 	copy bytes
* -> repeat
* while stmt:
1681:  LABEL  32,0,0 	generate label
* -> Op
* -> Id
1682:     LD  0,-9(2) 	load id value
1683:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
1684:     LD  0,-2(5) 	load id value
1685:   PUSH  0,0(6) 	store exp
* <- Id
1686:    POP  1,0(6) 	pop right
1687:    POP  0,0(6) 	pop left
1688:    SUB  0,0,1 	op ==, convertd_type
1689:    JNE  0,2(7) 	br if true
1690:    LDC  0,0(0) 	false case
1691:    LDA  7,1(7) 	unconditional jmp
1692:    LDC  0,1(0) 	true case
1693:   PUSH  0,0(6) 	
* <- Op
1694:    POP  0,0(6) 	pop from the mp
1695:    JNE  0,1,7 	true case:, skip the break, execute the block code
1696:     GO  33,0,0 	go to label
* ->Single Op
* -> Id
1697:     LD  0,-9(2) 	load id value
1698:   PUSH  0,0(6) 	store exp
* <- Id
1699:    POP  1,0,6 	load adress of lhs struct
1700:    LDC  0,2,0 	load offset of member
1701:    ADD  0,0,1 	compute the real adress if pointK
1702:   PUSH  0,0(6) 	
1703:    POP  0,0(6) 	load adress from mp
1704:     LD  1,0(0) 	copy bytes
1705:   PUSH  1,0(6) 	push a.x value into tmp
1706:    POP  0,0(6) 	pop the adress
1707:     LD  1,0(0) 	load bytes
1708:   PUSH  1,0(6) 	push bytes 
* <-Single Op
1709:    POP  0,0(6) 	move result to register
1710:    OUT  0,0,0 	output value in register[ac / fac]
* -> assign
* -> Id
1711:     LD  0,-9(2) 	load id value
1712:   PUSH  0,0(6) 	store exp
* <- Id
1713:    POP  1,0,6 	load adress of lhs struct
1714:    LDC  0,1,0 	load offset of member
1715:    ADD  0,0,1 	compute the real adress if pointK
1716:   PUSH  0,0(6) 	
1717:    POP  0,0(6) 	load adress from mp
1718:     LD  1,0(0) 	copy bytes
1719:   PUSH  1,0(6) 	push a.x value into tmp
1720:    LDA  1,-9(2) 	move the adress of ID
1721:    POP  0,0(6) 	copy bytes
1722:     ST  0,0(1) 	copy bytes
* -> Id
1723:     LD  0,-9(2) 	load id value
1724:   PUSH  0,0(6) 	store exp
* <- Id
* <- assign
1725:     GO  32,0,0 	go to label
1726:  LABEL  33,0,0 	generate label
* <- repeat
* ->Single Op
* -> Id
1727:    LDA  0,-8(2) 	load id adress
1728:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1729:    POP  1,0,6 	load adress of lhs struct
1730:    LDC  0,0,0 	load offset of member
1731:    ADD  0,0,1 	compute the real adress if pointK
1732:   PUSH  0,0(6) 	
1733:    POP  0,0(6) 	load adress from mp
1734:     LD  1,0(0) 	copy bytes
1735:   PUSH  1,0(6) 	push a.x value into tmp
1736:    POP  1,0,6 	load adress of lhs struct
1737:    LDC  0,1,0 	load offset of member
1738:    ADD  0,0,1 	compute the real adress if pointK
1739:   PUSH  0,0(6) 	
1740:    POP  0,0(6) 	load adress from mp
1741:     LD  1,0(0) 	copy bytes
1742:   PUSH  1,0(6) 	push a.x value into tmp
1743:    POP  1,0,6 	load adress of lhs struct
1744:    LDC  0,2,0 	load offset of member
1745:    ADD  0,0,1 	compute the real adress if pointK
1746:   PUSH  0,0(6) 	
1747:    POP  0,0(6) 	load adress from mp
1748:     LD  1,0(0) 	copy bytes
1749:   PUSH  1,0(6) 	push a.x value into tmp
1750:    POP  0,0(6) 	pop the adress
1751:     LD  1,0(0) 	load bytes
1752:   PUSH  1,0(6) 	push bytes 
* <-Single Op
1753:    POP  0,0(6) 	move result to register
1754:    OUT  0,0,0 	output value in register[ac / fac]
* ->Single Op
* -> Id
1755:    LDA  0,-8(2) 	load id adress
1756:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1757:    POP  1,0,6 	load adress of lhs struct
1758:    LDC  0,1,0 	load offset of member
1759:    ADD  0,0,1 	compute the real adress if pointK
1760:   PUSH  0,0(6) 	
1761:    POP  0,0(6) 	load adress from mp
1762:     LD  1,0(0) 	copy bytes
1763:   PUSH  1,0(6) 	push a.x value into tmp
1764:    POP  1,0,6 	load adress of lhs struct
1765:    LDC  0,2,0 	load offset of member
1766:    ADD  0,0,1 	compute the real adress if pointK
1767:   PUSH  0,0(6) 	
1768:    POP  0,0(6) 	load adress from mp
1769:     LD  1,0(0) 	copy bytes
1770:   PUSH  1,0(6) 	push a.x value into tmp
1771:    POP  0,0(6) 	pop the adress
1772:     LD  1,0(0) 	load bytes
1773:   PUSH  1,0(6) 	push bytes 
* <-Single Op
1774:    POP  0,0(6) 	move result to register
1775:    OUT  0,0,0 	output value in register[ac / fac]
1776:    MOV  3,2,0 	restore the caller sp
1777:     LD  2,0(2) 	resotre the caller fp
1778:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1529:    LDA  7,249(7) 	skip the function body
* function entry:
* main
1779:    LDA  3,-1(3) 	stack expand
1780:    LDC  0,1783(0) 	get function adress
1781:     ST  0,-14(5) 	set function adress
1783:    MOV  1,2,0 	store the caller fp temporarily
1784:    MOV  2,3,0 	exchang the stack(context)
1785:   PUSH  1,0(3) 	push the caller fp
1786:   PUSH  0,0(3) 	push the return adress
1787:    LDA  3,-2(3) 	stack expand
1788:    LDC  1,1332(0) 	get function adress from struct
1789:     ST  1,2(3) 	Init Struct Instance
* -> assign
* -> Const
1790:    LDC  0,100(0) 	load integer const
1791:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
1792:    LDA  0,-3(2) 	load id adress
1793:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1794:    POP  1,0,6 	load adress of lhs struct
1795:    LDC  0,0,0 	load offset of member
1796:    ADD  0,0,1 	compute the real adress if pointK
1797:   PUSH  0,0(6) 	
1798:    POP  1,0(6) 	move the adress of referenced
1799:    POP  0,0(6) 	copy bytes
1800:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
1801:    LDA  0,-3(2) 	load id adress
1802:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1803:    POP  0,0(6) 	
1804:   PUSH  0,0(3) 	
* call function: 
* self__f
* -> Id
1805:    LDA  0,-3(2) 	load id adress
1806:   PUSH  0,0(6) 	push array adress to mp
* <- Id
1807:    POP  1,0,6 	load adress of lhs struct
1808:    LDC  0,1,0 	load offset of member
1809:    ADD  0,0,1 	compute the real adress if pointK
1810:   PUSH  0,0(6) 	
1811:    POP  0,0(6) 	load adress from mp
1812:     LD  1,0(0) 	copy bytes
1813:   PUSH  1,0(6) 	push a.x value into tmp
1814:    LDC  0,1816(0) 	store the return adress
1815:    POP  7,0(6) 	ujp to the function body
1816:    LDA  3,0(3) 	pop parameters
1817:    MOV  3,2,0 	restore the caller sp
1818:     LD  2,0(2) 	resotre the caller fp
1819:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
1782:    LDA  7,37(7) 	skip the function body
* call main function
1820:     LD  1,-14(5) 	get main function adress
1821:    LDC  0,1823(0) 	store the return adress
1822:    LDA  7,0(1) 	ujp to the function body
1823:   HALT  0,0,0 	
