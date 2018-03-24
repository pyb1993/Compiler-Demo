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
 11:    LDA  0,-5(5) 	load id adress
 12:   PUSH  0,0(6) 	push array adress to mp
 13:    POP  1,0(6) 	move the adress of ID
 14:    POP  0,0(6) 	copy bytes
 15:     ST  0,0(1) 	copy bytes
* function entry:
* malloc
 16:    LDA  3,-1(3) 	stack expand for function variable
 17:    LDC  0,20(0) 	get function adress
 18:     ST  0,-6(5) 	set function adress
 19:     GO  7,0,0 	go to label
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
 31:  LABEL  7,0,0 	generate label
* function entry:
* free
 32:    LDA  3,-1(3) 	stack expand for function variable
 33:    LDC  0,36(0) 	get function adress
 34:     ST  0,-7(5) 	set function adress
 35:     GO  8,0,0 	go to label
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
 47:  LABEL  8,0,0 	generate label
* function entry:
* printStr
 48:    LDA  3,-1(3) 	stack expand for function variable
 49:    LDC  0,52(0) 	get function adress
 50:     ST  0,-8(5) 	set function adress
 51:     GO  9,0,0 	go to label
 52:    MOV  1,2,0 	store the caller fp temporarily
 53:    MOV  2,3,0 	exchang the stack(context)
 54:   PUSH  1,0(3) 	push the caller fp
 55:   PUSH  0,0(3) 	push the return adress
