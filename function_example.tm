* File: function_example.tm
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
* f
  8:    LDA  3,-1(3) 	stack expand for function variable
  9:    LDC  0,12(0) 	get function adress
 10:     ST  0,-103(5) 	set function adress
 11:     GO  100,0,0 	go to label
 12:    MOV  1,2,0 	store the caller fp temporarily
 13:    MOV  2,3,0 	exchang the stack(context)
 14:   PUSH  1,0(3) 	push the caller fp
 15:   PUSH  0,0(3) 	push the return adress
 16:     LD  0,2(2) 	load id value
 17:   PUSH  0,0(6) 	store exp
 18:    LDC  0,2(0) 	load integer const
 19:   PUSH  0,0(6) 	store exp
 20:    POP  1,0(6) 	pop right
 21:    POP  0,0(6) 	pop left
 22:    SUB  0,0,1 	op <
 23:    JLE  0,2(7) 	br if true
 24:    LDC  0,0(0) 	false case
 25:    LDA  7,1(7) 	unconditional jmp
 26:    LDC  0,1(0) 	true case
 27:   PUSH  0,0(6) 	
 28:    POP  0,0(6) 	pop from the mp
 29:    JNE  0,1,7 	true case:, execute if part
 30:     GO  101,0,0 	go to label
 31:    LDC  0,1(0) 	load integer const
 32:   PUSH  0,0(6) 	store exp
 33:    POP  0,0(6) 	op: POP left
 34:    MOV  9,0,0 	move register reg(s) tp reg(r)
 35:   PUSH  9,0(6) 	op: push left
 36:    MOV  3,2,0 	restore the caller sp
 37:     LD  2,0(2) 	resotre the caller fp
 38:  RETURN  0,-1,3 	return to the caller
 39:     GO  102,0,0 	go to label
 40:  LABEL  101,0,0 	generate label
* if: jump to else
* push function parameters
 41:     LD  0,2(2) 	load id value
 42:   PUSH  0,0(6) 	store exp
 43:    LDC  0,1(0) 	load integer const
 44:   PUSH  0,0(6) 	store exp
 45:    POP  1,0(6) 	pop right
 46:    POP  0,0(6) 	pop left
 47:    SUB  0,0,1 	op -
 48:   PUSH  0,0(6) 	op: load left
 49:    POP  0,0(6) 	copy bytes
 50:   PUSH  0,0(3) 	PUSH bytes
 51:     LD  0,1(2) 	load env
 52:   PUSH  0,0(3) 	store env
* call function: 
* f
 53:     LD  0,-103(5) 	load id value
 54:   PUSH  0,0(6) 	store exp
 55:    LDC  0,57(0) 	store the return adress
 56:    POP  7,0(6) 	ujp to the function body
 57:    LDA  3,1(3) 	pop parameters
 58:    LDA  3,1(3) 	pop env
* push function parameters
 59:     LD  0,2(2) 	load id value
 60:   PUSH  0,0(6) 	store exp
 61:    LDC  0,2(0) 	load integer const
 62:   PUSH  0,0(6) 	store exp
 63:    POP  1,0(6) 	pop right
 64:    POP  0,0(6) 	pop left
 65:    SUB  0,0,1 	op -
 66:   PUSH  0,0(6) 	op: load left
 67:    POP  0,0(6) 	copy bytes
 68:   PUSH  0,0(3) 	PUSH bytes
 69:     LD  0,1(2) 	load env
 70:   PUSH  0,0(3) 	store env
* call function: 
* f
 71:     LD  0,-103(5) 	load id value
 72:   PUSH  0,0(6) 	store exp
 73:    LDC  0,75(0) 	store the return adress
 74:    POP  7,0(6) 	ujp to the function body
 75:    LDA  3,1(3) 	pop parameters
 76:    LDA  3,1(3) 	pop env
 77:    POP  10,0(6) 	pop right
 78:    POP  9,0(6) 	pop left
 79:    ADD  9,9,10 	op +
 80:   PUSH  9,0(6) 	op: load left
 81:    MOV  3,2,0 	restore the caller sp
 82:     LD  2,0(2) 	resotre the caller fp
 83:  RETURN  0,-1,3 	return to the caller
 84:  LABEL  102,0,0 	generate label
 85:    MOV  3,2,0 	restore the caller sp
 86:     LD  2,0(2) 	resotre the caller fp
 87:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 88:  LABEL  100,0,0 	generate label
