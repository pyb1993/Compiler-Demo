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
 12:   PUSH  0,0(3) 	stack expand
* -> assign
* -> Const
 13:    LDC  0,2(0) 	load integer const
 14:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Const
 15:    LDC  0,3(0) 	load integer const
 16:   PUSH  0,0(6) 	store exp
* <- Const
 17:    POP  0,0(6) 	load index value to ac
 18:    LDC  1,1,0 	load array size
 19:    MUL  1,0,1 	compute the offset
* ->index k
* -> Const
 20:    LDC  0,1(0) 	load integer const
 21:   PUSH  0,0(6) 	store exp
* <- Const
 22:    POP  0,0(6) 	load index value to ac
 23:    LDC  1,4,0 	load array size
 24:    MUL  1,0,1 	compute the offset
* -> Id
 25:    LDA  0,-19(2) 	load id value
* <- Id
 26:    ADD  0,0,1 	compute the real index adress a[index]
 27:    ADD  0,0,1 	compute the real index adress a[index]
 28:    POP  1,0(6) 	load exp value
 29:     ST  1,0(0) 	store value
* <- assign
* ->index k
* -> Const
 30:    LDC  0,3(0) 	load integer const
 31:   PUSH  0,0(6) 	store exp
* <- Const
 32:    POP  0,0(6) 	load index value to ac
 33:    LDC  1,1,0 	load array size
 34:    MUL  1,0,1 	compute the offset
* ->index k
* -> Const
 35:    LDC  0,1(0) 	load integer const
 36:   PUSH  0,0(6) 	store exp
* <- Const
 37:    POP  0,0(6) 	load index value to ac
 38:    LDC  1,4,0 	load array size
 39:    MUL  1,0,1 	compute the offset
* -> Id
 40:    LDA  0,-19(2) 	load id value
* <- Id
 41:    ADD  0,0,1 	compute the real index adress a[index]
 42:    ADD  0,0,1 	compute the real index adress a[index]
 43:     LD  1,0(0) 	load value
 44:   PUSH  1,0(6) 	
 45:    POP  0,0(6) 	move result to register
 46:    OUT  0,0,0 	output value in register[ac / fac]
 47:    MOV  3,2,0 	restore the caller sp
 48:     LD  2,0(2) 	resotre the caller fp
 49:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,42(7) 	skip the function body
* call main function
 50:    LDC  0,52(0) 	store the return adress
 51:    LDC  7,8(0) 	ujp to the function body
 52:   HALT  0,0,0 	
