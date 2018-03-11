* File: list_example.tm
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
  8:    LDA  3,-1(3) 	stack expand
  9:    LDC  0,0(0) 	load integer const
 10:   PUSH  0,0(6) 	store exp
 11:    LDA  0,0(5) 	load id adress
 12:   PUSH  0,0(6) 	push array adress to mp
 13:    POP  1,0(6) 	move the adress of ID
 14:    POP  0,0(6) 	copy bytes
 15:     ST  0,0(1) 	copy bytes
* function entry:
* malloc
 16:    LDA  3,-1(3) 	stack expand for function variable
 17:    LDC  0,20(0) 	get function adress
 18:     ST  0,-1(5) 	set function adress
 19:     GO  0,0,0 	go to label
 20:    MOV  1,2,0 	store the caller fp temporarily
 21:    MOV  2,3,0 	exchang the stack(context)
 22:   PUSH  1,0(3) 	push the caller fp
 23:   PUSH  0,0(3) 	push the return adress
 24:     LD  0,2(2) 	load id value
 25:   PUSH  0,0(6) 	store exp
 26:    POP  0,0(6) 	get malloc parameters
 27:  MALLOC  0,0(0) 	system call for malloc
 28:    MOV  3,2,0 	restore the caller sp
 29:     LD  2,0(2) 	resotre the caller fp
 30:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 31:  LABEL  0,0,0 	generate label
* function entry:
* free
 32:    LDA  3,-1(3) 	stack expand for function variable
 33:    LDC  0,36(0) 	get function adress
 34:     ST  0,-2(5) 	set function adress
 35:     GO  1,0,0 	go to label
 36:    MOV  1,2,0 	store the caller fp temporarily
 37:    MOV  2,3,0 	exchang the stack(context)
 38:   PUSH  1,0(3) 	push the caller fp
 39:   PUSH  0,0(3) 	push the return adress
 40:     LD  0,2(2) 	load id value
 41:   PUSH  0,0(6) 	store exp
 42:    POP  0,0(6) 	get free parameters
 43:  FREE  0,0(0) 	system call for free
 44:    MOV  3,2,0 	restore the caller sp
 45:     LD  2,0(2) 	resotre the caller fp
 46:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 47:  LABEL  1,0,0 	generate label
* function entry:
* printStr
 48:    LDA  3,-1(3) 	stack expand for function variable
 49:    LDC  0,52(0) 	get function adress
 50:     ST  0,-3(5) 	set function adress
 51:     GO  2,0,0 	go to label
 52:    MOV  1,2,0 	store the caller fp temporarily
 53:    MOV  2,3,0 	exchang the stack(context)
 54:   PUSH  1,0(3) 	push the caller fp
 55:   PUSH  0,0(3) 	push the return adress
* while stmt:
 56:  LABEL  3,0,0 	generate label
 57:     LD  0,2(2) 	load id value
 58:   PUSH  0,0(6) 	store exp
 59:    POP  0,0(6) 	pop the adress
 60:     LD  1,0(0) 	load bytes
 61:   PUSH  1,0(6) 	push bytes 
 62:    LDC  0,0(0) 	load integer const
 63:   PUSH  0,0(6) 	store exp
 64:    POP  1,0(6) 	pop right
 65:    POP  0,0(6) 	pop left
 66:    SUB  0,0,1 	op ==, convertd_type
 67:    JNE  0,2(7) 	br if true
 68:    LDC  0,0(0) 	false case
 69:    LDA  7,1(7) 	unconditional jmp
 70:    LDC  0,1(0) 	true case
 71:   PUSH  0,0(6) 	
 72:    POP  0,0(6) 	pop from the mp
 73:    JNE  0,1,7 	true case:, skip the break, execute the block code
 74:     GO  4,0,0 	go to label
 75:     LD  0,2(2) 	load id value
 76:   PUSH  0,0(6) 	store exp
 77:    POP  0,0(6) 	pop right
 78:     LD  0,2(2) 	load id value
 79:   PUSH  0,0(6) 	store exp
 80:     LD  0,2(2) 	load id value
 81:   PUSH  0,0(6) 	store exp
 82:    LDC  0,1(0) 	load integer const
 83:   PUSH  0,0(6) 	store exp
 84:    POP  0,0(6) 	load index value to ac
 85:    LDC  1,1,0 	load pointkind size
 86:    MUL  0,1,0 	compute the offset
 87:    POP  1,0(6) 	load lhs adress to ac1
 88:    ADD  0,1,0 	compute the real index adress
 89:   PUSH  0,0(6) 	op: load left
 90:    LDA  0,2(2) 	load id adress
 91:   PUSH  0,0(6) 	push array adress to mp
 92:    POP  1,0(6) 	move the adress of ID
 93:    POP  0,0(6) 	copy bytes
 94:     ST  0,0(1) 	copy bytes
 95:    POP  0,0(6) 	pop the adress
 96:     LD  1,0(0) 	load bytes
 97:   PUSH  1,0(6) 	push bytes 
 98:    POP  0,0(6) 	move result to register
 99:    OUT  0,1,0 	output value in register[ac / fac]