* function entry:
* f2
 89:    LDA  3,-1(3) 	stack expand for function variable
 90:    LDC  0,93(0) 	get function adress
 91:     ST  0,-104(5) 	set function adress
 92:     GO  103,0,0 	go to label
 93:    MOV  1,2,0 	store the caller fp temporarily
 94:    MOV  2,3,0 	exchang the stack(context)
 95:   PUSH  1,0(3) 	push the caller fp
 96:   PUSH  0,0(3) 	push the return adress
 97:     LD  0,2(2) 	load id value
 98:    MOV  9,0,0 	move from one reg(s) to reg(r)
 99:   PUSH  9,0(6) 	store exp
100:     LD  0,3(2) 	load id value
101:    MOV  9,0,0 	move from one reg(s) to reg(r)
102:   PUSH  9,0(6) 	store exp
103:    POP  10,0(6) 	pop right
104:    POP  9,0(6) 	pop left
105:    MUL  9,9,10 	op *
106:   PUSH  9,0(6) 	op: load left
107:     LD  9,4(2) 	load id value
108:   PUSH  9,0(6) 	store exp
109:    POP  10,0(6) 	pop right
110:    POP  9,0(6) 	pop left
111:    MUL  9,9,10 	op *
112:   PUSH  9,0(6) 	op: load left
113:    MOV  3,2,0 	restore the caller sp
114:     LD  2,0(2) 	resotre the caller fp
115:  RETURN  0,-1,3 	return to the caller
116:    MOV  3,2,0 	restore the caller sp
117:     LD  2,0(2) 	resotre the caller fp
118:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
119:  LABEL  103,0,0 	generate label
* function entry:
* f3
120:    LDA  3,-1(3) 	stack expand for function variable
121:    LDC  0,124(0) 	get function adress
122:     ST  0,-105(5) 	set function adress
123:     GO  104,0,0 	go to label
124:    MOV  1,2,0 	store the caller fp temporarily
125:    MOV  2,3,0 	exchang the stack(context)
126:   PUSH  1,0(3) 	push the caller fp
127:   PUSH  0,0(3) 	push the return adress
128:     LD  0,2(2) 	load id value
129:   PUSH  0,0(6) 	store exp
130:     LD  0,2(2) 	load id value
131:   PUSH  0,0(6) 	store exp
132:    POP  1,0(6) 	pop right
133:    POP  0,0(6) 	pop left
134:    ADD  0,0,1 	op +
135:   PUSH  0,0(6) 	op: load left
136:    MOV  3,2,0 	restore the caller sp
137:     LD  2,0(2) 	resotre the caller fp
138:  RETURN  0,-1,3 	return to the caller
139:    MOV  3,2,0 	restore the caller sp
140:     LD  2,0(2) 	resotre the caller fp
141:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
142:  LABEL  104,0,0 	generate label
* function entry:
* f4
143:    LDA  3,-1(3) 	stack expand for function variable
144:    LDC  0,147(0) 	get function adress
145:     ST  0,-106(5) 	set function adress
146:     GO  105,0,0 	go to label
147:    MOV  1,2,0 	store the caller fp temporarily
148:    MOV  2,3,0 	exchang the stack(context)
149:   PUSH  1,0(3) 	push the caller fp
150:   PUSH  0,0(3) 	push the return adress
151:    LDA  3,-10(3) 	stack expand
152:    LDA  3,-1(3) 	stack expand
153:    LDC  0,101(0) 	load integer const
154:   PUSH  0,0(6) 	store exp
155:    LDA  0,-12(2) 	load id adress
156:   PUSH  0,0(6) 	push array adress to mp
157:    POP  1,0(6) 	move the adress of ID
158:    POP  0,0(6) 	copy bytes
159:     ST  0,0(1) 	copy bytes
* function entry:
* f3
160:    LDA  3,-1(3) 	stack expand for function variable
161:    LDC  0,164(0) 	get function adress
162:     ST  0,-13(2) 	set function adress
163:     GO  106,0,0 	go to label
164:    MOV  1,2,0 	store the caller fp temporarily
165:    MOV  2,3,0 	exchang the stack(context)
166:   PUSH  1,0(3) 	push the caller fp
167:   PUSH  0,0(3) 	push the return adress
168:    LDA  1,0(2) 	store current fp
169:     LD  2,1(2) 	load env
170:     LD  0,-12(2) 	load id value
171:   PUSH  0,0(6) 	store exp
172:    LDA  2,0(1) 	restore fp
173:    POP  0,0(6) 	move result to register
174:    OUT  0,0,0 	output value in register[ac / fac]
175:    LDA  1,0(2) 	store current fp
176:     LD  2,1(2) 	load env
177:     LD  0,-12(2) 	load id value
178:   PUSH  0,0(6) 	store exp
179:    LDA  2,0(1) 	restore fp
180:    LDC  0,10(0) 	load integer const
181:   PUSH  0,0(6) 	store exp
182:    POP  1,0(6) 	pop right
183:    POP  0,0(6) 	pop left
184:    ADD  0,0,1 	op +
185:   PUSH  0,0(6) 	op: load left
186:    LDA  1,0(2) 	store current fp
187:     LD  2,1(2) 	load env
188:    LDA  0,-12(2) 	load id adress
189:   PUSH  0,0(6) 	push array adress to mp
190:    LDA  2,0(1) 	restore fp
191:    POP  1,0(6) 	move the adress of ID
192:    POP  0,0(6) 	copy bytes
193:     ST  0,0(1) 	copy bytes
194:    LDC  0,5(0) 	load integer const
195:   PUSH  0,0(6) 	store exp
196:    LDA  1,0(2) 	store current fp
197:     LD  2,1(2) 	load env
198:    LDA  0,-11(2) 	load id adress
199:   PUSH  0,0(6) 	push array adress to mp
200:    LDA  2,0(1) 	restore fp
201:    LDC  0,1(0) 	load integer const
202:   PUSH  0,0(6) 	store exp
203:    POP  0,0(6) 	load index value to ac
204:    LDC  1,1,0 	load array size
205:    MUL  0,1,0 	compute the offset
206:    POP  1,0(6) 	load lhs adress to ac1
207:    ADD  0,0,1 	compute the real index adress a[index]
208:   PUSH  0,0(6) 	push the adress mode into mp
209:    POP  1,0(6) 	move the adress of referenced
210:    POP  0,0(6) 	copy bytes
211:     ST  0,0(1) 	copy bytes
212:    MOV  3,2,0 	restore the caller sp
213:     LD  2,0(2) 	resotre the caller fp
214:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
215:  LABEL  106,0,0 	generate label
216:    LDA  0,0(2) 	load env
217:   PUSH  0,0(3) 	store env
* call function: 
* f3
218:     LD  0,-13(2) 	load id value
219:   PUSH  0,0(6) 	store exp
220:    LDC  0,222(0) 	store the return adress
221:    POP  7,0(6) 	ujp to the function body
222:    LDA  3,0(3) 	pop parameters
223:    LDA  3,1(3) 	pop env
224:    LDA  0,0(2) 	load env
225:   PUSH  0,0(3) 	store env
* call function: 
* f3
226:     LD  0,-13(2) 	load id value
227:   PUSH  0,0(6) 	store exp
228:    LDC  0,230(0) 	store the return adress
229:    POP  7,0(6) 	ujp to the function body
230:    LDA  3,0(3) 	pop parameters
231:    LDA  3,1(3) 	pop env
232:     LD  0,-12(2) 	load id value
233:   PUSH  0,0(6) 	store exp
234:    POP  0,0(6) 	move result to register
235:    OUT  0,0,0 	output value in register[ac / fac]
236:    LDA  0,-11(2) 	load id adress
237:   PUSH  0,0(6) 	push array adress to mp
238:    LDC  0,1(0) 	load integer const
239:   PUSH  0,0(6) 	store exp
240:    POP  0,0(6) 	load index value to ac
241:    LDC  1,1,0 	load array size
242:    MUL  0,1,0 	compute the offset
243:    POP  1,0(6) 	load lhs adress to ac1
244:    ADD  0,0,1 	compute the real index adress a[index]
245:     LD  1,0(0) 	load bytes
246:   PUSH  1,0(6) 	push bytes 
247:    POP  0,0(6) 	move result to register
248:    OUT  0,0,0 	output value in register[ac / fac]
249:    MOV  3,2,0 	restore the caller sp
250:     LD  2,0(2) 	resotre the caller fp
251:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
252:  LABEL  105,0,0 	generate label
* function entry:
* f5
253:    LDA  3,-1(3) 	stack expand for function variable
254:    LDC  0,257(0) 	get function adress
255:     ST  0,-107(5) 	set function adress
256:     GO  107,0,0 	go to label
257:    MOV  1,2,0 	store the caller fp temporarily
258:    MOV  2,3,0 	exchang the stack(context)
259:   PUSH  1,0(3) 	push the caller fp
260:   PUSH  0,0(3) 	push the return adress
261:    LDA  3,-1(3) 	stack expand
262:    LDC  0,2(0) 	load integer const
263:   PUSH  0,0(6) 	store exp
264:    POP  0,0(6) 	pop right
265:    NEG  0,0,0 	single op (-)
266:   PUSH  0,0(6) 	op: load left
267:    LDA  0,-2(2) 	load id adress
268:   PUSH  0,0(6) 	push array adress to mp
269:    POP  1,0(6) 	move the adress of ID
270:    POP  0,0(6) 	copy bytes
271:     ST  0,0(1) 	copy bytes
* function entry:
* g1
272:    LDA  3,-1(3) 	stack expand for function variable
273:    LDC  0,276(0) 	get function adress
274:     ST  0,-3(2) 	set function adress
275:     GO  108,0,0 	go to label
276:    MOV  1,2,0 	store the caller fp temporarily
277:    MOV  2,3,0 	exchang the stack(context)
278:   PUSH  1,0(3) 	push the caller fp
279:   PUSH  0,0(3) 	push the return adress
280:    LDA  3,-1(3) 	stack expand
281:    LDC  0,1(0) 	load integer const
282:   PUSH  0,0(6) 	store exp
283:    POP  0,0(6) 	pop right
284:    NEG  0,0,0 	single op (-)
285:   PUSH  0,0(6) 	op: load left
286:    LDA  0,-2(2) 	load id adress
287:   PUSH  0,0(6) 	push array adress to mp
288:    POP  1,0(6) 	move the adress of ID
289:    POP  0,0(6) 	copy bytes
290:     ST  0,0(1) 	copy bytes
291:    LDA  1,0(2) 	store current fp
292:     LD  2,1(2) 	load env
293:     LD  0,-2(2) 	load id value
294:   PUSH  0,0(6) 	store exp
295:    LDA  2,0(1) 	restore fp
296:    LDC  0,10(0) 	load integer const
297:   PUSH  0,0(6) 	store exp
298:    POP  1,0(6) 	pop right
299:    POP  0,0(6) 	pop left
300:    ADD  0,0,1 	op +
301:   PUSH  0,0(6) 	op: load left
302:    LDA  1,0(2) 	store current fp
303:     LD  2,1(2) 	load env
304:    LDA  0,-2(2) 	load id adress
305:   PUSH  0,0(6) 	push array adress to mp
306:    LDA  2,0(1) 	restore fp
307:    POP  1,0(6) 	move the adress of ID
308:    POP  0,0(6) 	copy bytes
309:     ST  0,0(1) 	copy bytes
310:    MOV  3,2,0 	restore the caller sp
311:     LD  2,0(2) 	resotre the caller fp
312:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
313:  LABEL  108,0,0 	generate label
* function entry:
* g2
314:    LDA  3,-1(3) 	stack expand for function variable
315:    LDC  0,318(0) 	get function adress
316:     ST  0,-4(2) 	set function adress
317:     GO  109,0,0 	go to label
318:    MOV  1,2,0 	store the caller fp temporarily
319:    MOV  2,3,0 	exchang the stack(context)
320:   PUSH  1,0(3) 	push the caller fp
321:   PUSH  0,0(3) 	push the return adress
322:     LD  0,1(2) 	load env
323:   PUSH  0,0(3) 	store env
* call function: 
* g1
324:    LDA  1,0(2) 	store current fp
325:     LD  2,1(2) 	load env
326:     LD  0,-3(2) 	load id value
327:   PUSH  0,0(6) 	store exp
328:    LDA  2,0(1) 	restore fp
329:    LDC  0,331(0) 	store the return adress
330:    POP  7,0(6) 	ujp to the function body
331:    LDA  3,0(3) 	pop parameters
332:    LDA  3,1(3) 	pop env
333:    LDA  1,0(2) 	store current fp
334:     LD  2,1(2) 	load env
335:     LD  0,-2(2) 	load id value
336:   PUSH  0,0(6) 	store exp
337:    LDA  2,0(1) 	restore fp
338:    POP  0,0(6) 	move result to register
339:    OUT  0,0,0 	output value in register[ac / fac]
340:    MOV  3,2,0 	restore the caller sp
341:     LD  2,0(2) 	resotre the caller fp
342:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
343:  LABEL  109,0,0 	generate label
344:    LDA  0,0(2) 	load env
345:   PUSH  0,0(3) 	store env
* call function: 
* g2
346:     LD  0,-4(2) 	load id value
347:   PUSH  0,0(6) 	store exp
348:    LDC  0,350(0) 	store the return adress
349:    POP  7,0(6) 	ujp to the function body
350:    LDA  3,0(3) 	pop parameters
351:    LDA  3,1(3) 	pop env
352:    MOV  3,2,0 	restore the caller sp
353:     LD  2,0(2) 	resotre the caller fp
354:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
355:  LABEL  107,0,0 	generate label
* function entry:
* f6
356:    LDA  3,-1(3) 	stack expand for function variable
357:    LDC  0,360(0) 	get function adress
358:     ST  0,-108(5) 	set function adress
359:     GO  110,0,0 	go to label
360:    MOV  1,2,0 	store the caller fp temporarily
361:    MOV  2,3,0 	exchang the stack(context)
362:   PUSH  1,0(3) 	push the caller fp
363:   PUSH  0,0(3) 	push the return adress
364:    LDA  3,-1(3) 	stack expand
365:    LDC  0,3(0) 	load integer const
366:   PUSH  0,0(6) 	store exp
367:    POP  0,0(6) 	pop right
368:    NEG  0,0,0 	single op (-)
369:   PUSH  0,0(6) 	op: load left
370:    LDA  0,-2(2) 	load id adress
371:   PUSH  0,0(6) 	push array adress to mp
372:    POP  1,0(6) 	move the adress of ID
373:    POP  0,0(6) 	copy bytes
374:     ST  0,0(1) 	copy bytes
* function entry:
* g
375:    LDA  3,-1(3) 	stack expand for function variable
376:    LDC  0,379(0) 	get function adress
377:     ST  0,-3(2) 	set function adress
378:     GO  111,0,0 	go to label
379:    MOV  1,2,0 	store the caller fp temporarily
380:    MOV  2,3,0 	exchang the stack(context)
381:   PUSH  1,0(3) 	push the caller fp
382:   PUSH  0,0(3) 	push the return adress
383:    LDA  1,0(2) 	store current fp
384:     LD  2,1(2) 	load env
385:     LD  0,-2(2) 	load id value
386:   PUSH  0,0(6) 	store exp
387:    LDA  2,0(1) 	restore fp
388:    LDC  0,100(0) 	load integer const
389:   PUSH  0,0(6) 	store exp
390:    POP  1,0(6) 	pop right
391:    POP  0,0(6) 	pop left
392:    MUL  0,0,1 	op *
393:   PUSH  0,0(6) 	op: load left
394:    LDA  1,0(2) 	store current fp
395:     LD  2,1(2) 	load env
396:    LDA  0,-2(2) 	load id adress
397:   PUSH  0,0(6) 	push array adress to mp
398:    LDA  2,0(1) 	restore fp
399:    POP  1,0(6) 	move the adress of ID
400:    POP  0,0(6) 	copy bytes
401:     ST  0,0(1) 	copy bytes
402:    MOV  3,2,0 	restore the caller sp
403:     LD  2,0(2) 	resotre the caller fp
404:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
405:  LABEL  111,0,0 	generate label
* function entry:
* g1
406:    LDA  3,-1(3) 	stack expand for function variable
407:    LDC  0,410(0) 	get function adress
408:     ST  0,-4(2) 	set function adress
409:     GO  112,0,0 	go to label
410:    MOV  1,2,0 	store the caller fp temporarily
411:    MOV  2,3,0 	exchang the stack(context)
412:   PUSH  1,0(3) 	push the caller fp
413:   PUSH  0,0(3) 	push the return adress
414:    LDA  3,-1(3) 	stack expand
415:    LDC  0,40(0) 	load integer const
416:   PUSH  0,0(6) 	store exp
417:    LDA  0,-2(2) 	load id adress
418:   PUSH  0,0(6) 	push array adress to mp
419:    POP  1,0(6) 	move the adress of ID
420:    POP  0,0(6) 	copy bytes
421:     ST  0,0(1) 	copy bytes
422:     LD  0,1(2) 	load env
423:   PUSH  0,0(3) 	store env
* call function: 
* g
424:    LDA  1,0(2) 	store current fp
425:     LD  2,1(2) 	load env
426:     LD  0,-3(2) 	load id value
427:   PUSH  0,0(6) 	store exp
428:    LDA  2,0(1) 	restore fp
429:    LDC  0,431(0) 	store the return adress
430:    POP  7,0(6) 	ujp to the function body
431:    LDA  3,0(3) 	pop parameters
432:    LDA  3,1(3) 	pop env
433:    LDA  1,0(2) 	store current fp
434:     LD  2,1(2) 	load env
435:     LD  0,-2(2) 	load id value
436:   PUSH  0,0(6) 	store exp
437:    LDA  2,0(1) 	restore fp
438:    POP  0,0(6) 	move result to register
439:    OUT  0,0,0 	output value in register[ac / fac]
440:    MOV  3,2,0 	restore the caller sp
441:     LD  2,0(2) 	resotre the caller fp
442:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
443:  LABEL  112,0,0 	generate label
* function entry:
* g2
444:    LDA  3,-1(3) 	stack expand for function variable
445:    LDC  0,448(0) 	get function adress
446:     ST  0,-5(2) 	set function adress
447:     GO  113,0,0 	go to label
448:    MOV  1,2,0 	store the caller fp temporarily
449:    MOV  2,3,0 	exchang the stack(context)
450:   PUSH  1,0(3) 	push the caller fp
451:   PUSH  0,0(3) 	push the return adress
452:    LDA  3,-1(3) 	stack expand
453:    LDC  0,50(0) 	load integer const
454:   PUSH  0,0(6) 	store exp
455:    POP  0,0(6) 	pop right
456:    NEG  0,0,0 	single op (-)
457:   PUSH  0,0(6) 	op: load left
458:    LDA  0,-2(2) 	load id adress
459:   PUSH  0,0(6) 	push array adress to mp
460:    POP  1,0(6) 	move the adress of ID
461:    POP  0,0(6) 	copy bytes
462:     ST  0,0(1) 	copy bytes
* function entry:
* g3
463:    LDA  3,-1(3) 	stack expand for function variable
464:    LDC  0,467(0) 	get function adress
465:     ST  0,-3(2) 	set function adress
466:     GO  114,0,0 	go to label
467:    MOV  1,2,0 	store the caller fp temporarily
468:    MOV  2,3,0 	exchang the stack(context)
469:   PUSH  1,0(3) 	push the caller fp
470:   PUSH  0,0(3) 	push the return adress
471:    LDA  1,0(2) 	store current fp
472:     LD  2,1(2) 	load env
473:     LD  0,-2(2) 	load id value
474:   PUSH  0,0(6) 	store exp
475:    LDA  2,0(1) 	restore fp
476:    POP  0,0(6) 	move result to register
477:    OUT  0,0,0 	output value in register[ac / fac]
478:     LD  0,1(2) 	load env
479:     LD  0,1(0) 	load env1
480:   PUSH  0,0(3) 	store env
* call function: 
* g
481:    LDA  1,0(2) 	store current fp
482:     LD  2,1(2) 	load env
483:     LD  2,1(2) 	load env
484:     LD  0,-3(2) 	load id value
485:   PUSH  0,0(6) 	store exp
486:    LDA  2,0(1) 	restore fp
487:    LDC  0,489(0) 	store the return adress
488:    POP  7,0(6) 	ujp to the function body
489:    LDA  3,0(3) 	pop parameters
490:    LDA  3,1(3) 	pop env
491:    MOV  3,2,0 	restore the caller sp
492:     LD  2,0(2) 	resotre the caller fp
493:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
494:  LABEL  114,0,0 	generate label
495:    LDA  0,0(2) 	load env
496:   PUSH  0,0(3) 	store env
* call function: 
* g3
497:     LD  0,-3(2) 	load id value
498:   PUSH  0,0(6) 	store exp
499:    LDC  0,501(0) 	store the return adress
500:    POP  7,0(6) 	ujp to the function body
501:    LDA  3,0(3) 	pop parameters
502:    LDA  3,1(3) 	pop env
503:    MOV  3,2,0 	restore the caller sp
504:     LD  2,0(2) 	resotre the caller fp
505:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
506:  LABEL  113,0,0 	generate label
507:    LDA  0,0(2) 	load env
508:   PUSH  0,0(3) 	store env
* call function: 
* g1
509:     LD  0,-4(2) 	load id value
510:   PUSH  0,0(6) 	store exp
511:    LDC  0,513(0) 	store the return adress
512:    POP  7,0(6) 	ujp to the function body
513:    LDA  3,0(3) 	pop parameters
514:    LDA  3,1(3) 	pop env
515:    LDA  0,0(2) 	load env
516:   PUSH  0,0(3) 	store env
* call function: 
* g2
517:     LD  0,-5(2) 	load id value
518:   PUSH  0,0(6) 	store exp
519:    LDC  0,521(0) 	store the return adress
520:    POP  7,0(6) 	ujp to the function body
521:    LDA  3,0(3) 	pop parameters
522:    LDA  3,1(3) 	pop env
523:    MOV  3,2,0 	restore the caller sp
524:     LD  2,0(2) 	resotre the caller fp
525:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
526:  LABEL  110,0,0 	generate label
* function entry:
* main
527:    LDC  0,530(0) 	get function adress
528:     ST  0,-109(5) 	set function adress
529:     GO  115,0,0 	go to label
530:    MOV  1,2,0 	store the caller fp temporarily
531:    MOV  2,3,0 	exchang the stack(context)
532:   PUSH  1,0(3) 	push the caller fp
533:   PUSH  0,0(3) 	push the return adress
* push function parameters
534:    LDC  0,100(0) 	load integer const
535:   PUSH  0,0(6) 	store exp
536:    POP  0,0(6) 	copy bytes
537:   PUSH  0,0(3) 	PUSH bytes
538:     LD  0,1(2) 	load env
539:   PUSH  0,0(3) 	store env
* call function: 
* f3
540:     LD  0,-105(5) 	load id value
541:   PUSH  0,0(6) 	store exp
542:    LDC  0,544(0) 	store the return adress
543:    POP  7,0(6) 	ujp to the function body
544:    LDA  3,1(3) 	pop parameters
545:    LDA  3,1(3) 	pop env
546:    POP  0,0(6) 	move result to register
547:    OUT  0,0,0 	output value in register[ac / fac]
* push function parameters
* push function parameters
548:    LDC  0,1(0) 	load integer const
549:   PUSH  0,0(6) 	store exp
550:    POP  0,0(6) 	copy bytes
551:    MOV  9,0,0 	copy bytes
552:   PUSH  9,0(3) 	PUSH bytes
* push function parameters
553:    LDC  0,1(0) 	load integer const
554:   PUSH  0,0(6) 	store exp
555:    POP  0,0(6) 	copy bytes
556:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
* push function parameters
557:    LDC  9,0.400000(0)
 558:   PUSH  9,0(6) 	store exp