* while stmt:
 56:  LABEL  10,0,0 	generate label
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
 74:     GO  11,0,0 	go to label
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
100:     GO  10,0,0 	go to label
174:  LABEL  11,0,0 	generate label
175:    MOV  3,2,0 	restore the caller sp
176:     LD  2,0(2) 	resotre the caller fp
177:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
178:  LABEL  9,0,0 	generate label
* call main function
* File: list_example.tm
* Standard prelude:
179:    LDC  6,65535(0) 	load mp adress
180:     ST  0,0(0) 	clear location 0
181:    LDC  5,4095(0) 	load gp adress from location 1
182:     ST  0,1(0) 	clear location 1
183:    LDC  4,2000(0) 	load gp adress from location 1
184:    LDC  2,60000(0) 	load first fp from location 2
185:    LDC  3,60000(0) 	load first sp from location 2
186:     ST  0,2(0) 	clear location 2
* End of standard prelude.
187:    LDA  3,-1(3) 	stack expand
188:    LDA  3,-1(3) 	stack expand
189:    LDA  3,-1(3) 	stack expand
190:    LDA  3,-1(3) 	stack expand
191:    LDA  3,-1(3) 	stack expand
192:    LDA  3,-1(3) 	stack expand
* function entry:
* dup
193:    LDA  3,-1(3) 	stack expand for function variable
194:     GO  12,0,0 	go to label
195:    MOV  1,2,0 	store the caller fp temporarily
196:    MOV  2,3,0 	exchang the stack(context)
197:   PUSH  1,0(3) 	push the caller fp
198:   PUSH  0,0(3) 	push the return adress
199:    MOV  3,2,0 	restore the caller sp
200:     LD  2,0(2) 	resotre the caller fp
201:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
202:  LABEL  12,0,0 	generate label
* function entry:
* freeList
203:    LDA  3,-1(3) 	stack expand for function variable
204:     GO  13,0,0 	go to label
205:    MOV  1,2,0 	store the caller fp temporarily
206:    MOV  2,3,0 	exchang the stack(context)
207:   PUSH  1,0(3) 	push the caller fp
208:   PUSH  0,0(3) 	push the return adress
209:    MOV  3,2,0 	restore the caller sp
210:     LD  2,0(2) 	resotre the caller fp
211:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
212:  LABEL  13,0,0 	generate label
* function entry:
* match
213:    LDA  3,-1(3) 	stack expand for function variable
214:     GO  14,0,0 	go to label
215:    MOV  1,2,0 	store the caller fp temporarily
216:    MOV  2,3,0 	exchang the stack(context)
217:   PUSH  1,0(3) 	push the caller fp
218:   PUSH  0,0(3) 	push the return adress
219:    MOV  3,2,0 	restore the caller sp
220:     LD  2,0(2) 	resotre the caller fp
221:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
222:  LABEL  14,0,0 	generate label
* function entry:
* removeList
223:    LDA  3,-1(3) 	stack expand for function variable
224:     GO  15,0,0 	go to label
225:    MOV  1,2,0 	store the caller fp temporarily
226:    MOV  2,3,0 	exchang the stack(context)
227:   PUSH  1,0(3) 	push the caller fp
228:   PUSH  0,0(3) 	push the return adress
229:     LD  0,2(2) 	load id value
230:   PUSH  0,0(6) 	store exp
231:    POP  1,0,6 	load adress of lhs struct
232:    LDC  0,2,0 	load offset of member
233:    ADD  0,0,1 	compute the real adress if pointK
234:   PUSH  0,0(6) 	
235:    POP  0,0(6) 	load adress from mp
236:     LD  1,0(0) 	copy bytes
237:   PUSH  1,0(6) 	push a.x value into tmp
238:    LDC  0,0(0) 	load integer const
239:   PUSH  0,0(6) 	store exp
240:    POP  1,0(6) 	pop right
241:    POP  0,0(6) 	pop left
242:    SUB  0,0,1 	op <
243:    JLE  0,2(7) 	br if true
244:    LDC  0,0(0) 	false case
245:    LDA  7,1(7) 	unconditional jmp
246:    LDC  0,1(0) 	true case
247:   PUSH  0,0(6) 	
248:    POP  0,0(6) 	pop from the mp
249:    JNE  0,1,7 	true case:, execute if part
250:     GO  16,0,0 	go to label
251:    MOV  3,2,0 	restore the caller sp
252:     LD  2,0(2) 	resotre the caller fp
253:  RETURN  0,-1,3 	return to the caller
254:     GO  17,0,0 	go to label
255:  LABEL  16,0,0 	generate label
* if: jump to else
256:  LABEL  17,0,0 	generate label
257:     LD  0,2(2) 	load id value
258:   PUSH  0,0(6) 	store exp
259:    POP  1,0,6 	load adress of lhs struct
260:    LDC  0,2,0 	load offset of member
261:    ADD  0,0,1 	compute the real adress if pointK
262:   PUSH  0,0(6) 	
263:    POP  0,0(6) 	load adress from mp
264:     LD  1,0(0) 	copy bytes
265:   PUSH  1,0(6) 	push a.x value into tmp
266:    POP  0,0(6) 	pop right
267:     LD  0,2(2) 	load id value
268:   PUSH  0,0(6) 	store exp
269:    POP  1,0,6 	load adress of lhs struct
270:    LDC  0,2,0 	load offset of member
271:    ADD  0,0,1 	compute the real adress if pointK
272:   PUSH  0,0(6) 	
273:    POP  0,0(6) 	load adress from mp
274:     LD  1,0(0) 	copy bytes
275:   PUSH  1,0(6) 	push a.x value into tmp
276:    LDC  0,1(0) 	load integer const
277:   PUSH  0,0(6) 	store exp
278:    POP  1,0(6) 	pop right
279:    POP  0,0(6) 	pop left
280:    SUB  0,0,1 	op -
281:   PUSH  0,0(6) 	op: load left
282:     LD  0,2(2) 	load id value
283:   PUSH  0,0(6) 	store exp
284:    POP  1,0,6 	load adress of lhs struct
285:    LDC  0,2,0 	load offset of member
286:    ADD  0,0,1 	compute the real adress if pointK
287:   PUSH  0,0(6) 	
288:    POP  1,0(6) 	move the adress of referenced
289:    POP  0,0(6) 	copy bytes
290:     ST  0,0(1) 	copy bytes
291:    LDA  3,-1(3) 	stack expand
292:     LD  0,2(2) 	load id value
293:   PUSH  0,0(6) 	store exp
294:    POP  1,0,6 	load adress of lhs struct
295:    LDC  0,0,0 	load offset of member
296:    ADD  0,0,1 	compute the real adress if pointK
297:   PUSH  0,0(6) 	
298:    POP  0,0(6) 	load adress from mp
299:     LD  1,0(0) 	copy bytes
300:   PUSH  1,0(6) 	push a.x value into tmp
301:    POP  1,0,6 	load adress of lhs struct
302:    LDC  0,1,0 	load offset of member
303:    ADD  0,0,1 	compute the real adress if pointK
304:   PUSH  0,0(6) 	
305:    POP  0,0(6) 	load adress from mp
306:     LD  1,0(0) 	copy bytes
307:   PUSH  1,0(6) 	push a.x value into tmp
308:    LDA  0,-2(2) 	load id adress
309:   PUSH  0,0(6) 	push array adress to mp
310:    POP  1,0(6) 	move the adress of ID
311:    POP  0,0(6) 	copy bytes
312:     ST  0,0(1) 	copy bytes
* while stmt:
313:  LABEL  18,0,0 	generate label
314:     LD  0,-2(2) 	load id value
315:   PUSH  0,0(6) 	store exp
316:     LD  0,-5(5) 	load id value
317:   PUSH  0,0(6) 	store exp
318:    POP  1,0(6) 	pop right
319:    POP  0,0(6) 	pop left
320:    SUB  0,0,1 	op ==, convertd_type
321:    JNE  0,2(7) 	br if true
322:    LDC  0,0(0) 	false case
323:    LDA  7,1(7) 	unconditional jmp
324:    LDC  0,1(0) 	true case
325:   PUSH  0,0(6) 	
* push function parameters
326:     LD  0,3(2) 	load id value
327:   PUSH  0,0(6) 	store exp
328:    POP  0,0(6) 	copy bytes
329:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
330:     LD  0,-2(2) 	load id value
331:   PUSH  0,0(6) 	store exp
332:    POP  1,0,6 	load adress of lhs struct
333:    LDC  0,2,0 	load offset of member
334:    ADD  0,0,1 	compute the real adress if pointK
335:   PUSH  0,0(6) 	
336:    POP  0,0(6) 	load adress from mp
337:     LD  1,0(0) 	copy bytes
338:   PUSH  1,0(6) 	push a.x value into tmp
339:    POP  0,0(6) 	copy bytes
340:   PUSH  0,0(3) 	PUSH bytes
341:     LD  0,1(2) 	load env
342:   PUSH  0,0(3) 	store env
* call function: 
* match
343:     LD  0,2(2) 	load id value
344:   PUSH  0,0(6) 	store exp
345:    POP  1,0,6 	load adress of lhs struct
346:    LDC  0,5,0 	load offset of member
347:    ADD  0,0,1 	compute the real adress if pointK
348:   PUSH  0,0(6) 	
349:    POP  0,0(6) 	load adress from mp
350:     LD  1,0(0) 	copy bytes
351:   PUSH  1,0(6) 	push a.x value into tmp
352:    LDC  0,354(0) 	store the return adress
353:    POP  7,0(6) 	ujp to the function body
354:    LDA  3,2(3) 	pop parameters
355:    LDA  3,1(3) 	pop env
356:    LDC  0,0(0) 	load integer const
357:   PUSH  0,0(6) 	store exp
358:    POP  1,0(6) 	pop right
359:    POP  0,0(6) 	pop left
360:    SUB  0,0,1 	op ==, convertd_type
361:    JNE  0,2(7) 	br if true
362:    LDC  0,0(0) 	false case
363:    LDA  7,1(7) 	unconditional jmp
364:    LDC  0,1(0) 	true case
365:   PUSH  0,0(6) 	
366:    POP  1,0(6) 	pop right
367:    POP  0,0(6) 	pop left
368:    JEQ  0,3(7) 	br if false
369:    JEQ  1,2(7) 	br if false
370:    LDC  0,1(0) 	true case
371:    LDA  7,1(7) 	unconditional jmp
372:    LDC  0,0(0) 	false case
373:   PUSH  0,0(6) 	
374:    POP  0,0(6) 	pop from the mp
375:    JNE  0,1,7 	true case:, skip the break, execute the block code
376:     GO  19,0,0 	go to label
377:     LD  0,-2(2) 	load id value
378:   PUSH  0,0(6) 	store exp
379:    POP  1,0,6 	load adress of lhs struct
380:    LDC  0,1,0 	load offset of member
381:    ADD  0,0,1 	compute the real adress if pointK
382:   PUSH  0,0(6) 	
383:    POP  0,0(6) 	load adress from mp
384:     LD  1,0(0) 	copy bytes
385:   PUSH  1,0(6) 	push a.x value into tmp
386:    LDA  0,-2(2) 	load id adress
387:   PUSH  0,0(6) 	push array adress to mp
388:    POP  1,0(6) 	move the adress of ID
389:    POP  0,0(6) 	copy bytes
390:     ST  0,0(1) 	copy bytes
391:     GO  18,0,0 	go to label
392:  LABEL  19,0,0 	generate label
393:     LD  0,-2(2) 	load id value
394:   PUSH  0,0(6) 	store exp
395:     LD  0,-5(5) 	load id value
396:   PUSH  0,0(6) 	store exp
397:    POP  1,0(6) 	pop right
398:    POP  0,0(6) 	pop left
399:    SUB  0,0,1 	op ==, convertd_type
400:    JEQ  0,2(7) 	br if true
401:    LDC  0,0(0) 	false case
402:    LDA  7,1(7) 	unconditional jmp
403:    LDC  0,1(0) 	true case
404:   PUSH  0,0(6) 	
405:    POP  0,0(6) 	pop from the mp
406:    JNE  0,1,7 	true case:, execute if part
407:     GO  20,0,0 	go to label
408:    MOV  3,2,0 	restore the caller sp
409:     LD  2,0(2) 	resotre the caller fp
410:  RETURN  0,-1,3 	return to the caller
411:     GO  21,0,0 	go to label
412:  LABEL  20,0,0 	generate label
* if: jump to else
413:  LABEL  21,0,0 	generate label
414:    LDA  3,-1(3) 	stack expand
415:     LD  0,-2(2) 	load id value
416:   PUSH  0,0(6) 	store exp
417:    POP  1,0,6 	load adress of lhs struct
418:    LDC  0,0,0 	load offset of member
419:    ADD  0,0,1 	compute the real adress if pointK
420:   PUSH  0,0(6) 	
421:    POP  0,0(6) 	load adress from mp
422:     LD  1,0(0) 	copy bytes
423:   PUSH  1,0(6) 	push a.x value into tmp
424:    LDA  0,-3(2) 	load id adress
425:   PUSH  0,0(6) 	push array adress to mp
426:    POP  1,0(6) 	move the adress of ID
427:    POP  0,0(6) 	copy bytes
428:     ST  0,0(1) 	copy bytes
429:    LDA  3,-1(3) 	stack expand
430:     LD  0,-2(2) 	load id value
431:   PUSH  0,0(6) 	store exp
432:    POP  1,0,6 	load adress of lhs struct
433:    LDC  0,1,0 	load offset of member
434:    ADD  0,0,1 	compute the real adress if pointK
435:   PUSH  0,0(6) 	
436:    POP  0,0(6) 	load adress from mp
437:     LD  1,0(0) 	copy bytes
438:   PUSH  1,0(6) 	push a.x value into tmp
439:    LDA  0,-4(2) 	load id adress
440:   PUSH  0,0(6) 	push array adress to mp
441:    POP  1,0(6) 	move the adress of ID
442:    POP  0,0(6) 	copy bytes
443:     ST  0,0(1) 	copy bytes
444:     LD  0,-4(2) 	load id value
445:   PUSH  0,0(6) 	store exp
446:     LD  0,-3(2) 	load id value
447:   PUSH  0,0(6) 	store exp
448:    POP  1,0,6 	load adress of lhs struct
449:    LDC  0,1,0 	load offset of member
450:    ADD  0,0,1 	compute the real adress if pointK
451:   PUSH  0,0(6) 	
452:    POP  1,0(6) 	move the adress of referenced
453:    POP  0,0(6) 	copy bytes
454:     ST  0,0(1) 	copy bytes
455:     LD  0,-4(2) 	load id value
456:   PUSH  0,0(6) 	store exp
457:     LD  0,-5(5) 	load id value
458:   PUSH  0,0(6) 	store exp
459:    POP  1,0(6) 	pop right
460:    POP  0,0(6) 	pop left
461:    SUB  0,0,1 	op ==, convertd_type
462:    JNE  0,2(7) 	br if true
463:    LDC  0,0(0) 	false case
464:    LDA  7,1(7) 	unconditional jmp
465:    LDC  0,1(0) 	true case
466:   PUSH  0,0(6) 	
467:    POP  0,0(6) 	pop from the mp
468:    JNE  0,1,7 	true case:, execute if part
469:     GO  22,0,0 	go to label
470:     LD  0,-3(2) 	load id value
471:   PUSH  0,0(6) 	store exp
472:     LD  0,-4(2) 	load id value
473:   PUSH  0,0(6) 	store exp
474:    POP  1,0,6 	load adress of lhs struct
475:    LDC  0,0,0 	load offset of member
476:    ADD  0,0,1 	compute the real adress if pointK
477:   PUSH  0,0(6) 	
478:    POP  1,0(6) 	move the adress of referenced
479:    POP  0,0(6) 	copy bytes
480:     ST  0,0(1) 	copy bytes
481:     GO  23,0,0 	go to label
482:  LABEL  22,0,0 	generate label
* if: jump to else
483:  LABEL  23,0,0 	generate label
484:     LD  0,-2(2) 	load id value
485:   PUSH  0,0(6) 	store exp
486:     LD  0,2(2) 	load id value
487:   PUSH  0,0(6) 	store exp
488:    POP  1,0,6 	load adress of lhs struct
489:    LDC  0,1,0 	load offset of member
490:    ADD  0,0,1 	compute the real adress if pointK
491:   PUSH  0,0(6) 	
492:    POP  0,0(6) 	load adress from mp
493:     LD  1,0(0) 	copy bytes
494:   PUSH  1,0(6) 	push a.x value into tmp
495:    POP  1,0(6) 	pop right
496:    POP  0,0(6) 	pop left
497:    SUB  0,0,1 	op ==, convertd_type
498:    JEQ  0,2(7) 	br if true
499:    LDC  0,0(0) 	false case
500:    LDA  7,1(7) 	unconditional jmp
501:    LDC  0,1(0) 	true case
502:   PUSH  0,0(6) 	
503:    POP  0,0(6) 	pop from the mp
504:    JNE  0,1,7 	true case:, execute if part
505:     GO  24,0,0 	go to label
506:     LD  0,-3(2) 	load id value
507:   PUSH  0,0(6) 	store exp
508:     LD  0,2(2) 	load id value
509:   PUSH  0,0(6) 	store exp
510:    POP  1,0,6 	load adress of lhs struct
511:    LDC  0,1,0 	load offset of member
512:    ADD  0,0,1 	compute the real adress if pointK
513:   PUSH  0,0(6) 	
514:    POP  1,0(6) 	move the adress of referenced
515:    POP  0,0(6) 	copy bytes
516:     ST  0,0(1) 	copy bytes
517:     GO  25,0,0 	go to label
518:  LABEL  24,0,0 	generate label
* if: jump to else
519:  LABEL  25,0,0 	generate label
* push function parameters
520:     LD  0,-2(2) 	load id value
521:   PUSH  0,0(6) 	store exp
522:    POP  0,0(6) 	copy bytes
523:   PUSH  0,0(3) 	PUSH bytes
524:     LD  0,1(2) 	load env
525:     LD  0,1(0) 	load env1
526:   PUSH  0,0(3) 	store env
* call function: 
* free
527:     LD  0,-7(5) 	load id value
528:   PUSH  0,0(6) 	store exp
529:    LDC  0,531(0) 	store the return adress
530:    POP  7,0(6) 	ujp to the function body
531:    LDA  3,1(3) 	pop parameters
532:    LDA  3,1(3) 	pop env
533:    MOV  3,2,0 	restore the caller sp
534:     LD  2,0(2) 	resotre the caller fp
535:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
536:  LABEL  15,0,0 	generate label
* function entry:
* append
537:    LDA  3,-1(3) 	stack expand for function variable
538:     GO  26,0,0 	go to label
539:    MOV  1,2,0 	store the caller fp temporarily
540:    MOV  2,3,0 	exchang the stack(context)
541:   PUSH  1,0(3) 	push the caller fp
542:   PUSH  0,0(3) 	push the return adress
543:     LD  0,3(2) 	load id value
544:   PUSH  0,0(6) 	store exp
545:     LD  0,-5(5) 	load id value
546:   PUSH  0,0(6) 	store exp
547:    POP  1,0(6) 	pop right
548:    POP  0,0(6) 	pop left
549:    SUB  0,0,1 	op ==, convertd_type
550:    JEQ  0,2(7) 	br if true
551:    LDC  0,0(0) 	false case
552:    LDA  7,1(7) 	unconditional jmp
553:    LDC  0,1(0) 	true case
554:   PUSH  0,0(6) 	
555:    POP  0,0(6) 	pop from the mp
556:    JNE  0,1,7 	true case:, execute if part
557:     GO  27,0,0 	go to label
558:    MOV  3,2,0 	restore the caller sp
559:     LD  2,0(2) 	resotre the caller fp
560:  RETURN  0,-1,3 	return to the caller
561:     GO  28,0,0 	go to label
562:  LABEL  27,0,0 	generate label
* if: jump to else
563:  LABEL  28,0,0 	generate label
564:     LD  0,2(2) 	load id value
565:   PUSH  0,0(6) 	store exp
566:    POP  1,0,6 	load adress of lhs struct
567:    LDC  0,2,0 	load offset of member
568:    ADD  0,0,1 	compute the real adress if pointK
569:   PUSH  0,0(6) 	
570:    POP  0,0(6) 	load adress from mp
571:     LD  1,0(0) 	copy bytes
572:   PUSH  1,0(6) 	push a.x value into tmp
573:    POP  0,0(6) 	pop right
574:     LD  0,2(2) 	load id value
575:   PUSH  0,0(6) 	store exp
576:    POP  1,0,6 	load adress of lhs struct
577:    LDC  0,2,0 	load offset of member
578:    ADD  0,0,1 	compute the real adress if pointK
579:   PUSH  0,0(6) 	
580:    POP  0,0(6) 	load adress from mp
581:     LD  1,0(0) 	copy bytes
582:   PUSH  1,0(6) 	push a.x value into tmp
583:    LDC  0,1(0) 	load integer const
584:   PUSH  0,0(6) 	store exp
585:    POP  1,0(6) 	pop right
586:    POP  0,0(6) 	pop left
587:    ADD  0,0,1 	op +
588:   PUSH  0,0(6) 	op: load left
589:     LD  0,2(2) 	load id value
590:   PUSH  0,0(6) 	store exp
591:    POP  1,0,6 	load adress of lhs struct
592:    LDC  0,2,0 	load offset of member
593:    ADD  0,0,1 	compute the real adress if pointK
594:   PUSH  0,0(6) 	
595:    POP  1,0(6) 	move the adress of referenced
596:    POP  0,0(6) 	copy bytes
597:     ST  0,0(1) 	copy bytes
598:     LD  0,3(2) 	load id value
599:   PUSH  0,0(6) 	store exp
600:     LD  0,2(2) 	load id value
601:   PUSH  0,0(6) 	store exp
602:    POP  1,0,6 	load adress of lhs struct
603:    LDC  0,1,0 	load offset of member
604:    ADD  0,0,1 	compute the real adress if pointK
605:   PUSH  0,0(6) 	
606:    POP  0,0(6) 	load adress from mp
607:     LD  1,0(0) 	copy bytes
608:   PUSH  1,0(6) 	push a.x value into tmp
609:    POP  1,0,6 	load adress of lhs struct
610:    LDC  0,1,0 	load offset of member
611:    ADD  0,0,1 	compute the real adress if pointK
612:   PUSH  0,0(6) 	
613:    POP  1,0(6) 	move the adress of referenced
614:    POP  0,0(6) 	copy bytes
615:     ST  0,0(1) 	copy bytes
616:     LD  0,2(2) 	load id value
617:   PUSH  0,0(6) 	store exp
618:    POP  1,0,6 	load adress of lhs struct
619:    LDC  0,1,0 	load offset of member
620:    ADD  0,0,1 	compute the real adress if pointK
621:   PUSH  0,0(6) 	
622:    POP  0,0(6) 	load adress from mp
623:     LD  1,0(0) 	copy bytes
624:   PUSH  1,0(6) 	push a.x value into tmp
625:     LD  0,3(2) 	load id value
626:   PUSH  0,0(6) 	store exp
627:    POP  1,0,6 	load adress of lhs struct
628:    LDC  0,0,0 	load offset of member
629:    ADD  0,0,1 	compute the real adress if pointK
630:   PUSH  0,0(6) 	
631:    POP  1,0(6) 	move the adress of referenced
632:    POP  0,0(6) 	copy bytes
633:     ST  0,0(1) 	copy bytes
634:     LD  0,-5(5) 	load id value
635:   PUSH  0,0(6) 	store exp
636:     LD  0,3(2) 	load id value
637:   PUSH  0,0(6) 	store exp
638:    POP  1,0,6 	load adress of lhs struct
639:    LDC  0,1,0 	load offset of member
640:    ADD  0,0,1 	compute the real adress if pointK
641:   PUSH  0,0(6) 	
642:    POP  1,0(6) 	move the adress of referenced
643:    POP  0,0(6) 	copy bytes
644:     ST  0,0(1) 	copy bytes
645:     LD  0,3(2) 	load id value
646:   PUSH  0,0(6) 	store exp
647:     LD  0,2(2) 	load id value
648:   PUSH  0,0(6) 	store exp
649:    POP  1,0,6 	load adress of lhs struct
650:    LDC  0,1,0 	load offset of member
651:    ADD  0,0,1 	compute the real adress if pointK
652:   PUSH  0,0(6) 	
653:    POP  1,0(6) 	move the adress of referenced
654:    POP  0,0(6) 	copy bytes
655:     ST  0,0(1) 	copy bytes
656:    MOV  3,2,0 	restore the caller sp
657:     LD  2,0(2) 	resotre the caller fp
658:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
659:  LABEL  26,0,0 	generate label
* function entry:
* insertSortedList
660:    LDA  3,-1(3) 	stack expand for function variable
661:     GO  29,0,0 	go to label
662:    MOV  1,2,0 	store the caller fp temporarily
663:    MOV  2,3,0 	exchang the stack(context)
664:   PUSH  1,0(3) 	push the caller fp
665:   PUSH  0,0(3) 	push the return adress
666:     LD  0,3(2) 	load id value
667:   PUSH  0,0(6) 	store exp
668:     LD  0,-5(5) 	load id value
669:   PUSH  0,0(6) 	store exp
670:    POP  1,0(6) 	pop right
671:    POP  0,0(6) 	pop left
672:    SUB  0,0,1 	op ==, convertd_type
673:    JEQ  0,2(7) 	br if true
674:    LDC  0,0(0) 	false case
675:    LDA  7,1(7) 	unconditional jmp
676:    LDC  0,1(0) 	true case
677:   PUSH  0,0(6) 	
678:    POP  0,0(6) 	pop from the mp
679:    JNE  0,1,7 	true case:, execute if part
680:     GO  30,0,0 	go to label
681:    MOV  3,2,0 	restore the caller sp
682:     LD  2,0(2) 	resotre the caller fp
683:  RETURN  0,-1,3 	return to the caller
684:     GO  31,0,0 	go to label
685:  LABEL  30,0,0 	generate label
* if: jump to else
686:  LABEL  31,0,0 	generate label
687:    LDA  3,-1(3) 	stack expand
688:    LDC  0,10(0) 	load integer const
689:   PUSH  0,0(6) 	store exp
690:    LDA  0,-2(2) 	load id adress
691:   PUSH  0,0(6) 	push array adress to mp
692:    POP  1,0(6) 	move the adress of ID
693:    POP  0,0(6) 	copy bytes
694:     ST  0,0(1) 	copy bytes
695:     LD  0,2(2) 	load id value
696:   PUSH  0,0(6) 	store exp
697:    POP  1,0,6 	load adress of lhs struct
698:    LDC  0,2,0 	load offset of member
699:    ADD  0,0,1 	compute the real adress if pointK
700:   PUSH  0,0(6) 	
701:    POP  0,0(6) 	load adress from mp
702:     LD  1,0(0) 	copy bytes
703:   PUSH  1,0(6) 	push a.x value into tmp
704:    LDC  0,1(0) 	load integer const
705:   PUSH  0,0(6) 	store exp
706:    POP  1,0(6) 	pop right
707:    POP  0,0(6) 	pop left
708:    ADD  0,0,1 	op +
709:   PUSH  0,0(6) 	op: load left
710:     LD  0,2(2) 	load id value
711:   PUSH  0,0(6) 	store exp
712:    POP  1,0,6 	load adress of lhs struct
713:    LDC  0,2,0 	load offset of member
714:    ADD  0,0,1 	compute the real adress if pointK
715:   PUSH  0,0(6) 	
716:    POP  1,0(6) 	move the adress of referenced
717:    POP  0,0(6) 	copy bytes
718:     ST  0,0(1) 	copy bytes
719:    LDA  3,-1(3) 	stack expand
720:     LD  0,2(2) 	load id value
721:   PUSH  0,0(6) 	store exp
722:    POP  1,0,6 	load adress of lhs struct
723:    LDC  0,0,0 	load offset of member
724:    ADD  0,0,1 	compute the real adress if pointK
725:   PUSH  0,0(6) 	
726:    POP  0,0(6) 	load adress from mp
727:     LD  1,0(0) 	copy bytes
728:   PUSH  1,0(6) 	push a.x value into tmp
729:    LDA  0,-3(2) 	load id adress
730:   PUSH  0,0(6) 	push array adress to mp
731:    POP  1,0(6) 	move the adress of ID
732:    POP  0,0(6) 	copy bytes
733:     ST  0,0(1) 	copy bytes
* while stmt:
734:  LABEL  32,0,0 	generate label
735:     LD  0,-3(2) 	load id value
736:   PUSH  0,0(6) 	store exp
737:    POP  1,0,6 	load adress of lhs struct
738:    LDC  0,1,0 	load offset of member
739:    ADD  0,0,1 	compute the real adress if pointK
740:   PUSH  0,0(6) 	
741:    POP  0,0(6) 	load adress from mp
742:     LD  1,0(0) 	copy bytes
743:   PUSH  1,0(6) 	push a.x value into tmp
744:     LD  0,-5(5) 	load id value
745:   PUSH  0,0(6) 	store exp
746:    POP  1,0(6) 	pop right
747:    POP  0,0(6) 	pop left
748:    SUB  0,0,1 	op ==, convertd_type
749:    JNE  0,2(7) 	br if true
750:    LDC  0,0(0) 	false case
751:    LDA  7,1(7) 	unconditional jmp
752:    LDC  0,1(0) 	true case
753:   PUSH  0,0(6) 	
754:    POP  0,0(6) 	pop from the mp
755:    JNE  0,1,7 	true case:, skip the break, execute the block code
756:     GO  33,0,0 	go to label
* push function parameters
757:     LD  0,3(2) 	load id value
758:   PUSH  0,0(6) 	store exp
759:    POP  1,0,6 	load adress of lhs struct
760:    LDC  0,2,0 	load offset of member
761:    ADD  0,0,1 	compute the real adress if pointK
762:   PUSH  0,0(6) 	
763:    POP  0,0(6) 	load adress from mp
764:     LD  1,0(0) 	copy bytes
765:   PUSH  1,0(6) 	push a.x value into tmp
766:    POP  0,0(6) 	copy bytes
767:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
768:     LD  0,-3(2) 	load id value
769:   PUSH  0,0(6) 	store exp
770:    POP  1,0,6 	load adress of lhs struct
771:    LDC  0,1,0 	load offset of member
772:    ADD  0,0,1 	compute the real adress if pointK
773:   PUSH  0,0(6) 	
774:    POP  0,0(6) 	load adress from mp
775:     LD  1,0(0) 	copy bytes
776:   PUSH  1,0(6) 	push a.x value into tmp
777:    POP  1,0,6 	load adress of lhs struct
778:    LDC  0,2,0 	load offset of member
779:    ADD  0,0,1 	compute the real adress if pointK
780:   PUSH  0,0(6) 	
781:    POP  0,0(6) 	load adress from mp
782:     LD  1,0(0) 	copy bytes
783:   PUSH  1,0(6) 	push a.x value into tmp
784:    POP  0,0(6) 	copy bytes
785:   PUSH  0,0(3) 	PUSH bytes
786:     LD  0,1(2) 	load env
787:   PUSH  0,0(3) 	store env
* call function: 
* match
788:     LD  0,2(2) 	load id value
789:   PUSH  0,0(6) 	store exp
790:    POP  1,0,6 	load adress of lhs struct
791:    LDC  0,5,0 	load offset of member
792:    ADD  0,0,1 	compute the real adress if pointK
793:   PUSH  0,0(6) 	
794:    POP  0,0(6) 	load adress from mp
795:     LD  1,0(0) 	copy bytes
796:   PUSH  1,0(6) 	push a.x value into tmp
797:    LDC  0,799(0) 	store the return adress
798:    POP  7,0(6) 	ujp to the function body
799:    LDA  3,2(3) 	pop parameters
800:    LDA  3,1(3) 	pop env
801:    LDC  0,0(0) 	load integer const
802:   PUSH  0,0(6) 	store exp
803:    POP  1,0(6) 	pop right
804:    POP  0,0(6) 	pop left
805:    SUB  0,0,1 	op <
806:    JGE  0,2(7) 	br if true
807:    LDC  0,0(0) 	false case
808:    LDA  7,1(7) 	unconditional jmp
809:    LDC  0,1(0) 	true case
810:   PUSH  0,0(6) 	
811:    POP  0,0(6) 	pop from the mp
812:    JNE  0,1,7 	true case:, execute if part
813:     GO  34,0,0 	go to label
814:     GO  33,0,0 	go to label
815:     GO  35,0,0 	go to label
816:  LABEL  34,0,0 	generate label
* if: jump to else
817:  LABEL  35,0,0 	generate label
818:     LD  0,-3(2) 	load id value
819:   PUSH  0,0(6) 	store exp
820:    POP  1,0,6 	load adress of lhs struct
821:    LDC  0,1,0 	load offset of member
822:    ADD  0,0,1 	compute the real adress if pointK
823:   PUSH  0,0(6) 	
824:    POP  0,0(6) 	load adress from mp
825:     LD  1,0(0) 	copy bytes
826:   PUSH  1,0(6) 	push a.x value into tmp
827:    LDA  0,-3(2) 	load id adress
828:   PUSH  0,0(6) 	push array adress to mp
829:    POP  1,0(6) 	move the adress of ID
830:    POP  0,0(6) 	copy bytes
831:     ST  0,0(1) 	copy bytes
832:     GO  32,0,0 	go to label
833:  LABEL  33,0,0 	generate label
834:    LDA  3,-1(3) 	stack expand
835:     LD  0,-3(2) 	load id value
836:   PUSH  0,0(6) 	store exp
837:    POP  1,0,6 	load adress of lhs struct
838:    LDC  0,1,0 	load offset of member
839:    ADD  0,0,1 	compute the real adress if pointK
840:   PUSH  0,0(6) 	
841:    POP  0,0(6) 	load adress from mp
842:     LD  1,0(0) 	copy bytes
843:   PUSH  1,0(6) 	push a.x value into tmp
844:    LDA  0,-4(2) 	load id adress
845:   PUSH  0,0(6) 	push array adress to mp
846:    POP  1,0(6) 	move the adress of ID
847:    POP  0,0(6) 	copy bytes
848:     ST  0,0(1) 	copy bytes
849:     LD  0,3(2) 	load id value
850:   PUSH  0,0(6) 	store exp
851:     LD  0,-3(2) 	load id value
852:   PUSH  0,0(6) 	store exp
853:    POP  1,0,6 	load adress of lhs struct
854:    LDC  0,1,0 	load offset of member
855:    ADD  0,0,1 	compute the real adress if pointK
856:   PUSH  0,0(6) 	
857:    POP  1,0(6) 	move the adress of referenced
858:    POP  0,0(6) 	copy bytes
859:     ST  0,0(1) 	copy bytes
860:     LD  0,-4(2) 	load id value
861:   PUSH  0,0(6) 	store exp
862:     LD  0,3(2) 	load id value
863:   PUSH  0,0(6) 	store exp
864:    POP  1,0,6 	load adress of lhs struct
865:    LDC  0,1,0 	load offset of member
866:    ADD  0,0,1 	compute the real adress if pointK
867:   PUSH  0,0(6) 	
868:    POP  1,0(6) 	move the adress of referenced
869:    POP  0,0(6) 	copy bytes
870:     ST  0,0(1) 	copy bytes
871:     LD  0,-3(2) 	load id value
872:   PUSH  0,0(6) 	store exp
873:     LD  0,3(2) 	load id value
874:   PUSH  0,0(6) 	store exp
875:    POP  1,0,6 	load adress of lhs struct
876:    LDC  0,0,0 	load offset of member
877:    ADD  0,0,1 	compute the real adress if pointK
878:   PUSH  0,0(6) 	
879:    POP  1,0(6) 	move the adress of referenced
880:    POP  0,0(6) 	copy bytes
881:     ST  0,0(1) 	copy bytes
882:     LD  0,-4(2) 	load id value
883:   PUSH  0,0(6) 	store exp
884:     LD  0,-5(5) 	load id value
885:   PUSH  0,0(6) 	store exp
886:    POP  1,0(6) 	pop right
887:    POP  0,0(6) 	pop left
888:    SUB  0,0,1 	op ==, convertd_type
889:    JNE  0,2(7) 	br if true
890:    LDC  0,0(0) 	false case
891:    LDA  7,1(7) 	unconditional jmp
892:    LDC  0,1(0) 	true case
893:   PUSH  0,0(6) 	
894:    POP  0,0(6) 	pop from the mp
895:    JNE  0,1,7 	true case:, execute if part
896:     GO  36,0,0 	go to label
897:     LD  0,3(2) 	load id value
898:   PUSH  0,0(6) 	store exp
899:     LD  0,-4(2) 	load id value
900:   PUSH  0,0(6) 	store exp
901:    POP  1,0,6 	load adress of lhs struct
902:    LDC  0,0,0 	load offset of member
903:    ADD  0,0,1 	compute the real adress if pointK
904:   PUSH  0,0(6) 	
905:    POP  1,0(6) 	move the adress of referenced
906:    POP  0,0(6) 	copy bytes
907:     ST  0,0(1) 	copy bytes
908:     GO  37,0,0 	go to label
909:  LABEL  36,0,0 	generate label
* if: jump to else
910:     LD  0,3(2) 	load id value
911:   PUSH  0,0(6) 	store exp
912:     LD  0,2(2) 	load id value
913:   PUSH  0,0(6) 	store exp
914:    POP  1,0,6 	load adress of lhs struct
915:    LDC  0,1,0 	load offset of member
916:    ADD  0,0,1 	compute the real adress if pointK
917:   PUSH  0,0(6) 	
918:    POP  1,0(6) 	move the adress of referenced
919:    POP  0,0(6) 	copy bytes
920:     ST  0,0(1) 	copy bytes
921:  LABEL  37,0,0 	generate label
922:    MOV  3,2,0 	restore the caller sp
923:     LD  2,0(2) 	resotre the caller fp
924:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
925:  LABEL  29,0,0 	generate label
* function entry:
* popRight
926:    LDA  3,-1(3) 	stack expand for function variable
927:     GO  38,0,0 	go to label
928:    MOV  1,2,0 	store the caller fp temporarily
929:    MOV  2,3,0 	exchang the stack(context)
930:   PUSH  1,0(3) 	push the caller fp
931:   PUSH  0,0(3) 	push the return adress
932:     LD  0,2(2) 	load id value
933:   PUSH  0,0(6) 	store exp
934:     LD  0,-5(5) 	load id value
935:   PUSH  0,0(6) 	store exp
936:    POP  1,0(6) 	pop right
937:    POP  0,0(6) 	pop left
938:    SUB  0,0,1 	op ==, convertd_type
939:    JEQ  0,2(7) 	br if true
940:    LDC  0,0(0) 	false case
941:    LDA  7,1(7) 	unconditional jmp
942:    LDC  0,1(0) 	true case
943:   PUSH  0,0(6) 	
944:     LD  0,2(2) 	load id value
945:   PUSH  0,0(6) 	store exp
946:    POP  1,0,6 	load adress of lhs struct
947:    LDC  0,2,0 	load offset of member
948:    ADD  0,0,1 	compute the real adress if pointK
949:   PUSH  0,0(6) 	
950:    POP  0,0(6) 	load adress from mp
951:     LD  1,0(0) 	copy bytes
952:   PUSH  1,0(6) 	push a.x value into tmp
953:    LDC  0,0(0) 	load integer const
954:   PUSH  0,0(6) 	store exp
955:    POP  1,0(6) 	pop right
956:    POP  0,0(6) 	pop left
957:    SUB  0,0,1 	op <
958:    JLE  0,2(7) 	br if true
959:    LDC  0,0(0) 	false case
960:    LDA  7,1(7) 	unconditional jmp
961:    LDC  0,1(0) 	true case
962:   PUSH  0,0(6) 	
963:    POP  1,0(6) 	pop right
964:    POP  0,0(6) 	pop left
965:    JNE  0,3(7) 	br if true
966:    JNE  1,2(7) 	br if true
967:    LDC  0,0(0) 	false case
968:    LDA  7,1(7) 	unconditional jmp
969:    LDC  0,1(0) 	true case
970:   PUSH  0,0(6) 	
971:    POP  0,0(6) 	pop from the mp
972:    JNE  0,1,7 	true case:, execute if part
973:     GO  39,0,0 	go to label
974:    MOV  3,2,0 	restore the caller sp
975:     LD  2,0(2) 	resotre the caller fp
976:  RETURN  0,-1,3 	return to the caller
977:     GO  40,0,0 	go to label
978:  LABEL  39,0,0 	generate label
* if: jump to else
979:  LABEL  40,0,0 	generate label
980:     LD  0,2(2) 	load id value
981:   PUSH  0,0(6) 	store exp
982:    POP  1,0,6 	load adress of lhs struct
983:    LDC  0,2,0 	load offset of member
984:    ADD  0,0,1 	compute the real adress if pointK
985:   PUSH  0,0(6) 	
986:    POP  0,0(6) 	load adress from mp
987:     LD  1,0(0) 	copy bytes
988:   PUSH  1,0(6) 	push a.x value into tmp
989:    POP  0,0(6) 	pop right
990:     LD  0,2(2) 	load id value
991:   PUSH  0,0(6) 	store exp
992:    POP  1,0,6 	load adress of lhs struct
993:    LDC  0,2,0 	load offset of member
994:    ADD  0,0,1 	compute the real adress if pointK
995:   PUSH  0,0(6) 	
996:    POP  0,0(6) 	load adress from mp
997:     LD  1,0(0) 	copy bytes
998:   PUSH  1,0(6) 	push a.x value into tmp
999:    LDC  0,1(0) 	load integer const
1000:   PUSH  0,0(6) 	store exp
1001:    POP  1,0(6) 	pop right
1002:    POP  0,0(6) 	pop left
1003:    SUB  0,0,1 	op -
1004:   PUSH  0,0(6) 	op: load left
1005:     LD  0,2(2) 	load id value
1006:   PUSH  0,0(6) 	store exp
1007:    POP  1,0,6 	load adress of lhs struct
1008:    LDC  0,2,0 	load offset of member
1009:    ADD  0,0,1 	compute the real adress if pointK
1010:   PUSH  0,0(6) 	
1011:    POP  1,0(6) 	move the adress of referenced
1012:    POP  0,0(6) 	copy bytes
1013:     ST  0,0(1) 	copy bytes
1014:    LDA  3,-1(3) 	stack expand
1015:     LD  0,2(2) 	load id value
1016:   PUSH  0,0(6) 	store exp
1017:    POP  1,0,6 	load adress of lhs struct
1018:    LDC  0,1,0 	load offset of member
1019:    ADD  0,0,1 	compute the real adress if pointK
1020:   PUSH  0,0(6) 	
1021:    POP  0,0(6) 	load adress from mp
1022:     LD  1,0(0) 	copy bytes
1023:   PUSH  1,0(6) 	push a.x value into tmp
1024:    POP  1,0,6 	load adress of lhs struct
1025:    LDC  0,0,0 	load offset of member
1026:    ADD  0,0,1 	compute the real adress if pointK
1027:   PUSH  0,0(6) 	
1028:    POP  0,0(6) 	load adress from mp
1029:     LD  1,0(0) 	copy bytes
1030:   PUSH  1,0(6) 	push a.x value into tmp
1031:    LDA  0,-2(2) 	load id adress
1032:   PUSH  0,0(6) 	push array adress to mp
1033:    POP  1,0(6) 	move the adress of ID
1034:    POP  0,0(6) 	copy bytes
1035:     ST  0,0(1) 	copy bytes
1036:     LD  0,-5(5) 	load id value
1037:   PUSH  0,0(6) 	store exp
1038:     LD  0,-2(2) 	load id value
1039:   PUSH  0,0(6) 	store exp
1040:    POP  1,0,6 	load adress of lhs struct
1041:    LDC  0,1,0 	load offset of member
1042:    ADD  0,0,1 	compute the real adress if pointK
1043:   PUSH  0,0(6) 	
1044:    POP  1,0(6) 	move the adress of referenced
1045:    POP  0,0(6) 	copy bytes
1046:     ST  0,0(1) 	copy bytes
* push function parameters
1047:     LD  0,2(2) 	load id value
1048:   PUSH  0,0(6) 	store exp
1049:    POP  1,0,6 	load adress of lhs struct
1050:    LDC  0,1,0 	load offset of member
1051:    ADD  0,0,1 	compute the real adress if pointK
1052:   PUSH  0,0(6) 	
1053:    POP  0,0(6) 	load adress from mp
1054:     LD  1,0(0) 	copy bytes
1055:   PUSH  1,0(6) 	push a.x value into tmp
1056:    POP  0,0(6) 	copy bytes
1057:   PUSH  0,0(3) 	PUSH bytes
1058:     LD  0,1(2) 	load env
1059:     LD  0,1(0) 	load env1
1060:   PUSH  0,0(3) 	store env
* call function: 
* free
1061:     LD  0,-7(5) 	load id value
1062:   PUSH  0,0(6) 	store exp
1063:    LDC  0,1065(0) 	store the return adress
1064:    POP  7,0(6) 	ujp to the function body
1065:    LDA  3,1(3) 	pop parameters
1066:    LDA  3,1(3) 	pop env
1067:     LD  0,-2(2) 	load id value
1068:   PUSH  0,0(6) 	store exp
1069:     LD  0,2(2) 	load id value
1070:   PUSH  0,0(6) 	store exp
1071:    POP  1,0,6 	load adress of lhs struct
1072:    LDC  0,1,0 	load offset of member
1073:    ADD  0,0,1 	compute the real adress if pointK
1074:   PUSH  0,0(6) 	
1075:    POP  1,0(6) 	move the adress of referenced
1076:    POP  0,0(6) 	copy bytes
1077:     ST  0,0(1) 	copy bytes
1078:    MOV  3,2,0 	restore the caller sp
1079:     LD  2,0(2) 	resotre the caller fp
1080:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1081:  LABEL  38,0,0 	generate label
* function entry:
* popLeft
1082:    LDA  3,-1(3) 	stack expand for function variable
1083:     GO  41,0,0 	go to label
1084:    MOV  1,2,0 	store the caller fp temporarily
1085:    MOV  2,3,0 	exchang the stack(context)
1086:   PUSH  1,0(3) 	push the caller fp
1087:   PUSH  0,0(3) 	push the return adress
1088:     LD  0,2(2) 	load id value
1089:   PUSH  0,0(6) 	store exp
1090:     LD  0,-5(5) 	load id value
1091:   PUSH  0,0(6) 	store exp
1092:    POP  1,0(6) 	pop right
1093:    POP  0,0(6) 	pop left
1094:    SUB  0,0,1 	op ==, convertd_type
1095:    JEQ  0,2(7) 	br if true
1096:    LDC  0,0(0) 	false case
1097:    LDA  7,1(7) 	unconditional jmp
1098:    LDC  0,1(0) 	true case
1099:   PUSH  0,0(6) 	
1100:     LD  0,2(2) 	load id value
1101:   PUSH  0,0(6) 	store exp
1102:    POP  1,0,6 	load adress of lhs struct
1103:    LDC  0,2,0 	load offset of member
1104:    ADD  0,0,1 	compute the real adress if pointK
1105:   PUSH  0,0(6) 	
1106:    POP  0,0(6) 	load adress from mp
1107:     LD  1,0(0) 	copy bytes
1108:   PUSH  1,0(6) 	push a.x value into tmp
1109:    LDC  0,0(0) 	load integer const
1110:   PUSH  0,0(6) 	store exp
1111:    POP  1,0(6) 	pop right
1112:    POP  0,0(6) 	pop left
1113:    SUB  0,0,1 	op <
1114:    JLE  0,2(7) 	br if true
1115:    LDC  0,0(0) 	false case
1116:    LDA  7,1(7) 	unconditional jmp
1117:    LDC  0,1(0) 	true case
1118:   PUSH  0,0(6) 	
1119:    POP  1,0(6) 	pop right
1120:    POP  0,0(6) 	pop left
1121:    JNE  0,3(7) 	br if true
1122:    JNE  1,2(7) 	br if true
1123:    LDC  0,0(0) 	false case
1124:    LDA  7,1(7) 	unconditional jmp
1125:    LDC  0,1(0) 	true case
1126:   PUSH  0,0(6) 	
1127:    POP  0,0(6) 	pop from the mp
1128:    JNE  0,1,7 	true case:, execute if part
1129:     GO  42,0,0 	go to label
1130:    MOV  3,2,0 	restore the caller sp
1131:     LD  2,0(2) 	resotre the caller fp
1132:  RETURN  0,-1,3 	return to the caller
1133:     GO  43,0,0 	go to label
1134:  LABEL  42,0,0 	generate label
* if: jump to else
1135:  LABEL  43,0,0 	generate label
1136:     LD  0,2(2) 	load id value
1137:   PUSH  0,0(6) 	store exp
1138:    POP  1,0,6 	load adress of lhs struct
1139:    LDC  0,2,0 	load offset of member
1140:    ADD  0,0,1 	compute the real adress if pointK
1141:   PUSH  0,0(6) 	
1142:    POP  0,0(6) 	load adress from mp
1143:     LD  1,0(0) 	copy bytes
1144:   PUSH  1,0(6) 	push a.x value into tmp
1145:    POP  0,0(6) 	pop right
1146:     LD  0,2(2) 	load id value
1147:   PUSH  0,0(6) 	store exp
1148:    POP  1,0,6 	load adress of lhs struct
1149:    LDC  0,2,0 	load offset of member
1150:    ADD  0,0,1 	compute the real adress if pointK
1151:   PUSH  0,0(6) 	
1152:    POP  0,0(6) 	load adress from mp
1153:     LD  1,0(0) 	copy bytes
1154:   PUSH  1,0(6) 	push a.x value into tmp
1155:    LDC  0,1(0) 	load integer const
1156:   PUSH  0,0(6) 	store exp
1157:    POP  1,0(6) 	pop right
1158:    POP  0,0(6) 	pop left
1159:    SUB  0,0,1 	op -
1160:   PUSH  0,0(6) 	op: load left
1161:     LD  0,2(2) 	load id value
1162:   PUSH  0,0(6) 	store exp
1163:    POP  1,0,6 	load adress of lhs struct
1164:    LDC  0,2,0 	load offset of member
1165:    ADD  0,0,1 	compute the real adress if pointK
1166:   PUSH  0,0(6) 	
1167:    POP  1,0(6) 	move the adress of referenced
1168:    POP  0,0(6) 	copy bytes
1169:     ST  0,0(1) 	copy bytes
1170:    LDA  3,-1(3) 	stack expand
1171:     LD  0,2(2) 	load id value
1172:   PUSH  0,0(6) 	store exp
1173:    POP  1,0,6 	load adress of lhs struct
1174:    LDC  0,0,0 	load offset of member
1175:    ADD  0,0,1 	compute the real adress if pointK
1176:   PUSH  0,0(6) 	
1177:    POP  0,0(6) 	load adress from mp
1178:     LD  1,0(0) 	copy bytes
1179:   PUSH  1,0(6) 	push a.x value into tmp
1180:    POP  1,0,6 	load adress of lhs struct
1181:    LDC  0,1,0 	load offset of member
1182:    ADD  0,0,1 	compute the real adress if pointK
1183:   PUSH  0,0(6) 	
1184:    POP  0,0(6) 	load adress from mp
1185:     LD  1,0(0) 	copy bytes
1186:   PUSH  1,0(6) 	push a.x value into tmp
1187:    POP  1,0,6 	load adress of lhs struct
1188:    LDC  0,1,0 	load offset of member
1189:    ADD  0,0,1 	compute the real adress if pointK
1190:   PUSH  0,0(6) 	
1191:    POP  0,0(6) 	load adress from mp
1192:     LD  1,0(0) 	copy bytes
1193:   PUSH  1,0(6) 	push a.x value into tmp
1194:    LDA  0,-2(2) 	load id adress
1195:   PUSH  0,0(6) 	push array adress to mp
1196:    POP  1,0(6) 	move the adress of ID
1197:    POP  0,0(6) 	copy bytes
1198:     ST  0,0(1) 	copy bytes
* push function parameters
1199:     LD  0,2(2) 	load id value
1200:   PUSH  0,0(6) 	store exp
1201:    POP  1,0,6 	load adress of lhs struct
1202:    LDC  0,0,0 	load offset of member
1203:    ADD  0,0,1 	compute the real adress if pointK
1204:   PUSH  0,0(6) 	
1205:    POP  0,0(6) 	load adress from mp
1206:     LD  1,0(0) 	copy bytes
1207:   PUSH  1,0(6) 	push a.x value into tmp
1208:    POP  1,0,6 	load adress of lhs struct
1209:    LDC  0,1,0 	load offset of member
1210:    ADD  0,0,1 	compute the real adress if pointK
1211:   PUSH  0,0(6) 	
1212:    POP  0,0(6) 	load adress from mp
1213:     LD  1,0(0) 	copy bytes
1214:   PUSH  1,0(6) 	push a.x value into tmp
1215:    POP  0,0(6) 	copy bytes
1216:   PUSH  0,0(3) 	PUSH bytes
1217:     LD  0,1(2) 	load env
1218:     LD  0,1(0) 	load env1
1219:   PUSH  0,0(3) 	store env
* call function: 
* free
1220:     LD  0,-7(5) 	load id value
1221:   PUSH  0,0(6) 	store exp
1222:    LDC  0,1224(0) 	store the return adress
1223:    POP  7,0(6) 	ujp to the function body
1224:    LDA  3,1(3) 	pop parameters
1225:    LDA  3,1(3) 	pop env
1226:     LD  0,-2(2) 	load id value
1227:   PUSH  0,0(6) 	store exp
1228:     LD  0,2(2) 	load id value
1229:   PUSH  0,0(6) 	store exp
1230:    POP  1,0,6 	load adress of lhs struct
1231:    LDC  0,0,0 	load offset of member
1232:    ADD  0,0,1 	compute the real adress if pointK
1233:   PUSH  0,0(6) 	
1234:    POP  0,0(6) 	load adress from mp
1235:     LD  1,0(0) 	copy bytes
1236:   PUSH  1,0(6) 	push a.x value into tmp
1237:    POP  1,0,6 	load adress of lhs struct
1238:    LDC  0,1,0 	load offset of member
1239:    ADD  0,0,1 	compute the real adress if pointK
1240:   PUSH  0,0(6) 	
1241:    POP  1,0(6) 	move the adress of referenced
1242:    POP  0,0(6) 	copy bytes
1243:     ST  0,0(1) 	copy bytes
1244:     LD  0,-2(2) 	load id value
1245:   PUSH  0,0(6) 	store exp
1246:     LD  0,-5(5) 	load id value
1247:   PUSH  0,0(6) 	store exp
1248:    POP  1,0(6) 	pop right
1249:    POP  0,0(6) 	pop left
1250:    SUB  0,0,1 	op ==, convertd_type
1251:    JNE  0,2(7) 	br if true
1252:    LDC  0,0(0) 	false case
1253:    LDA  7,1(7) 	unconditional jmp
1254:    LDC  0,1(0) 	true case
1255:   PUSH  0,0(6) 	
1256:    POP  0,0(6) 	pop from the mp
1257:    JNE  0,1,7 	true case:, execute if part
1258:     GO  44,0,0 	go to label
1259:     LD  0,2(2) 	load id value
1260:   PUSH  0,0(6) 	store exp
1261:    POP  1,0,6 	load adress of lhs struct
1262:    LDC  0,0,0 	load offset of member
1263:    ADD  0,0,1 	compute the real adress if pointK
1264:   PUSH  0,0(6) 	
1265:    POP  0,0(6) 	load adress from mp
1266:     LD  1,0(0) 	copy bytes
1267:   PUSH  1,0(6) 	push a.x value into tmp
1268:     LD  0,-2(2) 	load id value
1269:   PUSH  0,0(6) 	store exp
1270:    POP  1,0,6 	load adress of lhs struct
1271:    LDC  0,0,0 	load offset of member
1272:    ADD  0,0,1 	compute the real adress if pointK
1273:   PUSH  0,0(6) 	
1274:    POP  1,0(6) 	move the adress of referenced
1275:    POP  0,0(6) 	copy bytes
1276:     ST  0,0(1) 	copy bytes
1277:     GO  45,0,0 	go to label
1278:  LABEL  44,0,0 	generate label
* if: jump to else
1279:  LABEL  45,0,0 	generate label
1280:    MOV  3,2,0 	restore the caller sp
1281:     LD  2,0(2) 	resotre the caller fp
1282:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1283:  LABEL  41,0,0 	generate label
* function entry:
* createListNode
1284:    LDA  3,-1(3) 	stack expand for function variable
1285:    LDC  0,1288(0) 	get function adress
1286:     ST  0,-9(5) 	set function adress
1287:     GO  46,0,0 	go to label
1288:    MOV  1,2,0 	store the caller fp temporarily
1289:    MOV  2,3,0 	exchang the stack(context)
1290:   PUSH  1,0(3) 	push the caller fp
1291:   PUSH  0,0(3) 	push the return adress
1292:    LDA  3,-1(3) 	stack expand
* push function parameters
1293:    LDC  0,3,0 	load size of exp
1294:   PUSH  0,0(6) 	
1295:    POP  0,0(6) 	copy bytes
1296:   PUSH  0,0(3) 	PUSH bytes
1297:     LD  0,1(2) 	load env
1298:   PUSH  0,0(3) 	store env
* call function: 
* malloc
1299:     LD  0,-6(5) 	load id value
1300:   PUSH  0,0(6) 	store exp
1301:    LDC  0,1303(0) 	store the return adress
1302:    POP  7,0(6) 	ujp to the function body
1303:    LDA  3,1(3) 	pop parameters
1304:    LDA  3,1(3) 	pop env
1305:    LDA  0,-2(2) 	load id adress
1306:   PUSH  0,0(6) 	push array adress to mp
1307:    POP  1,0(6) 	move the adress of ID
1308:    POP  0,0(6) 	copy bytes
1309:     ST  0,0(1) 	copy bytes
1310:     LD  0,-5(5) 	load id value
1311:   PUSH  0,0(6) 	store exp
1312:     LD  0,-2(2) 	load id value
1313:   PUSH  0,0(6) 	store exp
1314:    POP  1,0,6 	load adress of lhs struct
1315:    LDC  0,0,0 	load offset of member
1316:    ADD  0,0,1 	compute the real adress if pointK
1317:   PUSH  0,0(6) 	
1318:    POP  1,0(6) 	move the adress of referenced
1319:    POP  0,0(6) 	copy bytes
1320:     ST  0,0(1) 	copy bytes
1321:     LD  0,-5(5) 	load id value
1322:   PUSH  0,0(6) 	store exp
1323:     LD  0,-2(2) 	load id value
1324:   PUSH  0,0(6) 	store exp
1325:    POP  1,0,6 	load adress of lhs struct
1326:    LDC  0,1,0 	load offset of member
1327:    ADD  0,0,1 	compute the real adress if pointK
1328:   PUSH  0,0(6) 	
1329:    POP  1,0(6) 	move the adress of referenced
1330:    POP  0,0(6) 	copy bytes
1331:     ST  0,0(1) 	copy bytes
1332:     LD  0,-5(5) 	load id value
1333:   PUSH  0,0(6) 	store exp
1334:     LD  0,-2(2) 	load id value
1335:   PUSH  0,0(6) 	store exp
1336:    POP  1,0,6 	load adress of lhs struct
1337:    LDC  0,2,0 	load offset of member
1338:    ADD  0,0,1 	compute the real adress if pointK
1339:   PUSH  0,0(6) 	
1340:    POP  1,0(6) 	move the adress of referenced
1341:    POP  0,0(6) 	copy bytes
1342:     ST  0,0(1) 	copy bytes
1343:     LD  0,-2(2) 	load id value
1344:   PUSH  0,0(6) 	store exp
1345:    MOV  3,2,0 	restore the caller sp
1346:     LD  2,0(2) 	resotre the caller fp
1347:  RETURN  0,-1,3 	return to the caller
1348:    MOV  3,2,0 	restore the caller sp
1349:     LD  2,0(2) 	resotre the caller fp
1350:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1351:  LABEL  46,0,0 	generate label
* function entry:
* createList
1352:    LDA  3,-1(3) 	stack expand for function variable
1353:    LDC  0,1356(0) 	get function adress
1354:     ST  0,-10(5) 	set function adress
1355:     GO  47,0,0 	go to label
1356:    MOV  1,2,0 	store the caller fp temporarily
1357:    MOV  2,3,0 	exchang the stack(context)
1358:   PUSH  1,0(3) 	push the caller fp
1359:   PUSH  0,0(3) 	push the return adress
1360:    LDA  3,-11(3) 	stack expand
1361:    LDC  1,195(0) 	get function adress from struct
1362:     ST  1,4(3) 	Init Struct Instance
1363:    LDC  1,205(0) 	get function adress from struct
1364:     ST  1,5(3) 	Init Struct Instance
1365:    LDC  1,215(0) 	get function adress from struct
1366:     ST  1,6(3) 	Init Struct Instance
1367:    LDC  1,225(0) 	get function adress from struct
1368:     ST  1,7(3) 	Init Struct Instance
1369:    LDC  1,539(0) 	get function adress from struct
1370:     ST  1,8(3) 	Init Struct Instance
1371:    LDC  1,662(0) 	get function adress from struct
1372:     ST  1,9(3) 	Init Struct Instance
1373:    LDC  1,928(0) 	get function adress from struct
1374:     ST  1,10(3) 	Init Struct Instance
1375:    LDC  1,1084(0) 	get function adress from struct
1376:     ST  1,11(3) 	Init Struct Instance
1377:    LDA  3,-1(3) 	stack expand
1378:    LDC  0,0(0) 	load integer const
1379:   PUSH  0,0(6) 	store exp
1380:    LDA  0,-13(2) 	load id adress
1381:   PUSH  0,0(6) 	push array adress to mp
1382:    POP  1,0(6) 	move the adress of ID
1383:    POP  0,0(6) 	copy bytes
1384:     ST  0,0(1) 	copy bytes
1385:     LD  0,1(2) 	load env
1386:   PUSH  0,0(3) 	store env
* call function: 
* createListNode
1387:     LD  0,-9(5) 	load id value
1388:   PUSH  0,0(6) 	store exp
1389:    LDC  0,1391(0) 	store the return adress
1390:    POP  7,0(6) 	ujp to the function body
1391:    LDA  3,0(3) 	pop parameters
1392:    LDA  3,1(3) 	pop env
1393:    LDA  0,-12(2) 	load id adress
1394:   PUSH  0,0(6) 	push array adress to mp
1395:    POP  1,0,6 	load adress of lhs struct
1396:    LDC  0,0,0 	load offset of member
1397:    ADD  0,0,1 	compute the real adress if pointK
1398:   PUSH  0,0(6) 	
1399:    POP  1,0(6) 	move the adress of referenced
1400:    POP  0,0(6) 	copy bytes
1401:     ST  0,0(1) 	copy bytes
1402:    LDA  0,-12(2) 	load id adress
1403:   PUSH  0,0(6) 	push array adress to mp
1404:    POP  1,0,6 	load adress of lhs struct
1405:    LDC  0,0,0 	load offset of member
1406:    ADD  0,0,1 	compute the real adress if pointK
1407:   PUSH  0,0(6) 	
1408:    POP  0,0(6) 	load adress from mp
1409:     LD  1,0(0) 	copy bytes
1410:   PUSH  1,0(6) 	push a.x value into tmp
1411:    LDA  0,-12(2) 	load id adress
1412:   PUSH  0,0(6) 	push array adress to mp
1413:    POP  1,0,6 	load adress of lhs struct
1414:    LDC  0,1,0 	load offset of member
1415:    ADD  0,0,1 	compute the real adress if pointK
1416:   PUSH  0,0(6) 	
1417:    POP  1,0(6) 	move the adress of referenced
1418:    POP  0,0(6) 	copy bytes
1419:     ST  0,0(1) 	copy bytes
1420:    LDC  0,0(0) 	load integer const
1421:   PUSH  0,0(6) 	store exp
1422:    LDA  0,-12(2) 	load id adress
1423:   PUSH  0,0(6) 	push array adress to mp
1424:    POP  1,0,6 	load adress of lhs struct
1425:    LDC  0,2,0 	load offset of member
1426:    ADD  0,0,1 	compute the real adress if pointK
1427:   PUSH  0,0(6) 	
1428:    POP  1,0(6) 	move the adress of referenced
1429:    POP  0,0(6) 	copy bytes
1430:     ST  0,0(1) 	copy bytes
1431:     LD  0,-12(2) 	load id value
1432:   PUSH  0,0(6) 	store exp
1433:     LD  0,-11(2) 	load id value
1434:   PUSH  0,0(6) 	store exp
1435:     LD  0,-10(2) 	load id value
1436:   PUSH  0,0(6) 	store exp
1437:     LD  0,-9(2) 	load id value
1438:   PUSH  0,0(6) 	store exp
1439:     LD  0,-8(2) 	load id value
1440:   PUSH  0,0(6) 	store exp
1441:     LD  0,-7(2) 	load id value
1442:   PUSH  0,0(6) 	store exp
1443:     LD  0,-6(2) 	load id value
1444:   PUSH  0,0(6) 	store exp
1445:     LD  0,-5(2) 	load id value
1446:   PUSH  0,0(6) 	store exp
1447:     LD  0,-4(2) 	load id value
1448:   PUSH  0,0(6) 	store exp
1449:     LD  0,-3(2) 	load id value
1450:   PUSH  0,0(6) 	store exp
1451:     LD  0,-2(2) 	load id value
1452:   PUSH  0,0(6) 	store exp
1453:    MOV  3,2,0 	restore the caller sp
1454:     LD  2,0(2) 	resotre the caller fp
1455:  RETURN  0,-1,3 	return to the caller
1456:    MOV  3,2,0 	restore the caller sp
1457:     LD  2,0(2) 	resotre the caller fp
1458:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1459:  LABEL  47,0,0 	generate label
* call main function
* File: list_example.tm
* Standard prelude:
1460:    LDC  6,65535(0) 	load mp adress
1461:     ST  0,0(0) 	clear location 0
1462:    LDC  5,4095(0) 	load gp adress from location 1
1463:     ST  0,1(0) 	clear location 1
1464:    LDC  4,2000(0) 	load gp adress from location 1
1465:    LDC  2,60000(0) 	load first fp from location 2
1466:    LDC  3,60000(0) 	load first sp from location 2
1467:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* makeNode
1468:    LDA  3,-1(3) 	stack expand for function variable
1469:    LDC  0,1472(0) 	get function adress
1470:     ST  0,-11(5) 	set function adress
1471:     GO  48,0,0 	go to label
1472:    MOV  1,2,0 	store the caller fp temporarily
1473:    MOV  2,3,0 	exchang the stack(context)
1474:   PUSH  1,0(3) 	push the caller fp
1475:   PUSH  0,0(3) 	push the return adress
1476:    LDA  3,-1(3) 	stack expand
1477:     LD  0,1(2) 	load env
1478:   PUSH  0,0(3) 	store env
* call function: 
* createListNode
1479:     LD  0,-9(5) 	load id value
1480:   PUSH  0,0(6) 	store exp
1481:    LDC  0,1483(0) 	store the return adress
1482:    POP  7,0(6) 	ujp to the function body
1483:    LDA  3,0(3) 	pop parameters
1484:    LDA  3,1(3) 	pop env
1485:    LDA  0,-2(2) 	load id adress
1486:   PUSH  0,0(6) 	push array adress to mp
1487:    POP  1,0(6) 	move the adress of ID
1488:    POP  0,0(6) 	copy bytes
1489:     ST  0,0(1) 	copy bytes
* push function parameters
1490:    LDC  0,1,0 	load size of exp
1491:   PUSH  0,0(6) 	
1492:    POP  0,0(6) 	copy bytes
1493:   PUSH  0,0(3) 	PUSH bytes
1494:     LD  0,1(2) 	load env
1495:   PUSH  0,0(3) 	store env
* call function: 
* malloc
1496:     LD  0,-6(5) 	load id value
1497:   PUSH  0,0(6) 	store exp
1498:    LDC  0,1500(0) 	store the return adress
1499:    POP  7,0(6) 	ujp to the function body
1500:    LDA  3,1(3) 	pop parameters
1501:    LDA  3,1(3) 	pop env
1502:     LD  0,-2(2) 	load id value
1503:   PUSH  0,0(6) 	store exp
1504:    POP  1,0,6 	load adress of lhs struct
1505:    LDC  0,2,0 	load offset of member
1506:    ADD  0,0,1 	compute the real adress if pointK
1507:   PUSH  0,0(6) 	
1508:    POP  1,0(6) 	move the adress of referenced
1509:    POP  0,0(6) 	copy bytes
1510:     ST  0,0(1) 	copy bytes
1511:     LD  0,2(2) 	load id value
1512:   PUSH  0,0(6) 	store exp
1513:     LD  0,-2(2) 	load id value
1514:   PUSH  0,0(6) 	store exp
1515:    POP  1,0,6 	load adress of lhs struct
1516:    LDC  0,2,0 	load offset of member
1517:    ADD  0,0,1 	compute the real adress if pointK
1518:   PUSH  0,0(6) 	
1519:    POP  0,0(6) 	load adress from mp
1520:     LD  1,0(0) 	copy bytes
1521:   PUSH  1,0(6) 	push a.x value into tmp
1522:    POP  0,0(6) 	pop right
1523:   PUSH  0,0(6) 	
1524:    POP  1,0(6) 	move the adress of referenced
1525:    POP  0,0(6) 	copy bytes
1526:     ST  0,0(1) 	copy bytes
1527:     LD  0,-2(2) 	load id value
1528:   PUSH  0,0(6) 	store exp
1529:    MOV  3,2,0 	restore the caller sp
1530:     LD  2,0(2) 	resotre the caller fp
1531:  RETURN  0,-1,3 	return to the caller
1532:    MOV  3,2,0 	restore the caller sp
1533:     LD  2,0(2) 	resotre the caller fp
1534:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1535:  LABEL  48,0,0 	generate label
* function entry:
* makeList
1536:    LDA  3,-1(3) 	stack expand for function variable
1537:    LDC  0,1540(0) 	get function adress
1538:     ST  0,-12(5) 	set function adress
1539:     GO  49,0,0 	go to label
1540:    MOV  1,2,0 	store the caller fp temporarily
1541:    MOV  2,3,0 	exchang the stack(context)
1542:   PUSH  1,0(3) 	push the caller fp
1543:   PUSH  0,0(3) 	push the return adress
* function entry:
* compare
1544:    LDA  3,-1(3) 	stack expand for function variable
1545:    LDC  0,1548(0) 	get function adress
1546:     ST  0,-2(2) 	set function adress
1547:     GO  50,0,0 	go to label
1548:    MOV  1,2,0 	store the caller fp temporarily
1549:    MOV  2,3,0 	exchang the stack(context)
1550:   PUSH  1,0(3) 	push the caller fp
1551:   PUSH  0,0(3) 	push the return adress
1552:    LDA  3,-1(3) 	stack expand
1553:     LD  0,2(2) 	load id value
1554:   PUSH  0,0(6) 	store exp
1555:    POP  0,0(6) 	pop right
1556:   PUSH  0,0(6) 	
1557:    POP  0,0(6) 	pop the adress
1558:     LD  1,0(0) 	load bytes
1559:   PUSH  1,0(6) 	push bytes 
1560:    LDA  0,-2(2) 	load id adress
1561:   PUSH  0,0(6) 	push array adress to mp
1562:    POP  1,0(6) 	move the adress of ID
1563:    POP  0,0(6) 	copy bytes
1564:     ST  0,0(1) 	copy bytes
1565:    LDA  3,-1(3) 	stack expand
1566:     LD  0,3(2) 	load id value
1567:   PUSH  0,0(6) 	store exp
1568:    POP  0,0(6) 	pop right
1569:   PUSH  0,0(6) 	
1570:    POP  0,0(6) 	pop the adress
1571:     LD  1,0(0) 	load bytes
1572:   PUSH  1,0(6) 	push bytes 
1573:    LDA  0,-3(2) 	load id adress
1574:   PUSH  0,0(6) 	push array adress to mp
1575:    POP  1,0(6) 	move the adress of ID
1576:    POP  0,0(6) 	copy bytes
1577:     ST  0,0(1) 	copy bytes
1578:     LD  0,-2(2) 	load id value
1579:   PUSH  0,0(6) 	store exp
1580:     LD  0,-3(2) 	load id value
1581:   PUSH  0,0(6) 	store exp
1582:    POP  1,0(6) 	pop right
1583:    POP  0,0(6) 	pop left
1584:    SUB  0,0,1 	op <
1585:    JLT  0,2(7) 	br if true
1586:    LDC  0,0(0) 	false case
1587:    LDA  7,1(7) 	unconditional jmp
1588:    LDC  0,1(0) 	true case
1589:   PUSH  0,0(6) 	
1590:    POP  0,0(6) 	pop from the mp
1591:    JNE  0,1,7 	true case:, execute if part
1592:     GO  51,0,0 	go to label
1593:    LDC  0,10(0) 	load integer const
1594:   PUSH  0,0(6) 	store exp
1595:    POP  0,0(6) 	pop right
1596:    NEG  0,0,0 	single op (-)
1597:   PUSH  0,0(6) 	op: load left
1598:    MOV  3,2,0 	restore the caller sp
1599:     LD  2,0(2) 	resotre the caller fp
1600:  RETURN  0,-1,3 	return to the caller
1601:     GO  52,0,0 	go to label
1602:  LABEL  51,0,0 	generate label
* if: jump to else
1603:  LABEL  52,0,0 	generate label
1604:     LD  0,-2(2) 	load id value
1605:   PUSH  0,0(6) 	store exp
1606:     LD  0,-3(2) 	load id value
1607:   PUSH  0,0(6) 	store exp
1608:    POP  1,0(6) 	pop right
1609:    POP  0,0(6) 	pop left
1610:    SUB  0,0,1 	op <
1611:    JGT  0,2(7) 	br if true
1612:    LDC  0,0(0) 	false case
1613:    LDA  7,1(7) 	unconditional jmp
1614:    LDC  0,1(0) 	true case
1615:   PUSH  0,0(6) 	
1616:    POP  0,0(6) 	pop from the mp
1617:    JNE  0,1,7 	true case:, execute if part
1618:     GO  53,0,0 	go to label
1619:    LDC  0,10(0) 	load integer const
1620:   PUSH  0,0(6) 	store exp
1621:    MOV  3,2,0 	restore the caller sp
1622:     LD  2,0(2) 	resotre the caller fp
1623:  RETURN  0,-1,3 	return to the caller
1624:     GO  54,0,0 	go to label
1625:  LABEL  53,0,0 	generate label
* if: jump to else
1626:  LABEL  54,0,0 	generate label
1627:    LDC  0,0(0) 	load integer const
1628:   PUSH  0,0(6) 	store exp
1629:    MOV  3,2,0 	restore the caller sp
1630:     LD  2,0(2) 	resotre the caller fp
1631:  RETURN  0,-1,3 	return to the caller
1632:    MOV  3,2,0 	restore the caller sp
1633:     LD  2,0(2) 	resotre the caller fp
1634:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1635:  LABEL  50,0,0 	generate label
1636:    LDA  3,-11(3) 	stack expand
1637:    LDC  1,195(0) 	get function adress from struct
1638:     ST  1,4(3) 	Init Struct Instance
1639:    LDC  1,205(0) 	get function adress from struct
1640:     ST  1,5(3) 	Init Struct Instance
1641:    LDC  1,215(0) 	get function adress from struct
1642:     ST  1,6(3) 	Init Struct Instance
1643:    LDC  1,225(0) 	get function adress from struct
1644:     ST  1,7(3) 	Init Struct Instance
1645:    LDC  1,539(0) 	get function adress from struct
1646:     ST  1,8(3) 	Init Struct Instance
1647:    LDC  1,662(0) 	get function adress from struct
1648:     ST  1,9(3) 	Init Struct Instance
1649:    LDC  1,928(0) 	get function adress from struct
1650:     ST  1,10(3) 	Init Struct Instance
1651:    LDC  1,1084(0) 	get function adress from struct
1652:     ST  1,11(3) 	Init Struct Instance
1653:     LD  0,1(2) 	load env
1654:   PUSH  0,0(3) 	store env
* call function: 
* createList
1655:     LD  0,-10(5) 	load id value
1656:   PUSH  0,0(6) 	store exp
1657:    LDC  0,1659(0) 	store the return adress
1658:    POP  7,0(6) 	ujp to the function body
1659:    LDA  3,0(3) 	pop parameters
1660:    LDA  3,1(3) 	pop env
1661:    LDA  0,-13(2) 	load id adress
1662:   PUSH  0,0(6) 	push array adress to mp
1663:    POP  1,0(6) 	move the adress of ID
1664:    POP  0,0(6) 	copy bytes
1665:     ST  0,10(1) 	copy bytes
1666:    POP  0,0(6) 	copy bytes
1667:     ST  0,9(1) 	copy bytes
1668:    POP  0,0(6) 	copy bytes
1669:     ST  0,8(1) 	copy bytes
1670:    POP  0,0(6) 	copy bytes
1671:     ST  0,7(1) 	copy bytes
1672:    POP  0,0(6) 	copy bytes
1673:     ST  0,6(1) 	copy bytes
1674:    POP  0,0(6) 	copy bytes
1675:     ST  0,5(1) 	copy bytes
1676:    POP  0,0(6) 	copy bytes
1677:     ST  0,4(1) 	copy bytes
1678:    POP  0,0(6) 	copy bytes
1679:     ST  0,3(1) 	copy bytes
1680:    POP  0,0(6) 	copy bytes
1681:     ST  0,2(1) 	copy bytes
1682:    POP  0,0(6) 	copy bytes
1683:     ST  0,1(1) 	copy bytes
1684:    POP  0,0(6) 	copy bytes
1685:     ST  0,0(1) 	copy bytes
1686:     LD  0,-2(2) 	load id value
1687:   PUSH  0,0(6) 	store exp
1688:    LDA  0,-13(2) 	load id adress
1689:   PUSH  0,0(6) 	push array adress to mp
1690:    POP  1,0,6 	load adress of lhs struct
1691:    LDC  0,5,0 	load offset of member
1692:    ADD  0,0,1 	compute the real adress if pointK
1693:   PUSH  0,0(6) 	
1694:    POP  1,0(6) 	move the adress of referenced
1695:    POP  0,0(6) 	copy bytes
1696:     ST  0,0(1) 	copy bytes
1697:     LD  0,-13(2) 	load id value
1698:   PUSH  0,0(6) 	store exp
1699:     LD  0,-12(2) 	load id value
1700:   PUSH  0,0(6) 	store exp
1701:     LD  0,-11(2) 	load id value
1702:   PUSH  0,0(6) 	store exp
1703:     LD  0,-10(2) 	load id value
1704:   PUSH  0,0(6) 	store exp
1705:     LD  0,-9(2) 	load id value
1706:   PUSH  0,0(6) 	store exp
1707:     LD  0,-8(2) 	load id value
1708:   PUSH  0,0(6) 	store exp
1709:     LD  0,-7(2) 	load id value
1710:   PUSH  0,0(6) 	store exp
1711:     LD  0,-6(2) 	load id value
1712:   PUSH  0,0(6) 	store exp
1713:     LD  0,-5(2) 	load id value
1714:   PUSH  0,0(6) 	store exp
1715:     LD  0,-4(2) 	load id value
1716:   PUSH  0,0(6) 	store exp
1717:     LD  0,-3(2) 	load id value
1718:   PUSH  0,0(6) 	store exp
1719:    MOV  3,2,0 	restore the caller sp
1720:     LD  2,0(2) 	resotre the caller fp
1721:  RETURN  0,-1,3 	return to the caller
1722:    MOV  3,2,0 	restore the caller sp
1723:     LD  2,0(2) 	resotre the caller fp
1724:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
1725:  LABEL  49,0,0 	generate label
* function entry:
* test_insertSortedList
1726:    LDA  3,-1(3) 	stack expand for function variable
1727:    LDC  0,1730(0) 	get function adress
1728:     ST  0,-13(5) 	set function adress
1729:     GO  55,0,0 	go to label
1730:    MOV  1,2,0 	store the caller fp temporarily
1731:    MOV  2,3,0 	exchang the stack(context)
1732:   PUSH  1,0(3) 	push the caller fp
1733:   PUSH  0,0(3) 	push the return adress
1734:    LDA  3,-11(3) 	stack expand
1735:    LDC  1,195(0) 	get function adress from struct
1736:     ST  1,4(3) 	Init Struct Instance
1737:    LDC  1,205(0) 	get function adress from struct
1738:     ST  1,5(3) 	Init Struct Instance
1739:    LDC  1,215(0) 	get function adress from struct
1740:     ST  1,6(3) 	Init Struct Instance
1741:    LDC  1,225(0) 	get function adress from struct
1742:     ST  1,7(3) 	Init Struct Instance
1743:    LDC  1,539(0) 	get function adress from struct
1744:     ST  1,8(3) 	Init Struct Instance
1745:    LDC  1,662(0) 	get function adress from struct
1746:     ST  1,9(3) 	Init Struct Instance
1747:    LDC  1,928(0) 	get function adress from struct
1748:     ST  1,10(3) 	Init Struct Instance
1749:    LDC  1,1084(0) 	get function adress from struct
1750:     ST  1,11(3) 	Init Struct Instance
1751:     LD  0,1(2) 	load env
1752:   PUSH  0,0(3) 	store env
* call function: 
* makeList
1753:     LD  0,-12(5) 	load id value
1754:   PUSH  0,0(6) 	store exp
1755:    LDC  0,1757(0) 	store the return adress
1756:    POP  7,0(6) 	ujp to the function body
1757:    LDA  3,0(3) 	pop parameters
1758:    LDA  3,1(3) 	pop env
1759:    LDA  0,-12(2) 	load id adress
1760:   PUSH  0,0(6) 	push array adress to mp
1761:    POP  1,0(6) 	move the adress of ID
1762:    POP  0,0(6) 	copy bytes
1763:     ST  0,10(1) 	copy bytes
1764:    POP  0,0(6) 	copy bytes
1765:     ST  0,9(1) 	copy bytes
1766:    POP  0,0(6) 	copy bytes
1767:     ST  0,8(1) 	copy bytes
1768:    POP  0,0(6) 	copy bytes
1769:     ST  0,7(1) 	copy bytes
1770:    POP  0,0(6) 	copy bytes
1771:     ST  0,6(1) 	copy bytes
1772:    POP  0,0(6) 	copy bytes
1773:     ST  0,5(1) 	copy bytes
1774:    POP  0,0(6) 	copy bytes
1775:     ST  0,4(1) 	copy bytes
1776:    POP  0,0(6) 	copy bytes
1777:     ST  0,3(1) 	copy bytes
1778:    POP  0,0(6) 	copy bytes
1779:     ST  0,2(1) 	copy bytes
1780:    POP  0,0(6) 	copy bytes
1781:     ST  0,1(1) 	copy bytes
1782:    POP  0,0(6) 	copy bytes
1783:     ST  0,0(1) 	copy bytes
* push function parameters
* push function parameters
1784:    LDC  0,1(0) 	load integer const
1785:   PUSH  0,0(6) 	store exp
1786:    POP  0,0(6) 	pop right
1787:    NEG  0,0,0 	single op (-)
1788:   PUSH  0,0(6) 	op: load left
1789:    POP  0,0(6) 	copy bytes
1790:   PUSH  0,0(3) 	PUSH bytes
1791:     LD  0,1(2) 	load env
1792:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1793:     LD  0,-11(5) 	load id value
1794:   PUSH  0,0(6) 	store exp
1795:    LDC  0,1797(0) 	store the return adress
1796:    POP  7,0(6) 	ujp to the function body
1797:    LDA  3,1(3) 	pop parameters
1798:    LDA  3,1(3) 	pop env
1799:    POP  0,0(6) 	copy bytes
1800:   PUSH  0,0(3) 	PUSH bytes
1801:    LDA  0,-12(2) 	load id adress
1802:   PUSH  0,0(6) 	push array adress to mp
1803:    POP  0,0(6) 	
1804:   PUSH  0,0(3) 	
1805:    LDA  0,0(2) 	load env
1806:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1807:    LDA  0,-12(2) 	load id adress
1808:   PUSH  0,0(6) 	push array adress to mp
1809:    POP  1,0,6 	load adress of lhs struct
1810:    LDC  0,8,0 	load offset of member
1811:    ADD  0,0,1 	compute the real adress if pointK
1812:   PUSH  0,0(6) 	
1813:    POP  0,0(6) 	load adress from mp
1814:     LD  1,0(0) 	copy bytes
1815:   PUSH  1,0(6) 	push a.x value into tmp
1816:    LDC  0,1818(0) 	store the return adress
1817:    POP  7,0(6) 	ujp to the function body
1818:    LDA  3,1(3) 	pop parameters
1819:    LDA  3,1(3) 	pop env
1820:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1821:    LDC  0,1(0) 	load integer const
1822:   PUSH  0,0(6) 	store exp
1823:    POP  0,0(6) 	copy bytes
1824:   PUSH  0,0(3) 	PUSH bytes
1825:     LD  0,1(2) 	load env
1826:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1827:     LD  0,-11(5) 	load id value
1828:   PUSH  0,0(6) 	store exp
1829:    LDC  0,1831(0) 	store the return adress
1830:    POP  7,0(6) 	ujp to the function body
1831:    LDA  3,1(3) 	pop parameters
1832:    LDA  3,1(3) 	pop env
1833:    POP  0,0(6) 	copy bytes
1834:   PUSH  0,0(3) 	PUSH bytes
1835:    LDA  0,-12(2) 	load id adress
1836:   PUSH  0,0(6) 	push array adress to mp
1837:    POP  0,0(6) 	
1838:   PUSH  0,0(3) 	
1839:    LDA  0,0(2) 	load env
1840:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1841:    LDA  0,-12(2) 	load id adress
1842:   PUSH  0,0(6) 	push array adress to mp
1843:    POP  1,0,6 	load adress of lhs struct
1844:    LDC  0,8,0 	load offset of member
1845:    ADD  0,0,1 	compute the real adress if pointK
1846:   PUSH  0,0(6) 	
1847:    POP  0,0(6) 	load adress from mp
1848:     LD  1,0(0) 	copy bytes
1849:   PUSH  1,0(6) 	push a.x value into tmp
1850:    LDC  0,1852(0) 	store the return adress
1851:    POP  7,0(6) 	ujp to the function body
1852:    LDA  3,1(3) 	pop parameters
1853:    LDA  3,1(3) 	pop env
1854:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1855:    LDC  0,20(0) 	load integer const
1856:   PUSH  0,0(6) 	store exp
1857:    POP  0,0(6) 	pop right
1858:    NEG  0,0,0 	single op (-)
1859:   PUSH  0,0(6) 	op: load left
1860:    POP  0,0(6) 	copy bytes
1861:   PUSH  0,0(3) 	PUSH bytes
1862:     LD  0,1(2) 	load env
1863:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1864:     LD  0,-11(5) 	load id value
1865:   PUSH  0,0(6) 	store exp
1866:    LDC  0,1868(0) 	store the return adress
1867:    POP  7,0(6) 	ujp to the function body
1868:    LDA  3,1(3) 	pop parameters
1869:    LDA  3,1(3) 	pop env
1870:    POP  0,0(6) 	copy bytes
1871:   PUSH  0,0(3) 	PUSH bytes
1872:    LDA  0,-12(2) 	load id adress
1873:   PUSH  0,0(6) 	push array adress to mp
1874:    POP  0,0(6) 	
1875:   PUSH  0,0(3) 	
1876:    LDA  0,0(2) 	load env
1877:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1878:    LDA  0,-12(2) 	load id adress
1879:   PUSH  0,0(6) 	push array adress to mp
1880:    POP  1,0,6 	load adress of lhs struct
1881:    LDC  0,8,0 	load offset of member
1882:    ADD  0,0,1 	compute the real adress if pointK
1883:   PUSH  0,0(6) 	
1884:    POP  0,0(6) 	load adress from mp
1885:     LD  1,0(0) 	copy bytes
1886:   PUSH  1,0(6) 	push a.x value into tmp
1887:    LDC  0,1889(0) 	store the return adress
1888:    POP  7,0(6) 	ujp to the function body
1889:    LDA  3,1(3) 	pop parameters
1890:    LDA  3,1(3) 	pop env
1891:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1892:    LDC  0,20(0) 	load integer const
1893:   PUSH  0,0(6) 	store exp
1894:    POP  0,0(6) 	pop right
1895:    NEG  0,0,0 	single op (-)
1896:   PUSH  0,0(6) 	op: load left
1897:    POP  0,0(6) 	copy bytes
1898:   PUSH  0,0(3) 	PUSH bytes
1899:     LD  0,1(2) 	load env
1900:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1901:     LD  0,-11(5) 	load id value
1902:   PUSH  0,0(6) 	store exp
1903:    LDC  0,1905(0) 	store the return adress
1904:    POP  7,0(6) 	ujp to the function body
1905:    LDA  3,1(3) 	pop parameters
1906:    LDA  3,1(3) 	pop env
1907:    POP  0,0(6) 	copy bytes
1908:   PUSH  0,0(3) 	PUSH bytes
1909:    LDA  0,-12(2) 	load id adress
1910:   PUSH  0,0(6) 	push array adress to mp
1911:    POP  0,0(6) 	
1912:   PUSH  0,0(3) 	
1913:    LDA  0,0(2) 	load env
1914:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1915:    LDA  0,-12(2) 	load id adress
1916:   PUSH  0,0(6) 	push array adress to mp
1917:    POP  1,0,6 	load adress of lhs struct
1918:    LDC  0,8,0 	load offset of member
1919:    ADD  0,0,1 	compute the real adress if pointK
1920:   PUSH  0,0(6) 	
1921:    POP  0,0(6) 	load adress from mp
1922:     LD  1,0(0) 	copy bytes
1923:   PUSH  1,0(6) 	push a.x value into tmp
1924:    LDC  0,1926(0) 	store the return adress
1925:    POP  7,0(6) 	ujp to the function body
1926:    LDA  3,1(3) 	pop parameters
1927:    LDA  3,1(3) 	pop env
1928:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1929:    LDC  0,20(0) 	load integer const
1930:   PUSH  0,0(6) 	store exp
1931:    POP  0,0(6) 	pop right
1932:    NEG  0,0,0 	single op (-)
1933:   PUSH  0,0(6) 	op: load left
1934:    POP  0,0(6) 	copy bytes
1935:   PUSH  0,0(3) 	PUSH bytes
1936:     LD  0,1(2) 	load env
1937:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1938:     LD  0,-11(5) 	load id value
1939:   PUSH  0,0(6) 	store exp
1940:    LDC  0,1942(0) 	store the return adress
1941:    POP  7,0(6) 	ujp to the function body
1942:    LDA  3,1(3) 	pop parameters
1943:    LDA  3,1(3) 	pop env
1944:    POP  0,0(6) 	copy bytes
1945:   PUSH  0,0(3) 	PUSH bytes
1946:    LDA  0,-12(2) 	load id adress
1947:   PUSH  0,0(6) 	push array adress to mp
1948:    POP  0,0(6) 	
1949:   PUSH  0,0(3) 	
1950:    LDA  0,0(2) 	load env
1951:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1952:    LDA  0,-12(2) 	load id adress
1953:   PUSH  0,0(6) 	push array adress to mp
1954:    POP  1,0,6 	load adress of lhs struct
1955:    LDC  0,8,0 	load offset of member
1956:    ADD  0,0,1 	compute the real adress if pointK
1957:   PUSH  0,0(6) 	
1958:    POP  0,0(6) 	load adress from mp
1959:     LD  1,0(0) 	copy bytes
1960:   PUSH  1,0(6) 	push a.x value into tmp
1961:    LDC  0,1963(0) 	store the return adress
1962:    POP  7,0(6) 	ujp to the function body
1963:    LDA  3,1(3) 	pop parameters
1964:    LDA  3,1(3) 	pop env
1965:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
1966:    LDC  0,100000(0) 	load integer const
1967:   PUSH  0,0(6) 	store exp
1968:    POP  0,0(6) 	pop right
1969:    NEG  0,0,0 	single op (-)
1970:   PUSH  0,0(6) 	op: load left
1971:    POP  0,0(6) 	copy bytes
1972:   PUSH  0,0(3) 	PUSH bytes
1973:     LD  0,1(2) 	load env
1974:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
1975:     LD  0,-11(5) 	load id value
1976:   PUSH  0,0(6) 	store exp
1977:    LDC  0,1979(0) 	store the return adress
1978:    POP  7,0(6) 	ujp to the function body
1979:    LDA  3,1(3) 	pop parameters
1980:    LDA  3,1(3) 	pop env
1981:    POP  0,0(6) 	copy bytes
1982:   PUSH  0,0(3) 	PUSH bytes
1983:    LDA  0,-12(2) 	load id adress
1984:   PUSH  0,0(6) 	push array adress to mp
1985:    POP  0,0(6) 	
1986:   PUSH  0,0(3) 	
1987:    LDA  0,0(2) 	load env
1988:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
1989:    LDA  0,-12(2) 	load id adress
1990:   PUSH  0,0(6) 	push array adress to mp
1991:    POP  1,0,6 	load adress of lhs struct
1992:    LDC  0,8,0 	load offset of member
1993:    ADD  0,0,1 	compute the real adress if pointK
1994:   PUSH  0,0(6) 	
1995:    POP  0,0(6) 	load adress from mp
1996:     LD  1,0(0) 	copy bytes
1997:   PUSH  1,0(6) 	push a.x value into tmp
1998:    LDC  0,2000(0) 	store the return adress
1999:    POP  7,0(6) 	ujp to the function body
2000:    LDA  3,1(3) 	pop parameters
2001:    LDA  3,1(3) 	pop env
2002:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2003:    LDC  0,2000(0) 	load integer const
2004:   PUSH  0,0(6) 	store exp
2005:    POP  0,0(6) 	copy bytes
2006:   PUSH  0,0(3) 	PUSH bytes
2007:     LD  0,1(2) 	load env
2008:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2009:     LD  0,-11(5) 	load id value
2010:   PUSH  0,0(6) 	store exp
2011:    LDC  0,2013(0) 	store the return adress
2012:    POP  7,0(6) 	ujp to the function body
2013:    LDA  3,1(3) 	pop parameters
2014:    LDA  3,1(3) 	pop env
2015:    POP  0,0(6) 	copy bytes
2016:   PUSH  0,0(3) 	PUSH bytes
2017:    LDA  0,-12(2) 	load id adress
2018:   PUSH  0,0(6) 	push array adress to mp
2019:    POP  0,0(6) 	
2020:   PUSH  0,0(3) 	
2021:    LDA  0,0(2) 	load env
2022:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2023:    LDA  0,-12(2) 	load id adress
2024:   PUSH  0,0(6) 	push array adress to mp
2025:    POP  1,0,6 	load adress of lhs struct
2026:    LDC  0,8,0 	load offset of member
2027:    ADD  0,0,1 	compute the real adress if pointK
2028:   PUSH  0,0(6) 	
2029:    POP  0,0(6) 	load adress from mp
2030:     LD  1,0(0) 	copy bytes
2031:   PUSH  1,0(6) 	push a.x value into tmp
2032:    LDC  0,2034(0) 	store the return adress
2033:    POP  7,0(6) 	ujp to the function body
2034:    LDA  3,1(3) 	pop parameters
2035:    LDA  3,1(3) 	pop env
2036:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2037:    LDC  0,100(0) 	load integer const
2038:   PUSH  0,0(6) 	store exp
2039:    POP  0,0(6) 	copy bytes
2040:   PUSH  0,0(3) 	PUSH bytes
2041:     LD  0,1(2) 	load env
2042:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2043:     LD  0,-11(5) 	load id value
2044:   PUSH  0,0(6) 	store exp
2045:    LDC  0,2047(0) 	store the return adress
2046:    POP  7,0(6) 	ujp to the function body
2047:    LDA  3,1(3) 	pop parameters
2048:    LDA  3,1(3) 	pop env
2049:    POP  0,0(6) 	copy bytes
2050:   PUSH  0,0(3) 	PUSH bytes
2051:    LDA  0,-12(2) 	load id adress
2052:   PUSH  0,0(6) 	push array adress to mp
2053:    POP  0,0(6) 	
2054:   PUSH  0,0(3) 	
2055:    LDA  0,0(2) 	load env
2056:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2057:    LDA  0,-12(2) 	load id adress
2058:   PUSH  0,0(6) 	push array adress to mp
2059:    POP  1,0,6 	load adress of lhs struct
2060:    LDC  0,8,0 	load offset of member
2061:    ADD  0,0,1 	compute the real adress if pointK
2062:   PUSH  0,0(6) 	
2063:    POP  0,0(6) 	load adress from mp
2064:     LD  1,0(0) 	copy bytes
2065:   PUSH  1,0(6) 	push a.x value into tmp
2066:    LDC  0,2068(0) 	store the return adress
2067:    POP  7,0(6) 	ujp to the function body
2068:    LDA  3,1(3) 	pop parameters
2069:    LDA  3,1(3) 	pop env
2070:    LDA  3,1(3) 	pop parameters
2071:    LDA  3,-1(3) 	stack expand
2072:    LDA  0,-12(2) 	load id adress
2073:   PUSH  0,0(6) 	push array adress to mp
2074:    POP  1,0,6 	load adress of lhs struct
2075:    LDC  0,0,0 	load offset of member
2076:    ADD  0,0,1 	compute the real adress if pointK
2077:   PUSH  0,0(6) 	
2078:    POP  0,0(6) 	load adress from mp
2079:     LD  1,0(0) 	copy bytes
2080:   PUSH  1,0(6) 	push a.x value into tmp
2081:    POP  1,0,6 	load adress of lhs struct
2082:    LDC  0,1,0 	load offset of member
2083:    ADD  0,0,1 	compute the real adress if pointK
2084:   PUSH  0,0(6) 	
2085:    POP  0,0(6) 	load adress from mp
2086:     LD  1,0(0) 	copy bytes
2087:   PUSH  1,0(6) 	push a.x value into tmp
2088:    LDA  0,-13(2) 	load id adress
2089:   PUSH  0,0(6) 	push array adress to mp
2090:    POP  1,0(6) 	move the adress of ID
2091:    POP  0,0(6) 	copy bytes
2092:     ST  0,0(1) 	copy bytes
* while stmt:
2093:  LABEL  56,0,0 	generate label
2094:     LD  0,-13(2) 	load id value
2095:   PUSH  0,0(6) 	store exp
2096:     LD  0,-5(5) 	load id value
2097:   PUSH  0,0(6) 	store exp
2098:    POP  1,0(6) 	pop right
2099:    POP  0,0(6) 	pop left
2100:    SUB  0,0,1 	op ==, convertd_type
2101:    JNE  0,2(7) 	br if true
2102:    LDC  0,0(0) 	false case
2103:    LDA  7,1(7) 	unconditional jmp
2104:    LDC  0,1(0) 	true case
2105:   PUSH  0,0(6) 	
2106:    POP  0,0(6) 	pop from the mp
2107:    JNE  0,1,7 	true case:, skip the break, execute the block code
2108:     GO  57,0,0 	go to label
2109:     LD  0,-13(2) 	load id value
2110:   PUSH  0,0(6) 	store exp
2111:    POP  1,0,6 	load adress of lhs struct
2112:    LDC  0,2,0 	load offset of member
2113:    ADD  0,0,1 	compute the real adress if pointK
2114:   PUSH  0,0(6) 	
2115:    POP  0,0(6) 	load adress from mp
2116:     LD  1,0(0) 	copy bytes
2117:   PUSH  1,0(6) 	push a.x value into tmp
2118:    POP  0,0(6) 	pop the adress
2119:     LD  1,0(0) 	load bytes
2120:   PUSH  1,0(6) 	push bytes 
2121:    POP  0,0(6) 	move result to register
2122:    OUT  0,0,0 	output value in register[ac / fac]
2123:     LD  0,-13(2) 	load id value
2124:   PUSH  0,0(6) 	store exp
2125:    POP  1,0,6 	load adress of lhs struct
2126:    LDC  0,1,0 	load offset of member
2127:    ADD  0,0,1 	compute the real adress if pointK
2128:   PUSH  0,0(6) 	
2129:    POP  0,0(6) 	load adress from mp
2130:     LD  1,0(0) 	copy bytes
2131:   PUSH  1,0(6) 	push a.x value into tmp
2132:    LDA  0,-13(2) 	load id adress
2133:   PUSH  0,0(6) 	push array adress to mp
2134:    POP  1,0(6) 	move the adress of ID
2135:    POP  0,0(6) 	copy bytes
2136:     ST  0,0(1) 	copy bytes
2137:     GO  56,0,0 	go to label
2138:  LABEL  57,0,0 	generate label
2139:    MOV  3,2,0 	restore the caller sp
2140:     LD  2,0(2) 	resotre the caller fp
2141:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2142:  LABEL  55,0,0 	generate label
* function entry:
* test_appendList
2143:    LDA  3,-1(3) 	stack expand for function variable
2144:    LDC  0,2147(0) 	get function adress
2145:     ST  0,-14(5) 	set function adress
2146:     GO  58,0,0 	go to label
2147:    MOV  1,2,0 	store the caller fp temporarily
2148:    MOV  2,3,0 	exchang the stack(context)
2149:   PUSH  1,0(3) 	push the caller fp
2150:   PUSH  0,0(3) 	push the return adress
2151:    LDA  3,-11(3) 	stack expand
2152:    LDC  1,195(0) 	get function adress from struct
2153:     ST  1,4(3) 	Init Struct Instance
2154:    LDC  1,205(0) 	get function adress from struct
2155:     ST  1,5(3) 	Init Struct Instance
2156:    LDC  1,215(0) 	get function adress from struct
2157:     ST  1,6(3) 	Init Struct Instance
2158:    LDC  1,225(0) 	get function adress from struct
2159:     ST  1,7(3) 	Init Struct Instance
2160:    LDC  1,539(0) 	get function adress from struct
2161:     ST  1,8(3) 	Init Struct Instance
2162:    LDC  1,662(0) 	get function adress from struct
2163:     ST  1,9(3) 	Init Struct Instance
2164:    LDC  1,928(0) 	get function adress from struct
2165:     ST  1,10(3) 	Init Struct Instance
2166:    LDC  1,1084(0) 	get function adress from struct
2167:     ST  1,11(3) 	Init Struct Instance
2168:     LD  0,1(2) 	load env
2169:   PUSH  0,0(3) 	store env
* call function: 
* makeList
2170:     LD  0,-12(5) 	load id value
2171:   PUSH  0,0(6) 	store exp
2172:    LDC  0,2174(0) 	store the return adress
2173:    POP  7,0(6) 	ujp to the function body
2174:    LDA  3,0(3) 	pop parameters
2175:    LDA  3,1(3) 	pop env
2176:    LDA  0,-12(2) 	load id adress
2177:   PUSH  0,0(6) 	push array adress to mp
2178:    POP  1,0(6) 	move the adress of ID
2179:    POP  0,0(6) 	copy bytes
2180:     ST  0,10(1) 	copy bytes
2181:    POP  0,0(6) 	copy bytes
2182:     ST  0,9(1) 	copy bytes
2183:    POP  0,0(6) 	copy bytes
2184:     ST  0,8(1) 	copy bytes
2185:    POP  0,0(6) 	copy bytes
2186:     ST  0,7(1) 	copy bytes
2187:    POP  0,0(6) 	copy bytes
2188:     ST  0,6(1) 	copy bytes
2189:    POP  0,0(6) 	copy bytes
2190:     ST  0,5(1) 	copy bytes
2191:    POP  0,0(6) 	copy bytes
2192:     ST  0,4(1) 	copy bytes
2193:    POP  0,0(6) 	copy bytes
2194:     ST  0,3(1) 	copy bytes
2195:    POP  0,0(6) 	copy bytes
2196:     ST  0,2(1) 	copy bytes
2197:    POP  0,0(6) 	copy bytes
2198:     ST  0,1(1) 	copy bytes
2199:    POP  0,0(6) 	copy bytes
2200:     ST  0,0(1) 	copy bytes
* function entry:
* opera
2201:    LDA  3,-1(3) 	stack expand for function variable
2202:    LDC  0,2205(0) 	get function adress
2203:     ST  0,-13(2) 	set function adress
2204:     GO  59,0,0 	go to label
2205:    MOV  1,2,0 	store the caller fp temporarily
2206:    MOV  2,3,0 	exchang the stack(context)
2207:   PUSH  1,0(3) 	push the caller fp
2208:   PUSH  0,0(3) 	push the return adress
2209:    MOV  3,2,0 	restore the caller sp
2210:     LD  2,0(2) 	resotre the caller fp
2211:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2212:  LABEL  59,0,0 	generate label
* push function parameters
* push function parameters
2213:    LDC  0,1(0) 	load integer const
2214:   PUSH  0,0(6) 	store exp
2215:    POP  0,0(6) 	pop right
2216:    NEG  0,0,0 	single op (-)
2217:   PUSH  0,0(6) 	op: load left
2218:    POP  0,0(6) 	copy bytes
2219:   PUSH  0,0(3) 	PUSH bytes
2220:     LD  0,1(2) 	load env
2221:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2222:     LD  0,-11(5) 	load id value
2223:   PUSH  0,0(6) 	store exp
2224:    LDC  0,2226(0) 	store the return adress
2225:    POP  7,0(6) 	ujp to the function body
2226:    LDA  3,1(3) 	pop parameters
2227:    LDA  3,1(3) 	pop env
2228:    POP  0,0(6) 	copy bytes
2229:   PUSH  0,0(3) 	PUSH bytes
2230:    LDA  0,-12(2) 	load id adress
2231:   PUSH  0,0(6) 	push array adress to mp
2232:    POP  0,0(6) 	
2233:   PUSH  0,0(3) 	
2234:    LDA  0,0(2) 	load env
2235:   PUSH  0,0(3) 	store env
* call function: 
* append
2236:    LDA  0,-12(2) 	load id adress
2237:   PUSH  0,0(6) 	push array adress to mp
2238:    POP  1,0,6 	load adress of lhs struct
2239:    LDC  0,7,0 	load offset of member
2240:    ADD  0,0,1 	compute the real adress if pointK
2241:   PUSH  0,0(6) 	
2242:    POP  0,0(6) 	load adress from mp
2243:     LD  1,0(0) 	copy bytes
2244:   PUSH  1,0(6) 	push a.x value into tmp
2245:    LDC  0,2247(0) 	store the return adress
2246:    POP  7,0(6) 	ujp to the function body
2247:    LDA  3,1(3) 	pop parameters
2248:    LDA  3,1(3) 	pop env
2249:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2250:    LDC  0,1(0) 	load integer const
2251:   PUSH  0,0(6) 	store exp
2252:    POP  0,0(6) 	copy bytes
2253:   PUSH  0,0(3) 	PUSH bytes
2254:     LD  0,1(2) 	load env
2255:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2256:     LD  0,-11(5) 	load id value
2257:   PUSH  0,0(6) 	store exp
2258:    LDC  0,2260(0) 	store the return adress
2259:    POP  7,0(6) 	ujp to the function body
2260:    LDA  3,1(3) 	pop parameters
2261:    LDA  3,1(3) 	pop env
2262:    POP  0,0(6) 	copy bytes
2263:   PUSH  0,0(3) 	PUSH bytes
2264:    LDA  0,-12(2) 	load id adress
2265:   PUSH  0,0(6) 	push array adress to mp
2266:    POP  0,0(6) 	
2267:   PUSH  0,0(3) 	
2268:    LDA  0,0(2) 	load env
2269:   PUSH  0,0(3) 	store env
* call function: 
* append
2270:    LDA  0,-12(2) 	load id adress
2271:   PUSH  0,0(6) 	push array adress to mp
2272:    POP  1,0,6 	load adress of lhs struct
2273:    LDC  0,7,0 	load offset of member
2274:    ADD  0,0,1 	compute the real adress if pointK
2275:   PUSH  0,0(6) 	
2276:    POP  0,0(6) 	load adress from mp
2277:     LD  1,0(0) 	copy bytes
2278:   PUSH  1,0(6) 	push a.x value into tmp
2279:    LDC  0,2281(0) 	store the return adress
2280:    POP  7,0(6) 	ujp to the function body
2281:    LDA  3,1(3) 	pop parameters
2282:    LDA  3,1(3) 	pop env
2283:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2284:    LDC  0,20(0) 	load integer const
2285:   PUSH  0,0(6) 	store exp
2286:    POP  0,0(6) 	pop right
2287:    NEG  0,0,0 	single op (-)
2288:   PUSH  0,0(6) 	op: load left
2289:    POP  0,0(6) 	copy bytes
2290:   PUSH  0,0(3) 	PUSH bytes
2291:     LD  0,1(2) 	load env
2292:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2293:     LD  0,-11(5) 	load id value
2294:   PUSH  0,0(6) 	store exp
2295:    LDC  0,2297(0) 	store the return adress
2296:    POP  7,0(6) 	ujp to the function body
2297:    LDA  3,1(3) 	pop parameters
2298:    LDA  3,1(3) 	pop env
2299:    POP  0,0(6) 	copy bytes
2300:   PUSH  0,0(3) 	PUSH bytes
2301:    LDA  0,-12(2) 	load id adress
2302:   PUSH  0,0(6) 	push array adress to mp
2303:    POP  0,0(6) 	
2304:   PUSH  0,0(3) 	
2305:    LDA  0,0(2) 	load env
2306:   PUSH  0,0(3) 	store env
* call function: 
* append
2307:    LDA  0,-12(2) 	load id adress
2308:   PUSH  0,0(6) 	push array adress to mp
2309:    POP  1,0,6 	load adress of lhs struct
2310:    LDC  0,7,0 	load offset of member
2311:    ADD  0,0,1 	compute the real adress if pointK
2312:   PUSH  0,0(6) 	
2313:    POP  0,0(6) 	load adress from mp
2314:     LD  1,0(0) 	copy bytes
2315:   PUSH  1,0(6) 	push a.x value into tmp
2316:    LDC  0,2318(0) 	store the return adress
2317:    POP  7,0(6) 	ujp to the function body
2318:    LDA  3,1(3) 	pop parameters
2319:    LDA  3,1(3) 	pop env
2320:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2321:    LDC  0,20(0) 	load integer const
2322:   PUSH  0,0(6) 	store exp
2323:    POP  0,0(6) 	pop right
2324:    NEG  0,0,0 	single op (-)
2325:   PUSH  0,0(6) 	op: load left
2326:    POP  0,0(6) 	copy bytes
2327:   PUSH  0,0(3) 	PUSH bytes
2328:     LD  0,1(2) 	load env
2329:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2330:     LD  0,-11(5) 	load id value
2331:   PUSH  0,0(6) 	store exp
2332:    LDC  0,2334(0) 	store the return adress
2333:    POP  7,0(6) 	ujp to the function body
2334:    LDA  3,1(3) 	pop parameters
2335:    LDA  3,1(3) 	pop env
2336:    POP  0,0(6) 	copy bytes
2337:   PUSH  0,0(3) 	PUSH bytes
2338:    LDA  0,-12(2) 	load id adress
2339:   PUSH  0,0(6) 	push array adress to mp
2340:    POP  0,0(6) 	
2341:   PUSH  0,0(3) 	
2342:    LDA  0,0(2) 	load env
2343:   PUSH  0,0(3) 	store env
* call function: 
* append
2344:    LDA  0,-12(2) 	load id adress
2345:   PUSH  0,0(6) 	push array adress to mp
2346:    POP  1,0,6 	load adress of lhs struct
2347:    LDC  0,7,0 	load offset of member
2348:    ADD  0,0,1 	compute the real adress if pointK
2349:   PUSH  0,0(6) 	
2350:    POP  0,0(6) 	load adress from mp
2351:     LD  1,0(0) 	copy bytes
2352:   PUSH  1,0(6) 	push a.x value into tmp
2353:    LDC  0,2355(0) 	store the return adress
2354:    POP  7,0(6) 	ujp to the function body
2355:    LDA  3,1(3) 	pop parameters
2356:    LDA  3,1(3) 	pop env
2357:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2358:    LDC  0,20(0) 	load integer const
2359:   PUSH  0,0(6) 	store exp
2360:    POP  0,0(6) 	pop right
2361:    NEG  0,0,0 	single op (-)
2362:   PUSH  0,0(6) 	op: load left
2363:    POP  0,0(6) 	copy bytes
2364:   PUSH  0,0(3) 	PUSH bytes
2365:     LD  0,1(2) 	load env
2366:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2367:     LD  0,-11(5) 	load id value
2368:   PUSH  0,0(6) 	store exp
2369:    LDC  0,2371(0) 	store the return adress
2370:    POP  7,0(6) 	ujp to the function body
2371:    LDA  3,1(3) 	pop parameters
2372:    LDA  3,1(3) 	pop env
2373:    POP  0,0(6) 	copy bytes
2374:   PUSH  0,0(3) 	PUSH bytes
2375:    LDA  0,-12(2) 	load id adress
2376:   PUSH  0,0(6) 	push array adress to mp
2377:    POP  0,0(6) 	
2378:   PUSH  0,0(3) 	
2379:    LDA  0,0(2) 	load env
2380:   PUSH  0,0(3) 	store env
* call function: 
* append
2381:    LDA  0,-12(2) 	load id adress
2382:   PUSH  0,0(6) 	push array adress to mp
2383:    POP  1,0,6 	load adress of lhs struct
2384:    LDC  0,7,0 	load offset of member
2385:    ADD  0,0,1 	compute the real adress if pointK
2386:   PUSH  0,0(6) 	
2387:    POP  0,0(6) 	load adress from mp
2388:     LD  1,0(0) 	copy bytes
2389:   PUSH  1,0(6) 	push a.x value into tmp
2390:    LDC  0,2392(0) 	store the return adress
2391:    POP  7,0(6) 	ujp to the function body
2392:    LDA  3,1(3) 	pop parameters
2393:    LDA  3,1(3) 	pop env
2394:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2395:    LDC  0,100000(0) 	load integer const
2396:   PUSH  0,0(6) 	store exp
2397:    POP  0,0(6) 	pop right
2398:    NEG  0,0,0 	single op (-)
2399:   PUSH  0,0(6) 	op: load left
2400:    POP  0,0(6) 	copy bytes
2401:   PUSH  0,0(3) 	PUSH bytes
2402:     LD  0,1(2) 	load env
2403:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2404:     LD  0,-11(5) 	load id value
2405:   PUSH  0,0(6) 	store exp
2406:    LDC  0,2408(0) 	store the return adress
2407:    POP  7,0(6) 	ujp to the function body
2408:    LDA  3,1(3) 	pop parameters
2409:    LDA  3,1(3) 	pop env
2410:    POP  0,0(6) 	copy bytes
2411:   PUSH  0,0(3) 	PUSH bytes
2412:    LDA  0,-12(2) 	load id adress
2413:   PUSH  0,0(6) 	push array adress to mp
2414:    POP  0,0(6) 	
2415:   PUSH  0,0(3) 	
2416:    LDA  0,0(2) 	load env
2417:   PUSH  0,0(3) 	store env
* call function: 
* append
2418:    LDA  0,-12(2) 	load id adress
2419:   PUSH  0,0(6) 	push array adress to mp
2420:    POP  1,0,6 	load adress of lhs struct
2421:    LDC  0,7,0 	load offset of member
2422:    ADD  0,0,1 	compute the real adress if pointK
2423:   PUSH  0,0(6) 	
2424:    POP  0,0(6) 	load adress from mp
2425:     LD  1,0(0) 	copy bytes
2426:   PUSH  1,0(6) 	push a.x value into tmp
2427:    LDC  0,2429(0) 	store the return adress
2428:    POP  7,0(6) 	ujp to the function body
2429:    LDA  3,1(3) 	pop parameters
2430:    LDA  3,1(3) 	pop env
2431:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2432:    LDC  0,2000(0) 	load integer const
2433:   PUSH  0,0(6) 	store exp
2434:    POP  0,0(6) 	copy bytes
2435:   PUSH  0,0(3) 	PUSH bytes
2436:     LD  0,1(2) 	load env
2437:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2438:     LD  0,-11(5) 	load id value
2439:   PUSH  0,0(6) 	store exp
2440:    LDC  0,2442(0) 	store the return adress
2441:    POP  7,0(6) 	ujp to the function body
2442:    LDA  3,1(3) 	pop parameters
2443:    LDA  3,1(3) 	pop env
2444:    POP  0,0(6) 	copy bytes
2445:   PUSH  0,0(3) 	PUSH bytes
2446:    LDA  0,-12(2) 	load id adress
2447:   PUSH  0,0(6) 	push array adress to mp
2448:    POP  0,0(6) 	
2449:   PUSH  0,0(3) 	
2450:    LDA  0,0(2) 	load env
2451:   PUSH  0,0(3) 	store env
* call function: 
* append
2452:    LDA  0,-12(2) 	load id adress
2453:   PUSH  0,0(6) 	push array adress to mp
2454:    POP  1,0,6 	load adress of lhs struct
2455:    LDC  0,7,0 	load offset of member
2456:    ADD  0,0,1 	compute the real adress if pointK
2457:   PUSH  0,0(6) 	
2458:    POP  0,0(6) 	load adress from mp
2459:     LD  1,0(0) 	copy bytes
2460:   PUSH  1,0(6) 	push a.x value into tmp
2461:    LDC  0,2463(0) 	store the return adress
2462:    POP  7,0(6) 	ujp to the function body
2463:    LDA  3,1(3) 	pop parameters
2464:    LDA  3,1(3) 	pop env
2465:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2466:    LDC  0,100(0) 	load integer const
2467:   PUSH  0,0(6) 	store exp
2468:    POP  0,0(6) 	copy bytes
2469:   PUSH  0,0(3) 	PUSH bytes
2470:     LD  0,1(2) 	load env
2471:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2472:     LD  0,-11(5) 	load id value
2473:   PUSH  0,0(6) 	store exp
2474:    LDC  0,2476(0) 	store the return adress
2475:    POP  7,0(6) 	ujp to the function body
2476:    LDA  3,1(3) 	pop parameters
2477:    LDA  3,1(3) 	pop env
2478:    POP  0,0(6) 	copy bytes
2479:   PUSH  0,0(3) 	PUSH bytes
2480:    LDA  0,-12(2) 	load id adress
2481:   PUSH  0,0(6) 	push array adress to mp
2482:    POP  0,0(6) 	
2483:   PUSH  0,0(3) 	
2484:    LDA  0,0(2) 	load env
2485:   PUSH  0,0(3) 	store env
* call function: 
* append
2486:    LDA  0,-12(2) 	load id adress
2487:   PUSH  0,0(6) 	push array adress to mp
2488:    POP  1,0,6 	load adress of lhs struct
2489:    LDC  0,7,0 	load offset of member
2490:    ADD  0,0,1 	compute the real adress if pointK
2491:   PUSH  0,0(6) 	
2492:    POP  0,0(6) 	load adress from mp
2493:     LD  1,0(0) 	copy bytes
2494:   PUSH  1,0(6) 	push a.x value into tmp
2495:    LDC  0,2497(0) 	store the return adress
2496:    POP  7,0(6) 	ujp to the function body
2497:    LDA  3,1(3) 	pop parameters
2498:    LDA  3,1(3) 	pop env
2499:    LDA  3,1(3) 	pop parameters
2500:    LDA  3,-1(3) 	stack expand
2501:    LDA  0,-12(2) 	load id adress
2502:   PUSH  0,0(6) 	push array adress to mp
2503:    POP  1,0,6 	load adress of lhs struct
2504:    LDC  0,0,0 	load offset of member
2505:    ADD  0,0,1 	compute the real adress if pointK
2506:   PUSH  0,0(6) 	
2507:    POP  0,0(6) 	load adress from mp
2508:     LD  1,0(0) 	copy bytes
2509:   PUSH  1,0(6) 	push a.x value into tmp
2510:    POP  1,0,6 	load adress of lhs struct
2511:    LDC  0,1,0 	load offset of member
2512:    ADD  0,0,1 	compute the real adress if pointK
2513:   PUSH  0,0(6) 	
2514:    POP  0,0(6) 	load adress from mp
2515:     LD  1,0(0) 	copy bytes
2516:   PUSH  1,0(6) 	push a.x value into tmp
2517:    LDA  0,-14(2) 	load id adress
2518:   PUSH  0,0(6) 	push array adress to mp
2519:    POP  1,0(6) 	move the adress of ID
2520:    POP  0,0(6) 	copy bytes
2521:     ST  0,0(1) 	copy bytes
* while stmt:
2522:  LABEL  60,0,0 	generate label
2523:     LD  0,-14(2) 	load id value
2524:   PUSH  0,0(6) 	store exp
2525:     LD  0,-5(5) 	load id value
2526:   PUSH  0,0(6) 	store exp
2527:    POP  1,0(6) 	pop right
2528:    POP  0,0(6) 	pop left
2529:    SUB  0,0,1 	op ==, convertd_type
2530:    JNE  0,2(7) 	br if true
2531:    LDC  0,0(0) 	false case
2532:    LDA  7,1(7) 	unconditional jmp
2533:    LDC  0,1(0) 	true case
2534:   PUSH  0,0(6) 	
2535:    POP  0,0(6) 	pop from the mp
2536:    JNE  0,1,7 	true case:, skip the break, execute the block code
2537:     GO  61,0,0 	go to label
2538:     LD  0,-14(2) 	load id value
2539:   PUSH  0,0(6) 	store exp
2540:    POP  1,0,6 	load adress of lhs struct
2541:    LDC  0,2,0 	load offset of member
2542:    ADD  0,0,1 	compute the real adress if pointK
2543:   PUSH  0,0(6) 	
2544:    POP  0,0(6) 	load adress from mp
2545:     LD  1,0(0) 	copy bytes
2546:   PUSH  1,0(6) 	push a.x value into tmp
2547:    POP  0,0(6) 	pop the adress
2548:     LD  1,0(0) 	load bytes
2549:   PUSH  1,0(6) 	push bytes 
2550:    POP  0,0(6) 	move result to register
2551:    OUT  0,0,0 	output value in register[ac / fac]
2552:     LD  0,-14(2) 	load id value
2553:   PUSH  0,0(6) 	store exp
2554:    POP  1,0,6 	load adress of lhs struct
2555:    LDC  0,1,0 	load offset of member
2556:    ADD  0,0,1 	compute the real adress if pointK
2557:   PUSH  0,0(6) 	
2558:    POP  0,0(6) 	load adress from mp
2559:     LD  1,0(0) 	copy bytes
2560:   PUSH  1,0(6) 	push a.x value into tmp
2561:    LDA  0,-14(2) 	load id adress
2562:   PUSH  0,0(6) 	push array adress to mp
2563:    POP  1,0(6) 	move the adress of ID
2564:    POP  0,0(6) 	copy bytes
2565:     ST  0,0(1) 	copy bytes
2566:     GO  60,0,0 	go to label
2567:  LABEL  61,0,0 	generate label
2568:    MOV  3,2,0 	restore the caller sp
2569:     LD  2,0(2) 	resotre the caller fp
2570:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
2571:  LABEL  58,0,0 	generate label
* function entry:
* test_removeList
2572:    LDA  3,-1(3) 	stack expand for function variable
2573:    LDC  0,2576(0) 	get function adress
2574:     ST  0,-15(5) 	set function adress
2575:     GO  62,0,0 	go to label
2576:    MOV  1,2,0 	store the caller fp temporarily
2577:    MOV  2,3,0 	exchang the stack(context)
2578:   PUSH  1,0(3) 	push the caller fp
2579:   PUSH  0,0(3) 	push the return adress
2580:    LDA  3,-11(3) 	stack expand
2581:    LDC  1,195(0) 	get function adress from struct
2582:     ST  1,4(3) 	Init Struct Instance
2583:    LDC  1,205(0) 	get function adress from struct
2584:     ST  1,5(3) 	Init Struct Instance
2585:    LDC  1,215(0) 	get function adress from struct
2586:     ST  1,6(3) 	Init Struct Instance
2587:    LDC  1,225(0) 	get function adress from struct
2588:     ST  1,7(3) 	Init Struct Instance
2589:    LDC  1,539(0) 	get function adress from struct
2590:     ST  1,8(3) 	Init Struct Instance
2591:    LDC  1,662(0) 	get function adress from struct
2592:     ST  1,9(3) 	Init Struct Instance
2593:    LDC  1,928(0) 	get function adress from struct
2594:     ST  1,10(3) 	Init Struct Instance
2595:    LDC  1,1084(0) 	get function adress from struct
2596:     ST  1,11(3) 	Init Struct Instance
2597:     LD  0,1(2) 	load env
2598:   PUSH  0,0(3) 	store env
* call function: 
* makeList
2599:     LD  0,-12(5) 	load id value
2600:   PUSH  0,0(6) 	store exp
2601:    LDC  0,2603(0) 	store the return adress
2602:    POP  7,0(6) 	ujp to the function body
2603:    LDA  3,0(3) 	pop parameters
2604:    LDA  3,1(3) 	pop env
2605:    LDA  0,-12(2) 	load id adress
2606:   PUSH  0,0(6) 	push array adress to mp
2607:    POP  1,0(6) 	move the adress of ID
2608:    POP  0,0(6) 	copy bytes
2609:     ST  0,10(1) 	copy bytes
2610:    POP  0,0(6) 	copy bytes
2611:     ST  0,9(1) 	copy bytes
2612:    POP  0,0(6) 	copy bytes
2613:     ST  0,8(1) 	copy bytes
2614:    POP  0,0(6) 	copy bytes
2615:     ST  0,7(1) 	copy bytes
2616:    POP  0,0(6) 	copy bytes
2617:     ST  0,6(1) 	copy bytes
2618:    POP  0,0(6) 	copy bytes
2619:     ST  0,5(1) 	copy bytes
2620:    POP  0,0(6) 	copy bytes
2621:     ST  0,4(1) 	copy bytes
2622:    POP  0,0(6) 	copy bytes
2623:     ST  0,3(1) 	copy bytes
2624:    POP  0,0(6) 	copy bytes
2625:     ST  0,2(1) 	copy bytes
2626:    POP  0,0(6) 	copy bytes
2627:     ST  0,1(1) 	copy bytes
2628:    POP  0,0(6) 	copy bytes
2629:     ST  0,0(1) 	copy bytes
2630:    LDA  3,-1(3) 	stack expand
2631:    LDC  0,100(0) 	load integer const
2632:   PUSH  0,0(6) 	store exp
2633:    LDA  0,-13(2) 	load id adress
2634:   PUSH  0,0(6) 	push array adress to mp
2635:    POP  1,0(6) 	move the adress of ID
2636:    POP  0,0(6) 	copy bytes
2637:     ST  0,0(1) 	copy bytes
* push function parameters
* push function parameters
2638:    LDC  0,1(0) 	load integer const
2639:   PUSH  0,0(6) 	store exp
2640:    POP  0,0(6) 	pop right
2641:    NEG  0,0,0 	single op (-)
2642:   PUSH  0,0(6) 	op: load left
2643:    POP  0,0(6) 	copy bytes
2644:   PUSH  0,0(3) 	PUSH bytes
2645:     LD  0,1(2) 	load env
2646:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2647:     LD  0,-11(5) 	load id value
2648:   PUSH  0,0(6) 	store exp
2649:    LDC  0,2651(0) 	store the return adress
2650:    POP  7,0(6) 	ujp to the function body
2651:    LDA  3,1(3) 	pop parameters
2652:    LDA  3,1(3) 	pop env
2653:    POP  0,0(6) 	copy bytes
2654:   PUSH  0,0(3) 	PUSH bytes
2655:    LDA  0,-12(2) 	load id adress
2656:   PUSH  0,0(6) 	push array adress to mp
2657:    POP  0,0(6) 	
2658:   PUSH  0,0(3) 	
2659:    LDA  0,0(2) 	load env
2660:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2661:    LDA  0,-12(2) 	load id adress
2662:   PUSH  0,0(6) 	push array adress to mp
2663:    POP  1,0,6 	load adress of lhs struct
2664:    LDC  0,8,0 	load offset of member
2665:    ADD  0,0,1 	compute the real adress if pointK
2666:   PUSH  0,0(6) 	
2667:    POP  0,0(6) 	load adress from mp
2668:     LD  1,0(0) 	copy bytes
2669:   PUSH  1,0(6) 	push a.x value into tmp
2670:    LDC  0,2672(0) 	store the return adress
2671:    POP  7,0(6) 	ujp to the function body
2672:    LDA  3,1(3) 	pop parameters
2673:    LDA  3,1(3) 	pop env
2674:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2675:    LDC  0,1(0) 	load integer const
2676:   PUSH  0,0(6) 	store exp
2677:    POP  0,0(6) 	copy bytes
2678:   PUSH  0,0(3) 	PUSH bytes
2679:     LD  0,1(2) 	load env
2680:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2681:     LD  0,-11(5) 	load id value
2682:   PUSH  0,0(6) 	store exp
2683:    LDC  0,2685(0) 	store the return adress
2684:    POP  7,0(6) 	ujp to the function body
2685:    LDA  3,1(3) 	pop parameters
2686:    LDA  3,1(3) 	pop env
2687:    POP  0,0(6) 	copy bytes
2688:   PUSH  0,0(3) 	PUSH bytes
2689:    LDA  0,-12(2) 	load id adress
2690:   PUSH  0,0(6) 	push array adress to mp
2691:    POP  0,0(6) 	
2692:   PUSH  0,0(3) 	
2693:    LDA  0,0(2) 	load env
2694:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2695:    LDA  0,-12(2) 	load id adress
2696:   PUSH  0,0(6) 	push array adress to mp
2697:    POP  1,0,6 	load adress of lhs struct
2698:    LDC  0,8,0 	load offset of member
2699:    ADD  0,0,1 	compute the real adress if pointK
2700:   PUSH  0,0(6) 	
2701:    POP  0,0(6) 	load adress from mp
2702:     LD  1,0(0) 	copy bytes
2703:   PUSH  1,0(6) 	push a.x value into tmp
2704:    LDC  0,2706(0) 	store the return adress
2705:    POP  7,0(6) 	ujp to the function body
2706:    LDA  3,1(3) 	pop parameters
2707:    LDA  3,1(3) 	pop env
2708:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2709:    LDC  0,20(0) 	load integer const
2710:   PUSH  0,0(6) 	store exp
2711:    POP  0,0(6) 	pop right
2712:    NEG  0,0,0 	single op (-)
2713:   PUSH  0,0(6) 	op: load left
2714:    POP  0,0(6) 	copy bytes
2715:   PUSH  0,0(3) 	PUSH bytes
2716:     LD  0,1(2) 	load env
2717:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2718:     LD  0,-11(5) 	load id value
2719:   PUSH  0,0(6) 	store exp
2720:    LDC  0,2722(0) 	store the return adress
2721:    POP  7,0(6) 	ujp to the function body
2722:    LDA  3,1(3) 	pop parameters
2723:    LDA  3,1(3) 	pop env
2724:    POP  0,0(6) 	copy bytes
2725:   PUSH  0,0(3) 	PUSH bytes
2726:    LDA  0,-12(2) 	load id adress
2727:   PUSH  0,0(6) 	push array adress to mp
2728:    POP  0,0(6) 	
2729:   PUSH  0,0(3) 	
2730:    LDA  0,0(2) 	load env
2731:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2732:    LDA  0,-12(2) 	load id adress
2733:   PUSH  0,0(6) 	push array adress to mp
2734:    POP  1,0,6 	load adress of lhs struct
2735:    LDC  0,8,0 	load offset of member
2736:    ADD  0,0,1 	compute the real adress if pointK
2737:   PUSH  0,0(6) 	
2738:    POP  0,0(6) 	load adress from mp
2739:     LD  1,0(0) 	copy bytes
2740:   PUSH  1,0(6) 	push a.x value into tmp
2741:    LDC  0,2743(0) 	store the return adress
2742:    POP  7,0(6) 	ujp to the function body
2743:    LDA  3,1(3) 	pop parameters
2744:    LDA  3,1(3) 	pop env
2745:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2746:    LDC  0,100(0) 	load integer const
2747:   PUSH  0,0(6) 	store exp
2748:    POP  0,0(6) 	copy bytes
2749:   PUSH  0,0(3) 	PUSH bytes
2750:     LD  0,1(2) 	load env
2751:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2752:     LD  0,-11(5) 	load id value
2753:   PUSH  0,0(6) 	store exp
2754:    LDC  0,2756(0) 	store the return adress
2755:    POP  7,0(6) 	ujp to the function body
2756:    LDA  3,1(3) 	pop parameters
2757:    LDA  3,1(3) 	pop env
2758:    POP  0,0(6) 	copy bytes
2759:   PUSH  0,0(3) 	PUSH bytes
2760:    LDA  0,-12(2) 	load id adress
2761:   PUSH  0,0(6) 	push array adress to mp
2762:    POP  0,0(6) 	
2763:   PUSH  0,0(3) 	
2764:    LDA  0,0(2) 	load env
2765:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2766:    LDA  0,-12(2) 	load id adress
2767:   PUSH  0,0(6) 	push array adress to mp
2768:    POP  1,0,6 	load adress of lhs struct
2769:    LDC  0,8,0 	load offset of member
2770:    ADD  0,0,1 	compute the real adress if pointK
2771:   PUSH  0,0(6) 	
2772:    POP  0,0(6) 	load adress from mp
2773:     LD  1,0(0) 	copy bytes
2774:   PUSH  1,0(6) 	push a.x value into tmp
2775:    LDC  0,2777(0) 	store the return adress
2776:    POP  7,0(6) 	ujp to the function body
2777:    LDA  3,1(3) 	pop parameters
2778:    LDA  3,1(3) 	pop env
2779:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2780:    LDC  0,2001515(0) 	load integer const
2781:   PUSH  0,0(6) 	store exp
2782:    POP  0,0(6) 	copy bytes
2783:   PUSH  0,0(3) 	PUSH bytes
2784:     LD  0,1(2) 	load env
2785:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2786:     LD  0,-11(5) 	load id value
2787:   PUSH  0,0(6) 	store exp
2788:    LDC  0,2790(0) 	store the return adress
2789:    POP  7,0(6) 	ujp to the function body
2790:    LDA  3,1(3) 	pop parameters
2791:    LDA  3,1(3) 	pop env
2792:    POP  0,0(6) 	copy bytes
2793:   PUSH  0,0(3) 	PUSH bytes
2794:    LDA  0,-12(2) 	load id adress
2795:   PUSH  0,0(6) 	push array adress to mp
2796:    POP  0,0(6) 	
2797:   PUSH  0,0(3) 	
2798:    LDA  0,0(2) 	load env
2799:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2800:    LDA  0,-12(2) 	load id adress
2801:   PUSH  0,0(6) 	push array adress to mp
2802:    POP  1,0,6 	load adress of lhs struct
2803:    LDC  0,8,0 	load offset of member
2804:    ADD  0,0,1 	compute the real adress if pointK
2805:   PUSH  0,0(6) 	
2806:    POP  0,0(6) 	load adress from mp
2807:     LD  1,0(0) 	copy bytes
2808:   PUSH  1,0(6) 	push a.x value into tmp
2809:    LDC  0,2811(0) 	store the return adress
2810:    POP  7,0(6) 	ujp to the function body
2811:    LDA  3,1(3) 	pop parameters
2812:    LDA  3,1(3) 	pop env
2813:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2814:    LDC  0,5453(0) 	load integer const
2815:   PUSH  0,0(6) 	store exp
2816:    POP  0,0(6) 	copy bytes
2817:   PUSH  0,0(3) 	PUSH bytes
2818:     LD  0,1(2) 	load env
2819:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2820:     LD  0,-11(5) 	load id value
2821:   PUSH  0,0(6) 	store exp
2822:    LDC  0,2824(0) 	store the return adress
2823:    POP  7,0(6) 	ujp to the function body
2824:    LDA  3,1(3) 	pop parameters
2825:    LDA  3,1(3) 	pop env
2826:    POP  0,0(6) 	copy bytes
2827:   PUSH  0,0(3) 	PUSH bytes
2828:    LDA  0,-12(2) 	load id adress
2829:   PUSH  0,0(6) 	push array adress to mp
2830:    POP  0,0(6) 	
2831:   PUSH  0,0(3) 	
2832:    LDA  0,0(2) 	load env
2833:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2834:    LDA  0,-12(2) 	load id adress
2835:   PUSH  0,0(6) 	push array adress to mp
2836:    POP  1,0,6 	load adress of lhs struct
2837:    LDC  0,8,0 	load offset of member
2838:    ADD  0,0,1 	compute the real adress if pointK
2839:   PUSH  0,0(6) 	
2840:    POP  0,0(6) 	load adress from mp
2841:     LD  1,0(0) 	copy bytes
2842:   PUSH  1,0(6) 	push a.x value into tmp
2843:    LDC  0,2845(0) 	store the return adress
2844:    POP  7,0(6) 	ujp to the function body
2845:    LDA  3,1(3) 	pop parameters
2846:    LDA  3,1(3) 	pop env
2847:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
2848:    LDC  0,5675541(0) 	load integer const
2849:   PUSH  0,0(6) 	store exp
2850:    POP  0,0(6) 	copy bytes
2851:   PUSH  0,0(3) 	PUSH bytes
2852:     LD  0,1(2) 	load env
2853:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
2854:     LD  0,-11(5) 	load id value
2855:   PUSH  0,0(6) 	store exp
2856:    LDC  0,2858(0) 	store the return adress
2857:    POP  7,0(6) 	ujp to the function body
2858:    LDA  3,1(3) 	pop parameters
2859:    LDA  3,1(3) 	pop env
2860:    POP  0,0(6) 	copy bytes
2861:   PUSH  0,0(3) 	PUSH bytes
2862:    LDA  0,-12(2) 	load id adress
2863:   PUSH  0,0(6) 	push array adress to mp
2864:    POP  0,0(6) 	
2865:   PUSH  0,0(3) 	
2866:    LDA  0,0(2) 	load env
2867:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
2868:    LDA  0,-12(2) 	load id adress
2869:   PUSH  0,0(6) 	push array adress to mp
2870:    POP  1,0,6 	load adress of lhs struct
2871:    LDC  0,8,0 	load offset of member
2872:    ADD  0,0,1 	compute the real adress if pointK
2873:   PUSH  0,0(6) 	
2874:    POP  0,0(6) 	load adress from mp
2875:     LD  1,0(0) 	copy bytes
2876:   PUSH  1,0(6) 	push a.x value into tmp
2877:    LDC  0,2879(0) 	store the return adress
2878:    POP  7,0(6) 	ujp to the function body
2879:    LDA  3,1(3) 	pop parameters
2880:    LDA  3,1(3) 	pop env
2881:    LDA  3,1(3) 	pop parameters
2882:    LDA  3,-1(3) 	stack expand
2883:    LDA  0,-12(2) 	load id adress
2884:   PUSH  0,0(6) 	push array adress to mp
2885:    POP  1,0,6 	load adress of lhs struct
2886:    LDC  0,0,0 	load offset of member
2887:    ADD  0,0,1 	compute the real adress if pointK
2888:   PUSH  0,0(6) 	
2889:    POP  0,0(6) 	load adress from mp
2890:     LD  1,0(0) 	copy bytes
2891:   PUSH  1,0(6) 	push a.x value into tmp
2892:    POP  1,0,6 	load adress of lhs struct
2893:    LDC  0,1,0 	load offset of member
2894:    ADD  0,0,1 	compute the real adress if pointK
2895:   PUSH  0,0(6) 	
2896:    POP  0,0(6) 	load adress from mp
2897:     LD  1,0(0) 	copy bytes
2898:   PUSH  1,0(6) 	push a.x value into tmp
2899:    LDA  0,-14(2) 	load id adress
2900:   PUSH  0,0(6) 	push array adress to mp
2901:    POP  1,0(6) 	move the adress of ID
2902:    POP  0,0(6) 	copy bytes
2903:     ST  0,0(1) 	copy bytes
* push function parameters
2904:    LDA  0,-13(2) 	load id adress
2905:   PUSH  0,0(6) 	push array adress to mp
2906:    POP  0,0(6) 	copy bytes
2907:   PUSH  0,0(3) 	PUSH bytes
2908:    LDA  0,-12(2) 	load id adress
2909:   PUSH  0,0(6) 	push array adress to mp
2910:    POP  0,0(6) 	
2911:   PUSH  0,0(3) 	
2912:    LDA  0,0(2) 	load env
2913:   PUSH  0,0(3) 	store env
* call function: 
* removeList
2914:    LDA  0,-12(2) 	load id adress
2915:   PUSH  0,0(6) 	push array adress to mp
2916:    POP  1,0,6 	load adress of lhs struct
2917:    LDC  0,6,0 	load offset of member
2918:    ADD  0,0,1 	compute the real adress if pointK
2919:   PUSH  0,0(6) 	
2920:    POP  0,0(6) 	load adress from mp
2921:     LD  1,0(0) 	copy bytes
2922:   PUSH  1,0(6) 	push a.x value into tmp
2923:    LDC  0,2925(0) 	store the return adress
2924:    POP  7,0(6) 	ujp to the function body
2925:    LDA  3,1(3) 	pop parameters
2926:    LDA  3,1(3) 	pop env
2927:    LDA  3,1(3) 	pop parameters
2928:    LDC  0,2001515(0) 	load integer const
2929:   PUSH  0,0(6) 	store exp
2930:    LDA  0,-13(2) 	load id adress
2931:   PUSH  0,0(6) 	push array adress to mp
2932:    POP  1,0(6) 	move the adress of ID
2933:    POP  0,0(6) 	copy bytes
2934:     ST  0,0(1) 	copy bytes
* push function parameters
2935:    LDA  0,-13(2) 	load id adress
2936:   PUSH  0,0(6) 	push array adress to mp
2937:    POP  0,0(6) 	copy bytes
2938:   PUSH  0,0(3) 	PUSH bytes
2939:    LDA  0,-12(2) 	load id adress
2940:   PUSH  0,0(6) 	push array adress to mp
2941:    POP  0,0(6) 	
2942:   PUSH  0,0(3) 	
2943:    LDA  0,0(2) 	load env
2944:   PUSH  0,0(3) 	store env
* call function: 
* removeList
2945:    LDA  0,-12(2) 	load id adress
2946:   PUSH  0,0(6) 	push array adress to mp
2947:    POP  1,0,6 	load adress of lhs struct
2948:    LDC  0,6,0 	load offset of member
2949:    ADD  0,0,1 	compute the real adress if pointK
2950:   PUSH  0,0(6) 	
2951:    POP  0,0(6) 	load adress from mp
2952:     LD  1,0(0) 	copy bytes
2953:   PUSH  1,0(6) 	push a.x value into tmp
2954:    LDC  0,2956(0) 	store the return adress
2955:    POP  7,0(6) 	ujp to the function body
2956:    LDA  3,1(3) 	pop parameters
2957:    LDA  3,1(3) 	pop env
2958:    LDA  3,1(3) 	pop parameters
2959:    LDC  0,5453(0) 	load integer const
2960:   PUSH  0,0(6) 	store exp
2961:    LDA  0,-13(2) 	load id adress
2962:   PUSH  0,0(6) 	push array adress to mp
2963:    POP  1,0(6) 	move the adress of ID
2964:    POP  0,0(6) 	copy bytes
2965:     ST  0,0(1) 	copy bytes
* push function parameters
2966:    LDA  0,-13(2) 	load id adress
2967:   PUSH  0,0(6) 	push array adress to mp
2968:    POP  0,0(6) 	copy bytes
2969:   PUSH  0,0(3) 	PUSH bytes
2970:    LDA  0,-12(2) 	load id adress
2971:   PUSH  0,0(6) 	push array adress to mp
2972:    POP  0,0(6) 	
2973:   PUSH  0,0(3) 	
2974:    LDA  0,0(2) 	load env
2975:   PUSH  0,0(3) 	store env
* call function: 
* removeList
2976:    LDA  0,-12(2) 	load id adress
2977:   PUSH  0,0(6) 	push array adress to mp
2978:    POP  1,0,6 	load adress of lhs struct
2979:    LDC  0,6,0 	load offset of member
2980:    ADD  0,0,1 	compute the real adress if pointK
2981:   PUSH  0,0(6) 	
2982:    POP  0,0(6) 	load adress from mp
2983:     LD  1,0(0) 	copy bytes
2984:   PUSH  1,0(6) 	push a.x value into tmp
2985:    LDC  0,2987(0) 	store the return adress
2986:    POP  7,0(6) 	ujp to the function body
2987:    LDA  3,1(3) 	pop parameters
2988:    LDA  3,1(3) 	pop env
2989:    LDA  3,1(3) 	pop parameters
2990:    LDA  0,-12(2) 	load id adress
2991:   PUSH  0,0(6) 	push array adress to mp
2992:    POP  1,0,6 	load adress of lhs struct
2993:    LDC  0,0,0 	load offset of member
2994:    ADD  0,0,1 	compute the real adress if pointK
2995:   PUSH  0,0(6) 	
2996:    POP  0,0(6) 	load adress from mp
2997:     LD  1,0(0) 	copy bytes
2998:   PUSH  1,0(6) 	push a.x value into tmp
2999:    POP  1,0,6 	load adress of lhs struct
3000:    LDC  0,1,0 	load offset of member
3001:    ADD  0,0,1 	compute the real adress if pointK
3002:   PUSH  0,0(6) 	
3003:    POP  0,0(6) 	load adress from mp
3004:     LD  1,0(0) 	copy bytes
3005:   PUSH  1,0(6) 	push a.x value into tmp
3006:    LDA  0,-14(2) 	load id adress
3007:   PUSH  0,0(6) 	push array adress to mp
3008:    POP  1,0(6) 	move the adress of ID
3009:    POP  0,0(6) 	copy bytes
3010:     ST  0,0(1) 	copy bytes
* while stmt:
3011:  LABEL  63,0,0 	generate label
3012:     LD  0,-14(2) 	load id value
3013:   PUSH  0,0(6) 	store exp
3014:     LD  0,-5(5) 	load id value
3015:   PUSH  0,0(6) 	store exp
3016:    POP  1,0(6) 	pop right
3017:    POP  0,0(6) 	pop left
3018:    SUB  0,0,1 	op ==, convertd_type
3019:    JNE  0,2(7) 	br if true
3020:    LDC  0,0(0) 	false case
3021:    LDA  7,1(7) 	unconditional jmp
3022:    LDC  0,1(0) 	true case
3023:   PUSH  0,0(6) 	
3024:    POP  0,0(6) 	pop from the mp
3025:    JNE  0,1,7 	true case:, skip the break, execute the block code
3026:     GO  64,0,0 	go to label
3027:     LD  0,-14(2) 	load id value
3028:   PUSH  0,0(6) 	store exp
3029:    POP  1,0,6 	load adress of lhs struct
3030:    LDC  0,2,0 	load offset of member
3031:    ADD  0,0,1 	compute the real adress if pointK
3032:   PUSH  0,0(6) 	
3033:    POP  0,0(6) 	load adress from mp
3034:     LD  1,0(0) 	copy bytes
3035:   PUSH  1,0(6) 	push a.x value into tmp
3036:    POP  0,0(6) 	pop the adress
3037:     LD  1,0(0) 	load bytes
3038:   PUSH  1,0(6) 	push bytes 
3039:    POP  0,0(6) 	move result to register
3040:    OUT  0,0,0 	output value in register[ac / fac]
3041:     LD  0,-14(2) 	load id value
3042:   PUSH  0,0(6) 	store exp
3043:    POP  1,0,6 	load adress of lhs struct
3044:    LDC  0,1,0 	load offset of member
3045:    ADD  0,0,1 	compute the real adress if pointK
3046:   PUSH  0,0(6) 	
3047:    POP  0,0(6) 	load adress from mp
3048:     LD  1,0(0) 	copy bytes
3049:   PUSH  1,0(6) 	push a.x value into tmp
3050:    LDA  0,-14(2) 	load id adress
3051:   PUSH  0,0(6) 	push array adress to mp
3052:    POP  1,0(6) 	move the adress of ID
3053:    POP  0,0(6) 	copy bytes
3054:     ST  0,0(1) 	copy bytes
3055:     GO  63,0,0 	go to label
3056:  LABEL  64,0,0 	generate label
3057:    MOV  3,2,0 	restore the caller sp
3058:     LD  2,0(2) 	resotre the caller fp
3059:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3060:  LABEL  62,0,0 	generate label
* function entry:
* test_pop
3061:    LDA  3,-1(3) 	stack expand for function variable
3062:    LDC  0,3065(0) 	get function adress
3063:     ST  0,-16(5) 	set function adress
3064:     GO  65,0,0 	go to label
3065:    MOV  1,2,0 	store the caller fp temporarily
3066:    MOV  2,3,0 	exchang the stack(context)
3067:   PUSH  1,0(3) 	push the caller fp
3068:   PUSH  0,0(3) 	push the return adress
3069:    LDA  3,-11(3) 	stack expand
3070:    LDC  1,195(0) 	get function adress from struct
3071:     ST  1,4(3) 	Init Struct Instance
3072:    LDC  1,205(0) 	get function adress from struct
3073:     ST  1,5(3) 	Init Struct Instance
3074:    LDC  1,215(0) 	get function adress from struct
3075:     ST  1,6(3) 	Init Struct Instance
3076:    LDC  1,225(0) 	get function adress from struct
3077:     ST  1,7(3) 	Init Struct Instance
3078:    LDC  1,539(0) 	get function adress from struct
3079:     ST  1,8(3) 	Init Struct Instance
3080:    LDC  1,662(0) 	get function adress from struct
3081:     ST  1,9(3) 	Init Struct Instance
3082:    LDC  1,928(0) 	get function adress from struct
3083:     ST  1,10(3) 	Init Struct Instance
3084:    LDC  1,1084(0) 	get function adress from struct
3085:     ST  1,11(3) 	Init Struct Instance
3086:     LD  0,1(2) 	load env
3087:   PUSH  0,0(3) 	store env
* call function: 
* makeList
3088:     LD  0,-12(5) 	load id value
3089:   PUSH  0,0(6) 	store exp
3090:    LDC  0,3092(0) 	store the return adress
3091:    POP  7,0(6) 	ujp to the function body
3092:    LDA  3,0(3) 	pop parameters
3093:    LDA  3,1(3) 	pop env
3094:    LDA  0,-12(2) 	load id adress
3095:   PUSH  0,0(6) 	push array adress to mp
3096:    POP  1,0(6) 	move the adress of ID
3097:    POP  0,0(6) 	copy bytes
3098:     ST  0,10(1) 	copy bytes
3099:    POP  0,0(6) 	copy bytes
3100:     ST  0,9(1) 	copy bytes
3101:    POP  0,0(6) 	copy bytes
3102:     ST  0,8(1) 	copy bytes
3103:    POP  0,0(6) 	copy bytes
3104:     ST  0,7(1) 	copy bytes
3105:    POP  0,0(6) 	copy bytes
3106:     ST  0,6(1) 	copy bytes
3107:    POP  0,0(6) 	copy bytes
3108:     ST  0,5(1) 	copy bytes
3109:    POP  0,0(6) 	copy bytes
3110:     ST  0,4(1) 	copy bytes
3111:    POP  0,0(6) 	copy bytes
3112:     ST  0,3(1) 	copy bytes
3113:    POP  0,0(6) 	copy bytes
3114:     ST  0,2(1) 	copy bytes
3115:    POP  0,0(6) 	copy bytes
3116:     ST  0,1(1) 	copy bytes
3117:    POP  0,0(6) 	copy bytes
3118:     ST  0,0(1) 	copy bytes
* push function parameters
* push function parameters
3119:    LDC  0,1(0) 	load integer const
3120:   PUSH  0,0(6) 	store exp
3121:    POP  0,0(6) 	pop right
3122:    NEG  0,0,0 	single op (-)
3123:   PUSH  0,0(6) 	op: load left
3124:    POP  0,0(6) 	copy bytes
3125:   PUSH  0,0(3) 	PUSH bytes
3126:     LD  0,1(2) 	load env
3127:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3128:     LD  0,-11(5) 	load id value
3129:   PUSH  0,0(6) 	store exp
3130:    LDC  0,3132(0) 	store the return adress
3131:    POP  7,0(6) 	ujp to the function body
3132:    LDA  3,1(3) 	pop parameters
3133:    LDA  3,1(3) 	pop env
3134:    POP  0,0(6) 	copy bytes
3135:   PUSH  0,0(3) 	PUSH bytes
3136:    LDA  0,-12(2) 	load id adress
3137:   PUSH  0,0(6) 	push array adress to mp
3138:    POP  0,0(6) 	
3139:   PUSH  0,0(3) 	
3140:    LDA  0,0(2) 	load env
3141:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3142:    LDA  0,-12(2) 	load id adress
3143:   PUSH  0,0(6) 	push array adress to mp
3144:    POP  1,0,6 	load adress of lhs struct
3145:    LDC  0,8,0 	load offset of member
3146:    ADD  0,0,1 	compute the real adress if pointK
3147:   PUSH  0,0(6) 	
3148:    POP  0,0(6) 	load adress from mp
3149:     LD  1,0(0) 	copy bytes
3150:   PUSH  1,0(6) 	push a.x value into tmp
3151:    LDC  0,3153(0) 	store the return adress
3152:    POP  7,0(6) 	ujp to the function body
3153:    LDA  3,1(3) 	pop parameters
3154:    LDA  3,1(3) 	pop env
3155:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3156:    LDC  0,1(0) 	load integer const
3157:   PUSH  0,0(6) 	store exp
3158:    POP  0,0(6) 	copy bytes
3159:   PUSH  0,0(3) 	PUSH bytes
3160:     LD  0,1(2) 	load env
3161:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3162:     LD  0,-11(5) 	load id value
3163:   PUSH  0,0(6) 	store exp
3164:    LDC  0,3166(0) 	store the return adress
3165:    POP  7,0(6) 	ujp to the function body
3166:    LDA  3,1(3) 	pop parameters
3167:    LDA  3,1(3) 	pop env
3168:    POP  0,0(6) 	copy bytes
3169:   PUSH  0,0(3) 	PUSH bytes
3170:    LDA  0,-12(2) 	load id adress
3171:   PUSH  0,0(6) 	push array adress to mp
3172:    POP  0,0(6) 	
3173:   PUSH  0,0(3) 	
3174:    LDA  0,0(2) 	load env
3175:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3176:    LDA  0,-12(2) 	load id adress
3177:   PUSH  0,0(6) 	push array adress to mp
3178:    POP  1,0,6 	load adress of lhs struct
3179:    LDC  0,8,0 	load offset of member
3180:    ADD  0,0,1 	compute the real adress if pointK
3181:   PUSH  0,0(6) 	
3182:    POP  0,0(6) 	load adress from mp
3183:     LD  1,0(0) 	copy bytes
3184:   PUSH  1,0(6) 	push a.x value into tmp
3185:    LDC  0,3187(0) 	store the return adress
3186:    POP  7,0(6) 	ujp to the function body
3187:    LDA  3,1(3) 	pop parameters
3188:    LDA  3,1(3) 	pop env
3189:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3190:    LDC  0,20(0) 	load integer const
3191:   PUSH  0,0(6) 	store exp
3192:    POP  0,0(6) 	pop right
3193:    NEG  0,0,0 	single op (-)
3194:   PUSH  0,0(6) 	op: load left
3195:    POP  0,0(6) 	copy bytes
3196:   PUSH  0,0(3) 	PUSH bytes
3197:     LD  0,1(2) 	load env
3198:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3199:     LD  0,-11(5) 	load id value
3200:   PUSH  0,0(6) 	store exp
3201:    LDC  0,3203(0) 	store the return adress
3202:    POP  7,0(6) 	ujp to the function body
3203:    LDA  3,1(3) 	pop parameters
3204:    LDA  3,1(3) 	pop env
3205:    POP  0,0(6) 	copy bytes
3206:   PUSH  0,0(3) 	PUSH bytes
3207:    LDA  0,-12(2) 	load id adress
3208:   PUSH  0,0(6) 	push array adress to mp
3209:    POP  0,0(6) 	
3210:   PUSH  0,0(3) 	
3211:    LDA  0,0(2) 	load env
3212:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3213:    LDA  0,-12(2) 	load id adress
3214:   PUSH  0,0(6) 	push array adress to mp
3215:    POP  1,0,6 	load adress of lhs struct
3216:    LDC  0,8,0 	load offset of member
3217:    ADD  0,0,1 	compute the real adress if pointK
3218:   PUSH  0,0(6) 	
3219:    POP  0,0(6) 	load adress from mp
3220:     LD  1,0(0) 	copy bytes
3221:   PUSH  1,0(6) 	push a.x value into tmp
3222:    LDC  0,3224(0) 	store the return adress
3223:    POP  7,0(6) 	ujp to the function body
3224:    LDA  3,1(3) 	pop parameters
3225:    LDA  3,1(3) 	pop env
3226:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3227:    LDC  0,100(0) 	load integer const
3228:   PUSH  0,0(6) 	store exp
3229:    POP  0,0(6) 	copy bytes
3230:   PUSH  0,0(3) 	PUSH bytes
3231:     LD  0,1(2) 	load env
3232:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3233:     LD  0,-11(5) 	load id value
3234:   PUSH  0,0(6) 	store exp
3235:    LDC  0,3237(0) 	store the return adress
3236:    POP  7,0(6) 	ujp to the function body
3237:    LDA  3,1(3) 	pop parameters
3238:    LDA  3,1(3) 	pop env
3239:    POP  0,0(6) 	copy bytes
3240:   PUSH  0,0(3) 	PUSH bytes
3241:    LDA  0,-12(2) 	load id adress
3242:   PUSH  0,0(6) 	push array adress to mp
3243:    POP  0,0(6) 	
3244:   PUSH  0,0(3) 	
3245:    LDA  0,0(2) 	load env
3246:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3247:    LDA  0,-12(2) 	load id adress
3248:   PUSH  0,0(6) 	push array adress to mp
3249:    POP  1,0,6 	load adress of lhs struct
3250:    LDC  0,8,0 	load offset of member
3251:    ADD  0,0,1 	compute the real adress if pointK
3252:   PUSH  0,0(6) 	
3253:    POP  0,0(6) 	load adress from mp
3254:     LD  1,0(0) 	copy bytes
3255:   PUSH  1,0(6) 	push a.x value into tmp
3256:    LDC  0,3258(0) 	store the return adress
3257:    POP  7,0(6) 	ujp to the function body
3258:    LDA  3,1(3) 	pop parameters
3259:    LDA  3,1(3) 	pop env
3260:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3261:    LDC  0,2001515(0) 	load integer const
3262:   PUSH  0,0(6) 	store exp
3263:    POP  0,0(6) 	copy bytes
3264:   PUSH  0,0(3) 	PUSH bytes
3265:     LD  0,1(2) 	load env
3266:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3267:     LD  0,-11(5) 	load id value
3268:   PUSH  0,0(6) 	store exp
3269:    LDC  0,3271(0) 	store the return adress
3270:    POP  7,0(6) 	ujp to the function body
3271:    LDA  3,1(3) 	pop parameters
3272:    LDA  3,1(3) 	pop env
3273:    POP  0,0(6) 	copy bytes
3274:   PUSH  0,0(3) 	PUSH bytes
3275:    LDA  0,-12(2) 	load id adress
3276:   PUSH  0,0(6) 	push array adress to mp
3277:    POP  0,0(6) 	
3278:   PUSH  0,0(3) 	
3279:    LDA  0,0(2) 	load env
3280:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3281:    LDA  0,-12(2) 	load id adress
3282:   PUSH  0,0(6) 	push array adress to mp
3283:    POP  1,0,6 	load adress of lhs struct
3284:    LDC  0,8,0 	load offset of member
3285:    ADD  0,0,1 	compute the real adress if pointK
3286:   PUSH  0,0(6) 	
3287:    POP  0,0(6) 	load adress from mp
3288:     LD  1,0(0) 	copy bytes
3289:   PUSH  1,0(6) 	push a.x value into tmp
3290:    LDC  0,3292(0) 	store the return adress
3291:    POP  7,0(6) 	ujp to the function body
3292:    LDA  3,1(3) 	pop parameters
3293:    LDA  3,1(3) 	pop env
3294:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3295:    LDC  0,5453(0) 	load integer const
3296:   PUSH  0,0(6) 	store exp
3297:    POP  0,0(6) 	copy bytes
3298:   PUSH  0,0(3) 	PUSH bytes
3299:     LD  0,1(2) 	load env
3300:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3301:     LD  0,-11(5) 	load id value
3302:   PUSH  0,0(6) 	store exp
3303:    LDC  0,3305(0) 	store the return adress
3304:    POP  7,0(6) 	ujp to the function body
3305:    LDA  3,1(3) 	pop parameters
3306:    LDA  3,1(3) 	pop env
3307:    POP  0,0(6) 	copy bytes
3308:   PUSH  0,0(3) 	PUSH bytes
3309:    LDA  0,-12(2) 	load id adress
3310:   PUSH  0,0(6) 	push array adress to mp
3311:    POP  0,0(6) 	
3312:   PUSH  0,0(3) 	
3313:    LDA  0,0(2) 	load env
3314:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3315:    LDA  0,-12(2) 	load id adress
3316:   PUSH  0,0(6) 	push array adress to mp
3317:    POP  1,0,6 	load adress of lhs struct
3318:    LDC  0,8,0 	load offset of member
3319:    ADD  0,0,1 	compute the real adress if pointK
3320:   PUSH  0,0(6) 	
3321:    POP  0,0(6) 	load adress from mp
3322:     LD  1,0(0) 	copy bytes
3323:   PUSH  1,0(6) 	push a.x value into tmp
3324:    LDC  0,3326(0) 	store the return adress
3325:    POP  7,0(6) 	ujp to the function body
3326:    LDA  3,1(3) 	pop parameters
3327:    LDA  3,1(3) 	pop env
3328:    LDA  3,1(3) 	pop parameters
* push function parameters
* push function parameters
3329:    LDC  0,5675541(0) 	load integer const
3330:   PUSH  0,0(6) 	store exp
3331:    POP  0,0(6) 	copy bytes
3332:   PUSH  0,0(3) 	PUSH bytes
3333:     LD  0,1(2) 	load env
3334:   PUSH  0,0(3) 	store env
* call function: 
* makeNode
3335:     LD  0,-11(5) 	load id value
3336:   PUSH  0,0(6) 	store exp
3337:    LDC  0,3339(0) 	store the return adress
3338:    POP  7,0(6) 	ujp to the function body
3339:    LDA  3,1(3) 	pop parameters
3340:    LDA  3,1(3) 	pop env
3341:    POP  0,0(6) 	copy bytes
3342:   PUSH  0,0(3) 	PUSH bytes
3343:    LDA  0,-12(2) 	load id adress
3344:   PUSH  0,0(6) 	push array adress to mp
3345:    POP  0,0(6) 	
3346:   PUSH  0,0(3) 	
3347:    LDA  0,0(2) 	load env
3348:   PUSH  0,0(3) 	store env
* call function: 
* insertSortedList
3349:    LDA  0,-12(2) 	load id adress
3350:   PUSH  0,0(6) 	push array adress to mp
3351:    POP  1,0,6 	load adress of lhs struct
3352:    LDC  0,8,0 	load offset of member
3353:    ADD  0,0,1 	compute the real adress if pointK
3354:   PUSH  0,0(6) 	
3355:    POP  0,0(6) 	load adress from mp
3356:     LD  1,0(0) 	copy bytes
3357:   PUSH  1,0(6) 	push a.x value into tmp
3358:    LDC  0,3360(0) 	store the return adress
3359:    POP  7,0(6) 	ujp to the function body
3360:    LDA  3,1(3) 	pop parameters
3361:    LDA  3,1(3) 	pop env
3362:    LDA  3,1(3) 	pop parameters
3363:    LDA  0,-12(2) 	load id adress
3364:   PUSH  0,0(6) 	push array adress to mp
3365:    POP  0,0(6) 	
3366:   PUSH  0,0(3) 	
3367:    LDA  0,0(2) 	load env
3368:   PUSH  0,0(3) 	store env
* call function: 
* popRight
3369:    LDA  0,-12(2) 	load id adress
3370:   PUSH  0,0(6) 	push array adress to mp
3371:    POP  1,0,6 	load adress of lhs struct
3372:    LDC  0,9,0 	load offset of member
3373:    ADD  0,0,1 	compute the real adress if pointK
3374:   PUSH  0,0(6) 	
3375:    POP  0,0(6) 	load adress from mp
3376:     LD  1,0(0) 	copy bytes
3377:   PUSH  1,0(6) 	push a.x value into tmp
3378:    LDC  0,3380(0) 	store the return adress
3379:    POP  7,0(6) 	ujp to the function body
3380:    LDA  3,0(3) 	pop parameters
3381:    LDA  3,1(3) 	pop env
3382:    LDA  3,1(3) 	pop parameters
3383:    LDA  0,-12(2) 	load id adress
3384:   PUSH  0,0(6) 	push array adress to mp
3385:    POP  0,0(6) 	
3386:   PUSH  0,0(3) 	
3387:    LDA  0,0(2) 	load env
3388:   PUSH  0,0(3) 	store env
* call function: 
* popLeft
3389:    LDA  0,-12(2) 	load id adress
3390:   PUSH  0,0(6) 	push array adress to mp
3391:    POP  1,0,6 	load adress of lhs struct
3392:    LDC  0,10,0 	load offset of member
3393:    ADD  0,0,1 	compute the real adress if pointK
3394:   PUSH  0,0(6) 	
3395:    POP  0,0(6) 	load adress from mp
3396:     LD  1,0(0) 	copy bytes
3397:   PUSH  1,0(6) 	push a.x value into tmp
3398:    LDC  0,3400(0) 	store the return adress
3399:    POP  7,0(6) 	ujp to the function body
3400:    LDA  3,0(3) 	pop parameters
3401:    LDA  3,1(3) 	pop env
3402:    LDA  3,1(3) 	pop parameters
3403:    LDA  0,-12(2) 	load id adress
3404:   PUSH  0,0(6) 	push array adress to mp
3405:    POP  0,0(6) 	
3406:   PUSH  0,0(3) 	
3407:    LDA  0,0(2) 	load env
3408:   PUSH  0,0(3) 	store env
* call function: 
* popLeft
3409:    LDA  0,-12(2) 	load id adress
3410:   PUSH  0,0(6) 	push array adress to mp
3411:    POP  1,0,6 	load adress of lhs struct
3412:    LDC  0,10,0 	load offset of member
3413:    ADD  0,0,1 	compute the real adress if pointK
3414:   PUSH  0,0(6) 	
3415:    POP  0,0(6) 	load adress from mp
3416:     LD  1,0(0) 	copy bytes
3417:   PUSH  1,0(6) 	push a.x value into tmp
3418:    LDC  0,3420(0) 	store the return adress
3419:    POP  7,0(6) 	ujp to the function body
3420:    LDA  3,0(3) 	pop parameters
3421:    LDA  3,1(3) 	pop env
3422:    LDA  3,1(3) 	pop parameters
3423:    LDA  3,-1(3) 	stack expand
3424:    LDA  0,-12(2) 	load id adress
3425:   PUSH  0,0(6) 	push array adress to mp
3426:    POP  1,0,6 	load adress of lhs struct
3427:    LDC  0,0,0 	load offset of member
3428:    ADD  0,0,1 	compute the real adress if pointK
3429:   PUSH  0,0(6) 	
3430:    POP  0,0(6) 	load adress from mp
3431:     LD  1,0(0) 	copy bytes
3432:   PUSH  1,0(6) 	push a.x value into tmp
3433:    POP  1,0,6 	load adress of lhs struct
3434:    LDC  0,1,0 	load offset of member
3435:    ADD  0,0,1 	compute the real adress if pointK
3436:   PUSH  0,0(6) 	
3437:    POP  0,0(6) 	load adress from mp
3438:     LD  1,0(0) 	copy bytes
3439:   PUSH  1,0(6) 	push a.x value into tmp
3440:    LDA  0,-13(2) 	load id adress
3441:   PUSH  0,0(6) 	push array adress to mp
3442:    POP  1,0(6) 	move the adress of ID
3443:    POP  0,0(6) 	copy bytes
3444:     ST  0,0(1) 	copy bytes
* while stmt:
3445:  LABEL  66,0,0 	generate label
3446:     LD  0,-13(2) 	load id value
3447:   PUSH  0,0(6) 	store exp
3448:     LD  0,-5(5) 	load id value
3449:   PUSH  0,0(6) 	store exp
3450:    POP  1,0(6) 	pop right
3451:    POP  0,0(6) 	pop left
3452:    SUB  0,0,1 	op ==, convertd_type
3453:    JNE  0,2(7) 	br if true
3454:    LDC  0,0(0) 	false case
3455:    LDA  7,1(7) 	unconditional jmp
3456:    LDC  0,1(0) 	true case
3457:   PUSH  0,0(6) 	
3458:    POP  0,0(6) 	pop from the mp
3459:    JNE  0,1,7 	true case:, skip the break, execute the block code
3460:     GO  67,0,0 	go to label
3461:     LD  0,-13(2) 	load id value
3462:   PUSH  0,0(6) 	store exp
3463:    POP  1,0,6 	load adress of lhs struct
3464:    LDC  0,2,0 	load offset of member
3465:    ADD  0,0,1 	compute the real adress if pointK
3466:   PUSH  0,0(6) 	
3467:    POP  0,0(6) 	load adress from mp
3468:     LD  1,0(0) 	copy bytes
3469:   PUSH  1,0(6) 	push a.x value into tmp
3470:    POP  0,0(6) 	pop the adress
3471:     LD  1,0(0) 	load bytes
3472:   PUSH  1,0(6) 	push bytes 
3473:    POP  0,0(6) 	move result to register
3474:    OUT  0,0,0 	output value in register[ac / fac]
3475:     LD  0,-13(2) 	load id value
3476:   PUSH  0,0(6) 	store exp
3477:    POP  1,0,6 	load adress of lhs struct
3478:    LDC  0,1,0 	load offset of member
3479:    ADD  0,0,1 	compute the real adress if pointK
3480:   PUSH  0,0(6) 	
3481:    POP  0,0(6) 	load adress from mp
3482:     LD  1,0(0) 	copy bytes
3483:   PUSH  1,0(6) 	push a.x value into tmp
3484:    LDA  0,-13(2) 	load id adress
3485:   PUSH  0,0(6) 	push array adress to mp
3486:    POP  1,0(6) 	move the adress of ID
3487:    POP  0,0(6) 	copy bytes
3488:     ST  0,0(1) 	copy bytes
3489:     GO  66,0,0 	go to label
3490:  LABEL  67,0,0 	generate label
3491:    MOV  3,2,0 	restore the caller sp
3492:     LD  2,0(2) 	resotre the caller fp
3493:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3494:  LABEL  65,0,0 	generate label
* function entry:
* testMatch
3495:    LDA  3,-1(3) 	stack expand for function variable
3496:    LDC  0,3499(0) 	get function adress
3497:     ST  0,-17(5) 	set function adress
3498:     GO  68,0,0 	go to label
3499:    MOV  1,2,0 	store the caller fp temporarily
3500:    MOV  2,3,0 	exchang the stack(context)
3501:   PUSH  1,0(3) 	push the caller fp
3502:   PUSH  0,0(3) 	push the return adress
3503:    LDA  3,-11(3) 	stack expand
3504:    LDC  1,195(0) 	get function adress from struct
3505:     ST  1,4(3) 	Init Struct Instance
3506:    LDC  1,205(0) 	get function adress from struct
3507:     ST  1,5(3) 	Init Struct Instance
3508:    LDC  1,215(0) 	get function adress from struct
3509:     ST  1,6(3) 	Init Struct Instance
3510:    LDC  1,225(0) 	get function adress from struct
3511:     ST  1,7(3) 	Init Struct Instance
3512:    LDC  1,539(0) 	get function adress from struct
3513:     ST  1,8(3) 	Init Struct Instance
3514:    LDC  1,662(0) 	get function adress from struct
3515:     ST  1,9(3) 	Init Struct Instance
3516:    LDC  1,928(0) 	get function adress from struct
3517:     ST  1,10(3) 	Init Struct Instance
3518:    LDC  1,1084(0) 	get function adress from struct
3519:     ST  1,11(3) 	Init Struct Instance
3520:     LD  0,1(2) 	load env
3521:   PUSH  0,0(3) 	store env
* call function: 
* makeList
3522:     LD  0,-12(5) 	load id value
3523:   PUSH  0,0(6) 	store exp
3524:    LDC  0,3526(0) 	store the return adress
3525:    POP  7,0(6) 	ujp to the function body
3526:    LDA  3,0(3) 	pop parameters
3527:    LDA  3,1(3) 	pop env
3528:    LDA  0,-12(2) 	load id adress
3529:   PUSH  0,0(6) 	push array adress to mp
3530:    POP  1,0(6) 	move the adress of ID
3531:    POP  0,0(6) 	copy bytes
3532:     ST  0,10(1) 	copy bytes
3533:    POP  0,0(6) 	copy bytes
3534:     ST  0,9(1) 	copy bytes
3535:    POP  0,0(6) 	copy bytes
3536:     ST  0,8(1) 	copy bytes
3537:    POP  0,0(6) 	copy bytes
3538:     ST  0,7(1) 	copy bytes
3539:    POP  0,0(6) 	copy bytes
3540:     ST  0,6(1) 	copy bytes
3541:    POP  0,0(6) 	copy bytes
3542:     ST  0,5(1) 	copy bytes
3543:    POP  0,0(6) 	copy bytes
3544:     ST  0,4(1) 	copy bytes
3545:    POP  0,0(6) 	copy bytes
3546:     ST  0,3(1) 	copy bytes
3547:    POP  0,0(6) 	copy bytes
3548:     ST  0,2(1) 	copy bytes
3549:    POP  0,0(6) 	copy bytes
3550:     ST  0,1(1) 	copy bytes
3551:    POP  0,0(6) 	copy bytes
3552:     ST  0,0(1) 	copy bytes
3553:    LDA  3,-1(3) 	stack expand
3554:    LDC  0,1(0) 	load integer const
3555:   PUSH  0,0(6) 	store exp
3556:    LDA  0,-13(2) 	load id adress
3557:   PUSH  0,0(6) 	push array adress to mp
3558:    POP  1,0(6) 	move the adress of ID
3559:    POP  0,0(6) 	copy bytes
3560:     ST  0,0(1) 	copy bytes
3561:    LDA  3,-1(3) 	stack expand
3562:    LDC  0,1(0) 	load integer const
3563:   PUSH  0,0(6) 	store exp
3564:    LDA  0,-14(2) 	load id adress
3565:   PUSH  0,0(6) 	push array adress to mp
3566:    POP  1,0(6) 	move the adress of ID
3567:    POP  0,0(6) 	copy bytes
3568:     ST  0,0(1) 	copy bytes
* push function parameters
3569:    LDA  0,-14(2) 	load id adress
3570:   PUSH  0,0(6) 	push array adress to mp
3571:    POP  0,0(6) 	copy bytes
3572:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
3573:    LDA  0,-13(2) 	load id adress
3574:   PUSH  0,0(6) 	push array adress to mp
3575:    POP  0,0(6) 	copy bytes
3576:   PUSH  0,0(3) 	PUSH bytes
3577:    LDA  0,0(2) 	load env
3578:   PUSH  0,0(3) 	store env
* call function: 
* match
3579:    LDA  0,-12(2) 	load id adress
3580:   PUSH  0,0(6) 	push array adress to mp
3581:    POP  1,0,6 	load adress of lhs struct
3582:    LDC  0,5,0 	load offset of member
3583:    ADD  0,0,1 	compute the real adress if pointK
3584:   PUSH  0,0(6) 	
3585:    POP  0,0(6) 	load adress from mp
3586:     LD  1,0(0) 	copy bytes
3587:   PUSH  1,0(6) 	push a.x value into tmp
3588:    LDC  0,3590(0) 	store the return adress
3589:    POP  7,0(6) 	ujp to the function body
3590:    LDA  3,2(3) 	pop parameters
3591:    LDA  3,1(3) 	pop env
3592:    POP  0,0(6) 	move result to register
3593:    OUT  0,0,0 	output value in register[ac / fac]
3594:    MOV  3,2,0 	restore the caller sp
3595:     LD  2,0(2) 	resotre the caller fp
3596:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3597:  LABEL  68,0,0 	generate label
* function entry:
* main
3598:    LDC  0,3601(0) 	get function adress
3599:     ST  0,-18(5) 	set function adress
3600:     GO  69,0,0 	go to label
3601:    MOV  1,2,0 	store the caller fp temporarily
3602:    MOV  2,3,0 	exchang the stack(context)
3603:   PUSH  1,0(3) 	push the caller fp
3604:   PUSH  0,0(3) 	push the return adress
3605:     LD  0,1(2) 	load env
3606:   PUSH  0,0(3) 	store env
* call function: 
* testMatch
3607:     LD  0,-17(5) 	load id value
3608:   PUSH  0,0(6) 	store exp
3609:    LDC  0,3611(0) 	store the return adress
3610:    POP  7,0(6) 	ujp to the function body
3611:    LDA  3,0(3) 	pop parameters
3612:    LDA  3,1(3) 	pop env
3613:     LD  0,1(2) 	load env
3614:   PUSH  0,0(3) 	store env
* call function: 
* test_insertSortedList
3615:     LD  0,-13(5) 	load id value
3616:   PUSH  0,0(6) 	store exp
3617:    LDC  0,3619(0) 	store the return adress
3618:    POP  7,0(6) 	ujp to the function body
3619:    LDA  3,0(3) 	pop parameters
3620:    LDA  3,1(3) 	pop env
3621:    LDC  0,45(0) 	load char const
3622:     ST  0,-34(4) 	store exp
3623:    LDC  0,45(0) 	load char const
3624:     ST  0,-33(4) 	store exp
3625:    LDC  0,45(0) 	load char const
3626:     ST  0,-32(4) 	store exp
3627:    LDC  0,45(0) 	load char const
3628:     ST  0,-31(4) 	store exp
3629:    LDC  0,45(0) 	load char const
3630:     ST  0,-30(4) 	store exp
3631:    LDC  0,45(0) 	load char const
3632:     ST  0,-29(4) 	store exp
3633:    LDC  0,45(0) 	load char const
3634:     ST  0,-28(4) 	store exp
3635:    LDC  0,45(0) 	load char const
3636:     ST  0,-27(4) 	store exp
3637:    LDC  0,45(0) 	load char const
3638:     ST  0,-26(4) 	store exp
3639:    LDC  0,45(0) 	load char const
3640:     ST  0,-25(4) 	store exp
3641:    LDC  0,45(0) 	load char const
3642:     ST  0,-24(4) 	store exp
3643:    LDC  0,45(0) 	load char const
3644:     ST  0,-23(4) 	store exp
3645:    LDC  0,45(0) 	load char const
3646:     ST  0,-22(4) 	store exp
3647:    LDC  0,45(0) 	load char const
3648:     ST  0,-21(4) 	store exp
3649:    LDC  0,45(0) 	load char const
3650:     ST  0,-20(4) 	store exp
3651:    LDA  0,-34(4) 	load char const
3652:   PUSH  0,0(6) 	store exp
3653:    POP  0,0(6) 	move result to register
3654:    OUT  0,2,0 	output value in register[ac / fac]
3655:     LD  0,1(2) 	load env
3656:   PUSH  0,0(3) 	store env
* call function: 
* test_appendList
3657:     LD  0,-14(5) 	load id value
3658:   PUSH  0,0(6) 	store exp
3659:    LDC  0,3661(0) 	store the return adress
3660:    POP  7,0(6) 	ujp to the function body
3661:    LDA  3,0(3) 	pop parameters
3662:    LDA  3,1(3) 	pop env
3663:    LDC  0,45(0) 	load char const
3664:     ST  0,-50(4) 	store exp
3665:    LDC  0,45(0) 	load char const
3666:     ST  0,-49(4) 	store exp
3667:    LDC  0,45(0) 	load char const
3668:     ST  0,-48(4) 	store exp
3669:    LDC  0,45(0) 	load char const
3670:     ST  0,-47(4) 	store exp
3671:    LDC  0,45(0) 	load char const
3672:     ST  0,-46(4) 	store exp
3673:    LDC  0,45(0) 	load char const
3674:     ST  0,-45(4) 	store exp
3675:    LDC  0,45(0) 	load char const
3676:     ST  0,-44(4) 	store exp
3677:    LDC  0,45(0) 	load char const
3678:     ST  0,-43(4) 	store exp
3679:    LDC  0,45(0) 	load char const
3680:     ST  0,-42(4) 	store exp
3681:    LDC  0,45(0) 	load char const
3682:     ST  0,-41(4) 	store exp
3683:    LDC  0,45(0) 	load char const
3684:     ST  0,-40(4) 	store exp
3685:    LDC  0,45(0) 	load char const
3686:     ST  0,-39(4) 	store exp
3687:    LDC  0,45(0) 	load char const
3688:     ST  0,-38(4) 	store exp
3689:    LDC  0,45(0) 	load char const
3690:     ST  0,-37(4) 	store exp
3691:    LDC  0,45(0) 	load char const
3692:     ST  0,-36(4) 	store exp
3693:    LDA  0,-50(4) 	load char const
3694:   PUSH  0,0(6) 	store exp
3695:    POP  0,0(6) 	move result to register
3696:    OUT  0,2,0 	output value in register[ac / fac]
3697:     LD  0,1(2) 	load env
3698:   PUSH  0,0(3) 	store env
* call function: 
* test_removeList
3699:     LD  0,-15(5) 	load id value
3700:   PUSH  0,0(6) 	store exp
3701:    LDC  0,3703(0) 	store the return adress
3702:    POP  7,0(6) 	ujp to the function body
3703:    LDA  3,0(3) 	pop parameters
3704:    LDA  3,1(3) 	pop env
3705:    LDC  0,45(0) 	load char const
3706:     ST  0,-66(4) 	store exp
3707:    LDC  0,45(0) 	load char const
3708:     ST  0,-65(4) 	store exp
3709:    LDC  0,45(0) 	load char const
3710:     ST  0,-64(4) 	store exp
3711:    LDC  0,45(0) 	load char const
3712:     ST  0,-63(4) 	store exp
3713:    LDC  0,45(0) 	load char const
3714:     ST  0,-62(4) 	store exp
3715:    LDC  0,45(0) 	load char const
3716:     ST  0,-61(4) 	store exp
3717:    LDC  0,45(0) 	load char const
3718:     ST  0,-60(4) 	store exp
3719:    LDC  0,45(0) 	load char const
3720:     ST  0,-59(4) 	store exp
3721:    LDC  0,45(0) 	load char const
3722:     ST  0,-58(4) 	store exp
3723:    LDC  0,45(0) 	load char const
3724:     ST  0,-57(4) 	store exp
3725:    LDC  0,45(0) 	load char const
3726:     ST  0,-56(4) 	store exp
3727:    LDC  0,45(0) 	load char const
3728:     ST  0,-55(4) 	store exp
3729:    LDC  0,45(0) 	load char const
3730:     ST  0,-54(4) 	store exp
3731:    LDC  0,45(0) 	load char const
3732:     ST  0,-53(4) 	store exp
3733:    LDC  0,45(0) 	load char const
3734:     ST  0,-52(4) 	store exp
3735:    LDA  0,-66(4) 	load char const
3736:   PUSH  0,0(6) 	store exp
3737:    POP  0,0(6) 	move result to register
3738:    OUT  0,2,0 	output value in register[ac / fac]
3739:     LD  0,1(2) 	load env
3740:   PUSH  0,0(3) 	store env
* call function: 
* test_pop
3741:     LD  0,-16(5) 	load id value
3742:   PUSH  0,0(6) 	store exp
3743:    LDC  0,3745(0) 	store the return adress
3744:    POP  7,0(6) 	ujp to the function body
3745:    LDA  3,0(3) 	pop parameters
3746:    LDA  3,1(3) 	pop env
3747:    MOV  3,2,0 	restore the caller sp
3748:     LD  2,0(2) 	resotre the caller fp
3749:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
3750:  LABEL  69,0,0 	generate label
* call main function
3751:     LD  1,-18(5) 	get main function adress
3752:    LDC  0,3754(0) 	store the return adress
3753:    LDA  7,0(1) 	ujp to the function body
3754:   HALT  0,0,0 	