100:     GO  3,0,0 	go to label
101:  LABEL  4,0,0 	generate label
102:    MOV  3,2,0 	restore the caller sp
103:     LD  2,0(2) 	resotre the caller fp
104:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
105:  LABEL  2,0,0 	generate label
* call main function
* File: list_example.tm
* Standard prelude:
106:    LDC  6,65535(0) 	load mp adress
107:     ST  0,0(0) 	clear location 0
108:    LDC  5,4095(0) 	load gp adress from location 1
109:     ST  0,1(0) 	clear location 1
110:    LDC  4,2000(0) 	load gp adress from location 1
111:    LDC  2,60000(0) 	load first fp from location 2
112:    LDC  3,60000(0) 	load first sp from location 2
113:     ST  0,2(0) 	clear location 2
* End of standard prelude.
114:    LDA  3,-1(3) 	stack expand
115:    LDA  3,-1(3) 	stack expand
116:    LDA  3,-1(3) 	stack expand
117:    LDA  3,-1(3) 	stack expand
118:    LDA  3,-1(3) 	stack expand
119:    LDA  3,-1(3) 	stack expand
* function entry:
* dup
120:    LDA  3,-1(3) 	stack expand for function variable
121:     GO  5,0,0 	go to label
122:    MOV  1,2,0 	store the caller fp temporarily
123:    MOV  2,3,0 	exchang the stack(context)
124:   PUSH  1,0(3) 	push the caller fp
125:   PUSH  0,0(3) 	push the return adress
126:    MOV  3,2,0 	restore the caller sp
127:     LD  2,0(2) 	resotre the caller fp
128:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
129:  LABEL  5,0,0 	generate label
* function entry:
* freeList
130:    LDA  3,-1(3) 	stack expand for function variable
131:     GO  6,0,0 	go to label
132:    MOV  1,2,0 	store the caller fp temporarily
133:    MOV  2,3,0 	exchang the stack(context)
134:   PUSH  1,0(3) 	push the caller fp
135:   PUSH  0,0(3) 	push the return adress
136:    MOV  3,2,0 	restore the caller sp
137:     LD  2,0(2) 	resotre the caller fp
138:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
139:  LABEL  6,0,0 	generate label
* function entry:
* match
140:    LDA  3,-1(3) 	stack expand for function variable
141:     GO  7,0,0 	go to label
142:    MOV  1,2,0 	store the caller fp temporarily
143:    MOV  2,3,0 	exchang the stack(context)
144:   PUSH  1,0(3) 	push the caller fp
145:   PUSH  0,0(3) 	push the return adress
146:    MOV  3,2,0 	restore the caller sp
147:     LD  2,0(2) 	resotre the caller fp
148:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
149:  LABEL  7,0,0 	generate label
* function entry:
* removeList
150:    LDA  3,-1(3) 	stack expand for function variable
151:     GO  8,0,0 	go to label
152:    MOV  1,2,0 	store the caller fp temporarily
153:    MOV  2,3,0 	exchang the stack(context)
154:   PUSH  1,0(3) 	push the caller fp
155:   PUSH  0,0(3) 	push the return adress
156:     LD  0,2(2) 	load id value
157:   PUSH  0,0(6) 	store exp
158:    POP  1,0,6 	load adress of lhs struct
159:    LDC  0,2,0 	load offset of member
160:    ADD  0,0,1 	compute the real adress if pointK
161:   PUSH  0,0(6) 	
162:    POP  0,0(6) 	load adress from mp
163:     LD  1,0(0) 	copy bytes
164:   PUSH  1,0(6) 	push a.x value into tmp
165:    LDC  0,0(0) 	load integer const
166:   PUSH  0,0(6) 	store exp
167:    POP  1,0(6) 	pop right
168:    POP  0,0(6) 	pop left
169:    SUB  0,0,1 	op <
170:    JLE  0,2(7) 	br if true
171:    LDC  0,0(0) 	false case
172:    LDA  7,1(7) 	unconditional jmp
173:    LDC  0,1(0) 	true case
174:   PUSH  0,0(6) 	
175:    POP  0,0(6) 	pop from the mp
176:    JNE  0,1,7 	true case:, execute if part
177:     GO  9,0,0 	go to label
178:    MOV  3,2,0 	restore the caller sp
179:     LD  2,0(2) 	resotre the caller fp
180:  RETURN  0,-1,3 	return to the caller
181:     GO  10,0,0 	go to label
182:  LABEL  9,0,0 	generate label
* if: jump to else
183:  LABEL  10,0,0 	generate label
184:     LD  0,2(2) 	load id value
185:   PUSH  0,0(6) 	store exp
186:    POP  1,0,6 	load adress of lhs struct
187:    LDC  0,2,0 	load offset of member
188:    ADD  0,0,1 	compute the real adress if pointK
189:   PUSH  0,0(6) 	
190:    POP  0,0(6) 	load adress from mp
191:     LD  1,0(0) 	copy bytes
192:   PUSH  1,0(6) 	push a.x value into tmp
193:    POP  0,0(6) 	pop right
194:     LD  0,2(2) 	load id value
195:   PUSH  0,0(6) 	store exp
196:    POP  1,0,6 	load adress of lhs struct
197:    LDC  0,2,0 	load offset of member
198:    ADD  0,0,1 	compute the real adress if pointK
199:   PUSH  0,0(6) 	
200:    POP  0,0(6) 	load adress from mp
201:     LD  1,0(0) 	copy bytes
202:   PUSH  1,0(6) 	push a.x value into tmp
203:    LDC  0,1(0) 	load integer const
204:   PUSH  0,0(6) 	store exp
205:    POP  1,0(6) 	pop right
206:    POP  0,0(6) 	pop left
207:    SUB  0,0,1 	op -
208:   PUSH  0,0(6) 	op: load left
209:     LD  0,2(2) 	load id value
210:   PUSH  0,0(6) 	store exp
211:    POP  1,0,6 	load adress of lhs struct
212:    LDC  0,2,0 	load offset of member
213:    ADD  0,0,1 	compute the real adress if pointK
214:   PUSH  0,0(6) 	
215:    POP  1,0(6) 	move the adress of referenced
216:    POP  0,0(6) 	copy bytes
217:     ST  0,0(1) 	copy bytes
218:    LDA  3,-1(3) 	stack expand
219:     LD  0,2(2) 	load id value
220:   PUSH  0,0(6) 	store exp
221:    POP  1,0,6 	load adress of lhs struct
222:    LDC  0,0,0 	load offset of member
223:    ADD  0,0,1 	compute the real adress if pointK
224:   PUSH  0,0(6) 	
225:    POP  0,0(6) 	load adress from mp
226:     LD  1,0(0) 	copy bytes
227:   PUSH  1,0(6) 	push a.x value into tmp
228:    POP  1,0,6 	load adress of lhs struct
229:    LDC  0,1,0 	load offset of member
230:    ADD  0,0,1 	compute the real adress if pointK
231:   PUSH  0,0(6) 	
232:    POP  0,0(6) 	load adress from mp
233:     LD  1,0(0) 	copy bytes
234:   PUSH  1,0(6) 	push a.x value into tmp
235:    LDA  0,-2(2) 	load id adress
236:   PUSH  0,0(6) 	push array adress to mp
237:    POP  1,0(6) 	move the adress of ID
238:    POP  0,0(6) 	copy bytes
239:     ST  0,0(1) 	copy bytes
* while stmt:
240:  LABEL  11,0,0 	generate label
241:     LD  0,-2(2) 	load id value
242:   PUSH  0,0(6) 	store exp
243:     LD  0,0(5) 	load id value
244:   PUSH  0,0(6) 	store exp
245:    POP  1,0(6) 	pop right
246:    POP  0,0(6) 	pop left
247:    SUB  0,0,1 	op ==, convertd_type
248:    JNE  0,2(7) 	br if true
249:    LDC  0,0(0) 	false case
250:    LDA  7,1(7) 	unconditional jmp
251:    LDC  0,1(0) 	true case
252:   PUSH  0,0(6) 	
* push function parameters
253:     LD  0,3(2) 	load id value
254:   PUSH  0,0(6) 	store exp
255:    POP  0,0(6) 	copy bytes
256:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
257:     LD  0,-2(2) 	load id value
258:   PUSH  0,0(6) 	store exp
259:    POP  1,0,6 	load adress of lhs struct
260:    LDC  0,2,0 	load offset of member
261:    ADD  0,0,1 	compute the real adress if pointK
262:   PUSH  0,0(6) 	
263:    POP  0,0(6) 	load adress from mp
264:     LD  1,0(0) 	copy bytes
265:   PUSH  1,0(6) 	push a.x value into tmp
266:    POP  0,0(6) 	copy bytes
267:   PUSH  0,0(3) 	PUSH bytes
268:     LD  0,1(2) 	load env
269:   PUSH  0,0(3) 	store env
* call function: 
* match
270:     LD  0,2(2) 	load id value
271:   PUSH  0,0(6) 	store exp
272:    POP  1,0,6 	load adress of lhs struct
273:    LDC  0,5,0 	load offset of member
274:    ADD  0,0,1 	compute the real adress if pointK
275:   PUSH  0,0(6) 	
276:    POP  0,0(6) 	load adress from mp
277:     LD  1,0(0) 	copy bytes
278:   PUSH  1,0(6) 	push a.x value into tmp
279:    LDC  0,281(0) 	store the return adress
280:    POP  7,0(6) 	ujp to the function body
281:    LDA  3,2(3) 	pop parameters
282:    LDA  3,1(3) 	pop env
283:    LDC  0,0(0) 	load integer const
284:   PUSH  0,0(6) 	store exp
285:    POP  1,0(6) 	pop right
286:    POP  0,0(6) 	pop left
287:    SUB  0,0,1 	op ==, convertd_type
288:    JNE  0,2(7) 	br if true
289:    LDC  0,0(0) 	false case
290:    LDA  7,1(7) 	unconditional jmp
291:    LDC  0,1(0) 	true case
292:   PUSH  0,0(6) 	
293:    POP  1,0(6) 	pop right
294:    POP  0,0(6) 	pop left
295:    JEQ  0,3(7) 	br if false
296:    JEQ  1,2(7) 	br if false
297:    LDC  0,1(0) 	true case
298:    LDA  7,1(7) 	unconditional jmp
299:    LDC  0,0(0) 	false case
300:   PUSH  0,0(6) 	
301:    POP  0,0(6) 	pop from the mp
302:    JNE  0,1,7 	true case:, skip the break, execute the block code
303:     GO  12,0,0 	go to label
304:     LD  0,-2(2) 	load id value
305:   PUSH  0,0(6) 	store exp
306:    POP  1,0,6 	load adress of lhs struct
307:    LDC  0,1,0 	load offset of member
308:    ADD  0,0,1 	compute the real adress if pointK
309:   PUSH  0,0(6) 	
310:    POP  0,0(6) 	load adress from mp
311:     LD  1,0(0) 	copy bytes
312:   PUSH  1,0(6) 	push a.x value into tmp
313:    LDA  0,-2(2) 	load id adress
314:   PUSH  0,0(6) 	push array adress to mp
315:    POP  1,0(6) 	move the adress of ID
316:    POP  0,0(6) 	copy bytes
317:     ST  0,0(1) 	copy bytes
318:     GO  11,0,0 	go to label
319:  LABEL  12,0,0 	generate label
320:     LD  0,-2(2) 	load id value
321:   PUSH  0,0(6) 	store exp
322:     LD  0,0(5) 	load id value
323:   PUSH  0,0(6) 	store exp
324:    POP  1,0(6) 	pop right
325:    POP  0,0(6) 	pop left
326:    SUB  0,0,1 	op ==, convertd_type
327:    JEQ  0,2(7) 	br if true
328:    LDC  0,0(0) 	false case
329:    LDA  7,1(7) 	unconditional jmp
330:    LDC  0,1(0) 	true case
331:   PUSH  0,0(6) 	
332:    POP  0,0(6) 	pop from the mp
333:    JNE  0,1,7 	true case:, execute if part
334:     GO  13,0,0 	go to label
335:    MOV  3,2,0 	restore the caller sp
336:     LD  2,0(2) 	resotre the caller fp
337:  RETURN  0,-1,3 	return to the caller
338:     GO  14,0,0 	go to label
339:  LABEL  13,0,0 	generate label
* if: jump to else
340:  LABEL  14,0,0 	generate label
341:    LDA  3,-1(3) 	stack expand
342:     LD  0,-2(2) 	load id value
343:   PUSH  0,0(6) 	store exp
344:    POP  1,0,6 	load adress of lhs struct
345:    LDC  0,0,0 	load offset of member
346:    ADD  0,0,1 	compute the real adress if pointK
347:   PUSH  0,0(6) 	
348:    POP  0,0(6) 	load adress from mp
349:     LD  1,0(0) 	copy bytes
350:   PUSH  1,0(6) 	push a.x value into tmp
351:    LDA  0,-3(2) 	load id adress
352:   PUSH  0,0(6) 	push array adress to mp
353:    POP  1,0(6) 	move the adress of ID
354:    POP  0,0(6) 	copy bytes
355:     ST  0,0(1) 	copy bytes
356:    LDA  3,-1(3) 	stack expand
357:     LD  0,-2(2) 	load id value
358:   PUSH  0,0(6) 	store exp
359:    POP  1,0,6 	load adress of lhs struct
360:    LDC  0,1,0 	load offset of member
361:    ADD  0,0,1 	compute the real adress if pointK
362:   PUSH  0,0(6) 	
363:    POP  0,0(6) 	load adress from mp
364:     LD  1,0(0) 	copy bytes
365:   PUSH  1,0(6) 	push a.x value into tmp
366:    LDA  0,-4(2) 	load id adress
367:   PUSH  0,0(6) 	push array adress to mp
368:    POP  1,0(6) 	move the adress of ID
369:    POP  0,0(6) 	copy bytes
370:     ST  0,0(1) 	copy bytes
371:     LD  0,-4(2) 	load id value
372:   PUSH  0,0(6) 	store exp
373:     LD  0,-3(2) 	load id value
374:   PUSH  0,0(6) 	store exp
375:    POP  1,0,6 	load adress of lhs struct
376:    LDC  0,1,0 	load offset of member
377:    ADD  0,0,1 	compute the real adress if pointK
378:   PUSH  0,0(6) 	
379:    POP  1,0(6) 	move the adress of referenced
380:    POP  0,0(6) 	copy bytes
381:     ST  0,0(1) 	copy bytes
382:     LD  0,-4(2) 	load id value
383:   PUSH  0,0(6) 	store exp
384:     LD  0,0(5) 	load id value
385:   PUSH  0,0(6) 	store exp
386:    POP  1,0(6) 	pop right
387:    POP  0,0(6) 	pop left
388:    SUB  0,0,1 	op ==, convertd_type
389:    JNE  0,2(7) 	br if true
390:    LDC  0,0(0) 	false case
391:    LDA  7,1(7) 	unconditional jmp
392:    LDC  0,1(0) 	true case
393:   PUSH  0,0(6) 	
394:    POP  0,0(6) 	pop from the mp
395:    JNE  0,1,7 	true case:, execute if part
396:     GO  15,0,0 	go to label
397:     LD  0,-3(2) 	load id value
398:   PUSH  0,0(6) 	store exp
399:     LD  0,-4(2) 	load id value
400:   PUSH  0,0(6) 	store exp
401:    POP  1,0,6 	load adress of lhs struct
402:    LDC  0,0,0 	load offset of member
403:    ADD  0,0,1 	compute the real adress if pointK
404:   PUSH  0,0(6) 	
405:    POP  1,0(6) 	move the adress of referenced
406:    POP  0,0(6) 	copy bytes
407:     ST  0,0(1) 	copy bytes
408:     GO  16,0,0 	go to label
409:  LABEL  15,0,0 	generate label
* if: jump to else
410:  LABEL  16,0,0 	generate label
411:     LD  0,-2(2) 	load id value
412:   PUSH  0,0(6) 	store exp
413:     LD  0,2(2) 	load id value
414:   PUSH  0,0(6) 	store exp
415:    POP  1,0,6 	load adress of lhs struct
416:    LDC  0,1,0 	load offset of member
417:    ADD  0,0,1 	compute the real adress if pointK
418:   PUSH  0,0(6) 	
419:    POP  0,0(6) 	load adress from mp
420:     LD  1,0(0) 	copy bytes
421:   PUSH  1,0(6) 	push a.x value into tmp
422:    POP  1,0(6) 	pop right
423:    POP  0,0(6) 	pop left
424:    SUB  0,0,1 	op ==, convertd_type
425:    JEQ  0,2(7) 	br if true
426:    LDC  0,0(0) 	false case
427:    LDA  7,1(7) 	unconditional jmp
428:    LDC  0,1(0) 	true case
429:   PUSH  0,0(6) 	
430:    POP  0,0(6) 	pop from the mp
431:    JNE  0,1,7 	true case:, execute if part
432:     GO  17,0,0 	go to label
433:     LD  0,-3(2) 	load id value
434:   PUSH  0,0(6) 	store exp
435:     LD  0,2(2) 	load id value
436:   PUSH  0,0(6) 	store exp
437:    POP  1,0,6 	load adress of lhs struct
438:    LDC  0,1,0 	load offset of member
439:    ADD  0,0,1 	compute the real adress if pointK
440:   PUSH  0,0(6) 	
441:    POP  1,0(6) 	move the adress of referenced
442:    POP  0,0(6) 	copy bytes
443:     ST  0,0(1) 	copy bytes
444:     GO  18,0,0 	go to label
445:  LABEL  17,0,0 	generate label
* if: jump to else
446:  LABEL  18,0,0 	generate label
* push function parameters
447:     LD  0,-2(2) 	load id value
448:   PUSH  0,0(6) 	store exp
449:    POP  0,0(6) 	copy bytes
450:   PUSH  0,0(3) 	PUSH bytes
451:     LD  0,1(2) 	load env
452:     LD  0,1(0) 	load env1
453:   PUSH  0,0(3) 	store env
* call function: 
* free
454:     LD  0,-2(5) 	load id value
455:   PUSH  0,0(6) 	store exp
456:    LDC  0,458(0) 	store the return adress
457:    POP  7,0(6) 	ujp to the function body
458:    LDA  3,1(3) 	pop parameters
459:    LDA  3,1(3) 	pop env
460:    MOV  3,2,0 	restore the caller sp
461:     LD  2,0(2) 	resotre the caller fp
462:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
463:  LABEL  8,0,0 	generate label
* function entry:
* append
464:    LDA  3,-1(3) 	stack expand for function variable
465:     GO  19,0,0 	go to label
466:    MOV  1,2,0 	store the caller fp temporarily
467:    MOV  2,3,0 	exchang the stack(context)
468:   PUSH  1,0(3) 	push the caller fp
469:   PUSH  0,0(3) 	push the return adress
470:     LD  0,3(2) 	load id value
471:   PUSH  0,0(6) 	store exp
472:     LD  0,0(5) 	load id value
473:   PUSH  0,0(6) 	store exp
474:    POP  1,0(6) 	pop right
475:    POP  0,0(6) 	pop left
476:    SUB  0,0,1 	op ==, convertd_type
477:    JEQ  0,2(7) 	br if true
478:    LDC  0,0(0) 	false case
479:    LDA  7,1(7) 	unconditional jmp
480:    LDC  0,1(0) 	true case
481:   PUSH  0,0(6) 	
482:    POP  0,0(6) 	pop from the mp
483:    JNE  0,1,7 	true case:, execute if part
484:     GO  20,0,0 	go to label
485:    MOV  3,2,0 	restore the caller sp
486:     LD  2,0(2) 	resotre the caller fp
487:  RETURN  0,-1,3 	return to the caller
488:     GO  21,0,0 	go to label
489:  LABEL  20,0,0 	generate label
* if: jump to else
490:  LABEL  21,0,0 	generate label
491:     LD  0,2(2) 	load id value
492:   PUSH  0,0(6) 	store exp
493:    POP  1,0,6 	load adress of lhs struct
494:    LDC  0,2,0 	load offset of member
495:    ADD  0,0,1 	compute the real adress if pointK
496:   PUSH  0,0(6) 	
497:    POP  0,0(6) 	load adress from mp
498:     LD  1,0(0) 	copy bytes
499:   PUSH  1,0(6) 	push a.x value into tmp
500:    POP  0,0(6) 	pop right
501:     LD  0,2(2) 	load id value
502:   PUSH  0,0(6) 	store exp
503:    POP  1,0,6 	load adress of lhs struct
504:    LDC  0,2,0 	load offset of member
505:    ADD  0,0,1 	compute the real adress if pointK
506:   PUSH  0,0(6) 	
507:    POP  0,0(6) 	load adress from mp
508:     LD  1,0(0) 	copy bytes
509:   PUSH  1,0(6) 	push a.x value into tmp
510:    LDC  0,1(0) 	load integer const
511:   PUSH  0,0(6) 	store exp
512:    POP  1,0(6) 	pop right
513:    POP  0,0(6) 	pop left
514:    ADD  0,0,1 	op +
515:   PUSH  0,0(6) 	op: load left
516:     LD  0,2(2) 	load id value
517:   PUSH  0,0(6) 	store exp
518:    POP  1,0,6 	load adress of lhs struct
519:    LDC  0,2,0 	load offset of member
520:    ADD  0,0,1 	compute the real adress if pointK
521:   PUSH  0,0(6) 	
522:    POP  1,0(6) 	move the adress of referenced
523:    POP  0,0(6) 	copy bytes
524:     ST  0,0(1) 	copy bytes
525:     LD  0,3(2) 	load id value
526:   PUSH  0,0(6) 	store exp
527:     LD  0,2(2) 	load id value
528:   PUSH  0,0(6) 	store exp
529:    POP  1,0,6 	load adress of lhs struct
530:    LDC  0,1,0 	load offset of member
531:    ADD  0,0,1 	compute the real adress if pointK
532:   PUSH  0,0(6) 	
533:    POP  0,0(6) 	load adress from mp
534:     LD  1,0(0) 	copy bytes
535:   PUSH  1,0(6) 	push a.x value into tmp
536:    POP  1,0,6 	load adress of lhs struct
537:    LDC  0,1,0 	load offset of member
538:    ADD  0,0,1 	compute the real adress if pointK
539:   PUSH  0,0(6) 	
540:    POP  1,0(6) 	move the adress of referenced
541:    POP  0,0(6) 	copy bytes
542:     ST  0,0(1) 	copy bytes
543:     LD  0,2(2) 	load id value
544:   PUSH  0,0(6) 	store exp
545:    POP  1,0,6 	load adress of lhs struct
546:    LDC  0,1,0 	load offset of member
547:    ADD  0,0,1 	compute the real adress if pointK
548:   PUSH  0,0(6) 	
549:    POP  0,0(6) 	load adress from mp
550:     LD  1,0(0) 	copy bytes
551:   PUSH  1,0(6) 	push a.x value into tmp
552:     LD  0,3(2) 	load id value
553:   PUSH  0,0(6) 	store exp
554:    POP  1,0,6 	load adress of lhs struct
555:    LDC  0,0,0 	load offset of member
556:    ADD  0,0,1 	compute the real adress if pointK
557:   PUSH  0,0(6) 	
558:    POP  1,0(6) 	move the adress of referenced
559:    POP  0,0(6) 	copy bytes
560:     ST  0,0(1) 	copy bytes
561:     LD  0,0(5) 	load id value
562:   PUSH  0,0(6) 	store exp
563:     LD  0,3(2) 	load id value
564:   PUSH  0,0(6) 	store exp
565:    POP  1,0,6 	load adress of lhs struct
566:    LDC  0,1,0 	load offset of member
567:    ADD  0,0,1 	compute the real adress if pointK
568:   PUSH  0,0(6) 	
569:    POP  1,0(6) 	move the adress of referenced
570:    POP  0,0(6) 	copy bytes
571:     ST  0,0(1) 	copy bytes
572:     LD  0,3(2) 	load id value
573:   PUSH  0,0(6) 	store exp
574:     LD  0,2(2) 	load id value
575:   PUSH  0,0(6) 	store exp
576:    POP  1,0,6 	load adress of lhs struct
577:    LDC  0,1,0 	load offset of member
578:    ADD  0,0,1 	compute the real adress if pointK
579:   PUSH  0,0(6) 	
580:    POP  1,0(6) 	move the adress of referenced
581:    POP  0,0(6) 	copy bytes
582:     ST  0,0(1) 	copy bytes
583:    MOV  3,2,0 	restore the caller sp
584:     LD  2,0(2) 	resotre the caller fp
585:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
586:  LABEL  19,0,0 	generate label
* function entry:
* insertSortedList
587:    LDA  3,-1(3) 	stack expand for function variable
588:     GO  22,0,0 	go to label
589:    MOV  1,2,0 	store the caller fp temporarily
590:    MOV  2,3,0 	exchang the stack(context)
591:   PUSH  1,0(3) 	push the caller fp
592:   PUSH  0,0(3) 	push the return adress
593:     LD  0,3(2) 	load id value
594:   PUSH  0,0(6) 	store exp
595:     LD  0,0(5) 	load id value
596:   PUSH  0,0(6) 	store exp
597:    POP  1,0(6) 	pop right
598:    POP  0,0(6) 	pop left
599:    SUB  0,0,1 	op ==, convertd_type
600:    JEQ  0,2(7) 	br if true
601:    LDC  0,0(0) 	false case
602:    LDA  7,1(7) 	unconditional jmp
603:    LDC  0,1(0) 	true case
604:   PUSH  0,0(6) 	
605:    POP  0,0(6) 	pop from the mp
606:    JNE  0,1,7 	true case:, execute if part
607:     GO  23,0,0 	go to label
608:    MOV  3,2,0 	restore the caller sp
609:     LD  2,0(2) 	resotre the caller fp
610:  RETURN  0,-1,3 	return to the caller
611:     GO  24,0,0 	go to label
612:  LABEL  23,0,0 	generate label
* if: jump to else
613:  LABEL  24,0,0 	generate label
614:    LDA  3,-1(3) 	stack expand
615:    LDC  0,10(0) 	load integer const
616:   PUSH  0,0(6) 	store exp
617:    LDA  0,-2(2) 	load id adress
618:   PUSH  0,0(6) 	push array adress to mp
619:    POP  1,0(6) 	move the adress of ID
620:    POP  0,0(6) 	copy bytes
621:     ST  0,0(1) 	copy bytes
622:     LD  0,2(2) 	load id value
623:   PUSH  0,0(6) 	store exp
624:    POP  1,0,6 	load adress of lhs struct
625:    LDC  0,2,0 	load offset of member
626:    ADD  0,0,1 	compute the real adress if pointK
627:   PUSH  0,0(6) 	
628:    POP  0,0(6) 	load adress from mp
629:     LD  1,0(0) 	copy bytes
630:   PUSH  1,0(6) 	push a.x value into tmp
631:    LDC  0,1(0) 	load integer const
632:   PUSH  0,0(6) 	store exp
633:    POP  1,0(6) 	pop right
634:    POP  0,0(6) 	pop left
635:    ADD  0,0,1 	op +
636:   PUSH  0,0(6) 	op: load left
637:     LD  0,2(2) 	load id value
638:   PUSH  0,0(6) 	store exp
639:    POP  1,0,6 	load adress of lhs struct
640:    LDC  0,2,0 	load offset of member
641:    ADD  0,0,1 	compute the real adress if pointK
642:   PUSH  0,0(6) 	
643:    POP  1,0(6) 	move the adress of referenced
644:    POP  0,0(6) 	copy bytes
645:     ST  0,0(1) 	copy bytes
646:    LDA  3,-1(3) 	stack expand
647:     LD  0,2(2) 	load id value
648:   PUSH  0,0(6) 	store exp
649:    POP  1,0,6 	load adress of lhs struct
650:    LDC  0,0,0 	load offset of member
651:    ADD  0,0,1 	compute the real adress if pointK
652:   PUSH  0,0(6) 	
653:    POP  0,0(6) 	load adress from mp
654:     LD  1,0(0) 	copy bytes
655:   PUSH  1,0(6) 	push a.x value into tmp
656:    LDA  0,-3(2) 	load id adress
657:   PUSH  0,0(6) 	push array adress to mp
658:    POP  1,0(6) 	move the adress of ID
659:    POP  0,0(6) 	copy bytes
660:     ST  0,0(1) 	copy bytes
* while stmt:
661:  LABEL  25,0,0 	generate label
662:     LD  0,-3(2) 	load id value
663:   PUSH  0,0(6) 	store exp
664:    POP  1,0,6 	load adress of lhs struct
665:    LDC  0,1,0 	load offset of member
666:    ADD  0,0,1 	compute the real adress if pointK
667:   PUSH  0,0(6) 	
668:    POP  0,0(6) 	load adress from mp
669:     LD  1,0(0) 	copy bytes
670:   PUSH  1,0(6) 	push a.x value into tmp
671:     LD  0,0(5) 	load id value
672:   PUSH  0,0(6) 	store exp
673:    POP  1,0(6) 	pop right
674:    POP  0,0(6) 	pop left
675:    SUB  0,0,1 	op ==, convertd_type
676:    JNE  0,2(7) 	br if true
677:    LDC  0,0(0) 	false case
678:    LDA  7,1(7) 	unconditional jmp
679:    LDC  0,1(0) 	true case
680:   PUSH  0,0(6) 	
681:    POP  0,0(6) 	pop from the mp
682:    JNE  0,1,7 	true case:, skip the break, execute the block code
683:     GO  26,0,0 	go to label
* push function parameters
684:     LD  0,3(2) 	load id value
685:   PUSH  0,0(6) 	store exp
686:    POP  1,0,6 	load adress of lhs struct
687:    LDC  0,2,0 	load offset of member
688:    ADD  0,0,1 	compute the real adress if pointK
689:   PUSH  0,0(6) 	
690:    POP  0,0(6) 	load adress from mp
691:     LD  1,0(0) 	copy bytes
692:   PUSH  1,0(6) 	push a.x value into tmp
693:    POP  0,0(6) 	copy bytes
694:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
695:     LD  0,-3(2) 	load id value
696:   PUSH  0,0(6) 	store exp
697:    POP  1,0,6 	load adress of lhs struct
698:    LDC  0,1,0 	load offset of member
699:    ADD  0,0,1 	compute the real adress if pointK
700:   PUSH  0,0(6) 	
701:    POP  0,0(6) 	load adress from mp
702:     LD  1,0(0) 	copy bytes
703:   PUSH  1,0(6) 	push a.x value into tmp
704:    POP  1,0,6 	load adress of lhs struct
705:    LDC  0,2,0 	load offset of member
706:    ADD  0,0,1 	compute the real adress if pointK
707:   PUSH  0,0(6) 	
708:    POP  0,0(6) 	load adress from mp
709:     LD  1,0(0) 	copy bytes
710:   PUSH  1,0(6) 	push a.x value into tmp
711:    POP  0,0(6) 	copy bytes
712:   PUSH  0,0(3) 	PUSH bytes
713:     LD  0,1(2) 	load env
714:   PUSH  0,0(3) 	store env
* call function: 
* match
715:     LD  0,2(2) 	load id value
716:   PUSH  0,0(6) 	store exp
717:    POP  1,0,6 	load adress of lhs struct
718:    LDC  0,5,0 	load offset of member
719:    ADD  0,0,1 	compute the real adress if pointK
720:   PUSH  0,0(6) 	
721:    POP  0,0(6) 	load adress from mp
722:     LD  1,0(0) 	copy bytes
723:   PUSH  1,0(6) 	push a.x value into tmp
724:    LDC  0,726(0) 	store the return adress
725:    POP  7,0(6) 	ujp to the function body
726:    LDA  3,2(3) 	pop parameters
727:    LDA  3,1(3) 	pop env
728:    LDC  0,0(0) 	load integer const
729:   PUSH  0,0(6) 	store exp
730:    POP  1,0(6) 	pop right
731:    POP  0,0(6) 	pop left
732:    SUB  0,0,1 	op <
733:    JGE  0,2(7) 	br if true
734:    LDC  0,0(0) 	false case
735:    LDA  7,1(7) 	unconditional jmp
736:    LDC  0,1(0) 	true case
737:   PUSH  0,0(6) 	
738:    POP  0,0(6) 	pop from the mp
739:    JNE  0,1,7 	true case:, execute if part
740:     GO  27,0,0 	go to label
741:     GO  26,0,0 	go to label
742:     GO  28,0,0 	go to label
743:  LABEL  27,0,0 	generate label
* if: jump to else
744:  LABEL  28,0,0 	generate label
745:     LD  0,-3(2) 	load id value
746:   PUSH  0,0(6) 	store exp
747:    POP  1,0,6 	load adress of lhs struct
748:    LDC  0,1,0 	load offset of member
749:    ADD  0,0,1 	compute the real adress if pointK
750:   PUSH  0,0(6) 	
751:    POP  0,0(6) 	load adress from mp
752:     LD  1,0(0) 	copy bytes
753:   PUSH  1,0(6) 	push a.x value into tmp
754:    LDA  0,-3(2) 	load id adress
755:   PUSH  0,0(6) 	push array adress to mp
756:    POP  1,0(6) 	move the adress of ID
757:    POP  0,0(6) 	copy bytes
758:     ST  0,0(1) 	copy bytes
759:     GO  25,0,0 	go to label
760:  LABEL  26,0,0 	generate label
761:    LDA  3,-1(3) 	stack expand
762:     LD  0,-3(2) 	load id value
763:   PUSH  0,0(6) 	store exp
764:    POP  1,0,6 	load adress of lhs struct
765:    LDC  0,1,0 	load offset of member
766:    ADD  0,0,1 	compute the real adress if pointK
767:   PUSH  0,0(6) 	
768:    POP  0,0(6) 	load adress from mp
769:     LD  1,0(0) 	copy bytes
770:   PUSH  1,0(6) 	push a.x value into tmp
771:    LDA  0,-4(2) 	load id adress
772:   PUSH  0,0(6) 	push array adress to mp
773:    POP  1,0(6) 	move the adress of ID
774:    POP  0,0(6) 	copy bytes
775:     ST  0,0(1) 	copy bytes
776:     LD  0,3(2) 	load id value
777:   PUSH  0,0(6) 	store exp
778:     LD  0,-3(2) 	load id value
779:   PUSH  0,0(6) 	store exp
780:    POP  1,0,6 	load adress of lhs struct
781:    LDC  0,1,0 	load offset of member
782:    ADD  0,0,1 	compute the real adress if pointK
783:   PUSH  0,0(6) 	
784:    POP  1,0(6) 	move the adress of referenced
785:    POP  0,0(6) 	copy bytes
786:     ST  0,0(1) 	copy bytes
787:     LD  0,-4(2) 	load id value
788:   PUSH  0,0(6) 	store exp
789:     LD  0,3(2) 	load id value
790:   PUSH  0,0(6) 	store exp
791:    POP  1,0,6 	load adress of lhs struct
792:    LDC  0,1,0 	load offset of member
793:    ADD  0,0,1 	compute the real adress if pointK
794:   PUSH  0,0(6) 	
795:    POP  1,0(6) 	move the adress of referenced
796:    POP  0,0(6) 	copy bytes
797:     ST  0,0(1) 	copy bytes
798:     LD  0,-3(2) 	load id value
799:   PUSH  0,0(6) 	store exp
800:     LD  0,3(2) 	load id value
801:   PUSH  0,0(6) 	store exp
802:    POP  1,0,6 	load adress of lhs struct
803:    LDC  0,0,0 	load offset of member
804:    ADD  0,0,1 	compute the real adress if pointK
805:   PUSH  0,0(6) 	
806:    POP  1,0(6) 	move the adress of referenced
807:    POP  0,0(6) 	copy bytes
808:     ST  0,0(1) 	copy bytes
809:     LD  0,-4(2) 	load id value
810:   PUSH  0,0(6) 	store exp
811:     LD  0,0(5) 	load id value
812:   PUSH  0,0(6) 	store exp
813:    POP  1,0(6) 	pop right
814:    POP  0,0(6) 	pop left
815:    SUB  0,0,1 	op ==, convertd_type
816:    JNE  0,2(7) 	br if true
817:    LDC  0,0(0) 	false case
818:    LDA  7,1(7) 	unconditional jmp
819:    LDC  0,1(0) 	true case
820:   PUSH  0,0(6) 	
821:    POP  0,0(6) 	pop from the mp
822:    JNE  0,1,7 	true case:, execute if part
823:     GO  29,0,0 	go to label
824:     LD  0,3(2) 	load id value
825:   PUSH  0,0(6) 	store exp
826:     LD  0,-4(2) 	load id value
827:   PUSH  0,0(6) 	store exp
828:    POP  1,0,6 	load adress of lhs struct
829:    LDC  0,0,0 	load offset of member
830:    ADD  0,0,1 	compute the real adress if pointK
831:   PUSH  0,0(6) 	
832:    POP  1,0(6) 	move the adress of referenced
833:    POP  0,0(6) 	copy bytes
834:     ST  0,0(1) 	copy bytes
835:     GO  30,0,0 	go to label
836:  LABEL  29,0,0 	generate label
* if: jump to else
837:     LD  0,3(2) 	load id value
838:   PUSH  0,0(6) 	store exp
839:     LD  0,2(2) 	load id value
840:   PUSH  0,0(6) 	store exp
841:    POP  1,0,6 	load adress of lhs struct
842:    LDC  0,1,0 	load offset of member
843:    ADD  0,0,1 	compute the real adress if pointK
844:   PUSH  0,0(6) 	
845:    POP  1,0(6) 	move the adress of referenced
846:    POP  0,0(6) 	copy bytes
847:     ST  0,0(1) 	copy bytes
848:  LABEL  30,0,0 	generate label
849:    MOV  3,2,0 	restore the caller sp
850:     LD  2,0(2) 	resotre the caller fp
851:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
852:  LABEL  22,0,0 	generate label
* function entry:
* popRight
853:    LDA  3,-1(3) 	stack expand for function variable
854:     GO  31,0,0 	go to label
855:    MOV  1,2,0 	store the caller fp temporarily
856:    MOV  2,3,0 	exchang the stack(context)
857:   PUSH  1,0(3) 	push the caller fp
858:   PUSH  0,0(3) 	push the return adress
859:     LD  0,2(2) 	load id value
860:   PUSH  0,0(6) 	store exp
861:     LD  0,0(5) 	load id value
862:   PUSH  0,0(6) 	store exp
863:    POP  1,0(6) 	pop right
864:    POP  0,0(6) 	pop left
865:    SUB  0,0,1 	op ==, convertd_type
866:    JEQ  0,2(7) 	br if true
867:    LDC  0,0(0) 	false case
868:    LDA  7,1(7) 	unconditional jmp
869:    LDC  0,1(0) 	true case
870:   PUSH  0,0(6) 	
871:     LD  0,2(2) 	load id value
872:   PUSH  0,0(6) 	store exp
873:    POP  1,0,6 	load adress of lhs struct
874:    LDC  0,2,0 	load offset of member
875:    ADD  0,0,1 	compute the real adress if pointK
876:   PUSH  0,0(6) 	
877:    POP  0,0(6) 	load adress from mp
878:     LD  1,0(0) 	copy bytes
879:   PUSH  1,0(6) 	push a.x value into tmp
880:    LDC  0,0(0) 	load integer const
881:   PUSH  0,0(6) 	store exp
882:    POP  1,0(6) 	pop right
883:    POP  0,0(6) 	pop left
884:    SUB  0,0,1 	op <
885:    JLE  0,2(7) 	br if true
886:    LDC  0,0(0) 	false case
887:    LDA  7,1(7) 	unconditional jmp
888:    LDC  0,1(0) 	true case
889:   PUSH  0,0(6) 	
890:    POP  1,0(6) 	pop right
891:    POP  0,0(6) 	pop left
892:    JNE  0,3(7) 	br if true
893:    JNE  1,2(7) 	br if true
894:    LDC  0,0(0) 	false case
895:    LDA  7,1(7) 	unconditional jmp
896:    LDC  0,1(0) 	true case
897:   PUSH  0,0(6) 	
898:    POP  0,0(6) 	pop from the mp
899:    JNE  0,1,7 	true case:, execute if part
900:     GO  32,0,0 	go to label
901:    MOV  3,2,0 	restore the caller sp
902:     LD  2,0(2) 	resotre the caller fp
903:  RETURN  0,-1,3 	return to the caller
904:     GO  33,0,0 	go to label
905:  LABEL  32,0,0 	generate label
* if: jump to else
906:  LABEL  33,0,0 	generate label
907:     LD  0,2(2) 	load id value
908:   PUSH  0,0(6) 	store exp
909:    POP  1,0,6 	load adress of lhs struct
910:    LDC  0,2,0 	load offset of member
911:    ADD  0,0,1 	compute the real adress if pointK
912:   PUSH  0,0(6) 	
913:    POP  0,0(6) 	load adress from mp
914:     LD  1,0(0) 	copy bytes
915:   PUSH  1,0(6) 	push a.x value into tmp
916:    POP  0,0(6) 	pop right
917:     LD  0,2(2) 	load id value
918:   PUSH  0,0(6) 	store exp
919:    POP  1,0,6 	load adress of lhs struct
920:    LDC  0,2,0 	load offset of member
921:    ADD  0,0,1 	compute the real adress if pointK
922:   PUSH  0,0(6) 	
923:    POP  0,0(6) 	load adress from mp
924:     LD  1,0(0) 	copy bytes
925:   PUSH  1,0(6) 	push a.x value into tmp
926:    LDC  0,1(0) 	load integer const
927:   PUSH  0,0(6) 	store exp
928:    POP  1,0(6) 	pop right
929:    POP  0,0(6) 	pop left
930:    SUB  0,0,1 	op -
931:   PUSH  0,0(6) 	op: load left
932:     LD  0,2(2) 	load id value
933:   PUSH  0,0(6) 	store exp
934:    POP  1,0,6 	load adress of lhs struct
935:    LDC  0,2,0 	load offset of member
936:    ADD  0,0,1 	compute the real adress if pointK
937:   PUSH  0,0(6) 	
938:    POP  1,0(6) 	move the adress of referenced
939:    POP  0,0(6) 	copy bytes
940:     ST  0,0(1) 	copy bytes
941:    LDA  3,-1(3) 	stack expand
942:     LD  0,2(2) 	load id value
943:   PUSH  0,0(6) 	store exp
944:    POP  1,0,6 	load adress of lhs struct
945:    LDC  0,1,0 	load offset of member
946:    ADD  0,0,1 	compute the real adress if pointK
947:   PUSH  0,0(6) 	
948:    POP  0,0(6) 	load adress from mp
949:     LD  1,0(0) 	copy bytes
950:   PUSH  1,0(6) 	push a.x value into tmp
951:    POP  1,0,6 	load adress of lhs struct
952:    LDC  0,0,0 	load offset of member
953:    ADD  0,0,1 	compute the real adress if pointK
954:   PUSH  0,0(6) 	
955:    POP  0,0(6) 	load adress from mp
956:     LD  1,0(0) 	copy bytes
957:   PUSH  1,0(6) 	push a.x value into tmp
958:    LDA  0,-2(2) 	load id adress
959:   PUSH  0,0(6) 	push array adress to mp
960:    POP  1,0(6) 	move the adress of ID
961:    POP  0,0(6) 	copy bytes
962:     ST  0,0(1) 	copy bytes
963:     LD  0,0(5) 	load id value
964:   PUSH  0,0(6) 	store exp
965:     LD  0,-2(2) 	load id value
966:   PUSH  0,0(6) 	store exp
967:    POP  1,0,6 	load adress of lhs struct
968:    LDC  0,1,0 	load offset of member
969:    ADD  0,0,1 	compute the real adress if pointK
970:   PUSH  0,0(6) 	
971:    POP  1,0(6) 	move the adress of referenced
972:    POP  0,0(6) 	copy bytes
973:     ST  0,0(1) 	copy bytes
* push function parameters
974:     LD  0,2(2) 	load id value
975:   PUSH  0,0(6) 	store exp
976:    POP  1,0,6 	load adress of lhs struct
977:    LDC  0,1,0 	load offset of member
978:    ADD  0,0,1 	compute the real adress if pointK
979:   PUSH  0,0(6) 	
980:    POP  0,0(6) 	load adress from mp
981:     LD  1,0(0) 	copy bytes
982:   PUSH  1,0(6) 	push a.x value into tmp
983:    POP  0,0(6) 	copy bytes
984:   PUSH  0,0(3) 	PUSH bytes
985:     LD  0,1(2) 	load env
986:     LD  0,1(0) 	load env1
987:   PUSH  0,0(3) 	store env
* call function: 
* free
988:     LD  0,-2(5) 	load id value
989:   PUSH  0,0(6) 	store exp
990:    LDC  0,992(0) 	store the return adress
991:    POP  7,0(6) 	ujp to the function body
992:    LDA  3,1(3) 	pop parameters
993:    LDA  3,1(3) 	pop env
994:     LD  0,-2(2) 	load id value
995:   PUSH  0,0(6) 	store exp
996:     LD  0,2(2) 	load id value
997:   PUSH  0,0(6) 	store exp
998:    POP  1,0,6 	load adress of lhs struct
999:    LDC  0,1,0 	load offset of member
1000:    ADD  0,0,1 	compute the real adress if pointK
1001:   PUSH  0,0(6) 	
1002:    POP  1,0(6) 	move the adress of referenced
1003:    POP  0,0(6) 	copy bytes
1004:     ST  0,0(1) 	copy bytes
1005:    MOV  3,2,0 	restore the caller sp
1006:     LD  2,0(2) 	resotre the caller fp
1007:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1008:  LABEL  31,0,0 	generate label
* function entry:
* popLeft
1009:    LDA  3,-1(3) 	stack expand for function variable
1010:     GO  34,0,0 	go to label
1011:    MOV  1,2,0 	store the caller fp temporarily
1012:    MOV  2,3,0 	exchang the stack(context)
1013:   PUSH  1,0(3) 	push the caller fp
1014:   PUSH  0,0(3) 	push the return adress
1015:     LD  0,2(2) 	load id value
1016:   PUSH  0,0(6) 	store exp
1017:     LD  0,0(5) 	load id value
1018:   PUSH  0,0(6) 	store exp
1019:    POP  1,0(6) 	pop right
1020:    POP  0,0(6) 	pop left
1021:    SUB  0,0,1 	op ==, convertd_type
1022:    JEQ  0,2(7) 	br if true
1023:    LDC  0,0(0) 	false case
1024:    LDA  7,1(7) 	unconditional jmp
1025:    LDC  0,1(0) 	true case
1026:   PUSH  0,0(6) 	
1027:     LD  0,2(2) 	load id value
1028:   PUSH  0,0(6) 	store exp
1029:    POP  1,0,6 	load adress of lhs struct
1030:    LDC  0,2,0 	load offset of member
1031:    ADD  0,0,1 	compute the real adress if pointK
1032:   PUSH  0,0(6) 	
1033:    POP  0,0(6) 	load adress from mp
1034:     LD  1,0(0) 	copy bytes
1035:   PUSH  1,0(6) 	push a.x value into tmp
1036:    LDC  0,0(0) 	load integer const
1037:   PUSH  0,0(6) 	store exp
1038:    POP  1,0(6) 	pop right
1039:    POP  0,0(6) 	pop left
1040:    SUB  0,0,1 	op <
1041:    JLE  0,2(7) 	br if true
1042:    LDC  0,0(0) 	false case
1043:    LDA  7,1(7) 	unconditional jmp
1044:    LDC  0,1(0) 	true case
1045:   PUSH  0,0(6) 	
1046:    POP  1,0(6) 	pop right
1047:    POP  0,0(6) 	pop left
1048:    JNE  0,3(7) 	br if true
1049:    JNE  1,2(7) 	br if true
1050:    LDC  0,0(0) 	false case
1051:    LDA  7,1(7) 	unconditional jmp
1052:    LDC  0,1(0) 	true case
1053:   PUSH  0,0(6) 	
1054:    POP  0,0(6) 	pop from the mp
1055:    JNE  0,1,7 	true case:, execute if part
1056:     GO  35,0,0 	go to label
1057:    MOV  3,2,0 	restore the caller sp
1058:     LD  2,0(2) 	resotre the caller fp
1059:  RETURN  0,-1,3 	return to the caller
1060:     GO  36,0,0 	go to label
1061:  LABEL  35,0,0 	generate label
* if: jump to else
1062:  LABEL  36,0,0 	generate label
1063:     LD  0,2(2) 	load id value
1064:   PUSH  0,0(6) 	store exp
1065:    POP  1,0,6 	load adress of lhs struct
1066:    LDC  0,2,0 	load offset of member
1067:    ADD  0,0,1 	compute the real adress if pointK
1068:   PUSH  0,0(6) 	
1069:    POP  0,0(6) 	load adress from mp
1070:     LD  1,0(0) 	copy bytes
1071:   PUSH  1,0(6) 	push a.x value into tmp
1072:    POP  0,0(6) 	pop right
1073:     LD  0,2(2) 	load id value
1074:   PUSH  0,0(6) 	store exp
1075:    POP  1,0,6 	load adress of lhs struct
1076:    LDC  0,2,0 	load offset of member
1077:    ADD  0,0,1 	compute the real adress if pointK
1078:   PUSH  0,0(6) 	
1079:    POP  0,0(6) 	load adress from mp
1080:     LD  1,0(0) 	copy bytes
1081:   PUSH  1,0(6) 	push a.x value into tmp
1082:    LDC  0,1(0) 	load integer const
1083:   PUSH  0,0(6) 	store exp
1084:    POP  1,0(6) 	pop right
1085:    POP  0,0(6) 	pop left
1086:    SUB  0,0,1 	op -
1087:   PUSH  0,0(6) 	op: load left
1088:     LD  0,2(2) 	load id value
1089:   PUSH  0,0(6) 	store exp
1090:    POP  1,0,6 	load adress of lhs struct
1091:    LDC  0,2,0 	load offset of member
1092:    ADD  0,0,1 	compute the real adress if pointK
1093:   PUSH  0,0(6) 	
1094:    POP  1,0(6) 	move the adress of referenced
1095:    POP  0,0(6) 	copy bytes
1096:     ST  0,0(1) 	copy bytes
1097:    LDA  3,-1(3) 	stack expand
1098:     LD  0,2(2) 	load id value
1099:   PUSH  0,0(6) 	store exp
1100:    POP  1,0,6 	load adress of lhs struct
1101:    LDC  0,0,0 	load offset of member
1102:    ADD  0,0,1 	compute the real adress if pointK
1103:   PUSH  0,0(6) 	
1104:    POP  0,0(6) 	load adress from mp
1105:     LD  1,0(0) 	copy bytes
1106:   PUSH  1,0(6) 	push a.x value into tmp
1107:    POP  1,0,6 	load adress of lhs struct
1108:    LDC  0,1,0 	load offset of member
1109:    ADD  0,0,1 	compute the real adress if pointK
1110:   PUSH  0,0(6) 	
1111:    POP  0,0(6) 	load adress from mp
1112:     LD  1,0(0) 	copy bytes
1113:   PUSH  1,0(6) 	push a.x value into tmp
1114:    POP  1,0,6 	load adress of lhs struct
1115:    LDC  0,1,0 	load offset of member
1116:    ADD  0,0,1 	compute the real adress if pointK
1117:   PUSH  0,0(6) 	
1118:    POP  0,0(6) 	load adress from mp
1119:     LD  1,0(0) 	copy bytes
1120:   PUSH  1,0(6) 	push a.x value into tmp
1121:    LDA  0,-2(2) 	load id adress
1122:   PUSH  0,0(6) 	push array adress to mp
1123:    POP  1,0(6) 	move the adress of ID
1124:    POP  0,0(6) 	copy bytes
1125:     ST  0,0(1) 	copy bytes
* push function parameters
1126:     LD  0,2(2) 	load id value
1127:   PUSH  0,0(6) 	store exp
1128:    POP  1,0,6 	load adress of lhs struct
1129:    LDC  0,0,0 	load offset of member
1130:    ADD  0,0,1 	compute the real adress if pointK
1131:   PUSH  0,0(6) 	
1132:    POP  0,0(6) 	load adress from mp
1133:     LD  1,0(0) 	copy bytes
1134:   PUSH  1,0(6) 	push a.x value into tmp
1135:    POP  1,0,6 	load adress of lhs struct
1136:    LDC  0,1,0 	load offset of member
1137:    ADD  0,0,1 	compute the real adress if pointK
1138:   PUSH  0,0(6) 	
1139:    POP  0,0(6) 	load adress from mp
1140:     LD  1,0(0) 	copy bytes
1141:   PUSH  1,0(6) 	push a.x value into tmp
1142:    POP  0,0(6) 	copy bytes
1143:   PUSH  0,0(3) 	PUSH bytes
1144:     LD  0,1(2) 	load env
1145:     LD  0,1(0) 	load env1
1146:   PUSH  0,0(3) 	store env
* call function: 
* free
1147:     LD  0,-2(5) 	load id value
1148:   PUSH  0,0(6) 	store exp
1149:    LDC  0,1151(0) 	store the return adress
1150:    POP  7,0(6) 	ujp to the function body
1151:    LDA  3,1(3) 	pop parameters
1152:    LDA  3,1(3) 	pop env
1153:     LD  0,-2(2) 	load id value
1154:   PUSH  0,0(6) 	store exp
1155:     LD  0,2(2) 	load id value
1156:   PUSH  0,0(6) 	store exp
1157:    POP  1,0,6 	load adress of lhs struct
1158:    LDC  0,0,0 	load offset of member
1159:    ADD  0,0,1 	compute the real adress if pointK
1160:   PUSH  0,0(6) 	
1161:    POP  0,0(6) 	load adress from mp
1162:     LD  1,0(0) 	copy bytes
1163:   PUSH  1,0(6) 	push a.x value into tmp
1164:    POP  1,0,6 	load adress of lhs struct
1165:    LDC  0,1,0 	load offset of member
1166:    ADD  0,0,1 	compute the real adress if pointK
1167:   PUSH  0,0(6) 	
1168:    POP  1,0(6) 	move the adress of referenced
1169:    POP  0,0(6) 	copy bytes
1170:     ST  0,0(1) 	copy bytes
1171:     LD  0,-2(2) 	load id value
1172:   PUSH  0,0(6) 	store exp
1173:     LD  0,0(5) 	load id value
1174:   PUSH  0,0(6) 	store exp
1175:    POP  1,0(6) 	pop right
1176:    POP  0,0(6) 	pop left
1177:    SUB  0,0,1 	op ==, convertd_type
1178:    JNE  0,2(7) 	br if true
1179:    LDC  0,0(0) 	false case
1180:    LDA  7,1(7) 	unconditional jmp
1181:    LDC  0,1(0) 	true case
1182:   PUSH  0,0(6) 	
1183:    POP  0,0(6) 	pop from the mp
1184:    JNE  0,1,7 	true case:, execute if part
1185:     GO  37,0,0 	go to label
1186:     LD  0,2(2) 	load id value
1187:   PUSH  0,0(6) 	store exp
1188:    POP  1,0,6 	load adress of lhs struct
1189:    LDC  0,0,0 	load offset of member
1190:    ADD  0,0,1 	compute the real adress if pointK
1191:   PUSH  0,0(6) 	
1192:    POP  0,0(6) 	load adress from mp
1193:     LD  1,0(0) 	copy bytes
1194:   PUSH  1,0(6) 	push a.x value into tmp
1195:     LD  0,-2(2) 	load id value
1196:   PUSH  0,0(6) 	store exp
1197:    POP  1,0,6 	load adress of lhs struct
1198:    LDC  0,0,0 	load offset of member
1199:    ADD  0,0,1 	compute the real adress if pointK
1200:   PUSH  0,0(6) 	
1201:    POP  1,0(6) 	move the adress of referenced
1202:    POP  0,0(6) 	copy bytes
1203:     ST  0,0(1) 	copy bytes
1204:     GO  38,0,0 	go to label
1205:  LABEL  37,0,0 	generate label
* if: jump to else
1206:  LABEL  38,0,0 	generate label
1207:    MOV  3,2,0 	restore the caller sp
1208:     LD  2,0(2) 	resotre the caller fp
1209:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1210:  LABEL  34,0,0 	generate label
* function entry:
* createListNode
1211:    LDA  3,-1(3) 	stack expand for function variable
1212:    LDC  0,1215(0) 	get function adress
1213:     ST  0,-4(5) 	set function adress
1214:     GO  39,0,0 	go to label
1215:    MOV  1,2,0 	store the caller fp temporarily
1216:    MOV  2,3,0 	exchang the stack(context)
1217:   PUSH  1,0(3) 	push the caller fp
1218:   PUSH  0,0(3) 	push the return adress
1219:    LDA  3,-1(3) 	stack expand
* push function parameters
1220:    LDC  0,3,0 	load size of exp
1221:   PUSH  0,0(6) 	
1222:    POP  0,0(6) 	copy bytes
1223:   PUSH  0,0(3) 	PUSH bytes
1224:     LD  0,1(2) 	load env
1225:   PUSH  0,0(3) 	store env
* call function: 
* malloc
1226:     LD  0,-1(5) 	load id value
1227:   PUSH  0,0(6) 	store exp
1228:    LDC  0,1230(0) 	store the return adress
1229:    POP  7,0(6) 	ujp to the function body
1230:    LDA  3,1(3) 	pop parameters
1231:    LDA  3,1(3) 	pop env
1232:    LDA  0,-2(2) 	load id adress
1233:   PUSH  0,0(6) 	push array adress to mp
1234:    POP  1,0(6) 	move the adress of ID
1235:    POP  0,0(6) 	copy bytes
1236:     ST  0,0(1) 	copy bytes
1237:     LD  0,0(5) 	load id value
1238:   PUSH  0,0(6) 	store exp
1239:     LD  0,-2(2) 	load id value
1240:   PUSH  0,0(6) 	store exp
1241:    POP  1,0,6 	load adress of lhs struct
1242:    LDC  0,0,0 	load offset of member
1243:    ADD  0,0,1 	compute the real adress if pointK
1244:   PUSH  0,0(6) 	
1245:    POP  1,0(6) 	move the adress of referenced
1246:    POP  0,0(6) 	copy bytes
1247:     ST  0,0(1) 	copy bytes
1248:     LD  0,0(5) 	load id value
1249:   PUSH  0,0(6) 	store exp
1250:     LD  0,-2(2) 	load id value
1251:   PUSH  0,0(6) 	store exp
1252:    POP  1,0,6 	load adress of lhs struct
1253:    LDC  0,1,0 	load offset of member
1254:    ADD  0,0,1 	compute the real adress if pointK
1255:   PUSH  0,0(6) 	
1256:    POP  1,0(6) 	move the adress of referenced
1257:    POP  0,0(6) 	copy bytes
1258:     ST  0,0(1) 	copy bytes
1259:     LD  0,0(5) 	load id value
1260:   PUSH  0,0(6) 	store exp
1261:     LD  0,-2(2) 	load id value
1262:   PUSH  0,0(6) 	store exp
1263:    POP  1,0,6 	load adress of lhs struct
1264:    LDC  0,2,0 	load offset of member
1265:    ADD  0,0,1 	compute the real adress if pointK
1266:   PUSH  0,0(6) 	
1267:    POP  1,0(6) 	move the adress of referenced
1268:    POP  0,0(6) 	copy bytes
1269:     ST  0,0(1) 	copy bytes
1270:     LD  0,-2(2) 	load id value
1271:   PUSH  0,0(6) 	store exp
1272:    MOV  3,2,0 	restore the caller sp
1273:     LD  2,0(2) 	resotre the caller fp
1274:  RETURN  0,-1,3 	return to the caller
1275:    MOV  3,2,0 	restore the caller sp
1276:     LD  2,0(2) 	resotre the caller fp
1277:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1278:  LABEL  39,0,0 	generate label
* function entry:
* createList
1279:    LDA  3,-1(3) 	stack expand for function variable
1280:    LDC  0,1283(0) 	get function adress
1281:     ST  0,-5(5) 	set function adress
1282:     GO  40,0,0 	go to label
1283:    MOV  1,2,0 	store the caller fp temporarily
1284:    MOV  2,3,0 	exchang the stack(context)
1285:   PUSH  1,0(3) 	push the caller fp
1286:   PUSH  0,0(3) 	push the return adress
1287:    LDA  3,-11(3) 	stack expand
1288:    LDC  1,122(0) 	get function adress from struct
1289:     ST  1,4(3) 	Init Struct Instance
1290:    LDC  1,132(0) 	get function adress from struct
1291:     ST  1,5(3) 	Init Struct Instance
1292:    LDC  1,142(0) 	get function adress from struct
1293:     ST  1,6(3) 	Init Struct Instance
1294:    LDC  1,152(0) 	get function adress from struct
1295:     ST  1,7(3) 	Init Struct Instance
1296:    LDC  1,466(0) 	get function adress from struct
1297:     ST  1,8(3) 	Init Struct Instance
1298:    LDC  1,589(0) 	get function adress from struct
1299:     ST  1,9(3) 	Init Struct Instance
1300:    LDC  1,855(0) 	get function adress from struct
1301:     ST  1,10(3) 	Init Struct Instance
1302:    LDC  1,1011(0) 	get function adress from struct
1303:     ST  1,11(3) 	Init Struct Instance
1304:    LDA  3,-1(3) 	stack expand
1305:    LDC  0,0(0) 	load integer const
1306:   PUSH  0,0(6) 	store exp
1307:    LDA  0,-13(2) 	load id adress
1308:   PUSH  0,0(6) 	push array adress to mp
1309:    POP  1,0(6) 	move the adress of ID
1310:    POP  0,0(6) 	copy bytes
1311:     ST  0,0(1) 	copy bytes
1312:     LD  0,1(2) 	load env
1313:   PUSH  0,0(3) 	store env
* call function: 
* createListNode
1314:     LD  0,-4(5) 	load id value
1315:   PUSH  0,0(6) 	store exp
1316:    LDC  0,1318(0) 	store the return adress
1317:    POP  7,0(6) 	ujp to the function body
1318:    LDA  3,0(3) 	pop parameters
1319:    LDA  3,1(3) 	pop env
1320:    LDA  0,-12(2) 	load id adress
1321:   PUSH  0,0(6) 	push array adress to mp
1322:    POP  1,0,6 	load adress of lhs struct
1323:    LDC  0,0,0 	load offset of member
1324:    ADD  0,0,1 	compute the real adress if pointK
1325:   PUSH  0,0(6) 	
1326:    POP  1,0(6) 	move the adress of referenced
1327:    POP  0,0(6) 	copy bytes
1328:     ST  0,0(1) 	copy bytes
1329:    LDA  0,-12(2) 	load id adress
1330:   PUSH  0,0(6) 	push array adress to mp
1331:    POP  1,0,6 	load adress of lhs struct
1332:    LDC  0,0,0 	load offset of member
1333:    ADD  0,0,1 	compute the real adress if pointK
1334:   PUSH  0,0(6) 	
1335:    POP  0,0(6) 	load adress from mp
1336:     LD  1,0(0) 	copy bytes
1337:   PUSH  1,0(6) 	push a.x value into tmp
1338:    LDA  0,-12(2) 	load id adress
1339:   PUSH  0,0(6) 	push array adress to mp
1340:    POP  1,0,6 	load adress of lhs struct
1341:    LDC  0,1,0 	load offset of member
1342:    ADD  0,0,1 	compute the real adress if pointK
1343:   PUSH  0,0(6) 	
1344:    POP  1,0(6) 	move the adress of referenced
1345:    POP  0,0(6) 	copy bytes
1346:     ST  0,0(1) 	copy bytes
1347:    LDC  0,0(0) 	load integer const
1348:   PUSH  0,0(6) 	store exp
1349:    LDA  0,-12(2) 	load id adress
1350:   PUSH  0,0(6) 	push array adress to mp
1351:    POP  1,0,6 	load adress of lhs struct
1352:    LDC  0,2,0 	load offset of member
1353:    ADD  0,0,1 	compute the real adress if pointK
1354:   PUSH  0,0(6) 	
1355:    POP  1,0(6) 	move the adress of referenced
1356:    POP  0,0(6) 	copy bytes
1357:     ST  0,0(1) 	copy bytes
1358:     LD  0,-12(2) 	load id value
1359:   PUSH  0,0(6) 	store exp
1360:     LD  0,-11(2) 	load id value
1361:   PUSH  0,0(6) 	store exp
1362:     LD  0,-10(2) 	load id value
1363:   PUSH  0,0(6) 	store exp
1364:     LD  0,-9(2) 	load id value
1365:   PUSH  0,0(6) 	store exp
1366:     LD  0,-8(2) 	load id value
1367:   PUSH  0,0(6) 	store exp
1368:     LD  0,-7(2) 	load id value
1369:   PUSH  0,0(6) 	store exp
1370:     LD  0,-6(2) 	load id value
1371:   PUSH  0,0(6) 	store exp
1372:     LD  0,-5(2) 	load id value
1373:   PUSH  0,0(6) 	store exp
1374:     LD  0,-4(2) 	load id value
1375:   PUSH  0,0(6) 	store exp
1376:     LD  0,-3(2) 	load id value
1377:   PUSH  0,0(6) 	store exp
1378:     LD  0,-2(2) 	load id value
1379:   PUSH  0,0(6) 	store exp
1380:    MOV  3,2,0 	restore the caller sp
1381:     LD  2,0(2) 	resotre the caller fp
1382:  RETURN  0,-1,3 	return to the caller
1383:    MOV  3,2,0 	restore the caller sp
1384:     LD  2,0(2) 	resotre the caller fp
1385:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1386:  LABEL  40,0,0 	generate label
* call main function
* File: list_example.tm
* Standard prelude:
1387:    LDC  6,65535(0) 	load mp adress
1388:     ST  0,0(0) 	clear location 0
1389:    LDC  5,4095(0) 	load gp adress from location 1
1390:     ST  0,1(0) 	clear location 1
1391:    LDC  4,2000(0) 	load gp adress from location 1
1392:    LDC  2,60000(0) 	load first fp from location 2
1393:    LDC  3,60000(0) 	load first sp from location 2
1394:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* makeNode
1395:    LDA  3,-1(3) 	stack expand for function variable
1396:    LDC  0,1399(0) 	get function adress
1397:     ST  0,-6(5) 	set function adress
1398:     GO  41,0,0 	go to label
1399:    MOV  1,2,0 	store the caller fp temporarily
1400:    MOV  2,3,0 	exchang the stack(context)
1401:   PUSH  1,0(3) 	push the caller fp
1402:   PUSH  0,0(3) 	push the return adress
1403:    LDA  3,-1(3) 	stack expand
1404:     LD  0,1(2) 	load env
1405:   PUSH  0,0(3) 	store env
* call function: 
* createListNode
1406:     LD  0,-4(5) 	load id value
1407:   PUSH  0,0(6) 	store exp
1408:    LDC  0,1410(0) 	store the return adress
1409:    POP  7,0(6) 	ujp to the function body
1410:    LDA  3,0(3) 	pop parameters
1411:    LDA  3,1(3) 	pop env
1412:    LDA  0,-2(2) 	load id adress
1413:   PUSH  0,0(6) 	push array adress to mp
1414:    POP  1,0(6) 	move the adress of ID
1415:    POP  0,0(6) 	copy bytes
1416:     ST  0,0(1) 	copy bytes
* push function parameters
1417:    LDC  0,1,0 	load size of exp
1418:   PUSH  0,0(6) 	
1419:    POP  0,0(6) 	copy bytes
1420:   PUSH  0,0(3) 	PUSH bytes
1421:     LD  0,1(2) 	load env
1422:   PUSH  0,0(3) 	store env
* call function: 
* malloc
1423:     LD  0,-1(5) 	load id value
1424:   PUSH  0,0(6) 	store exp
1425:    LDC  0,1427(0) 	store the return adress
1426:    POP  7,0(6) 	ujp to the function body
1427:    LDA  3,1(3) 	pop parameters
1428:    LDA  3,1(3) 	pop env
1429:     LD  0,-2(2) 	load id value
1430:   PUSH  0,0(6) 	store exp
1431:    POP  1,0,6 	load adress of lhs struct
1432:    LDC  0,2,0 	load offset of member
1433:    ADD  0,0,1 	compute the real adress if pointK
1434:   PUSH  0,0(6) 	
1435:    POP  1,0(6) 	move the adress of referenced
1436:    POP  0,0(6) 	copy bytes
1437:     ST  0,0(1) 	copy bytes
1438:     LD  0,2(2) 	load id value
1439:   PUSH  0,0(6) 	store exp
1440:     LD  0,-2(2) 	load id value
1441:   PUSH  0,0(6) 	store exp
1442:    POP  1,0,6 	load adress of lhs struct
1443:    LDC  0,2,0 	load offset of member
1444:    ADD  0,0,1 	compute the real adress if pointK
1445:   PUSH  0,0(6) 	
1446:    POP  0,0(6) 	load adress from mp
1447:     LD  1,0(0) 	copy bytes
1448:   PUSH  1,0(6) 	push a.x value into tmp
1449:    POP  0,0(6) 	pop right
1450:   PUSH  0,0(6) 	
1451:    POP  1,0(6) 	move the adress of referenced
1452:    POP  0,0(6) 	copy bytes
1453:     ST  0,0(1) 	copy bytes
1454:     LD  0,-2(2) 	load id value
1455:   PUSH  0,0(6) 	store exp
1456:    MOV  3,2,0 	restore the caller sp
1457:     LD  2,0(2) 	resotre the caller fp
1458:  RETURN  0,-1,3 	return to the caller
1459:    MOV  3,2,0 	restore the caller sp
1460:     LD  2,0(2) 	resotre the caller fp
1461:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1462:  LABEL  41,0,0 	generate label
* function entry:
* makeList
1463:    LDA  3,-1(3) 	stack expand for function variable
1464:    LDC  0,1467(0) 	get function adress
1465:     ST  0,-7(5) 	set function adress
1466:     GO  42,0,0 	go to label
1467:    MOV  1,2,0 	store the caller fp temporarily
1468:    MOV  2,3,0 	exchang the stack(context)
1469:   PUSH  1,0(3) 	push the caller fp
1470:   PUSH  0,0(3) 	push the return adress
* function entry:
* compare
1471:    LDA  3,-1(3) 	stack expand for function variable
1472:    LDC  0,1475(0) 	get function adress
1473:     ST  0,-2(2) 	set function adress
1474:     GO  43,0,0 	go to label
1475:    MOV  1,2,0 	store the caller fp temporarily
1476:    MOV  2,3,0 	exchang the stack(context)
1477:   PUSH  1,0(3) 	push the caller fp
1478:   PUSH  0,0(3) 	push the return adress
1479:    LDA  3,-1(3) 	stack expand
1480:     LD  0,2(2) 	load id value
1481:   PUSH  0,0(6) 	store exp
1482:    POP  0,0(6) 	pop right
1483:   PUSH  0,0(6) 	
1484:    POP  0,0(6) 	pop the adress
1485:     LD  1,0(0) 	load bytes
1486:   PUSH  1,0(6) 	push bytes 
1487:    LDA  0,-2(2) 	load id adress
1488:   PUSH  0,0(6) 	push array adress to mp
1489:    POP  1,0(6) 	move the adress of ID
1490:    POP  0,0(6) 	copy bytes
1491:     ST  0,0(1) 	copy bytes
1492:    LDA  3,-1(3) 	stack expand
1493:     LD  0,3(2) 	load id value
1494:   PUSH  0,0(6) 	store exp
1495:    POP  0,0(6) 	pop right
1496:   PUSH  0,0(6) 	
1497:    POP  0,0(6) 	pop the adress
1498:     LD  1,0(0) 	load bytes
1499:   PUSH  1,0(6) 	push bytes 
1500:    LDA  0,-3(2) 	load id adress
1501:   PUSH  0,0(6) 	push array adress to mp
1502:    POP  1,0(6) 	move the adress of ID
1503:    POP  0,0(6) 	copy bytes
1504:     ST  0,0(1) 	copy bytes
1505:     LD  0,-2(2) 	load id value
1506:   PUSH  0,0(6) 	store exp
1507:     LD  0,-3(2) 	load id value
1508:   PUSH  0,0(6) 	store exp
1509:    POP  1,0(6) 	pop right
1510:    POP  0,0(6) 	pop left
1511:    SUB  0,0,1 	op <
1512:    JLT  0,2(7) 	br if true
1513:    LDC  0,0(0) 	false case
1514:    LDA  7,1(7) 	unconditional jmp
1515:    LDC  0,1(0) 	true case
1516:   PUSH  0,0(6) 	
1517:    POP  0,0(6) 	pop from the mp
1518:    JNE  0,1,7 	true case:, execute if part
1519:     GO  44,0,0 	go to label
1520:    LDC  0,10(0) 	load integer const
1521:   PUSH  0,0(6) 	store exp
1522:    POP  0,0(6) 	pop right
1523:    NEG  0,0,0 	single op (-)
1524:   PUSH  0,0(6) 	op: load left
1525:    MOV  3,2,0 	restore the caller sp
1526:     LD  2,0(2) 	resotre the caller fp
1527:  RETURN  0,-1,3 	return to the caller
1528:     GO  45,0,0 	go to label
1529:  LABEL  44,0,0 	generate label
* if: jump to else
1530:  LABEL  45,0,0 	generate label
1531:     LD  0,-2(2) 	load id value
1532:   PUSH  0,0(6) 	store exp
1533:     LD  0,-3(2) 	load id value
1534:   PUSH  0,0(6) 	store exp
1535:    POP  1,0(6) 	pop right
1536:    POP  0,0(6) 	pop left
1537:    SUB  0,0,1 	op <
1538:    JGT  0,2(7) 	br if true
1539:    LDC  0,0(0) 	false case
1540:    LDA  7,1(7) 	unconditional jmp
1541:    LDC  0,1(0) 	true case
1542:   PUSH  0,0(6) 	
1543:    POP  0,0(6) 	pop from the mp
1544:    JNE  0,1,7 	true case:, execute if part
1545:     GO  46,0,0 	go to label
1546:    LDC  0,10(0) 	load integer const
1547:   PUSH  0,0(6) 	store exp
1548:    MOV  3,2,0 	restore the caller sp
1549:     LD  2,0(2) 	resotre the caller fp
1550:  RETURN  0,-1,3 	return to the caller
1551:     GO  47,0,0 	go to label
1552:  LABEL  46,0,0 	generate label
* if: jump to else
1553:  LABEL  47,0,0 	generate label
1554:    LDC  0,0(0) 	load integer const
1555:   PUSH  0,0(6) 	store exp
1556:    MOV  3,2,0 	restore the caller sp
1557:     LD  2,0(2) 	resotre the caller fp
1558:  RETURN  0,-1,3 	return to the caller
1559:    MOV  3,2,0 	restore the caller sp
1560:     LD  2,0(2) 	resotre the caller fp
1561:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1562:  LABEL  43,0,0 	generate label
1563:    LDA  3,-11(3) 	stack expand
1564:    LDC  1,122(0) 	get function adress from struct
1565:     ST  1,4(3) 	Init Struct Instance
1566:    LDC  1,132(0) 	get function adress from struct
1567:     ST  1,5(3) 	Init Struct Instance
1568:    LDC  1,142(0) 	get function adress from struct
1569:     ST  1,6(3) 	Init Struct Instance
1570:    LDC  1,152(0) 	get function adress from struct
1571:     ST  1,7(3) 	Init Struct Instance
1572:    LDC  1,466(0) 	get function adress from struct
1573:     ST  1,8(3) 	Init Struct Instance
1574:    LDC  1,589(0) 	get function adress from struct
1575:     ST  1,9(3) 	Init Struct Instance
1576:    LDC  1,855(0) 	get function adress from struct
1577:     ST  1,10(3) 	Init Struct Instance
1578:    LDC  1,1011(0) 	get function adress from struct
1579:     ST  1,11(3) 	Init Struct Instance
1580:     LD  0,1(2) 	load env
1581:   PUSH  0,0(3) 	store env
* call function: 
* createList
1582:     LD  0,-5(5) 	load id value
1583:   PUSH  0,0(6) 	store exp
1584:    LDC  0,1586(0) 	store the return adress
1585:    POP  7,0(6) 	ujp to the function body
1586:    LDA  3,0(3) 	pop parameters
1587:    LDA  3,1(3) 	pop env
1588:    LDA  0,-13(2) 	load id adress
1589:   PUSH  0,0(6) 	push array adress to mp
1590:    POP  1,0(6) 	move the adress of ID
1591:    POP  0,0(6) 	copy bytes
1592:     ST  0,10(1) 	copy bytes
1593:    POP  0,0(6) 	copy bytes
1594:     ST  0,9(1) 	copy bytes
1595:    POP  0,0(6) 	copy bytes
1596:     ST  0,8(1) 	copy bytes
1597:    POP  0,0(6) 	copy bytes
1598:     ST  0,7(1) 	copy bytes
1599:    POP  0,0(6) 	copy bytes
1600:     ST  0,6(1) 	copy bytes
1601:    POP  0,0(6) 	copy bytes
1602:     ST  0,5(1) 	copy bytes
1603:    POP  0,0(6) 	copy bytes
1604:     ST  0,4(1) 	copy bytes
1605:    POP  0,0(6) 	copy bytes
1606:     ST  0,3(1) 	copy bytes
1607:    POP  0,0(6) 	copy bytes
1608:     ST  0,2(1) 	copy bytes
1609:    POP  0,0(6) 	copy bytes
1610:     ST  0,1(1) 	copy bytes
1611:    POP  0,0(6) 	copy bytes
1612:     ST  0,0(1) 	copy bytes
1613:     LD  0,-2(2) 	load id value
1614:   PUSH  0,0(6) 	store exp
1615:    LDA  0,-13(2) 	load id adress
1616:   PUSH  0,0(6) 	push array adress to mp
1617:    POP  1,0,6 	load adress of lhs struct
1618:    LDC  0,5,0 	load offset of member
1619:    ADD  0,0,1 	compute the real adress if pointK
1620:   PUSH  0,0(6) 	
1621:    POP  1,0(6) 	move the adress of referenced
1622:    POP  0,0(6) 	copy bytes
1623:     ST  0,0(1) 	copy bytes
1624:     LD  0,-13(2) 	load id value
1625:   PUSH  0,0(6) 	store exp
1626:     LD  0,-12(2) 	load id value
1627:   PUSH  0,0(6) 	store exp
1628:     LD  0,-11(2) 	load id value
1629:   PUSH  0,0(6) 	store exp
1630:     LD  0,-10(2) 	load id value
1631:   PUSH  0,0(6) 	store exp
1632:     LD  0,-9(2) 	load id value
1633:   PUSH  0,0(6) 	store exp
1634:     LD  0,-8(2) 	load id value
1635:   PUSH  0,0(6) 	store exp
1636:     LD  0,-7(2) 	load id value
1637:   PUSH  0,0(6) 	store exp
1638:     LD  0,-6(2) 	load id value
1639:   PUSH  0,0(6) 	store exp
1640:     LD  0,-5(2) 	load id value
1641:   PUSH  0,0(6) 	store exp
1642:     LD  0,-4(2) 	load id value
1643:   PUSH  0,0(6) 	store exp
1644:     LD  0,-3(2) 	load id value
1645:   PUSH  0,0(6) 	store exp
1646:    MOV  3,2,0 	restore the caller sp
1647:     LD  2,0(2) 	resotre the caller fp
1648:  RETURN  0,-1,3 	return to the caller
1649:    MOV  3,2,0 	restore the caller sp
1650:     LD  2,0(2) 	resotre the caller fp
1651:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1652:  LABEL  42,0,0 	generate label
* function entry:
* test_insertSortedList
1653:    LDA  3,-1(3) 	stack expand for function variable
1654:    LDC  0,1657(0) 	get function adress
1655:     ST  0,-8(5) 	set function adress
1656:     GO  48,0,0 	go to label
1657:    MOV  1,2,0 	store the caller fp temporarily
1658:    MOV  2,3,0 	exchang the stack(context)
1659:   PUSH  1,0(3) 	push the caller fp
1660:   PUSH  0,0(3) 	push the return adress
1661:    LDA  3,-11(3) 	stack expand
1662:    LDC  1,122(0) 	get function adress from struct
1663:     ST  1,4(3) 	Init Struct Instance
1664:    LDC  1,132(0) 	get function adress from struct
1665:     ST  1,5(3) 	Init Struct Instance
1666:    LDC  1,142(0) 	get function adress from struct
1667:     ST  1,6(3) 	Init Struct Instance
1668:    LDC  1,152(0) 	get function adress from struct
1669:     ST  1,7(3) 	Init Struct Instance
1670:    LDC  1,466(0) 	get function adress from struct
1671:     ST  1,8(3) 	Init Struct Instance
1672:    LDC  1,589(0) 	get function adress from struct
1673:     ST  1,9(3) 	Init Struct Instance
1674:    LDC  1,855(0) 	get function adress from struct
1675:     ST  1,10(3) 	Init Struct Instance
1676:    LDC  1,1011(0) 	get function adress from struct
1677:     ST  1,11(3) 	Init Struct Instance
1678:     LD  0,1(2) 	load env
1679:   PUSH  0,0(3) 	store env
* call function: 
* makeList
1680:     LD  0,-7(5) 	load id value
1681:   PUSH  0,0(6) 	store exp
1682:    LDC  0,1684(0) 	store the return adress
1683:    POP  7,0(6) 	ujp to the function body
1684:    LDA  3,0(3) 	pop parameters
1685:    LDA  3,1(3) 	pop env
1686:    LDA  0,-12(2) 	load id adress
1687:   PUSH  0,0(6) 	push array adress to mp
1688:    POP  1,0(6) 	move the adress of ID
1689:    POP  0,0(6) 	copy bytes
1690:     ST  0,10(1) 	copy bytes
1691:    POP  0,0(6) 	copy bytes
1692:     ST  0,9(1) 	copy bytes
1693:    POP  0,0(6) 	copy bytes
1694:     ST  0,8(1) 	copy bytes
1695:    POP  0,0(6) 	copy bytes
1696:     ST  0,7(1) 	copy bytes
1697:    POP  0,0(6) 	copy bytes
1698:     ST  0,6(1) 	copy bytes
1699:    POP  0,0(6) 	copy bytes
1700:     ST  0,5(1) 	copy bytes
1701:    POP  0,0(6) 	copy bytes
1702:     ST  0,4(1) 	copy bytes
1703:    POP  0,0(6) 	copy bytes
1704:     ST  0,3(1) 	copy bytes
1705:    POP  0,0(6) 	copy bytes
1706:     ST  0,2(1) 	copy bytes
1707:    POP  0,0(6) 	copy bytes
1708:     ST  0,1(1) 	copy bytes
1709:    POP  0,0(6) 	copy bytes
1710:     ST  0,0(1) 	copy bytes
* push function parameters
* push function parameters
1711:    LDC  0,1(0) 	load integer const
1712:   PUSH  0,0(6) 	store exp
1713:    POP  0,0(6) 	pop right
1714:    NEG  0,0,0 	single op (-)
1715:   PUSH  0,0(6) 	op: load left
1716:    POP  0,0(6) 	copy bytes
1717:   PUSH  0,0(3) 	PUSH bytes
1718:     LD  0,1(2) 	load env
1719:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1720:     LD  0,-6(5) 	load id value
1721:   PUSH  0,0(6) 	store exp
1722:    LDC  0,1724(0) 	store the return adress
1723:    POP  7,0(6) 	ujp to the function body
1724:    LDA  3,1(3) 	pop parameters
1725:    LDA  3,1(3) 	pop env
1726:    POP  0,0(6) 	copy bytes
1727:   PUSH  0,0(3) 	PUSH bytes
1728:    LDA  0,-12(2) 	load id adress
1729:   PUSH  0,0(6) 	push array adress to mp
1730:    POP  0,0(6) 	
1731:   PUSH  0,0(3) 	
1732:    LDA  0,0(2) 	load env
1733:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1734:    LDA  0,-12(2) 	load id adress
1735:   PUSH  0,0(6) 	push array adress to mp
1736:    POP  1,0,6 	load adress of lhs struct
1737:    LDC  0,8,0 	load offset of member
1738:    ADD  0,0,1 	compute the real adress if pointK
1739:   PUSH  0,0(6) 	
1740:    POP  0,0(6) 	load adress from mp
1741:     LD  1,0(0) 	copy bytes
1742:   PUSH  1,0(6) 	push a.x value into tmp
1743:    LDC  0,1745(0) 	store the return adress
1744:    POP  7,0(6) 	ujp to the function body
1745:    LDA  3,1(3) 	pop parameters
1746:    LDA  3,1(3) 	pop env
1747:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1748:    LDC  0,1(0) 	load integer const
1749:   PUSH  0,0(6) 	store exp
1750:    POP  0,0(6) 	copy bytes
1751:   PUSH  0,0(3) 	PUSH bytes
1752:     LD  0,1(2) 	load env
1753:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1754:     LD  0,-6(5) 	load id value
1755:   PUSH  0,0(6) 	store exp
1756:    LDC  0,1758(0) 	store the return adress
1757:    POP  7,0(6) 	ujp to the function body
1758:    LDA  3,1(3) 	pop parameters
1759:    LDA  3,1(3) 	pop env
1760:    POP  0,0(6) 	copy bytes
1761:   PUSH  0,0(3) 	PUSH bytes
1762:    LDA  0,-12(2) 	load id adress
1763:   PUSH  0,0(6) 	push array adress to mp
1764:    POP  0,0(6) 	
1765:   PUSH  0,0(3) 	
1766:    LDA  0,0(2) 	load env
1767:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1768:    LDA  0,-12(2) 	load id adress
1769:   PUSH  0,0(6) 	push array adress to mp
1770:    POP  1,0,6 	load adress of lhs struct
1771:    LDC  0,8,0 	load offset of member
1772:    ADD  0,0,1 	compute the real adress if pointK
1773:   PUSH  0,0(6) 	
1774:    POP  0,0(6) 	load adress from mp
1775:     LD  1,0(0) 	copy bytes
1776:   PUSH  1,0(6) 	push a.x value into tmp
1777:    LDC  0,1779(0) 	store the return adress
1778:    POP  7,0(6) 	ujp to the function body
1779:    LDA  3,1(3) 	pop parameters
1780:    LDA  3,1(3) 	pop env
1781:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1782:    LDC  0,20(0) 	load integer const
1783:   PUSH  0,0(6) 	store exp
1784:    POP  0,0(6) 	pop right
1785:    NEG  0,0,0 	single op (-)
1786:   PUSH  0,0(6) 	op: load left
1787:    POP  0,0(6) 	copy bytes
1788:   PUSH  0,0(3) 	PUSH bytes
1789:     LD  0,1(2) 	load env
1790:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1791:     LD  0,-6(5) 	load id value
1792:   PUSH  0,0(6) 	store exp
1793:    LDC  0,1795(0) 	store the return adress
1794:    POP  7,0(6) 	ujp to the function body
1795:    LDA  3,1(3) 	pop parameters
1796:    LDA  3,1(3) 	pop env
1797:    POP  0,0(6) 	copy bytes
1798:   PUSH  0,0(3) 	PUSH bytes
1799:    LDA  0,-12(2) 	load id adress
1800:   PUSH  0,0(6) 	push array adress to mp
1801:    POP  0,0(6) 	
1802:   PUSH  0,0(3) 	
1803:    LDA  0,0(2) 	load env
1804:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1805:    LDA  0,-12(2) 	load id adress
1806:   PUSH  0,0(6) 	push array adress to mp
1807:    POP  1,0,6 	load adress of lhs struct
1808:    LDC  0,8,0 	load offset of member
1809:    ADD  0,0,1 	compute the real adress if pointK
1810:   PUSH  0,0(6) 	
1811:    POP  0,0(6) 	load adress from mp
1812:     LD  1,0(0) 	copy bytes
1813:   PUSH  1,0(6) 	push a.x value into tmp
1814:    LDC  0,1816(0) 	store the return adress
1815:    POP  7,0(6) 	ujp to the function body
1816:    LDA  3,1(3) 	pop parameters
1817:    LDA  3,1(3) 	pop env
1818:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1819:    LDC  0,20(0) 	load integer const
1820:   PUSH  0,0(6) 	store exp
1821:    POP  0,0(6) 	pop right
1822:    NEG  0,0,0 	single op (-)
1823:   PUSH  0,0(6) 	op: load left
1824:    POP  0,0(6) 	copy bytes
1825:   PUSH  0,0(3) 	PUSH bytes
1826:     LD  0,1(2) 	load env
1827:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1828:     LD  0,-6(5) 	load id value
1829:   PUSH  0,0(6) 	store exp
1830:    LDC  0,1832(0) 	store the return adress
1831:    POP  7,0(6) 	ujp to the function body
1832:    LDA  3,1(3) 	pop parameters
1833:    LDA  3,1(3) 	pop env
1834:    POP  0,0(6) 	copy bytes
1835:   PUSH  0,0(3) 	PUSH bytes
1836:    LDA  0,-12(2) 	load id adress
1837:   PUSH  0,0(6) 	push array adress to mp
1838:    POP  0,0(6) 	
1839:   PUSH  0,0(3) 	
1840:    LDA  0,0(2) 	load env
1841:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1842:    LDA  0,-12(2) 	load id adress
1843:   PUSH  0,0(6) 	push array adress to mp
1844:    POP  1,0,6 	load adress of lhs struct
1845:    LDC  0,8,0 	load offset of member
1846:    ADD  0,0,1 	compute the real adress if pointK
1847:   PUSH  0,0(6) 	
1848:    POP  0,0(6) 	load adress from mp
1849:     LD  1,0(0) 	copy bytes
1850:   PUSH  1,0(6) 	push a.x value into tmp
1851:    LDC  0,1853(0) 	store the return adress
1852:    POP  7,0(6) 	ujp to the function body
1853:    LDA  3,1(3) 	pop parameters
1854:    LDA  3,1(3) 	pop env
1855:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1856:    LDC  0,20(0) 	load integer const
1857:   PUSH  0,0(6) 	store exp
1858:    POP  0,0(6) 	pop right
1859:    NEG  0,0,0 	single op (-)
1860:   PUSH  0,0(6) 	op: load left
1861:    POP  0,0(6) 	copy bytes
1862:   PUSH  0,0(3) 	PUSH bytes
1863:     LD  0,1(2) 	load env
1864:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1865:     LD  0,-6(5) 	load id value
1866:   PUSH  0,0(6) 	store exp
1867:    LDC  0,1869(0) 	store the return adress
1868:    POP  7,0(6) 	ujp to the function body
1869:    LDA  3,1(3) 	pop parameters
1870:    LDA  3,1(3) 	pop env
1871:    POP  0,0(6) 	copy bytes
1872:   PUSH  0,0(3) 	PUSH bytes
1873:    LDA  0,-12(2) 	load id adress
1874:   PUSH  0,0(6) 	push array adress to mp
1875:    POP  0,0(6) 	
1876:   PUSH  0,0(3) 	
1877:    LDA  0,0(2) 	load env
1878:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1879:    LDA  0,-12(2) 	load id adress
1880:   PUSH  0,0(6) 	push array adress to mp
1881:    POP  1,0,6 	load adress of lhs struct
1882:    LDC  0,8,0 	load offset of member
1883:    ADD  0,0,1 	compute the real adress if pointK
1884:   PUSH  0,0(6) 	
1885:    POP  0,0(6) 	load adress from mp
1886:     LD  1,0(0) 	copy bytes
1887:   PUSH  1,0(6) 	push a.x value into tmp
1888:    LDC  0,1890(0) 	store the return adress
1889:    POP  7,0(6) 	ujp to the function body
1890:    LDA  3,1(3) 	pop parameters
1891:    LDA  3,1(3) 	pop env
1892:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1893:    LDC  0,100000(0) 	load integer const
1894:   PUSH  0,0(6) 	store exp
1895:    POP  0,0(6) 	pop right
1896:    NEG  0,0,0 	single op (-)
1897:   PUSH  0,0(6) 	op: load left
1898:    POP  0,0(6) 	copy bytes
1899:   PUSH  0,0(3) 	PUSH bytes
1900:     LD  0,1(2) 	load env
1901:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1902:     LD  0,-6(5) 	load id value
1903:   PUSH  0,0(6) 	store exp
1904:    LDC  0,1906(0) 	store the return adress
1905:    POP  7,0(6) 	ujp to the function body
1906:    LDA  3,1(3) 	pop parameters
1907:    LDA  3,1(3) 	pop env
1908:    POP  0,0(6) 	copy bytes
1909:   PUSH  0,0(3) 	PUSH bytes
1910:    LDA  0,-12(2) 	load id adress
1911:   PUSH  0,0(6) 	push array adress to mp
1912:    POP  0,0(6) 	
1913:   PUSH  0,0(3) 	
1914:    LDA  0,0(2) 	load env
1915:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1916:    LDA  0,-12(2) 	load id adress
1917:   PUSH  0,0(6) 	push array adress to mp
1918:    POP  1,0,6 	load adress of lhs struct
1919:    LDC  0,8,0 	load offset of member
1920:    ADD  0,0,1 	compute the real adress if pointK
1921:   PUSH  0,0(6) 	
1922:    POP  0,0(6) 	load adress from mp
1923:     LD  1,0(0) 	copy bytes
1924:   PUSH  1,0(6) 	push a.x value into tmp
1925:    LDC  0,1927(0) 	store the return adress
1926:    POP  7,0(6) 	ujp to the function body
1927:    LDA  3,1(3) 	pop parameters
1928:    LDA  3,1(3) 	pop env
1929:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1930:    LDC  0,2000(0) 	load integer const
1931:   PUSH  0,0(6) 	store exp
1932:    POP  0,0(6) 	copy bytes
1933:   PUSH  0,0(3) 	PUSH bytes
1934:     LD  0,1(2) 	load env
1935:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1936:     LD  0,-6(5) 	load id value
1937:   PUSH  0,0(6) 	store exp
1938:    LDC  0,1940(0) 	store the return adress
1939:    POP  7,0(6) 	ujp to the function body
1940:    LDA  3,1(3) 	pop parameters
1941:    LDA  3,1(3) 	pop env
1942:    POP  0,0(6) 	copy bytes
1943:   PUSH  0,0(3) 	PUSH bytes
1944:    LDA  0,-12(2) 	load id adress
1945:   PUSH  0,0(6) 	push array adress to mp
1946:    POP  0,0(6) 	
1947:   PUSH  0,0(3) 	
1948:    LDA  0,0(2) 	load env
1949:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1950:    LDA  0,-12(2) 	load id adress
1951:   PUSH  0,0(6) 	push array adress to mp
1952:    POP  1,0,6 	load adress of lhs struct
1953:    LDC  0,8,0 	load offset of member
1954:    ADD  0,0,1 	compute the real adress if pointK
1955:   PUSH  0,0(6) 	
1956:    POP  0,0(6) 	load adress from mp
1957:     LD  1,0(0) 	copy bytes
1958:   PUSH  1,0(6) 	push a.x value into tmp
1959:    LDC  0,1961(0) 	store the return adress
1960:    POP  7,0(6) 	ujp to the function body
1961:    LDA  3,1(3) 	pop parameters
1962:    LDA  3,1(3) 	pop env
1963:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1964:    LDC  0,100(0) 	load integer const
1965:   PUSH  0,0(6) 	store exp
1966:    POP  0,0(6) 	copy bytes
1967:   PUSH  0,0(3) 	PUSH bytes
1968:     LD  0,1(2) 	load env
1969:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1970:     LD  0,-6(5) 	load id value
1971:   PUSH  0,0(6) 	store exp
1972:    LDC  0,1974(0) 	store the return adress
1973:    POP  7,0(6) 	ujp to the function body
1974:    LDA  3,1(3) 	pop parameters
1975:    LDA  3,1(3) 	pop env
1976:    POP  0,0(6) 	copy bytes
1977:   PUSH  0,0(3) 	PUSH bytes
1978:    LDA  0,-12(2) 	load id adress
1979:   PUSH  0,0(6) 	push array adress to mp
1980:    POP  0,0(6) 	
1981:   PUSH  0,0(3) 	
1982:    LDA  0,0(2) 	load env
1983:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1984:    LDA  0,-12(2) 	load id adress
1985:   PUSH  0,0(6) 	push array adress to mp
1986:    POP  1,0,6 	load adress of lhs struct
1987:    LDC  0,8,0 	load offset of member
1988:    ADD  0,0,1 	compute the real adress if pointK
1989:   PUSH  0,0(6) 	
1990:    POP  0,0(6) 	load adress from mp
1991:     LD  1,0(0) 	copy bytes
1992:   PUSH  1,0(6) 	push a.x value into tmp
1993:    LDC  0,1995(0) 	store the return adress
1994:    POP  7,0(6) 	ujp to the function body
1995:    LDA  3,1(3) 	pop parameters
1996:    LDA  3,1(3) 	pop env
1997:    LDA  3,1(3) 	pop parameters
1998:    LDA  3,-1(3) 	stack expand
1999:    LDA  0,-12(2) 	load id adress
2000:   PUSH  0,0(6) 	push array adress to mp
2001:    POP  1,0,6 	load adress of lhs struct
2002:    LDC  0,0,0 	load offset of member
2003:    ADD  0,0,1 	compute the real adress if pointK
2004:   PUSH  0,0(6) 	
2005:    POP  0,0(6) 	load adress from mp
2006:     LD  1,0(0) 	copy bytes
2007:   PUSH  1,0(6) 	push a.x value into tmp
2008:    POP  1,0,6 	load adress of lhs struct
2009:    LDC  0,1,0 	load offset of member
2010:    ADD  0,0,1 	compute the real adress if pointK
2011:   PUSH  0,0(6) 	
2012:    POP  0,0(6) 	load adress from mp
2013:     LD  1,0(0) 	copy bytes
2014:   PUSH  1,0(6) 	push a.x value into tmp
2015:    LDA  0,-13(2) 	load id adress
2016:   PUSH  0,0(6) 	push array adress to mp
2017:    POP  1,0(6) 	move the adress of ID
2018:    POP  0,0(6) 	copy bytes
2019:     ST  0,0(1) 	copy bytes
* while stmt:
2020:  LABEL  49,0,0 	generate label
2021:     LD  0,-13(2) 	load id value
2022:   PUSH  0,0(6) 	store exp
2023:     LD  0,0(5) 	load id value
2024:   PUSH  0,0(6) 	store exp
2025:    POP  1,0(6) 	pop right
2026:    POP  0,0(6) 	pop left
2027:    SUB  0,0,1 	op ==, convertd_type
2028:    JNE  0,2(7) 	br if true
2029:    LDC  0,0(0) 	false case
2030:    LDA  7,1(7) 	unconditional jmp
2031:    LDC  0,1(0) 	true case
2032:   PUSH  0,0(6) 	
2033:    POP  0,0(6) 	pop from the mp
2034:    JNE  0,1,7 	true case:, skip the break, execute the block code
2035:     GO  50,0,0 	go to label
2036:     LD  0,-13(2) 	load id value
2037:   PUSH  0,0(6) 	store exp
2038:    POP  1,0,6 	load adress of lhs struct
2039:    LDC  0,2,0 	load offset of member
2040:    ADD  0,0,1 	compute the real adress if pointK
2041:   PUSH  0,0(6) 	
2042:    POP  0,0(6) 	load adress from mp
2043:     LD  1,0(0) 	copy bytes
2044:   PUSH  1,0(6) 	push a.x value into tmp
2045:    POP  0,0(6) 	pop the adress
2046:     LD  1,0(0) 	load bytes
2047:   PUSH  1,0(6) 	push bytes 
2048:    POP  0,0(6) 	move result to register
2049:    OUT  0,0,0 	output value in register[ac / fac]
2050:     LD  0,-13(2) 	load id value
2051:   PUSH  0,0(6) 	store exp
2052:    POP  1,0,6 	load adress of lhs struct
2053:    LDC  0,1,0 	load offset of member
2054:    ADD  0,0,1 	compute the real adress if pointK
2055:   PUSH  0,0(6) 	
2056:    POP  0,0(6) 	load adress from mp
2057:     LD  1,0(0) 	copy bytes
2058:   PUSH  1,0(6) 	push a.x value into tmp
2059:    LDA  0,-13(2) 	load id adress
2060:   PUSH  0,0(6) 	push array adress to mp
2061:    POP  1,0(6) 	move the adress of ID
2062:    POP  0,0(6) 	copy bytes
2063:     ST  0,0(1) 	copy bytes
2064:     GO  49,0,0 	go to label
2065:  LABEL  50,0,0 	generate label
2066:    MOV  3,2,0 	restore the caller sp
2067:     LD  2,0(2) 	resotre the caller fp
2068:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2069:  LABEL  48,0,0 	generate label
* function entry:
* test_appendList
2070:    LDA  3,-1(3) 	stack expand for function variable
2071:    LDC  0,2074(0) 	get function adress
2072:     ST  0,-9(5) 	set function adress
2073:     GO  51,0,0 	go to label
2074:    MOV  1,2,0 	store the caller fp temporarily
2075:    MOV  2,3,0 	exchang the stack(context)
2076:   PUSH  1,0(3) 	push the caller fp
2077:   PUSH  0,0(3) 	push the return adress
2078:    LDA  3,-11(3) 	stack expand
2079:    LDC  1,122(0) 	get function adress from struct
2080:     ST  1,4(3) 	Init Struct Instance
2081:    LDC  1,132(0) 	get function adress from struct
2082:     ST  1,5(3) 	Init Struct Instance
2083:    LDC  1,142(0) 	get function adress from struct
2084:     ST  1,6(3) 	Init Struct Instance
2085:    LDC  1,152(0) 	get function adress from struct
2086:     ST  1,7(3) 	Init Struct Instance
2087:    LDC  1,466(0) 	get function adress from struct
2088:     ST  1,8(3) 	Init Struct Instance
2089:    LDC  1,589(0) 	get function adress from struct
2090:     ST  1,9(3) 	Init Struct Instance
2091:    LDC  1,855(0) 	get function adress from struct
2092:     ST  1,10(3) 	Init Struct Instance
2093:    LDC  1,1011(0) 	get function adress from struct
2094:     ST  1,11(3) 	Init Struct Instance
2095:     LD  0,1(2) 	load env
2096:   PUSH  0,0(3) 	store env
* call function: 
* makeList
2097:     LD  0,-7(5) 	load id value
2098:   PUSH  0,0(6) 	store exp
2099:    LDC  0,2101(0) 	store the return adress
2100:    POP  7,0(6) 	ujp to the function body
2101:    LDA  3,0(3) 	pop parameters
2102:    LDA  3,1(3) 	pop env
2103:    LDA  0,-12(2) 	load id adress
2104:   PUSH  0,0(6) 	push array adress to mp
2105:    POP  1,0(6) 	move the adress of ID
2106:    POP  0,0(6) 	copy bytes
2107:     ST  0,10(1) 	copy bytes
2108:    POP  0,0(6) 	copy bytes
2109:     ST  0,9(1) 	copy bytes
2110:    POP  0,0(6) 	copy bytes
2111:     ST  0,8(1) 	copy bytes
2112:    POP  0,0(6) 	copy bytes
2113:     ST  0,7(1) 	copy bytes
2114:    POP  0,0(6) 	copy bytes
2115:     ST  0,6(1) 	copy bytes
2116:    POP  0,0(6) 	copy bytes
2117:     ST  0,5(1) 	copy bytes
2118:    POP  0,0(6) 	copy bytes
2119:     ST  0,4(1) 	copy bytes
2120:    POP  0,0(6) 	copy bytes
2121:     ST  0,3(1) 	copy bytes
2122:    POP  0,0(6) 	copy bytes
2123:     ST  0,2(1) 	copy bytes
2124:    POP  0,0(6) 	copy bytes
2125:     ST  0,1(1) 	copy bytes
2126:    POP  0,0(6) 	copy bytes
2127:     ST  0,0(1) 	copy bytes
* function entry:
* opera
2128:    LDA  3,-1(3) 	stack expand for function variable
2129:    LDC  0,2132(0) 	get function adress
2130:     ST  0,-13(2) 	set function adress
2131:     GO  52,0,0 	go to label
2132:    MOV  1,2,0 	store the caller fp temporarily
2133:    MOV  2,3,0 	exchang the stack(context)
2134:   PUSH  1,0(3) 	push the caller fp
2135:   PUSH  0,0(3) 	push the return adress
2136:    MOV  3,2,0 	restore the caller sp
2137:     LD  2,0(2) 	resotre the caller fp
2138:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2139:  LABEL  52,0,0 	generate label
* push function parameters
* push function parameters
2140:    LDC  0,1(0) 	load integer const
2141:   PUSH  0,0(6) 	store exp
2142:    POP  0,0(6) 	pop right
2143:    NEG  0,0,0 	single op (-)
2144:   PUSH  0,0(6) 	op: load left
2145:    POP  0,0(6) 	copy bytes
2146:   PUSH  0,0(3) 	PUSH bytes
2147:     LD  0,1(2) 	load env
2148:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2149:     LD  0,-6(5) 	load id value
2150:   PUSH  0,0(6) 	store exp
2151:    LDC  0,2153(0) 	store the return adress
2152:    POP  7,0(6) 	ujp to the function body
2153:    LDA  3,1(3) 	pop parameters
2154:    LDA  3,1(3) 	pop env
2155:    POP  0,0(6) 	copy bytes
2156:   PUSH  0,0(3) 	PUSH bytes
2157:    LDA  0,-12(2) 	load id adress
2158:   PUSH  0,0(6) 	push array adress to mp
2159:    POP  0,0(6) 	
2160:   PUSH  0,0(3) 	
2161:    LDA  0,0(2) 	load env
2162:   PUSH  0,0(3) 	store env
* call function: 
* append
2163:    LDA  0,-12(2) 	load id adress
2164:   PUSH  0,0(6) 	push array adress to mp
2165:    POP  1,0,6 	load adress of lhs struct
2166:    LDC  0,7,0 	load offset of member
2167:    ADD  0,0,1 	compute the real adress if pointK
2168:   PUSH  0,0(6) 	
2169:    POP  0,0(6) 	load adress from mp
2170:     LD  1,0(0) 	copy bytes
2171:   PUSH  1,0(6) 	push a.x value into tmp
2172:    LDC  0,2174(0) 	store the return adress
2173:    POP  7,0(6) 	ujp to the function body
2174:    LDA  3,1(3) 	pop parameters
2175:    LDA  3,1(3) 	pop env
2176:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2177:    LDC  0,1(0) 	load integer const
2178:   PUSH  0,0(6) 	store exp
2179:    POP  0,0(6) 	copy bytes
2180:   PUSH  0,0(3) 	PUSH bytes
2181:     LD  0,1(2) 	load env
2182:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2183:     LD  0,-6(5) 	load id value
2184:   PUSH  0,0(6) 	store exp
2185:    LDC  0,2187(0) 	store the return adress
2186:    POP  7,0(6) 	ujp to the function body
2187:    LDA  3,1(3) 	pop parameters
2188:    LDA  3,1(3) 	pop env
2189:    POP  0,0(6) 	copy bytes
2190:   PUSH  0,0(3) 	PUSH bytes
2191:    LDA  0,-12(2) 	load id adress
2192:   PUSH  0,0(6) 	push array adress to mp
2193:    POP  0,0(6) 	
2194:   PUSH  0,0(3) 	
2195:    LDA  0,0(2) 	load env
2196:   PUSH  0,0(3) 	store env
* call function: 
* append
2197:    LDA  0,-12(2) 	load id adress
2198:   PUSH  0,0(6) 	push array adress to mp
2199:    POP  1,0,6 	load adress of lhs struct
2200:    LDC  0,7,0 	load offset of member
2201:    ADD  0,0,1 	compute the real adress if pointK
2202:   PUSH  0,0(6) 	
2203:    POP  0,0(6) 	load adress from mp
2204:     LD  1,0(0) 	copy bytes
2205:   PUSH  1,0(6) 	push a.x value into tmp
2206:    LDC  0,2208(0) 	store the return adress
2207:    POP  7,0(6) 	ujp to the function body
2208:    LDA  3,1(3) 	pop parameters
2209:    LDA  3,1(3) 	pop env
2210:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2211:    LDC  0,20(0) 	load integer const
2212:   PUSH  0,0(6) 	store exp
2213:    POP  0,0(6) 	pop right
2214:    NEG  0,0,0 	single op (-)
2215:   PUSH  0,0(6) 	op: load left
2216:    POP  0,0(6) 	copy bytes
2217:   PUSH  0,0(3) 	PUSH bytes
2218:     LD  0,1(2) 	load env
2219:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2220:     LD  0,-6(5) 	load id value
2221:   PUSH  0,0(6) 	store exp
2222:    LDC  0,2224(0) 	store the return adress
2223:    POP  7,0(6) 	ujp to the function body
2224:    LDA  3,1(3) 	pop parameters
2225:    LDA  3,1(3) 	pop env
2226:    POP  0,0(6) 	copy bytes
2227:   PUSH  0,0(3) 	PUSH bytes
2228:    LDA  0,-12(2) 	load id adress
2229:   PUSH  0,0(6) 	push array adress to mp
2230:    POP  0,0(6) 	
2231:   PUSH  0,0(3) 	
2232:    LDA  0,0(2) 	load env
2233:   PUSH  0,0(3) 	store env
* call function: 
* append
2234:    LDA  0,-12(2) 	load id adress
2235:   PUSH  0,0(6) 	push array adress to mp
2236:    POP  1,0,6 	load adress of lhs struct
2237:    LDC  0,7,0 	load offset of member
2238:    ADD  0,0,1 	compute the real adress if pointK
2239:   PUSH  0,0(6) 	
2240:    POP  0,0(6) 	load adress from mp
2241:     LD  1,0(0) 	copy bytes
2242:   PUSH  1,0(6) 	push a.x value into tmp
2243:    LDC  0,2245(0) 	store the return adress
2244:    POP  7,0(6) 	ujp to the function body
2245:    LDA  3,1(3) 	pop parameters
2246:    LDA  3,1(3) 	pop env
2247:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2248:    LDC  0,20(0) 	load integer const
2249:   PUSH  0,0(6) 	store exp
2250:    POP  0,0(6) 	pop right
2251:    NEG  0,0,0 	single op (-)
2252:   PUSH  0,0(6) 	op: load left
2253:    POP  0,0(6) 	copy bytes
2254:   PUSH  0,0(3) 	PUSH bytes
2255:     LD  0,1(2) 	load env
2256:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2257:     LD  0,-6(5) 	load id value
2258:   PUSH  0,0(6) 	store exp
2259:    LDC  0,2261(0) 	store the return adress
2260:    POP  7,0(6) 	ujp to the function body
2261:    LDA  3,1(3) 	pop parameters
2262:    LDA  3,1(3) 	pop env
2263:    POP  0,0(6) 	copy bytes
2264:   PUSH  0,0(3) 	PUSH bytes
2265:    LDA  0,-12(2) 	load id adress
2266:   PUSH  0,0(6) 	push array adress to mp
2267:    POP  0,0(6) 	
2268:   PUSH  0,0(3) 	
2269:    LDA  0,0(2) 	load env
2270:   PUSH  0,0(3) 	store env
* call function: 
* append
2271:    LDA  0,-12(2) 	load id adress
2272:   PUSH  0,0(6) 	push array adress to mp
2273:    POP  1,0,6 	load adress of lhs struct
2274:    LDC  0,7,0 	load offset of member
2275:    ADD  0,0,1 	compute the real adress if pointK
2276:   PUSH  0,0(6) 	
2277:    POP  0,0(6) 	load adress from mp
2278:     LD  1,0(0) 	copy bytes
2279:   PUSH  1,0(6) 	push a.x value into tmp
2280:    LDC  0,2282(0) 	store the return adress
2281:    POP  7,0(6) 	ujp to the function body
2282:    LDA  3,1(3) 	pop parameters
2283:    LDA  3,1(3) 	pop env
2284:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2285:    LDC  0,20(0) 	load integer const
2286:   PUSH  0,0(6) 	store exp
2287:    POP  0,0(6) 	pop right
2288:    NEG  0,0,0 	single op (-)
2289:   PUSH  0,0(6) 	op: load left
2290:    POP  0,0(6) 	copy bytes
2291:   PUSH  0,0(3) 	PUSH bytes
2292:     LD  0,1(2) 	load env
2293:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2294:     LD  0,-6(5) 	load id value
2295:   PUSH  0,0(6) 	store exp
2296:    LDC  0,2298(0) 	store the return adress
2297:    POP  7,0(6) 	ujp to the function body
2298:    LDA  3,1(3) 	pop parameters
2299:    LDA  3,1(3) 	pop env
2300:    POP  0,0(6) 	copy bytes
2301:   PUSH  0,0(3) 	PUSH bytes
2302:    LDA  0,-12(2) 	load id adress
2303:   PUSH  0,0(6) 	push array adress to mp
2304:    POP  0,0(6) 	
2305:   PUSH  0,0(3) 	
2306:    LDA  0,0(2) 	load env
2307:   PUSH  0,0(3) 	store env
* call function: 
* append
2308:    LDA  0,-12(2) 	load id adress
2309:   PUSH  0,0(6) 	push array adress to mp
2310:    POP  1,0,6 	load adress of lhs struct
2311:    LDC  0,7,0 	load offset of member
2312:    ADD  0,0,1 	compute the real adress if pointK
2313:   PUSH  0,0(6) 	
2314:    POP  0,0(6) 	load adress from mp
2315:     LD  1,0(0) 	copy bytes
2316:   PUSH  1,0(6) 	push a.x value into tmp
2317:    LDC  0,2319(0) 	store the return adress
2318:    POP  7,0(6) 	ujp to the function body
2319:    LDA  3,1(3) 	pop parameters
2320:    LDA  3,1(3) 	pop env
2321:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2322:    LDC  0,100000(0) 	load integer const
2323:   PUSH  0,0(6) 	store exp
2324:    POP  0,0(6) 	pop right
2325:    NEG  0,0,0 	single op (-)
2326:   PUSH  0,0(6) 	op: load left
2327:    POP  0,0(6) 	copy bytes
2328:   PUSH  0,0(3) 	PUSH bytes
2329:     LD  0,1(2) 	load env
2330:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2331:     LD  0,-6(5) 	load id value
2332:   PUSH  0,0(6) 	store exp
2333:    LDC  0,2335(0) 	store the return adress
2334:    POP  7,0(6) 	ujp to the function body
2335:    LDA  3,1(3) 	pop parameters
2336:    LDA  3,1(3) 	pop env
2337:    POP  0,0(6) 	copy bytes
2338:   PUSH  0,0(3) 	PUSH bytes
2339:    LDA  0,-12(2) 	load id adress
2340:   PUSH  0,0(6) 	push array adress to mp
2341:    POP  0,0(6) 	
2342:   PUSH  0,0(3) 	
2343:    LDA  0,0(2) 	load env
2344:   PUSH  0,0(3) 	store env
* call function: 
* append
2345:    LDA  0,-12(2) 	load id adress
2346:   PUSH  0,0(6) 	push array adress to mp
2347:    POP  1,0,6 	load adress of lhs struct
2348:    LDC  0,7,0 	load offset of member
2349:    ADD  0,0,1 	compute the real adress if pointK
2350:   PUSH  0,0(6) 	
2351:    POP  0,0(6) 	load adress from mp
2352:     LD  1,0(0) 	copy bytes
2353:   PUSH  1,0(6) 	push a.x value into tmp
2354:    LDC  0,2356(0) 	store the return adress
2355:    POP  7,0(6) 	ujp to the function body
2356:    LDA  3,1(3) 	pop parameters
2357:    LDA  3,1(3) 	pop env
2358:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2359:    LDC  0,2000(0) 	load integer const
2360:   PUSH  0,0(6) 	store exp
2361:    POP  0,0(6) 	copy bytes
2362:   PUSH  0,0(3) 	PUSH bytes
2363:     LD  0,1(2) 	load env
2364:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2365:     LD  0,-6(5) 	load id value
2366:   PUSH  0,0(6) 	store exp
2367:    LDC  0,2369(0) 	store the return adress
2368:    POP  7,0(6) 	ujp to the function body
2369:    LDA  3,1(3) 	pop parameters
2370:    LDA  3,1(3) 	pop env
2371:    POP  0,0(6) 	copy bytes
2372:   PUSH  0,0(3) 	PUSH bytes
2373:    LDA  0,-12(2) 	load id adress
2374:   PUSH  0,0(6) 	push array adress to mp
2375:    POP  0,0(6) 	
2376:   PUSH  0,0(3) 	
2377:    LDA  0,0(2) 	load env
2378:   PUSH  0,0(3) 	store env
* call function: 
* append
2379:    LDA  0,-12(2) 	load id adress
2380:   PUSH  0,0(6) 	push array adress to mp
2381:    POP  1,0,6 	load adress of lhs struct
2382:    LDC  0,7,0 	load offset of member
2383:    ADD  0,0,1 	compute the real adress if pointK
2384:   PUSH  0,0(6) 	
2385:    POP  0,0(6) 	load adress from mp
2386:     LD  1,0(0) 	copy bytes
2387:   PUSH  1,0(6) 	push a.x value into tmp
2388:    LDC  0,2390(0) 	store the return adress
2389:    POP  7,0(6) 	ujp to the function body
2390:    LDA  3,1(3) 	pop parameters
2391:    LDA  3,1(3) 	pop env
2392:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2393:    LDC  0,100(0) 	load integer const
2394:   PUSH  0,0(6) 	store exp
2395:    POP  0,0(6) 	copy bytes
2396:   PUSH  0,0(3) 	PUSH bytes
2397:     LD  0,1(2) 	load env
2398:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2399:     LD  0,-6(5) 	load id value
2400:   PUSH  0,0(6) 	store exp
2401:    LDC  0,2403(0) 	store the return adress
2402:    POP  7,0(6) 	ujp to the function body
2403:    LDA  3,1(3) 	pop parameters
2404:    LDA  3,1(3) 	pop env
2405:    POP  0,0(6) 	copy bytes
2406:   PUSH  0,0(3) 	PUSH bytes
2407:    LDA  0,-12(2) 	load id adress
2408:   PUSH  0,0(6) 	push array adress to mp
2409:    POP  0,0(6) 	
2410:   PUSH  0,0(3) 	
2411:    LDA  0,0(2) 	load env
2412:   PUSH  0,0(3) 	store env
* call function: 
* append
2413:    LDA  0,-12(2) 	load id adress
2414:   PUSH  0,0(6) 	push array adress to mp
2415:    POP  1,0,6 	load adress of lhs struct
2416:    LDC  0,7,0 	load offset of member
2417:    ADD  0,0,1 	compute the real adress if pointK
2418:   PUSH  0,0(6) 	
2419:    POP  0,0(6) 	load adress from mp
2420:     LD  1,0(0) 	copy bytes
2421:   PUSH  1,0(6) 	push a.x value into tmp
2422:    LDC  0,2424(0) 	store the return adress
2423:    POP  7,0(6) 	ujp to the function body
2424:    LDA  3,1(3) 	pop parameters
2425:    LDA  3,1(3) 	pop env
2426:    LDA  3,1(3) 	pop parameters
2427:    LDA  3,-1(3) 	stack expand
2428:    LDA  0,-12(2) 	load id adress
2429:   PUSH  0,0(6) 	push array adress to mp
2430:    POP  1,0,6 	load adress of lhs struct
2431:    LDC  0,0,0 	load offset of member
2432:    ADD  0,0,1 	compute the real adress if pointK
2433:   PUSH  0,0(6) 	
2434:    POP  0,0(6) 	load adress from mp
2435:     LD  1,0(0) 	copy bytes
2436:   PUSH  1,0(6) 	push a.x value into tmp
2437:    POP  1,0,6 	load adress of lhs struct
2438:    LDC  0,1,0 	load offset of member
2439:    ADD  0,0,1 	compute the real adress if pointK
2440:   PUSH  0,0(6) 	
2441:    POP  0,0(6) 	load adress from mp
2442:     LD  1,0(0) 	copy bytes
2443:   PUSH  1,0(6) 	push a.x value into tmp
2444:    LDA  0,-14(2) 	load id adress
2445:   PUSH  0,0(6) 	push array adress to mp
2446:    POP  1,0(6) 	move the adress of ID
2447:    POP  0,0(6) 	copy bytes
2448:     ST  0,0(1) 	copy bytes
* while stmt:
2449:  LABEL  53,0,0 	generate label
2450:     LD  0,-14(2) 	load id value
2451:   PUSH  0,0(6) 	store exp
2452:     LD  0,0(5) 	load id value
2453:   PUSH  0,0(6) 	store exp
2454:    POP  1,0(6) 	pop right
2455:    POP  0,0(6) 	pop left
2456:    SUB  0,0,1 	op ==, convertd_type
2457:    JNE  0,2(7) 	br if true
2458:    LDC  0,0(0) 	false case
2459:    LDA  7,1(7) 	unconditional jmp
2460:    LDC  0,1(0) 	true case
2461:   PUSH  0,0(6) 	
2462:    POP  0,0(6) 	pop from the mp
2463:    JNE  0,1,7 	true case:, skip the break, execute the block code
2464:     GO  54,0,0 	go to label
2465:     LD  0,-14(2) 	load id value
2466:   PUSH  0,0(6) 	store exp
2467:    POP  1,0,6 	load adress of lhs struct
2468:    LDC  0,2,0 	load offset of member
2469:    ADD  0,0,1 	compute the real adress if pointK
2470:   PUSH  0,0(6) 	
2471:    POP  0,0(6) 	load adress from mp
2472:     LD  1,0(0) 	copy bytes
2473:   PUSH  1,0(6) 	push a.x value into tmp
2474:    POP  0,0(6) 	pop the adress
2475:     LD  1,0(0) 	load bytes
2476:   PUSH  1,0(6) 	push bytes 
2477:    POP  0,0(6) 	move result to register
2478:    OUT  0,0,0 	output value in register[ac / fac]
2479:     LD  0,-14(2) 	load id value
2480:   PUSH  0,0(6) 	store exp
2481:    POP  1,0,6 	load adress of lhs struct
2482:    LDC  0,1,0 	load offset of member
2483:    ADD  0,0,1 	compute the real adress if pointK
2484:   PUSH  0,0(6) 	
2485:    POP  0,0(6) 	load adress from mp
2486:     LD  1,0(0) 	copy bytes
2487:   PUSH  1,0(6) 	push a.x value into tmp
2488:    LDA  0,-14(2) 	load id adress
2489:   PUSH  0,0(6) 	push array adress to mp
2490:    POP  1,0(6) 	move the adress of ID
2491:    POP  0,0(6) 	copy bytes
2492:     ST  0,0(1) 	copy bytes
2493:     GO  53,0,0 	go to label
2494:  LABEL  54,0,0 	generate label
2495:    MOV  3,2,0 	restore the caller sp
2496:     LD  2,0(2) 	resotre the caller fp
2497:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2498:  LABEL  51,0,0 	generate label
* function entry:
* test_removeList
2499:    LDA  3,-1(3) 	stack expand for function variable
2500:    LDC  0,2503(0) 	get function adress
2501:     ST  0,-10(5) 	set function adress
2502:     GO  55,0,0 	go to label
2503:    MOV  1,2,0 	store the caller fp temporarily
2504:    MOV  2,3,0 	exchang the stack(context)
2505:   PUSH  1,0(3) 	push the caller fp
2506:   PUSH  0,0(3) 	push the return adress
2507:    LDA  3,-11(3) 	stack expand
2508:    LDC  1,122(0) 	get function adress from struct
2509:     ST  1,4(3) 	Init Struct Instance
2510:    LDC  1,132(0) 	get function adress from struct
2511:     ST  1,5(3) 	Init Struct Instance
2512:    LDC  1,142(0) 	get function adress from struct
2513:     ST  1,6(3) 	Init Struct Instance
2514:    LDC  1,152(0) 	get function adress from struct
2515:     ST  1,7(3) 	Init Struct Instance
2516:    LDC  1,466(0) 	get function adress from struct
2517:     ST  1,8(3) 	Init Struct Instance
2518:    LDC  1,589(0) 	get function adress from struct
2519:     ST  1,9(3) 	Init Struct Instance
2520:    LDC  1,855(0) 	get function adress from struct
2521:     ST  1,10(3) 	Init Struct Instance
2522:    LDC  1,1011(0) 	get function adress from struct
2523:     ST  1,11(3) 	Init Struct Instance
2524:     LD  0,1(2) 	load env
2525:   PUSH  0,0(3) 	store env
* call function: 
* makeList
2526:     LD  0,-7(5) 	load id value
2527:   PUSH  0,0(6) 	store exp
2528:    LDC  0,2530(0) 	store the return adress
2529:    POP  7,0(6) 	ujp to the function body
2530:    LDA  3,0(3) 	pop parameters
2531:    LDA  3,1(3) 	pop env
2532:    LDA  0,-12(2) 	load id adress
2533:   PUSH  0,0(6) 	push array adress to mp
2534:    POP  1,0(6) 	move the adress of ID
2535:    POP  0,0(6) 	copy bytes
2536:     ST  0,10(1) 	copy bytes
2537:    POP  0,0(6) 	copy bytes
2538:     ST  0,9(1) 	copy bytes
2539:    POP  0,0(6) 	copy bytes
2540:     ST  0,8(1) 	copy bytes
2541:    POP  0,0(6) 	copy bytes
2542:     ST  0,7(1) 	copy bytes
2543:    POP  0,0(6) 	copy bytes
2544:     ST  0,6(1) 	copy bytes
2545:    POP  0,0(6) 	copy bytes
2546:     ST  0,5(1) 	copy bytes
2547:    POP  0,0(6) 	copy bytes
2548:     ST  0,4(1) 	copy bytes
2549:    POP  0,0(6) 	copy bytes
2550:     ST  0,3(1) 	copy bytes
2551:    POP  0,0(6) 	copy bytes
2552:     ST  0,2(1) 	copy bytes
2553:    POP  0,0(6) 	copy bytes
2554:     ST  0,1(1) 	copy bytes
2555:    POP  0,0(6) 	copy bytes
2556:     ST  0,0(1) 	copy bytes
2557:    LDA  3,-1(3) 	stack expand
2558:    LDC  0,100(0) 	load integer const
2559:   PUSH  0,0(6) 	store exp
2560:    LDA  0,-13(2) 	load id adress
2561:   PUSH  0,0(6) 	push array adress to mp
2562:    POP  1,0(6) 	move the adress of ID
2563:    POP  0,0(6) 	copy bytes
2564:     ST  0,0(1) 	copy bytes
* push function parameters
* push function parameters
2565:    LDC  0,1(0) 	load integer const
2566:   PUSH  0,0(6) 	store exp
2567:    POP  0,0(6) 	pop right
2568:    NEG  0,0,0 	single op (-)
2569:   PUSH  0,0(6) 	op: load left
2570:    POP  0,0(6) 	copy bytes
2571:   PUSH  0,0(3) 	PUSH bytes
2572:     LD  0,1(2) 	load env
2573:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2574:     LD  0,-6(5) 	load id value
2575:   PUSH  0,0(6) 	store exp
2576:    LDC  0,2578(0) 	store the return adress
2577:    POP  7,0(6) 	ujp to the function body
2578:    LDA  3,1(3) 	pop parameters
2579:    LDA  3,1(3) 	pop env
2580:    POP  0,0(6) 	copy bytes
2581:   PUSH  0,0(3) 	PUSH bytes
2582:    LDA  0,-12(2) 	load id adress
2583:   PUSH  0,0(6) 	push array adress to mp
2584:    POP  0,0(6) 	
2585:   PUSH  0,0(3) 	
2586:    LDA  0,0(2) 	load env
2587:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2588:    LDA  0,-12(2) 	load id adress
2589:   PUSH  0,0(6) 	push array adress to mp
2590:    POP  1,0,6 	load adress of lhs struct
2591:    LDC  0,8,0 	load offset of member
2592:    ADD  0,0,1 	compute the real adress if pointK
2593:   PUSH  0,0(6) 	
2594:    POP  0,0(6) 	load adress from mp
2595:     LD  1,0(0) 	copy bytes
2596:   PUSH  1,0(6) 	push a.x value into tmp
2597:    LDC  0,2599(0) 	store the return adress
2598:    POP  7,0(6) 	ujp to the function body
2599:    LDA  3,1(3) 	pop parameters
2600:    LDA  3,1(3) 	pop env
2601:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2602:    LDC  0,1(0) 	load integer const
2603:   PUSH  0,0(6) 	store exp
2604:    POP  0,0(6) 	copy bytes
2605:   PUSH  0,0(3) 	PUSH bytes
2606:     LD  0,1(2) 	load env
2607:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2608:     LD  0,-6(5) 	load id value
2609:   PUSH  0,0(6) 	store exp
2610:    LDC  0,2612(0) 	store the return adress
2611:    POP  7,0(6) 	ujp to the function body
2612:    LDA  3,1(3) 	pop parameters
2613:    LDA  3,1(3) 	pop env
2614:    POP  0,0(6) 	copy bytes
2615:   PUSH  0,0(3) 	PUSH bytes
2616:    LDA  0,-12(2) 	load id adress
2617:   PUSH  0,0(6) 	push array adress to mp
2618:    POP  0,0(6) 	
2619:   PUSH  0,0(3) 	
2620:    LDA  0,0(2) 	load env
2621:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2622:    LDA  0,-12(2) 	load id adress
2623:   PUSH  0,0(6) 	push array adress to mp
2624:    POP  1,0,6 	load adress of lhs struct
2625:    LDC  0,8,0 	load offset of member
2626:    ADD  0,0,1 	compute the real adress if pointK
2627:   PUSH  0,0(6) 	
2628:    POP  0,0(6) 	load adress from mp
2629:     LD  1,0(0) 	copy bytes
2630:   PUSH  1,0(6) 	push a.x value into tmp
2631:    LDC  0,2633(0) 	store the return adress
2632:    POP  7,0(6) 	ujp to the function body
2633:    LDA  3,1(3) 	pop parameters
2634:    LDA  3,1(3) 	pop env
2635:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2636:    LDC  0,20(0) 	load integer const
2637:   PUSH  0,0(6) 	store exp
2638:    POP  0,0(6) 	pop right
2639:    NEG  0,0,0 	single op (-)
2640:   PUSH  0,0(6) 	op: load left
2641:    POP  0,0(6) 	copy bytes
2642:   PUSH  0,0(3) 	PUSH bytes
2643:     LD  0,1(2) 	load env
2644:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2645:     LD  0,-6(5) 	load id value
2646:   PUSH  0,0(6) 	store exp
2647:    LDC  0,2649(0) 	store the return adress
2648:    POP  7,0(6) 	ujp to the function body
2649:    LDA  3,1(3) 	pop parameters
2650:    LDA  3,1(3) 	pop env
2651:    POP  0,0(6) 	copy bytes
2652:   PUSH  0,0(3) 	PUSH bytes
2653:    LDA  0,-12(2) 	load id adress
2654:   PUSH  0,0(6) 	push array adress to mp
2655:    POP  0,0(6) 	
2656:   PUSH  0,0(3) 	
2657:    LDA  0,0(2) 	load env
2658:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2659:    LDA  0,-12(2) 	load id adress
2660:   PUSH  0,0(6) 	push array adress to mp
2661:    POP  1,0,6 	load adress of lhs struct
2662:    LDC  0,8,0 	load offset of member
2663:    ADD  0,0,1 	compute the real adress if pointK
2664:   PUSH  0,0(6) 	
2665:    POP  0,0(6) 	load adress from mp
2666:     LD  1,0(0) 	copy bytes
2667:   PUSH  1,0(6) 	push a.x value into tmp
2668:    LDC  0,2670(0) 	store the return adress
2669:    POP  7,0(6) 	ujp to the function body
2670:    LDA  3,1(3) 	pop parameters
2671:    LDA  3,1(3) 	pop env
2672:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2673:    LDC  0,100(0) 	load integer const
2674:   PUSH  0,0(6) 	store exp
2675:    POP  0,0(6) 	copy bytes
2676:   PUSH  0,0(3) 	PUSH bytes
2677:     LD  0,1(2) 	load env
2678:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2679:     LD  0,-6(5) 	load id value
2680:   PUSH  0,0(6) 	store exp
2681:    LDC  0,2683(0) 	store the return adress
2682:    POP  7,0(6) 	ujp to the function body
2683:    LDA  3,1(3) 	pop parameters
2684:    LDA  3,1(3) 	pop env
2685:    POP  0,0(6) 	copy bytes
2686:   PUSH  0,0(3) 	PUSH bytes
2687:    LDA  0,-12(2) 	load id adress
2688:   PUSH  0,0(6) 	push array adress to mp
2689:    POP  0,0(6) 	
2690:   PUSH  0,0(3) 	
2691:    LDA  0,0(2) 	load env
2692:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2693:    LDA  0,-12(2) 	load id adress
2694:   PUSH  0,0(6) 	push array adress to mp
2695:    POP  1,0,6 	load adress of lhs struct
2696:    LDC  0,8,0 	load offset of member
2697:    ADD  0,0,1 	compute the real adress if pointK
2698:   PUSH  0,0(6) 	
2699:    POP  0,0(6) 	load adress from mp
2700:     LD  1,0(0) 	copy bytes
2701:   PUSH  1,0(6) 	push a.x value into tmp
2702:    LDC  0,2704(0) 	store the return adress
2703:    POP  7,0(6) 	ujp to the function body
2704:    LDA  3,1(3) 	pop parameters
2705:    LDA  3,1(3) 	pop env
2706:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2707:    LDC  0,2001515(0) 	load integer const
2708:   PUSH  0,0(6) 	store exp
2709:    POP  0,0(6) 	copy bytes
2710:   PUSH  0,0(3) 	PUSH bytes
2711:     LD  0,1(2) 	load env
2712:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2713:     LD  0,-6(5) 	load id value
2714:   PUSH  0,0(6) 	store exp
2715:    LDC  0,2717(0) 	store the return adress
2716:    POP  7,0(6) 	ujp to the function body
2717:    LDA  3,1(3) 	pop parameters
2718:    LDA  3,1(3) 	pop env
2719:    POP  0,0(6) 	copy bytes
2720:   PUSH  0,0(3) 	PUSH bytes
2721:    LDA  0,-12(2) 	load id adress
2722:   PUSH  0,0(6) 	push array adress to mp
2723:    POP  0,0(6) 	
2724:   PUSH  0,0(3) 	
2725:    LDA  0,0(2) 	load env
2726:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2727:    LDA  0,-12(2) 	load id adress
2728:   PUSH  0,0(6) 	push array adress to mp
2729:    POP  1,0,6 	load adress of lhs struct
2730:    LDC  0,8,0 	load offset of member
2731:    ADD  0,0,1 	compute the real adress if pointK
2732:   PUSH  0,0(6) 	
2733:    POP  0,0(6) 	load adress from mp
2734:     LD  1,0(0) 	copy bytes
2735:   PUSH  1,0(6) 	push a.x value into tmp
2736:    LDC  0,2738(0) 	store the return adress
2737:    POP  7,0(6) 	ujp to the function body
2738:    LDA  3,1(3) 	pop parameters
2739:    LDA  3,1(3) 	pop env
2740:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2741:    LDC  0,5453(0) 	load integer const
2742:   PUSH  0,0(6) 	store exp
2743:    POP  0,0(6) 	copy bytes
2744:   PUSH  0,0(3) 	PUSH bytes
2745:     LD  0,1(2) 	load env
2746:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2747:     LD  0,-6(5) 	load id value
2748:   PUSH  0,0(6) 	store exp
2749:    LDC  0,2751(0) 	store the return adress
2750:    POP  7,0(6) 	ujp to the function body
2751:    LDA  3,1(3) 	pop parameters
2752:    LDA  3,1(3) 	pop env
2753:    POP  0,0(6) 	copy bytes
2754:   PUSH  0,0(3) 	PUSH bytes
2755:    LDA  0,-12(2) 	load id adress
2756:   PUSH  0,0(6) 	push array adress to mp
2757:    POP  0,0(6) 	
2758:   PUSH  0,0(3) 	
2759:    LDA  0,0(2) 	load env
2760:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2761:    LDA  0,-12(2) 	load id adress
2762:   PUSH  0,0(6) 	push array adress to mp
2763:    POP  1,0,6 	load adress of lhs struct
2764:    LDC  0,8,0 	load offset of member
2765:    ADD  0,0,1 	compute the real adress if pointK
2766:   PUSH  0,0(6) 	
2767:    POP  0,0(6) 	load adress from mp
2768:     LD  1,0(0) 	copy bytes
2769:   PUSH  1,0(6) 	push a.x value into tmp
2770:    LDC  0,2772(0) 	store the return adress
2771:    POP  7,0(6) 	ujp to the function body
2772:    LDA  3,1(3) 	pop parameters
2773:    LDA  3,1(3) 	pop env
2774:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2775:    LDC  0,5675541(0) 	load integer const
2776:   PUSH  0,0(6) 	store exp
2777:    POP  0,0(6) 	copy bytes
2778:   PUSH  0,0(3) 	PUSH bytes
2779:     LD  0,1(2) 	load env
2780:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2781:     LD  0,-6(5) 	load id value
2782:   PUSH  0,0(6) 	store exp
2783:    LDC  0,2785(0) 	store the return adress
2784:    POP  7,0(6) 	ujp to the function body
2785:    LDA  3,1(3) 	pop parameters
2786:    LDA  3,1(3) 	pop env
2787:    POP  0,0(6) 	copy bytes
2788:   PUSH  0,0(3) 	PUSH bytes
2789:    LDA  0,-12(2) 	load id adress
2790:   PUSH  0,0(6) 	push array adress to mp
2791:    POP  0,0(6) 	
2792:   PUSH  0,0(3) 	
2793:    LDA  0,0(2) 	load env
2794:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2795:    LDA  0,-12(2) 	load id adress
2796:   PUSH  0,0(6) 	push array adress to mp
2797:    POP  1,0,6 	load adress of lhs struct
2798:    LDC  0,8,0 	load offset of member
2799:    ADD  0,0,1 	compute the real adress if pointK
2800:   PUSH  0,0(6) 	
2801:    POP  0,0(6) 	load adress from mp
2802:     LD  1,0(0) 	copy bytes
2803:   PUSH  1,0(6) 	push a.x value into tmp
2804:    LDC  0,2806(0) 	store the return adress
2805:    POP  7,0(6) 	ujp to the function body
2806:    LDA  3,1(3) 	pop parameters
2807:    LDA  3,1(3) 	pop env
2808:    LDA  3,1(3) 	pop parameters
2809:    LDA  3,-1(3) 	stack expand
2810:    LDA  0,-12(2) 	load id adress
2811:   PUSH  0,0(6) 	push array adress to mp
2812:    POP  1,0,6 	load adress of lhs struct
2813:    LDC  0,0,0 	load offset of member
2814:    ADD  0,0,1 	compute the real adress if pointK
2815:   PUSH  0,0(6) 	
2816:    POP  0,0(6) 	load adress from mp
2817:     LD  1,0(0) 	copy bytes
2818:   PUSH  1,0(6) 	push a.x value into tmp
2819:    POP  1,0,6 	load adress of lhs struct
2820:    LDC  0,1,0 	load offset of member
2821:    ADD  0,0,1 	compute the real adress if pointK
2822:   PUSH  0,0(6) 	
2823:    POP  0,0(6) 	load adress from mp
2824:     LD  1,0(0) 	copy bytes
2825:   PUSH  1,0(6) 	push a.x value into tmp
2826:    LDA  0,-14(2) 	load id adress
2827:   PUSH  0,0(6) 	push array adress to mp
2828:    POP  1,0(6) 	move the adress of ID
2829:    POP  0,0(6) 	copy bytes
2830:     ST  0,0(1) 	copy bytes
* push function parameters
2831:    LDA  0,-13(2) 	load id adress
2832:   PUSH  0,0(6) 	push array adress to mp
2833:    POP  0,0(6) 	copy bytes
2834:   PUSH  0,0(3) 	PUSH bytes
2835:    LDA  0,-12(2) 	load id adress
2836:   PUSH  0,0(6) 	push array adress to mp
2837:    POP  0,0(6) 	
2838:   PUSH  0,0(3) 	
2839:    LDA  0,0(2) 	load env
2840:   PUSH  0,0(3) 	store env
* call function: 
* removeList
2841:    LDA  0,-12(2) 	load id adress
2842:   PUSH  0,0(6) 	push array adress to mp
2843:    POP  1,0,6 	load adress of lhs struct
2844:    LDC  0,6,0 	load offset of member
2845:    ADD  0,0,1 	compute the real adress if pointK
2846:   PUSH  0,0(6) 	
2847:    POP  0,0(6) 	load adress from mp
2848:     LD  1,0(0) 	copy bytes
2849:   PUSH  1,0(6) 	push a.x value into tmp
2850:    LDC  0,2852(0) 	store the return adress
2851:    POP  7,0(6) 	ujp to the function body
2852:    LDA  3,1(3) 	pop parameters
2853:    LDA  3,1(3) 	pop env
2854:    LDA  3,1(3) 	pop parameters
2855:    LDC  0,2001515(0) 	load integer const
2856:   PUSH  0,0(6) 	store exp
2857:    LDA  0,-13(2) 	load id adress
2858:   PUSH  0,0(6) 	push array adress to mp
2859:    POP  1,0(6) 	move the adress of ID
2860:    POP  0,0(6) 	copy bytes
2861:     ST  0,0(1) 	copy bytes
* push function parameters
2862:    LDA  0,-13(2) 	load id adress
2863:   PUSH  0,0(6) 	push array adress to mp
2864:    POP  0,0(6) 	copy bytes
2865:   PUSH  0,0(3) 	PUSH bytes
2866:    LDA  0,-12(2) 	load id adress
2867:   PUSH  0,0(6) 	push array adress to mp
2868:    POP  0,0(6) 	
2869:   PUSH  0,0(3) 	
2870:    LDA  0,0(2) 	load env
2871:   PUSH  0,0(3) 	store env
* call function: 
* removeList
2872:    LDA  0,-12(2) 	load id adress
2873:   PUSH  0,0(6) 	push array adress to mp
2874:    POP  1,0,6 	load adress of lhs struct
2875:    LDC  0,6,0 	load offset of member
2876:    ADD  0,0,1 	compute the real adress if pointK
2877:   PUSH  0,0(6) 	
2878:    POP  0,0(6) 	load adress from mp
2879:     LD  1,0(0) 	copy bytes
2880:   PUSH  1,0(6) 	push a.x value into tmp
2881:    LDC  0,2883(0) 	store the return adress
2882:    POP  7,0(6) 	ujp to the function body
2883:    LDA  3,1(3) 	pop parameters
2884:    LDA  3,1(3) 	pop env
2885:    LDA  3,1(3) 	pop parameters
2886:    LDC  0,5453(0) 	load integer const
2887:   PUSH  0,0(6) 	store exp
2888:    LDA  0,-13(2) 	load id adress
2889:   PUSH  0,0(6) 	push array adress to mp
2890:    POP  1,0(6) 	move the adress of ID
2891:    POP  0,0(6) 	copy bytes
2892:     ST  0,0(1) 	copy bytes
* push function parameters
2893:    LDA  0,-13(2) 	load id adress
2894:   PUSH  0,0(6) 	push array adress to mp
2895:    POP  0,0(6) 	copy bytes
2896:   PUSH  0,0(3) 	PUSH bytes
2897:    LDA  0,-12(2) 	load id adress
2898:   PUSH  0,0(6) 	push array adress to mp
2899:    POP  0,0(6) 	
2900:   PUSH  0,0(3) 	
2901:    LDA  0,0(2) 	load env
2902:   PUSH  0,0(3) 	store env
* call function: 
* removeList
2903:    LDA  0,-12(2) 	load id adress
2904:   PUSH  0,0(6) 	push array adress to mp
2905:    POP  1,0,6 	load adress of lhs struct
2906:    LDC  0,6,0 	load offset of member
2907:    ADD  0,0,1 	compute the real adress if pointK
2908:   PUSH  0,0(6) 	
2909:    POP  0,0(6) 	load adress from mp
2910:     LD  1,0(0) 	copy bytes
2911:   PUSH  1,0(6) 	push a.x value into tmp
2912:    LDC  0,2914(0) 	store the return adress
2913:    POP  7,0(6) 	ujp to the function body
2914:    LDA  3,1(3) 	pop parameters
2915:    LDA  3,1(3) 	pop env
2916:    LDA  3,1(3) 	pop parameters
2917:    LDA  0,-12(2) 	load id adress
2918:   PUSH  0,0(6) 	push array adress to mp
2919:    POP  1,0,6 	load adress of lhs struct
2920:    LDC  0,0,0 	load offset of member
2921:    ADD  0,0,1 	compute the real adress if pointK
2922:   PUSH  0,0(6) 	
2923:    POP  0,0(6) 	load adress from mp
2924:     LD  1,0(0) 	copy bytes
2925:   PUSH  1,0(6) 	push a.x value into tmp
2926:    POP  1,0,6 	load adress of lhs struct
2927:    LDC  0,1,0 	load offset of member
2928:    ADD  0,0,1 	compute the real adress if pointK
2929:   PUSH  0,0(6) 	
2930:    POP  0,0(6) 	load adress from mp
2931:     LD  1,0(0) 	copy bytes
2932:   PUSH  1,0(6) 	push a.x value into tmp
2933:    LDA  0,-14(2) 	load id adress
2934:   PUSH  0,0(6) 	push array adress to mp
2935:    POP  1,0(6) 	move the adress of ID
2936:    POP  0,0(6) 	copy bytes
2937:     ST  0,0(1) 	copy bytes
* while stmt:
2938:  LABEL  56,0,0 	generate label
2939:     LD  0,-14(2) 	load id value
2940:   PUSH  0,0(6) 	store exp
2941:     LD  0,0(5) 	load id value
2942:   PUSH  0,0(6) 	store exp
2943:    POP  1,0(6) 	pop right
2944:    POP  0,0(6) 	pop left
2945:    SUB  0,0,1 	op ==, convertd_type
2946:    JNE  0,2(7) 	br if true
2947:    LDC  0,0(0) 	false case
2948:    LDA  7,1(7) 	unconditional jmp
2949:    LDC  0,1(0) 	true case
2950:   PUSH  0,0(6) 	
2951:    POP  0,0(6) 	pop from the mp
2952:    JNE  0,1,7 	true case:, skip the break, execute the block code
2953:     GO  57,0,0 	go to label
2954:     LD  0,-14(2) 	load id value
2955:   PUSH  0,0(6) 	store exp
2956:    POP  1,0,6 	load adress of lhs struct
2957:    LDC  0,2,0 	load offset of member
2958:    ADD  0,0,1 	compute the real adress if pointK
2959:   PUSH  0,0(6) 	
2960:    POP  0,0(6) 	load adress from mp
2961:     LD  1,0(0) 	copy bytes
2962:   PUSH  1,0(6) 	push a.x value into tmp
2963:    POP  0,0(6) 	pop the adress
2964:     LD  1,0(0) 	load bytes
2965:   PUSH  1,0(6) 	push bytes 
2966:    POP  0,0(6) 	move result to register
2967:    OUT  0,0,0 	output value in register[ac / fac]
2968:     LD  0,-14(2) 	load id value
2969:   PUSH  0,0(6) 	store exp
2970:    POP  1,0,6 	load adress of lhs struct
2971:    LDC  0,1,0 	load offset of member
2972:    ADD  0,0,1 	compute the real adress if pointK
2973:   PUSH  0,0(6) 	
2974:    POP  0,0(6) 	load adress from mp
2975:     LD  1,0(0) 	copy bytes
2976:   PUSH  1,0(6) 	push a.x value into tmp
2977:    LDA  0,-14(2) 	load id adress
2978:   PUSH  0,0(6) 	push array adress to mp
2979:    POP  1,0(6) 	move the adress of ID
2980:    POP  0,0(6) 	copy bytes
2981:     ST  0,0(1) 	copy bytes
2982:     GO  56,0,0 	go to label
2983:  LABEL  57,0,0 	generate label
2984:    MOV  3,2,0 	restore the caller sp
2985:     LD  2,0(2) 	resotre the caller fp
2986:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2987:  LABEL  55,0,0 	generate label
* function entry:
* test_pop
2988:    LDA  3,-1(3) 	stack expand for function variable
2989:    LDC  0,2992(0) 	get function adress
2990:     ST  0,-11(5) 	set function adress
2991:     GO  58,0,0 	go to label
2992:    MOV  1,2,0 	store the caller fp temporarily
2993:    MOV  2,3,0 	exchang the stack(context)
2994:   PUSH  1,0(3) 	push the caller fp
2995:   PUSH  0,0(3) 	push the return adress
2996:    LDA  3,-11(3) 	stack expand
2997:    LDC  1,122(0) 	get function adress from struct
2998:     ST  1,4(3) 	Init Struct Instance
2999:    LDC  1,132(0) 	get function adress from struct
3000:     ST  1,5(3) 	Init Struct Instance
3001:    LDC  1,142(0) 	get function adress from struct
3002:     ST  1,6(3) 	Init Struct Instance
3003:    LDC  1,152(0) 	get function adress from struct
3004:     ST  1,7(3) 	Init Struct Instance
3005:    LDC  1,466(0) 	get function adress from struct
3006:     ST  1,8(3) 	Init Struct Instance
3007:    LDC  1,589(0) 	get function adress from struct
3008:     ST  1,9(3) 	Init Struct Instance
3009:    LDC  1,855(0) 	get function adress from struct
3010:     ST  1,10(3) 	Init Struct Instance
3011:    LDC  1,1011(0) 	get function adress from struct
3012:     ST  1,11(3) 	Init Struct Instance
3013:     LD  0,1(2) 	load env
3014:   PUSH  0,0(3) 	store env
* call function: 
* makeList
3015:     LD  0,-7(5) 	load id value
3016:   PUSH  0,0(6) 	store exp
3017:    LDC  0,3019(0) 	store the return adress
3018:    POP  7,0(6) 	ujp to the function body
3019:    LDA  3,0(3) 	pop parameters
3020:    LDA  3,1(3) 	pop env
3021:    LDA  0,-12(2) 	load id adress
3022:   PUSH  0,0(6) 	push array adress to mp
3023:    POP  1,0(6) 	move the adress of ID
3024:    POP  0,0(6) 	copy bytes
3025:     ST  0,10(1) 	copy bytes
3026:    POP  0,0(6) 	copy bytes
3027:     ST  0,9(1) 	copy bytes
3028:    POP  0,0(6) 	copy bytes
3029:     ST  0,8(1) 	copy bytes
3030:    POP  0,0(6) 	copy bytes
3031:     ST  0,7(1) 	copy bytes
3032:    POP  0,0(6) 	copy bytes
3033:     ST  0,6(1) 	copy bytes
3034:    POP  0,0(6) 	copy bytes
3035:     ST  0,5(1) 	copy bytes
3036:    POP  0,0(6) 	copy bytes
3037:     ST  0,4(1) 	copy bytes
3038:    POP  0,0(6) 	copy bytes
3039:     ST  0,3(1) 	copy bytes
3040:    POP  0,0(6) 	copy bytes
3041:     ST  0,2(1) 	copy bytes
3042:    POP  0,0(6) 	copy bytes
3043:     ST  0,1(1) 	copy bytes
3044:    POP  0,0(6) 	copy bytes
3045:     ST  0,0(1) 	copy bytes
* push function parameters
* push function parameters
3046:    LDC  0,1(0) 	load integer const
3047:   PUSH  0,0(6) 	store exp
3048:    POP  0,0(6) 	pop right
3049:    NEG  0,0,0 	single op (-)
3050:   PUSH  0,0(6) 	op: load left
3051:    POP  0,0(6) 	copy bytes
3052:   PUSH  0,0(3) 	PUSH bytes
3053:     LD  0,1(2) 	load env
3054:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3055:     LD  0,-6(5) 	load id value
3056:   PUSH  0,0(6) 	store exp
3057:    LDC  0,3059(0) 	store the return adress
3058:    POP  7,0(6) 	ujp to the function body
3059:    LDA  3,1(3) 	pop parameters
3060:    LDA  3,1(3) 	pop env
3061:    POP  0,0(6) 	copy bytes
3062:   PUSH  0,0(3) 	PUSH bytes
3063:    LDA  0,-12(2) 	load id adress
3064:   PUSH  0,0(6) 	push array adress to mp
3065:    POP  0,0(6) 	
3066:   PUSH  0,0(3) 	
3067:    LDA  0,0(2) 	load env
3068:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3069:    LDA  0,-12(2) 	load id adress
3070:   PUSH  0,0(6) 	push array adress to mp
3071:    POP  1,0,6 	load adress of lhs struct
3072:    LDC  0,8,0 	load offset of member
3073:    ADD  0,0,1 	compute the real adress if pointK
3074:   PUSH  0,0(6) 	
3075:    POP  0,0(6) 	load adress from mp
3076:     LD  1,0(0) 	copy bytes
3077:   PUSH  1,0(6) 	push a.x value into tmp
3078:    LDC  0,3080(0) 	store the return adress
3079:    POP  7,0(6) 	ujp to the function body
3080:    LDA  3,1(3) 	pop parameters
3081:    LDA  3,1(3) 	pop env
3082:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3083:    LDC  0,1(0) 	load integer const
3084:   PUSH  0,0(6) 	store exp
3085:    POP  0,0(6) 	copy bytes
3086:   PUSH  0,0(3) 	PUSH bytes
3087:     LD  0,1(2) 	load env
3088:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3089:     LD  0,-6(5) 	load id value
3090:   PUSH  0,0(6) 	store exp
3091:    LDC  0,3093(0) 	store the return adress
3092:    POP  7,0(6) 	ujp to the function body
3093:    LDA  3,1(3) 	pop parameters
3094:    LDA  3,1(3) 	pop env
3095:    POP  0,0(6) 	copy bytes
3096:   PUSH  0,0(3) 	PUSH bytes
3097:    LDA  0,-12(2) 	load id adress
3098:   PUSH  0,0(6) 	push array adress to mp
3099:    POP  0,0(6) 	
3100:   PUSH  0,0(3) 	
3101:    LDA  0,0(2) 	load env
3102:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3103:    LDA  0,-12(2) 	load id adress
3104:   PUSH  0,0(6) 	push array adress to mp
3105:    POP  1,0,6 	load adress of lhs struct
3106:    LDC  0,8,0 	load offset of member
3107:    ADD  0,0,1 	compute the real adress if pointK
3108:   PUSH  0,0(6) 	
3109:    POP  0,0(6) 	load adress from mp
3110:     LD  1,0(0) 	copy bytes
3111:   PUSH  1,0(6) 	push a.x value into tmp
3112:    LDC  0,3114(0) 	store the return adress
3113:    POP  7,0(6) 	ujp to the function body
3114:    LDA  3,1(3) 	pop parameters
3115:    LDA  3,1(3) 	pop env
3116:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3117:    LDC  0,20(0) 	load integer const
3118:   PUSH  0,0(6) 	store exp
3119:    POP  0,0(6) 	pop right
3120:    NEG  0,0,0 	single op (-)
3121:   PUSH  0,0(6) 	op: load left
3122:    POP  0,0(6) 	copy bytes
3123:   PUSH  0,0(3) 	PUSH bytes
3124:     LD  0,1(2) 	load env
3125:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3126:     LD  0,-6(5) 	load id value
3127:   PUSH  0,0(6) 	store exp
3128:    LDC  0,3130(0) 	store the return adress
3129:    POP  7,0(6) 	ujp to the function body
3130:    LDA  3,1(3) 	pop parameters
3131:    LDA  3,1(3) 	pop env
3132:    POP  0,0(6) 	copy bytes
3133:   PUSH  0,0(3) 	PUSH bytes
3134:    LDA  0,-12(2) 	load id adress
3135:   PUSH  0,0(6) 	push array adress to mp
3136:    POP  0,0(6) 	
3137:   PUSH  0,0(3) 	
3138:    LDA  0,0(2) 	load env
3139:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3140:    LDA  0,-12(2) 	load id adress
3141:   PUSH  0,0(6) 	push array adress to mp
3142:    POP  1,0,6 	load adress of lhs struct
3143:    LDC  0,8,0 	load offset of member
3144:    ADD  0,0,1 	compute the real adress if pointK
3145:   PUSH  0,0(6) 	
3146:    POP  0,0(6) 	load adress from mp
3147:     LD  1,0(0) 	copy bytes
3148:   PUSH  1,0(6) 	push a.x value into tmp
3149:    LDC  0,3151(0) 	store the return adress
3150:    POP  7,0(6) 	ujp to the function body
3151:    LDA  3,1(3) 	pop parameters
3152:    LDA  3,1(3) 	pop env
3153:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3154:    LDC  0,100(0) 	load integer const
3155:   PUSH  0,0(6) 	store exp
3156:    POP  0,0(6) 	copy bytes
3157:   PUSH  0,0(3) 	PUSH bytes
3158:     LD  0,1(2) 	load env
3159:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3160:     LD  0,-6(5) 	load id value
3161:   PUSH  0,0(6) 	store exp
3162:    LDC  0,3164(0) 	store the return adress
3163:    POP  7,0(6) 	ujp to the function body
3164:    LDA  3,1(3) 	pop parameters
3165:    LDA  3,1(3) 	pop env
3166:    POP  0,0(6) 	copy bytes
3167:   PUSH  0,0(3) 	PUSH bytes
3168:    LDA  0,-12(2) 	load id adress
3169:   PUSH  0,0(6) 	push array adress to mp
3170:    POP  0,0(6) 	
3171:   PUSH  0,0(3) 	
3172:    LDA  0,0(2) 	load env
3173:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3174:    LDA  0,-12(2) 	load id adress
3175:   PUSH  0,0(6) 	push array adress to mp
3176:    POP  1,0,6 	load adress of lhs struct
3177:    LDC  0,8,0 	load offset of member
3178:    ADD  0,0,1 	compute the real adress if pointK
3179:   PUSH  0,0(6) 	
3180:    POP  0,0(6) 	load adress from mp
3181:     LD  1,0(0) 	copy bytes
3182:   PUSH  1,0(6) 	push a.x value into tmp
3183:    LDC  0,3185(0) 	store the return adress
3184:    POP  7,0(6) 	ujp to the function body
3185:    LDA  3,1(3) 	pop parameters
3186:    LDA  3,1(3) 	pop env
3187:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3188:    LDC  0,2001515(0) 	load integer const
3189:   PUSH  0,0(6) 	store exp
3190:    POP  0,0(6) 	copy bytes
3191:   PUSH  0,0(3) 	PUSH bytes
3192:     LD  0,1(2) 	load env
3193:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3194:     LD  0,-6(5) 	load id value
3195:   PUSH  0,0(6) 	store exp
3196:    LDC  0,3198(0) 	store the return adress
3197:    POP  7,0(6) 	ujp to the function body
3198:    LDA  3,1(3) 	pop parameters
3199:    LDA  3,1(3) 	pop env
3200:    POP  0,0(6) 	copy bytes
3201:   PUSH  0,0(3) 	PUSH bytes
3202:    LDA  0,-12(2) 	load id adress
3203:   PUSH  0,0(6) 	push array adress to mp
3204:    POP  0,0(6) 	
3205:   PUSH  0,0(3) 	
3206:    LDA  0,0(2) 	load env
3207:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3208:    LDA  0,-12(2) 	load id adress
3209:   PUSH  0,0(6) 	push array adress to mp
3210:    POP  1,0,6 	load adress of lhs struct
3211:    LDC  0,8,0 	load offset of member
3212:    ADD  0,0,1 	compute the real adress if pointK
3213:   PUSH  0,0(6) 	
3214:    POP  0,0(6) 	load adress from mp
3215:     LD  1,0(0) 	copy bytes
3216:   PUSH  1,0(6) 	push a.x value into tmp
3217:    LDC  0,3219(0) 	store the return adress
3218:    POP  7,0(6) 	ujp to the function body
3219:    LDA  3,1(3) 	pop parameters
3220:    LDA  3,1(3) 	pop env
3221:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3222:    LDC  0,5453(0) 	load integer const
3223:   PUSH  0,0(6) 	store exp
3224:    POP  0,0(6) 	copy bytes
3225:   PUSH  0,0(3) 	PUSH bytes
3226:     LD  0,1(2) 	load env
3227:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3228:     LD  0,-6(5) 	load id value
3229:   PUSH  0,0(6) 	store exp
3230:    LDC  0,3232(0) 	store the return adress
3231:    POP  7,0(6) 	ujp to the function body
3232:    LDA  3,1(3) 	pop parameters
3233:    LDA  3,1(3) 	pop env
3234:    POP  0,0(6) 	copy bytes
3235:   PUSH  0,0(3) 	PUSH bytes
3236:    LDA  0,-12(2) 	load id adress
3237:   PUSH  0,0(6) 	push array adress to mp
3238:    POP  0,0(6) 	
3239:   PUSH  0,0(3) 	
3240:    LDA  0,0(2) 	load env
3241:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3242:    LDA  0,-12(2) 	load id adress
3243:   PUSH  0,0(6) 	push array adress to mp
3244:    POP  1,0,6 	load adress of lhs struct
3245:    LDC  0,8,0 	load offset of member
3246:    ADD  0,0,1 	compute the real adress if pointK
3247:   PUSH  0,0(6) 	
3248:    POP  0,0(6) 	load adress from mp
3249:     LD  1,0(0) 	copy bytes
3250:   PUSH  1,0(6) 	push a.x value into tmp
3251:    LDC  0,3253(0) 	store the return adress
3252:    POP  7,0(6) 	ujp to the function body
3253:    LDA  3,1(3) 	pop parameters
3254:    LDA  3,1(3) 	pop env
3255:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3256:    LDC  0,5675541(0) 	load integer const
3257:   PUSH  0,0(6) 	store exp
3258:    POP  0,0(6) 	copy bytes
3259:   PUSH  0,0(3) 	PUSH bytes
3260:     LD  0,1(2) 	load env
3261:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3262:     LD  0,-6(5) 	load id value
3263:   PUSH  0,0(6) 	store exp
3264:    LDC  0,3266(0) 	store the return adress
3265:    POP  7,0(6) 	ujp to the function body
3266:    LDA  3,1(3) 	pop parameters
3267:    LDA  3,1(3) 	pop env
3268:    POP  0,0(6) 	copy bytes
3269:   PUSH  0,0(3) 	PUSH bytes
3270:    LDA  0,-12(2) 	load id adress
3271:   PUSH  0,0(6) 	push array adress to mp
3272:    POP  0,0(6) 	
3273:   PUSH  0,0(3) 	
3274:    LDA  0,0(2) 	load env
3275:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3276:    LDA  0,-12(2) 	load id adress
3277:   PUSH  0,0(6) 	push array adress to mp
3278:    POP  1,0,6 	load adress of lhs struct
3279:    LDC  0,8,0 	load offset of member
3280:    ADD  0,0,1 	compute the real adress if pointK
3281:   PUSH  0,0(6) 	
3282:    POP  0,0(6) 	load adress from mp
3283:     LD  1,0(0) 	copy bytes
3284:   PUSH  1,0(6) 	push a.x value into tmp
3285:    LDC  0,3287(0) 	store the return adress
3286:    POP  7,0(6) 	ujp to the function body
3287:    LDA  3,1(3) 	pop parameters
3288:    LDA  3,1(3) 	pop env
3289:    LDA  3,1(3) 	pop parameters
3290:    LDA  0,-12(2) 	load id adress
3291:   PUSH  0,0(6) 	push array adress to mp
3292:    POP  0,0(6) 	
3293:   PUSH  0,0(3) 	
3294:    LDA  0,0(2) 	load env
3295:   PUSH  0,0(3) 	store env
* call function: 
* popRight
3296:    LDA  0,-12(2) 	load id adress
3297:   PUSH  0,0(6) 	push array adress to mp
3298:    POP  1,0,6 	load adress of lhs struct
3299:    LDC  0,9,0 	load offset of member
3300:    ADD  0,0,1 	compute the real adress if pointK
3301:   PUSH  0,0(6) 	
3302:    POP  0,0(6) 	load adress from mp
3303:     LD  1,0(0) 	copy bytes
3304:   PUSH  1,0(6) 	push a.x value into tmp
3305:    LDC  0,3307(0) 	store the return adress
3306:    POP  7,0(6) 	ujp to the function body
3307:    LDA  3,0(3) 	pop parameters
3308:    LDA  3,1(3) 	pop env
3309:    LDA  3,1(3) 	pop parameters
3310:    LDA  0,-12(2) 	load id adress
3311:   PUSH  0,0(6) 	push array adress to mp
3312:    POP  0,0(6) 	
3313:   PUSH  0,0(3) 	
3314:    LDA  0,0(2) 	load env
3315:   PUSH  0,0(3) 	store env
* call function: 
* popLeft
3316:    LDA  0,-12(2) 	load id adress
3317:   PUSH  0,0(6) 	push array adress to mp
3318:    POP  1,0,6 	load adress of lhs struct
3319:    LDC  0,10,0 	load offset of member
3320:    ADD  0,0,1 	compute the real adress if pointK
3321:   PUSH  0,0(6) 	
3322:    POP  0,0(6) 	load adress from mp
3323:     LD  1,0(0) 	copy bytes
3324:   PUSH  1,0(6) 	push a.x value into tmp
3325:    LDC  0,3327(0) 	store the return adress
3326:    POP  7,0(6) 	ujp to the function body
3327:    LDA  3,0(3) 	pop parameters
3328:    LDA  3,1(3) 	pop env
3329:    LDA  3,1(3) 	pop parameters
3330:    LDA  0,-12(2) 	load id adress
3331:   PUSH  0,0(6) 	push array adress to mp
3332:    POP  0,0(6) 	
3333:   PUSH  0,0(3) 	
3334:    LDA  0,0(2) 	load env
3335:   PUSH  0,0(3) 	store env
* call function: 
* popLeft
3336:    LDA  0,-12(2) 	load id adress
3337:   PUSH  0,0(6) 	push array adress to mp
3338:    POP  1,0,6 	load adress of lhs struct
3339:    LDC  0,10,0 	load offset of member
3340:    ADD  0,0,1 	compute the real adress if pointK
3341:   PUSH  0,0(6) 	
3342:    POP  0,0(6) 	load adress from mp
3343:     LD  1,0(0) 	copy bytes
3344:   PUSH  1,0(6) 	push a.x value into tmp
3345:    LDC  0,3347(0) 	store the return adress
3346:    POP  7,0(6) 	ujp to the function body
3347:    LDA  3,0(3) 	pop parameters
3348:    LDA  3,1(3) 	pop env
3349:    LDA  3,1(3) 	pop parameters
3350:    LDA  3,-1(3) 	stack expand
3351:    LDA  0,-12(2) 	load id adress
3352:   PUSH  0,0(6) 	push array adress to mp
3353:    POP  1,0,6 	load adress of lhs struct
3354:    LDC  0,0,0 	load offset of member
3355:    ADD  0,0,1 	compute the real adress if pointK
3356:   PUSH  0,0(6) 	
3357:    POP  0,0(6) 	load adress from mp
3358:     LD  1,0(0) 	copy bytes
3359:   PUSH  1,0(6) 	push a.x value into tmp
3360:    POP  1,0,6 	load adress of lhs struct
3361:    LDC  0,1,0 	load offset of member
3362:    ADD  0,0,1 	compute the real adress if pointK
3363:   PUSH  0,0(6) 	
3364:    POP  0,0(6) 	load adress from mp
3365:     LD  1,0(0) 	copy bytes
3366:   PUSH  1,0(6) 	push a.x value into tmp
3367:    LDA  0,-13(2) 	load id adress
3368:   PUSH  0,0(6) 	push array adress to mp
3369:    POP  1,0(6) 	move the adress of ID
3370:    POP  0,0(6) 	copy bytes
3371:     ST  0,0(1) 	copy bytes
* while stmt:
3372:  LABEL  59,0,0 	generate label
3373:     LD  0,-13(2) 	load id value
3374:   PUSH  0,0(6) 	store exp
3375:     LD  0,0(5) 	load id value
3376:   PUSH  0,0(6) 	store exp
3377:    POP  1,0(6) 	pop right
3378:    POP  0,0(6) 	pop left
3379:    SUB  0,0,1 	op ==, convertd_type
3380:    JNE  0,2(7) 	br if true
3381:    LDC  0,0(0) 	false case
3382:    LDA  7,1(7) 	unconditional jmp
3383:    LDC  0,1(0) 	true case
3384:   PUSH  0,0(6) 	
3385:    POP  0,0(6) 	pop from the mp
3386:    JNE  0,1,7 	true case:, skip the break, execute the block code
3387:     GO  60,0,0 	go to label
3388:     LD  0,-13(2) 	load id value
3389:   PUSH  0,0(6) 	store exp
3390:    POP  1,0,6 	load adress of lhs struct
3391:    LDC  0,2,0 	load offset of member
3392:    ADD  0,0,1 	compute the real adress if pointK
3393:   PUSH  0,0(6) 	
3394:    POP  0,0(6) 	load adress from mp
3395:     LD  1,0(0) 	copy bytes
3396:   PUSH  1,0(6) 	push a.x value into tmp
3397:    POP  0,0(6) 	pop the adress
3398:     LD  1,0(0) 	load bytes
3399:   PUSH  1,0(6) 	push bytes 
3400:    POP  0,0(6) 	move result to register
3401:    OUT  0,0,0 	output value in register[ac / fac]
3402:     LD  0,-13(2) 	load id value
3403:   PUSH  0,0(6) 	store exp
3404:    POP  1,0,6 	load adress of lhs struct
3405:    LDC  0,1,0 	load offset of member
3406:    ADD  0,0,1 	compute the real adress if pointK
3407:   PUSH  0,0(6) 	
3408:    POP  0,0(6) 	load adress from mp
3409:     LD  1,0(0) 	copy bytes
3410:   PUSH  1,0(6) 	push a.x value into tmp
3411:    LDA  0,-13(2) 	load id adress
3412:   PUSH  0,0(6) 	push array adress to mp
3413:    POP  1,0(6) 	move the adress of ID
3414:    POP  0,0(6) 	copy bytes
3415:     ST  0,0(1) 	copy bytes
3416:     GO  59,0,0 	go to label
3417:  LABEL  60,0,0 	generate label
3418:    MOV  3,2,0 	restore the caller sp
3419:     LD  2,0(2) 	resotre the caller fp
3420:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3421:  LABEL  58,0,0 	generate label
* function entry:
* testMatch
3422:    LDA  3,-1(3) 	stack expand for function variable
3423:    LDC  0,3426(0) 	get function adress
3424:     ST  0,-12(5) 	set function adress
3425:     GO  61,0,0 	go to label
3426:    MOV  1,2,0 	store the caller fp temporarily
3427:    MOV  2,3,0 	exchang the stack(context)
3428:   PUSH  1,0(3) 	push the caller fp
3429:   PUSH  0,0(3) 	push the return adress
3430:    LDA  3,-11(3) 	stack expand
3431:    LDC  1,122(0) 	get function adress from struct
3432:     ST  1,4(3) 	Init Struct Instance
3433:    LDC  1,132(0) 	get function adress from struct
3434:     ST  1,5(3) 	Init Struct Instance
3435:    LDC  1,142(0) 	get function adress from struct
3436:     ST  1,6(3) 	Init Struct Instance
3437:    LDC  1,152(0) 	get function adress from struct
3438:     ST  1,7(3) 	Init Struct Instance
3439:    LDC  1,466(0) 	get function adress from struct
3440:     ST  1,8(3) 	Init Struct Instance
3441:    LDC  1,589(0) 	get function adress from struct
3442:     ST  1,9(3) 	Init Struct Instance
3443:    LDC  1,855(0) 	get function adress from struct
3444:     ST  1,10(3) 	Init Struct Instance
3445:    LDC  1,1011(0) 	get function adress from struct
3446:     ST  1,11(3) 	Init Struct Instance
3447:     LD  0,1(2) 	load env
3448:   PUSH  0,0(3) 	store env
* call function: 
* makeList
3449:     LD  0,-7(5) 	load id value
3450:   PUSH  0,0(6) 	store exp
3451:    LDC  0,3453(0) 	store the return adress
3452:    POP  7,0(6) 	ujp to the function body
3453:    LDA  3,0(3) 	pop parameters
3454:    LDA  3,1(3) 	pop env
3455:    LDA  0,-12(2) 	load id adress
3456:   PUSH  0,0(6) 	push array adress to mp
3457:    POP  1,0(6) 	move the adress of ID
3458:    POP  0,0(6) 	copy bytes
3459:     ST  0,10(1) 	copy bytes
3460:    POP  0,0(6) 	copy bytes
3461:     ST  0,9(1) 	copy bytes
3462:    POP  0,0(6) 	copy bytes
3463:     ST  0,8(1) 	copy bytes
3464:    POP  0,0(6) 	copy bytes
3465:     ST  0,7(1) 	copy bytes
3466:    POP  0,0(6) 	copy bytes
3467:     ST  0,6(1) 	copy bytes
3468:    POP  0,0(6) 	copy bytes
3469:     ST  0,5(1) 	copy bytes
3470:    POP  0,0(6) 	copy bytes
3471:     ST  0,4(1) 	copy bytes
3472:    POP  0,0(6) 	copy bytes
3473:     ST  0,3(1) 	copy bytes
3474:    POP  0,0(6) 	copy bytes
3475:     ST  0,2(1) 	copy bytes
3476:    POP  0,0(6) 	copy bytes
3477:     ST  0,1(1) 	copy bytes
3478:    POP  0,0(6) 	copy bytes
3479:     ST  0,0(1) 	copy bytes
3480:    LDA  3,-1(3) 	stack expand
3481:    LDC  0,1(0) 	load integer const
3482:   PUSH  0,0(6) 	store exp
3483:    LDA  0,-13(2) 	load id adress
3484:   PUSH  0,0(6) 	push array adress to mp
3485:    POP  1,0(6) 	move the adress of ID
3486:    POP  0,0(6) 	copy bytes
3487:     ST  0,0(1) 	copy bytes
3488:    LDA  3,-1(3) 	stack expand
3489:    LDC  0,1(0) 	load integer const
3490:   PUSH  0,0(6) 	store exp
3491:    LDA  0,-14(2) 	load id adress
3492:   PUSH  0,0(6) 	push array adress to mp
3493:    POP  1,0(6) 	move the adress of ID
3494:    POP  0,0(6) 	copy bytes
3495:     ST  0,0(1) 	copy bytes
* push function parameters
3496:    LDA  0,-14(2) 	load id adress
3497:   PUSH  0,0(6) 	push array adress to mp
3498:    POP  0,0(6) 	copy bytes
3499:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
3500:    LDA  0,-13(2) 	load id adress
3501:   PUSH  0,0(6) 	push array adress to mp
3502:    POP  0,0(6) 	copy bytes
3503:   PUSH  0,0(3) 	PUSH bytes
3504:    LDA  0,0(2) 	load env
3505:   PUSH  0,0(3) 	store env
* call function: 
* match
3506:    LDA  0,-12(2) 	load id adress
3507:   PUSH  0,0(6) 	push array adress to mp
3508:    POP  1,0,6 	load adress of lhs struct
3509:    LDC  0,5,0 	load offset of member
3510:    ADD  0,0,1 	compute the real adress if pointK
3511:   PUSH  0,0(6) 	
3512:    POP  0,0(6) 	load adress from mp
3513:     LD  1,0(0) 	copy bytes
3514:   PUSH  1,0(6) 	push a.x value into tmp
3515:    LDC  0,3517(0) 	store the return adress
3516:    POP  7,0(6) 	ujp to the function body
3517:    LDA  3,2(3) 	pop parameters
3518:    LDA  3,1(3) 	pop env
3519:    POP  0,0(6) 	move result to register
3520:    OUT  0,0,0 	output value in register[ac / fac]
3521:    MOV  3,2,0 	restore the caller sp
3522:     LD  2,0(2) 	resotre the caller fp
3523:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3524:  LABEL  61,0,0 	generate label
* function entry:
* main
3525:    LDC  0,3528(0) 	get function adress
3526:     ST  0,-13(5) 	set function adress
3527:     GO  62,0,0 	go to label
3528:    MOV  1,2,0 	store the caller fp temporarily
3529:    MOV  2,3,0 	exchang the stack(context)
3530:   PUSH  1,0(3) 	push the caller fp
3531:   PUSH  0,0(3) 	push the return adress
3532:     LD  0,1(2) 	load env
3533:   PUSH  0,0(3) 	store env
* call function: 
* testMatch
3534:     LD  0,-12(5) 	load id value
3535:   PUSH  0,0(6) 	store exp
3536:    LDC  0,3538(0) 	store the return adress
3537:    POP  7,0(6) 	ujp to the function body
3538:    LDA  3,0(3) 	pop parameters
3539:    LDA  3,1(3) 	pop env
3540:     LD  0,1(2) 	load env
3541:   PUSH  0,0(3) 	store env
* call function: 
* test_insertSortedList
3542:     LD  0,-8(5) 	load id value
3543:   PUSH  0,0(6) 	store exp
3544:    LDC  0,3546(0) 	store the return adress
3545:    POP  7,0(6) 	ujp to the function body
3546:    LDA  3,0(3) 	pop parameters
3547:    LDA  3,1(3) 	pop env
3548:    LDC  0,45(0) 	load char const
3549:     ST  0,-29(4) 	store exp
3550:    LDC  0,45(0) 	load char const
3551:     ST  0,-28(4) 	store exp
3552:    LDC  0,45(0) 	load char const
3553:     ST  0,-27(4) 	store exp
3554:    LDC  0,45(0) 	load char const
3555:     ST  0,-26(4) 	store exp
3556:    LDC  0,45(0) 	load char const
3557:     ST  0,-25(4) 	store exp
3558:    LDC  0,45(0) 	load char const
3559:     ST  0,-24(4) 	store exp
3560:    LDC  0,45(0) 	load char const
3561:     ST  0,-23(4) 	store exp
3562:    LDC  0,45(0) 	load char const
3563:     ST  0,-22(4) 	store exp
3564:    LDC  0,45(0) 	load char const
3565:     ST  0,-21(4) 	store exp
3566:    LDC  0,45(0) 	load char const
3567:     ST  0,-20(4) 	store exp
3568:    LDC  0,45(0) 	load char const
3569:     ST  0,-19(4) 	store exp
3570:    LDC  0,45(0) 	load char const
3571:     ST  0,-18(4) 	store exp
3572:    LDC  0,45(0) 	load char const
3573:     ST  0,-17(4) 	store exp
3574:    LDC  0,45(0) 	load char const
3575:     ST  0,-16(4) 	store exp
3576:    LDC  0,45(0) 	load char const
3577:     ST  0,-15(4) 	store exp
3578:    LDA  0,-29(4) 	load char const
3579:   PUSH  0,0(6) 	store exp
3580:    POP  0,0(6) 	move result to register
3581:    OUT  0,2,0 	output value in register[ac / fac]
3582:     LD  0,1(2) 	load env
3583:   PUSH  0,0(3) 	store env
* call function: 
* test_appendList
3584:     LD  0,-9(5) 	load id value
3585:   PUSH  0,0(6) 	store exp
3586:    LDC  0,3588(0) 	store the return adress
3587:    POP  7,0(6) 	ujp to the function body
3588:    LDA  3,0(3) 	pop parameters
3589:    LDA  3,1(3) 	pop env
3590:    LDC  0,45(0) 	load char const
3591:     ST  0,-45(4) 	store exp
3592:    LDC  0,45(0) 	load char const
3593:     ST  0,-44(4) 	store exp
3594:    LDC  0,45(0) 	load char const
3595:     ST  0,-43(4) 	store exp
3596:    LDC  0,45(0) 	load char const
3597:     ST  0,-42(4) 	store exp
3598:    LDC  0,45(0) 	load char const
3599:     ST  0,-41(4) 	store exp
3600:    LDC  0,45(0) 	load char const
3601:     ST  0,-40(4) 	store exp
3602:    LDC  0,45(0) 	load char const
3603:     ST  0,-39(4) 	store exp
3604:    LDC  0,45(0) 	load char const
3605:     ST  0,-38(4) 	store exp
3606:    LDC  0,45(0) 	load char const
3607:     ST  0,-37(4) 	store exp
3608:    LDC  0,45(0) 	load char const
3609:     ST  0,-36(4) 	store exp
3610:    LDC  0,45(0) 	load char const
3611:     ST  0,-35(4) 	store exp
3612:    LDC  0,45(0) 	load char const
3613:     ST  0,-34(4) 	store exp
3614:    LDC  0,45(0) 	load char const
3615:     ST  0,-33(4) 	store exp
3616:    LDC  0,45(0) 	load char const
3617:     ST  0,-32(4) 	store exp
3618:    LDC  0,45(0) 	load char const
3619:     ST  0,-31(4) 	store exp
3620:    LDA  0,-45(4) 	load char const
3621:   PUSH  0,0(6) 	store exp
3622:    POP  0,0(6) 	move result to register
3623:    OUT  0,2,0 	output value in register[ac / fac]
3624:     LD  0,1(2) 	load env
3625:   PUSH  0,0(3) 	store env
* call function: 
* test_removeList
3626:     LD  0,-10(5) 	load id value
3627:   PUSH  0,0(6) 	store exp
3628:    LDC  0,3630(0) 	store the return adress
3629:    POP  7,0(6) 	ujp to the function body
3630:    LDA  3,0(3) 	pop parameters
3631:    LDA  3,1(3) 	pop env
3632:    LDC  0,45(0) 	load char const
3633:     ST  0,-61(4) 	store exp
3634:    LDC  0,45(0) 	load char const
3635:     ST  0,-60(4) 	store exp
3636:    LDC  0,45(0) 	load char const
3637:     ST  0,-59(4) 	store exp
3638:    LDC  0,45(0) 	load char const
3639:     ST  0,-58(4) 	store exp
3640:    LDC  0,45(0) 	load char const
3641:     ST  0,-57(4) 	store exp
3642:    LDC  0,45(0) 	load char const
3643:     ST  0,-56(4) 	store exp
3644:    LDC  0,45(0) 	load char const
3645:     ST  0,-55(4) 	store exp
3646:    LDC  0,45(0) 	load char const
3647:     ST  0,-54(4) 	store exp
3648:    LDC  0,45(0) 	load char const
3649:     ST  0,-53(4) 	store exp
3650:    LDC  0,45(0) 	load char const
3651:     ST  0,-52(4) 	store exp
3652:    LDC  0,45(0) 	load char const
3653:     ST  0,-51(4) 	store exp
3654:    LDC  0,45(0) 	load char const
3655:     ST  0,-50(4) 	store exp
3656:    LDC  0,45(0) 	load char const
3657:     ST  0,-49(4) 	store exp
3658:    LDC  0,45(0) 	load char const
3659:     ST  0,-48(4) 	store exp
3660:    LDC  0,45(0) 	load char const
3661:     ST  0,-47(4) 	store exp
3662:    LDA  0,-61(4) 	load char const
3663:   PUSH  0,0(6) 	store exp
3664:    POP  0,0(6) 	move result to register
3665:    OUT  0,2,0 	output value in register[ac / fac]
3666:     LD  0,1(2) 	load env
3667:   PUSH  0,0(3) 	store env
* call function: 
* test_pop
3668:     LD  0,-11(5) 	load id value
3669:   PUSH  0,0(6) 	store exp
3670:    LDC  0,3672(0) 	store the return adress
3671:    POP  7,0(6) 	ujp to the function body
3672:    LDA  3,0(3) 	pop parameters
3673:    LDA  3,1(3) 	pop env
3674:    MOV  3,2,0 	restore the caller sp
3675:     LD  2,0(2) 	resotre the caller fp
3676:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3677:  LABEL  62,0,0 	generate label
* call main function
3678:     LD  1,-13(5) 	get main function adress
3679:    LDC  0,3681(0) 	store the return adress
3680:    LDA  7,0(1) 	ujp to the function body
3681:   HALT  0,0,0 	