559:    POP  9,0(6) 	copy bytes
560:   PUSH  9,0(3) 	PUSH bytes
* push function parameters
* push function parameters
561:    LDC  0,4(0) 	load integer const
562:   PUSH  0,0(6) 	store exp
563:    POP  0,0(6) 	copy bytes
564:   PUSH  0,0(3) 	PUSH bytes
565:     LD  0,1(2) 	load env
566:   PUSH  0,0(3) 	store env
* call function: 
* f
567:     LD  0,-103(5) 	load id value
568:   PUSH  0,0(6) 	store exp
569:    LDC  0,571(0) 	store the return adress
570:    POP  7,0(6) 	ujp to the function body
571:    LDA  3,1(3) 	pop parameters
572:    LDA  3,1(3) 	pop env
573:    POP  9,0(6) 	copy bytes
574:    MOV  0,9,0 	copy bytes
575:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
576:    LDC  0,4(0) 	load integer const
577:   PUSH  0,0(6) 	store exp
578:    POP  0,0(6) 	copy bytes
579:   PUSH  0,0(3) 	PUSH bytes
580:     LD  0,1(2) 	load env
581:   PUSH  0,0(3) 	store env
* call function: 
* f2
582:     LD  0,-104(5) 	load id value
583:   PUSH  0,0(6) 	store exp
584:    LDC  0,586(0) 	store the return adress
585:    POP  7,0(6) 	ujp to the function body
586:    LDA  3,3(3) 	pop parameters
587:    LDA  3,1(3) 	pop env
588:    POP  9,0(6) 	copy bytes
589:    MOV  0,9,0 	copy bytes
590:   PUSH  0,0(3) 	PUSH bytes
591:     LD  0,1(2) 	load env
592:   PUSH  0,0(3) 	store env
* call function: 
* f2
593:     LD  0,-104(5) 	load id value
594:   PUSH  0,0(6) 	store exp
595:    LDC  0,597(0) 	store the return adress
596:    POP  7,0(6) 	ujp to the function body
597:    LDA  3,3(3) 	pop parameters
598:    LDA  3,1(3) 	pop env
599:    POP  9,0(6) 	copy bytes
600:    MOV  0,9,0 	copy bytes
601:   PUSH  0,0(3) 	PUSH bytes
602:     LD  0,1(2) 	load env
603:   PUSH  0,0(3) 	store env
* call function: 
* f
604:     LD  0,-103(5) 	load id value
605:   PUSH  0,0(6) 	store exp
606:    LDC  0,608(0) 	store the return adress
607:    POP  7,0(6) 	ujp to the function body
608:    LDA  3,1(3) 	pop parameters
609:    LDA  3,1(3) 	pop env
610:    POP  9,0(6) 	move result to register
611:    OUT  9,0,0 	output value in register[ac / fac]
* push function parameters
612:    LDC  0,8(0) 	load integer const
613:   PUSH  0,0(6) 	store exp
614:    POP  0,0(6) 	copy bytes
615:   PUSH  0,0(3) 	PUSH bytes
616:     LD  0,1(2) 	load env
617:   PUSH  0,0(3) 	store env
* call function: 
* f
618:     LD  0,-103(5) 	load id value
619:   PUSH  0,0(6) 	store exp
620:    LDC  0,622(0) 	store the return adress
621:    POP  7,0(6) 	ujp to the function body
622:    LDA  3,1(3) 	pop parameters
623:    LDA  3,1(3) 	pop env
* push function parameters
624:    LDC  0,6(0) 	load integer const
625:   PUSH  0,0(6) 	store exp
626:    POP  0,0(6) 	copy bytes
627:    MOV  9,0,0 	copy bytes
628:   PUSH  9,0(3) 	PUSH bytes
* push function parameters
629:    LDC  0,2(0) 	load integer const
630:   PUSH  0,0(6) 	store exp
631:    POP  0,0(6) 	copy bytes
632:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
633:    LDC  0,1(0) 	load integer const
634:   PUSH  0,0(6) 	store exp
635:    POP  0,0(6) 	copy bytes
636:   PUSH  0,0(3) 	PUSH bytes
637:     LD  0,1(2) 	load env
638:   PUSH  0,0(3) 	store env
* call function: 
* f2
639:     LD  0,-104(5) 	load id value
640:   PUSH  0,0(6) 	store exp
641:    LDC  0,643(0) 	store the return adress
642:    POP  7,0(6) 	ujp to the function body
643:    LDA  3,3(3) 	pop parameters
644:    LDA  3,1(3) 	pop env
645:    POP  10,0(6) 	pop right
646:    POP  9,0(6) 	pop left
647:    ADD  9,9,10 	op +
648:   PUSH  9,0(6) 	op: load left
649:    POP  9,0(6) 	move result to register
650:    OUT  9,0,0 	output value in register[ac / fac]
* push function parameters
651:    LDC  9,0.600000(0)
 652:   PUSH  9,0(6) 	store exp
