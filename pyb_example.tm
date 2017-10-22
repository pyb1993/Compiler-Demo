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
 10:     ST  0,-1(5) 	copy bytes 
* <- assign
* -> assign
* ->Single Op
 11:    LDA  0,-1,5 	LDA the var adress
 12:   PUSH  0,0(6) 	op: load left
 13:    POP  0,0(6) 	copy bytes
 14:     ST  0,0(5) 	copy bytes 
* <- assign
* function entry
 16:    MOV  1,2,0 	store the caller fp temporarily
 17:    MOV  2,3,0 	exchang the stack(context)
 18:   PUSH  1,0(3) 	push the caller fp
 19:   PUSH  0,0(3) 	push the return adress
* -> assign
* -> Const
 20:    LDC  0,100(0) 	load integer const
 21:   PUSH  0,0(6) 	store exp
* <- Const
 22:    POP  0,0(6) 	copy bytes
 23:     ST  0,-1(5) 	copy bytes 
* <- assign
* -> Id
 24:     LD  0,-1(5) 	load id value
 25:   PUSH  0,0(6) 	store exp
* <- Id
 26:    POP  0,0(6) 	move result to register
 27:    OUT  0,0,0 	output value in register[ac / fac]
* -> assign
* -> Const
 28:    LDC  0,10(0) 	load integer const
 29:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 30:     LD  0,0(5) 	load id value
 31:   PUSH  0,0(6) 	store exp
* <- Id
 32:    POP  1,0(6) 	POP the adress of referenced
 33:    POP  0,0(6) 	copy bytes
 34:     ST  0,0(1) 	copy bytes 
* <- assign
* -> Id
 35:     LD  0,-1(5) 	load id value
 36:   PUSH  0,0(6) 	store exp
* <- Id
 37:    POP  0,0(6) 	move result to register
 38:    OUT  0,0,0 	output value in register[ac / fac]
 39:    MOV  3,2,0 	restore the caller sp
 40:     LD  2,0(2) 	resotre the caller fp
 41:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 15:    LDA  7,26(7) 	skip the function body
* call main function
 42:    LDC  0,44(0) 	store the return adress
 43:    LDC  7,16(0) 	ujp to the function body
 44:   HALT  0,0,0 	
