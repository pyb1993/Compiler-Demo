* File: list.tm
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
  8:    LDC  0,11(0) 	get function adress
  9:     ST  0,0(5) 	set function adress
 11:    MOV  1,2,0 	store the caller fp temporarily
 12:    MOV  2,3,0 	exchang the stack(context)
 13:   PUSH  1,0(3) 	push the caller fp
 14:   PUSH  0,0(3) 	push the return adress
* -> Id
 15:     LD  0,1(2) 	load id value
 16:   PUSH  0,0(6) 	store exp
* <- Id
 17:    POP  0,0(6) 	get malloc parameters
 18:  MALLOC  0,0(0) 	system call for malloc
 19:    MOV  3,2,0 	restore the caller sp
 20:     LD  2,0(2) 	resotre the caller fp
 21:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 10:    LDA  7,11(7) 	skip the function body
* function entry:
* free
 22:    LDC  0,25(0) 	get function adress
 23:     ST  0,-1(5) 	set function adress
 25:    MOV  1,2,0 	store the caller fp temporarily
 26:    MOV  2,3,0 	exchang the stack(context)
 27:   PUSH  1,0(3) 	push the caller fp
 28:   PUSH  0,0(3) 	push the return adress
* -> Id
 29:     LD  0,1(2) 	load id value
 30:   PUSH  0,0(6) 	store exp
* <- Id
 31:    POP  0,0(6) 	get free parameters
 32:  FREE  0,0(0) 	system call for free
 33:    MOV  3,2,0 	restore the caller sp
 34:     LD  2,0(2) 	resotre the caller fp
 35:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 24:    LDA  7,11(7) 	skip the function body
* call main function
* File: list.tm
* Standard prelude:
 36:    LDC  6,65535(0) 	load mp adress
 37:     ST  0,0(0) 	clear location 0
 38:    LDC  5,4095(0) 	load gp adress from location 1
 39:     ST  0,1(0) 	clear location 1
 40:    LDC  4,2000(0) 	load gp adress from location 1
 41:    LDC  2,60000(0) 	load first fp from location 2
 42:    LDC  3,60000(0) 	load first sp from location 2
 43:     ST  0,2(0) 	clear location 2
* End of standard prelude.
 44:    LDA  3,-1(3) 	stack expand
* -> Const
 45:    LDC  0,0(0) 	load integer const
 46:   PUSH  0,0(6) 	store exp
* <- Const
 47:    LDA  1,-2(5) 	move the adress of ID
 48:    POP  0,0(6) 	copy bytes
 49:     ST  0,0(1) 	copy bytes
 50:    LDA  3,-1(3) 	stack expand
 51:    LDA  3,-1(3) 	stack expand
 52:    LDA  3,-1(3) 	stack expand
 53:    MOV  3,2,0 	resotre stack in struct
 54:    LDA  3,-1(3) 	stack expand
 55:    LDA  3,-1(3) 	stack expand
 56:    LDA  3,-1(3) 	stack expand
* function entry:
* dup
 58:    MOV  1,2,0 	store the caller fp temporarily
 59:    MOV  2,3,0 	exchang the stack(context)
 60:   PUSH  1,0(3) 	push the caller fp
 61:   PUSH  0,0(3) 	push the return adress
 62:    MOV  3,2,0 	restore the caller sp
 63:     LD  2,0(2) 	resotre the caller fp
 64:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 57:    LDA  7,7(7) 	skip the function body
* function entry:
* free
 66:    MOV  1,2,0 	store the caller fp temporarily
 67:    MOV  2,3,0 	exchang the stack(context)
 68:   PUSH  1,0(3) 	push the caller fp
 69:   PUSH  0,0(3) 	push the return adress
 70:    MOV  3,2,0 	restore the caller sp
 71:     LD  2,0(2) 	resotre the caller fp
 72:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 65:    LDA  7,7(7) 	skip the function body