653:    POP  9,0(6) 	copy bytes
654:   PUSH  9,0(3) 	PUSH bytes
* push function parameters
655:    LDC  0,2(0) 	load integer const
656:   PUSH  0,0(6) 	store exp
657:    POP  0,0(6) 	copy bytes
658:   PUSH  0,0(3) 	PUSH bytes
* push function parameters
659:    LDC  0,11(0) 	load integer const
660:   PUSH  0,0(6) 	store exp
661:    POP  0,0(6) 	copy bytes
662:   PUSH  0,0(3) 	PUSH bytes
663:     LD  0,1(2) 	load env
664:   PUSH  0,0(3) 	store env
* call function: 
* f2
665:     LD  0,-104(5) 	load id value
666:   PUSH  0,0(6) 	store exp
667:    LDC  0,669(0) 	store the return adress
668:    POP  7,0(6) 	ujp to the function body
669:    LDA  3,3(3) 	pop parameters
670:    LDA  3,1(3) 	pop env
671:    POP  9,0(6) 	move result to register
672:    OUT  9,0,0 	output value in register[ac / fac]
673:     LD  0,1(2) 	load env
674:   PUSH  0,0(3) 	store env
* call function: 
* f4
675:     LD  0,-106(5) 	load id value
676:   PUSH  0,0(6) 	store exp
677:    LDC  0,679(0) 	store the return adress
678:    POP  7,0(6) 	ujp to the function body
679:    LDA  3,0(3) 	pop parameters
680:    LDA  3,1(3) 	pop env
681:     LD  0,1(2) 	load env
682:   PUSH  0,0(3) 	store env
* call function: 
* f5
683:     LD  0,-107(5) 	load id value
684:   PUSH  0,0(6) 	store exp
685:    LDC  0,687(0) 	store the return adress
686:    POP  7,0(6) 	ujp to the function body
687:    LDA  3,0(3) 	pop parameters
688:    LDA  3,1(3) 	pop env
689:     LD  0,1(2) 	load env
690:   PUSH  0,0(3) 	store env
* call function: 
* f6
691:     LD  0,-108(5) 	load id value
692:   PUSH  0,0(6) 	store exp
693:    LDC  0,695(0) 	store the return adress
694:    POP  7,0(6) 	ujp to the function body
695:    LDA  3,0(3) 	pop parameters
696:    LDA  3,1(3) 	pop env
697:    MOV  3,2,0 	restore the caller sp
698:     LD  2,0(2) 	resotre the caller fp
699:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
700:  LABEL  115,0,0 	generate label
* call main function
701:     LD  1,-109(5) 	get main function adress
702:    LDC  0,704(0) 	store the return adress
703:    LDA  7,0(1) 	ujp to the function body
704:   HALT  0,0,0 	
