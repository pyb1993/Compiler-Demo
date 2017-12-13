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
* function entry
  8:    MOV  1,2,0 	store the caller fp temporarily
  9:    MOV  2,3,0 	exchang the stack(context)
 10:   PUSH  1,0(3) 	push the caller fp
 11:   PUSH  0,0(3) 	push the return adress
 12:    LDA  3,-10(3) 	stack expand
 13:    LDA  3,-1(3) 	stack expand
* ->Single Op
* -> Id
 14:    LDA  0,-11(2) 	load id adress
 15:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* <-Single Op
 16:    LDA  1,-12(2) 	move the adress of ID
 17:    POP  0,0(6) 	copy bytes
 18:     ST  0,0(1) 	copy bytes
* ->Single Op
* -> Id
 19:     LD  0,-12(2) 	load id value
 20:   PUSH  0,0(6) 	store exp
* <- Id
 21:    POP  0,0(6) 	pop right
* -> Op
* -> Id
 22:     LD  0,-12(2) 	load id value
 23:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 24:    LDC  0,1(0) 	load integer const
 25:   PUSH  0,0(6) 	store exp
* <- Const
 26:    POP  0,0(6) 	load index value to ac
 27:    LDC  1,10,0 	load pointkind size
 28:    MUL  0,1,0 	compute the offset
 29:    POP  1,0(6) 	load lhs adress to ac1
 30:    ADD  0,0,1 	compute the real index adress a[index]
 31:   PUSH  0,0(6) 	op: load left
* <- Op
 32:    LDA  1,-12(2) 	move the adress of ID
 33:    POP  0,0(6) 	copy bytes
 34:     ST  0,0(1) 	copy bytes
* <-Single Op
* -> Id
 35:     LD  0,-12(2) 	load id value
 36:   PUSH  0,0(6) 	store exp
* <- Id
 37:    POP  0,0(6) 	move result to register
 38:    OUT  0,0,0 	output value in register[ac / fac]
 39:    MOV  3,2,0 	restore the caller sp
 40:     LD  2,0(2) 	resotre the caller fp
 41:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,34(7) 	skip the function body
* call main function
 42:    LDC  0,44(0) 	store the return adress
 43:    LDC  7,8(0) 	ujp to the function body
 44:   HALT  0,0,0 	