* function entry:
* match
 74:    MOV  1,2,0 	store the caller fp temporarily
 75:    MOV  2,3,0 	exchang the stack(context)
 76:   PUSH  1,0(3) 	push the caller fp
 77:   PUSH  0,0(3) 	push the return adress
 78:    MOV  3,2,0 	restore the caller sp
 79:     LD  2,0(2) 	resotre the caller fp
 80:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 73:    LDA  7,7(7) 	skip the function body
 81:    MOV  3,2,0 	resotre stack in struct
* function entry:
* createListNode
 82:    LDC  0,85(0) 	get function adress
 83:     ST  0,-3(5) 	set function adress
 85:    MOV  1,2,0 	store the caller fp temporarily
 86:    MOV  2,3,0 	exchang the stack(context)
 87:   PUSH  1,0(3) 	push the caller fp
 88:   PUSH  0,0(3) 	push the return adress
 89:    LDA  3,-1(3) 	stack expand
* ->Single Op
 90:    LDC  0,3,0 	load size of exp
 91:   PUSH  0,0(6) 	
* <-Single Op
 92:    POP  0,0(6) 	copy bytes
 93:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* malloc
* -> Id
 94:     LD  0,0(5) 	load id value
 95:   PUSH  0,0(6) 	store exp
* <- Id
 96:    LDC  0,98(0) 	store the return adress
 97:    POP  7,0(6) 	ujp to the function body
 98:    LDA  3,1(3) 	pop parameters
 99:    LDA  1,-2(2) 	move the adress of ID
100:    POP  0,0(6) 	copy bytes
101:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
102:     LD  0,-2(5) 	load id value
103:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
104:     LD  0,-2(2) 	load id value
105:   PUSH  0,0(6) 	store exp
* <- Id
106:    POP  1,0,6 	load adress of lhs struct
107:    LDC  0,0,0 	load offset of member
108:    ADD  0,0,1 	compute the real adress if pointK
109:   PUSH  0,0(6) 	
110:    POP  1,0(6) 	move the adress of referenced
111:    POP  0,0(6) 	copy bytes
112:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
113:     LD  0,-2(5) 	load id value
114:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
115:     LD  0,-2(2) 	load id value
116:   PUSH  0,0(6) 	store exp
* <- Id
117:    POP  1,0,6 	load adress of lhs struct
118:    LDC  0,1,0 	load offset of member
119:    ADD  0,0,1 	compute the real adress if pointK
120:   PUSH  0,0(6) 	
121:    POP  1,0(6) 	move the adress of referenced
122:    POP  0,0(6) 	copy bytes
123:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
124:     LD  0,-2(5) 	load id value
125:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
126:     LD  0,-2(2) 	load id value
127:   PUSH  0,0(6) 	store exp
* <- Id
128:    POP  1,0,6 	load adress of lhs struct
129:    LDC  0,2,0 	load offset of member
130:    ADD  0,0,1 	compute the real adress if pointK
131:   PUSH  0,0(6) 	
132:    POP  1,0(6) 	move the adress of referenced
133:    POP  0,0(6) 	copy bytes
134:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
135:     LD  0,-2(2) 	load id value
136:   PUSH  0,0(6) 	store exp
* <- Id
137:    MOV  3,2,0 	restore the caller sp
138:     LD  2,0(2) 	resotre the caller fp
139:  RETURN  0,-1,3 	return to the caller
140:    MOV  3,2,0 	restore the caller sp
141:     LD  2,0(2) 	resotre the caller fp
142:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 84:    LDA  7,58(7) 	skip the function body
* function entry:
* createList
143:    LDC  0,146(0) 	get function adress
144:     ST  0,-4(5) 	set function adress
146:    MOV  1,2,0 	store the caller fp temporarily
147:    MOV  2,3,0 	exchang the stack(context)
148:   PUSH  1,0(3) 	push the caller fp
149:   PUSH  0,0(3) 	push the return adress
150:    LDA  3,-6(3) 	stack expand
151:    LDC  1,58(0) 	get function adress from struct
152:     ST  1,4(3) 	Init Struct Instance
153:    LDC  1,66(0) 	get function adress from struct
154:     ST  1,5(3) 	Init Struct Instance
155:    LDC  1,74(0) 	get function adress from struct
156:     ST  1,6(3) 	Init Struct Instance
157:    LDA  3,-1(3) 	stack expand
* -> Const
158:    LDC  0,0(0) 	load integer const
159:   PUSH  0,0(6) 	store exp
* <- Const
160:    LDA  1,-8(2) 	move the adress of ID
161:    POP  0,0(6) 	copy bytes
162:     ST  0,0(1) 	copy bytes
* -> assign
* call function: 
* createListNode
* -> Id
163:     LD  0,-3(5) 	load id value
164:   PUSH  0,0(6) 	store exp
* <- Id
165:    LDC  0,167(0) 	store the return adress
166:    POP  7,0(6) 	ujp to the function body
167:    LDA  3,0(3) 	pop parameters
* -> Id
168:    LDA  0,-7(2) 	load id adress
169:   PUSH  0,0(6) 	push array adress to mp
* <- Id
170:    POP  1,0,6 	load adress of lhs struct
171:    LDC  0,0,0 	load offset of member
172:    ADD  0,0,1 	compute the real adress if pointK
173:   PUSH  0,0(6) 	
174:    POP  1,0(6) 	move the adress of referenced
175:    POP  0,0(6) 	copy bytes
176:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
177:     LD  0,-8(2) 	load id value
178:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
179:    LDA  0,-7(2) 	load id adress
180:   PUSH  0,0(6) 	push array adress to mp
* <- Id
181:    POP  1,0,6 	load adress of lhs struct
182:    LDC  0,1,0 	load offset of member
183:    ADD  0,0,1 	compute the real adress if pointK
184:   PUSH  0,0(6) 	
185:    POP  1,0(6) 	move the adress of referenced
186:    POP  0,0(6) 	copy bytes
187:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Const
188:    LDC  0,0(0) 	load integer const
189:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
190:    LDA  0,-7(2) 	load id adress
191:   PUSH  0,0(6) 	push array adress to mp
* <- Id
192:    POP  1,0,6 	load adress of lhs struct
193:    LDC  0,2,0 	load offset of member
194:    ADD  0,0,1 	compute the real adress if pointK
195:   PUSH  0,0(6) 	
196:    POP  1,0(6) 	move the adress of referenced
197:    POP  0,0(6) 	copy bytes
198:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
199:     LD  0,-7(2) 	load id value
200:   PUSH  0,0(6) 	store exp
201:     LD  0,-6(2) 	load id value
202:   PUSH  0,0(6) 	store exp
203:     LD  0,-5(2) 	load id value
204:   PUSH  0,0(6) 	store exp
205:     LD  0,-4(2) 	load id value
206:   PUSH  0,0(6) 	store exp
207:     LD  0,-3(2) 	load id value
208:   PUSH  0,0(6) 	store exp
209:     LD  0,-2(2) 	load id value
210:   PUSH  0,0(6) 	store exp
* <- Id
211:    MOV  3,2,0 	restore the caller sp
212:     LD  2,0(2) 	resotre the caller fp
213:  RETURN  0,-1,3 	return to the caller
214:    MOV  3,2,0 	restore the caller sp
215:     LD  2,0(2) 	resotre the caller fp
216:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
145:    LDA  7,71(7) 	skip the function body
* function entry:
* insertList
217:    LDC  0,220(0) 	get function adress
218:     ST  0,-5(5) 	set function adress
220:    MOV  1,2,0 	store the caller fp temporarily
221:    MOV  2,3,0 	exchang the stack(context)
222:   PUSH  1,0(3) 	push the caller fp
223:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
224:     LD  0,7(2) 	load id value
225:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
226:     LD  0,-2(5) 	load id value
227:   PUSH  0,0(6) 	store exp
* <- Id
* <- Op
228:    POP  0,0(6) 	pop from the mp
229:    JNE  0,1,7 	true case:, execute if part
230:     GO  0,0,0 	go to label
231:    MOV  3,2,0 	restore the caller sp
232:     LD  2,0(2) 	resotre the caller fp
233:  RETURN  0,-1,3 	return to the caller
234:     GO  1,0,0 	go to label
235:  LABEL  0,0,0 	generate label
* if: jump to else
236:  LABEL  1,0,0 	generate label
* <- if
237:    LDA  3,-1(3) 	stack expand
* -> Const
238:    LDC  0,100(0) 	load integer const
239:   PUSH  0,0(6) 	store exp
* <- Const
240:    LDA  1,-2(2) 	move the adress of ID
241:    POP  0,0(6) 	copy bytes
242:     ST  0,0(1) 	copy bytes
* -> assign
* -> Op
* -> Id
243:    LDA  0,1(2) 	load id adress
244:   PUSH  0,0(6) 	push array adress to mp
* <- Id
245:    POP  1,0,6 	load adress of lhs struct
246:    LDC  0,2,0 	load offset of member
247:    ADD  0,0,1 	compute the real adress if pointK
248:   PUSH  0,0(6) 	
249:    POP  0,0(6) 	load adress from mp
250:     LD  1,0(0) 	copy bytes
251:   PUSH  1,0(6) 	push a.x value into tmp
* -> Const
252:    LDC  0,1(0) 	load integer const
253:   PUSH  0,0(6) 	store exp
* <- Const
254:    POP  1,0(6) 	pop right
255:    POP  0,0(6) 	pop left
256:    ADD  0,0,1 	op +
257:   PUSH  0,0(6) 	op: load left
* <- Op
* -> Id
258:    LDA  0,1(2) 	load id adress
259:   PUSH  0,0(6) 	push array adress to mp
* <- Id
260:    POP  1,0,6 	load adress of lhs struct
261:    LDC  0,2,0 	load offset of member
262:    ADD  0,0,1 	compute the real adress if pointK
263:   PUSH  0,0(6) 	
264:    POP  1,0(6) 	move the adress of referenced
265:    POP  0,0(6) 	copy bytes
266:     ST  0,0(1) 	copy bytes
* <- assign
267:    LDA  3,-1(3) 	stack expand
* -> Id
268:    LDA  0,1(2) 	load id adress
269:   PUSH  0,0(6) 	push array adress to mp
* <- Id
270:    POP  1,0,6 	load adress of lhs struct
271:    LDC  0,0,0 	load offset of member
272:    ADD  0,0,1 	compute the real adress if pointK
273:   PUSH  0,0(6) 	
274:    POP  0,0(6) 	load adress from mp
275:     LD  1,0(0) 	copy bytes
276:   PUSH  1,0(6) 	push a.x value into tmp
277:    LDA  1,-3(2) 	move the adress of ID
278:    POP  0,0(6) 	copy bytes
279:     ST  0,0(1) 	copy bytes
* -> repeat
* while stmt:
280:  LABEL  2,0,0 	generate label
* -> Op
* -> Id
281:     LD  0,-2(5) 	load id value
282:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
283:     LD  0,-3(2) 	load id value
284:   PUSH  0,0(6) 	store exp
* <- Id
285:    POP  1,0,6 	load adress of lhs struct
286:    LDC  0,1,0 	load offset of member
287:    ADD  0,0,1 	compute the real adress if pointK
288:   PUSH  0,0(6) 	
289:    POP  0,0(6) 	load adress from mp
290:     LD  1,0(0) 	copy bytes
291:   PUSH  1,0(6) 	push a.x value into tmp
* <- Op
292:    POP  0,0(6) 	pop from the mp
293:    JNE  0,1,7 	true case:, skip the break, execute the block code
294:     GO  3,0,0 	go to label
* -> if
* -> Op
* -> Id
295:     LD  0,7(2) 	load id value
296:   PUSH  0,0(6) 	store exp
* <- Id
297:    POP  0,0(6) 	copy bytes
298:   PUSH  0,0(3) 	PUSH bytes
* -> Id
299:     LD  0,-3(2) 	load id value
300:   PUSH  0,0(6) 	store exp
* <- Id
301:    POP  0,0(6) 	copy bytes
302:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* match
* -> Id
303:    LDA  0,1(2) 	load id adress
304:   PUSH  0,0(6) 	push array adress to mp
* <- Id
305:    POP  1,0,6 	load adress of lhs struct
306:    LDC  0,5,0 	load offset of member
307:    ADD  0,0,1 	compute the real adress if pointK
308:   PUSH  0,0(6) 	
309:    POP  0,0(6) 	load adress from mp
310:     LD  1,0(0) 	copy bytes
311:   PUSH  1,0(6) 	push a.x value into tmp
312:    LDC  0,314(0) 	store the return adress
313:    POP  7,0(6) 	ujp to the function body
314:    LDA  3,2(3) 	pop parameters
* -> Const
315:    LDC  0,0(0) 	load integer const
316:   PUSH  0,0(6) 	store exp
* <- Const
317:    POP  1,0(6) 	pop right
318:    POP  0,0(6) 	pop left
319:    SUB  0,0,1 	op <
320:    JGE  0,2(7) 	br if true
321:    LDC  0,0(0) 	false case
322:    LDA  7,1(7) 	unconditional jmp
323:    LDC  0,1(0) 	true case
324:   PUSH  0,0(6) 	op: load left
* <- Op
325:    POP  0,0(6) 	pop from the mp
326:    JNE  0,1,7 	true case:, execute if part
327:     GO  4,0,0 	go to label
328:     GO  3,0,0 	go to label
329:     GO  5,0,0 	go to label
330:  LABEL  4,0,0 	generate label
* if: jump to else
331:  LABEL  5,0,0 	generate label
* <- if
* ->Single Op
* -> Id
332:     LD  0,-3(2) 	load id value
333:   PUSH  0,0(6) 	store exp
* <- Id
334:    POP  0,0(6) 	pop right
* -> Id
335:     LD  0,-3(2) 	load id value
336:   PUSH  0,0(6) 	store exp
* <- Id
* -> Op
* -> Id
337:     LD  0,-3(2) 	load id value
338:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
339:    LDC  0,1(0) 	load integer const
340:   PUSH  0,0(6) 	store exp
* <- Const
341:    POP  0,0(6) 	load index value to ac
342:    LDC  1,3,0 	load pointkind size
343:    MUL  0,1,0 	compute the offset
344:    POP  1,0(6) 	load lhs adress to ac1
345:    ADD  0,1,0 	compute the real index adress
346:   PUSH  0,0(6) 	op: load left
* <- Op
347:    LDA  1,-3(2) 	move the adress of ID
348:    POP  0,0(6) 	copy bytes
349:     ST  0,0(1) 	copy bytes
* <-Single Op
350:     GO  2,0,0 	go to label
351:  LABEL  3,0,0 	generate label
* <- repeat
352:    LDA  3,-1(3) 	stack expand
* -> Id
353:     LD  0,-3(2) 	load id value
354:   PUSH  0,0(6) 	store exp
* <- Id
355:    POP  1,0,6 	load adress of lhs struct
356:    LDC  0,1,0 	load offset of member
357:    ADD  0,0,1 	compute the real adress if pointK
358:   PUSH  0,0(6) 	
359:    POP  0,0(6) 	load adress from mp
360:     LD  1,0(0) 	copy bytes
361:   PUSH  1,0(6) 	push a.x value into tmp
362:    LDA  1,-4(2) 	move the adress of ID
363:    POP  0,0(6) 	copy bytes
364:     ST  0,0(1) 	copy bytes
* -> assign
* -> Id
365:     LD  0,7(2) 	load id value
366:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
367:     LD  0,-3(2) 	load id value
368:   PUSH  0,0(6) 	store exp
* <- Id
369:    POP  1,0,6 	load adress of lhs struct
370:    LDC  0,1,0 	load offset of member
371:    ADD  0,0,1 	compute the real adress if pointK
372:   PUSH  0,0(6) 	
373:    POP  1,0(6) 	move the adress of referenced
374:    POP  0,0(6) 	copy bytes
375:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
376:     LD  0,-4(2) 	load id value
377:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
378:     LD  0,7(2) 	load id value
379:   PUSH  0,0(6) 	store exp
* <- Id
380:    POP  1,0,6 	load adress of lhs struct
381:    LDC  0,1,0 	load offset of member
382:    ADD  0,0,1 	compute the real adress if pointK
383:   PUSH  0,0(6) 	
384:    POP  1,0(6) 	move the adress of referenced
385:    POP  0,0(6) 	copy bytes
386:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Id
387:     LD  0,-3(2) 	load id value
388:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
389:     LD  0,7(2) 	load id value
390:   PUSH  0,0(6) 	store exp
* <- Id
391:    POP  1,0,6 	load adress of lhs struct
392:    LDC  0,0,0 	load offset of member
393:    ADD  0,0,1 	compute the real adress if pointK
394:   PUSH  0,0(6) 	
395:    POP  1,0(6) 	move the adress of referenced
396:    POP  0,0(6) 	copy bytes
397:     ST  0,0(1) 	copy bytes
* <- assign
* -> if
* -> Op
* -> Id
398:     LD  0,-4(2) 	load id value
399:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
400:     LD  0,-2(5) 	load id value
401:   PUSH  0,0(6) 	store exp
* <- Id
* <- Op
402:    POP  0,0(6) 	pop from the mp
403:    JNE  0,1,7 	true case:, execute if part
404:     GO  6,0,0 	go to label
* -> assign
* -> Id
405:     LD  0,7(2) 	load id value
406:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
407:     LD  0,-4(2) 	load id value
408:   PUSH  0,0(6) 	store exp
* <- Id
409:    POP  1,0,6 	load adress of lhs struct
410:    LDC  0,0,0 	load offset of member
411:    ADD  0,0,1 	compute the real adress if pointK
412:   PUSH  0,0(6) 	
413:    POP  1,0(6) 	move the adress of referenced
414:    POP  0,0(6) 	copy bytes
415:     ST  0,0(1) 	copy bytes
* <- assign
416:     GO  7,0,0 	go to label
417:  LABEL  6,0,0 	generate label
* if: jump to else
* -> assign
* -> Id
418:     LD  0,7(2) 	load id value
419:   PUSH  0,0(6) 	store exp
* <- Id
* -> Id
420:    LDA  0,1(2) 	load id adress
421:   PUSH  0,0(6) 	push array adress to mp
* <- Id
422:    POP  1,0,6 	load adress of lhs struct
423:    LDC  0,1,0 	load offset of member
424:    ADD  0,0,1 	compute the real adress if pointK
425:   PUSH  0,0(6) 	
426:    POP  1,0(6) 	move the adress of referenced
427:    POP  0,0(6) 	copy bytes
428:     ST  0,0(1) 	copy bytes
* <- assign
429:  LABEL  7,0,0 	generate label
* <- if
430:    MOV  3,2,0 	restore the caller sp
431:     LD  2,0(2) 	resotre the caller fp
432:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
219:    LDA  7,213(7) 	skip the function body
* call main function
