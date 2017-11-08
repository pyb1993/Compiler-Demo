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
 13:    LDC  0,10(0) 	load integer const
 14:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 15:    LDA  0,-12(2) 	load id value
* <- Id
 16:    MOV  1,0,0 	load adress of lhs struct
 17:    LDC  0,2,0 	load offset of member
 18:    ADD  0,0,1 	compute the real adress if pointK
 19:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 20:    LDC  0,5(0) 	load integer const
 21:   PUSH  0,0(6) 	store exp
* <- Const
 22:    POP  0,0(6) 	load index value to ac
 23:    LDC  1,1,0 	load array size
 24:    MUL  0,1,0 	compute the offset
 25:    POP  1,0(6) 	load lhs adress to ac1
 26:    ADD  0,0,1 	compute the real index adress a[index]
 27:    POP  1,0(6) 	load exp value
 28:     ST  1,0(0) 	store value
* <- assign
* -> assign
* -> Const
 29:    LDC  0,2(0) 	load integer const
 30:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 31:    LDC  0,2(0) 	load integer const
 32:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 33:    LDA  0,-12(2) 	load id value
* <- Id
 34:    MOV  1,0,0 	load adress of lhs struct
 35:    LDC  0,0,0 	load offset of member
 36:    ADD  0,0,1 	compute the real adress if pointK
 37:    MOV  1,0,0 	move adress to ac1
 38:    POP  0,0(6) 	copy bytes
 39:     ST  0,0(1) 	copy bytes 
* <- assign
* -> Op
* ->index k
* -> Id
 40:    LDA  0,-12(2) 	load id value
* <- Id
 41:    MOV  1,0,0 	load adress of lhs struct
 42:    LDC  0,2,0 	load offset of member
 43:    ADD  0,0,1 	compute the real adress if pointK
 44:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 45:    LDC  0,5(0) 	load integer const
 46:   PUSH  0,0(6) 	store exp
* <- Const
 47:    POP  0,0(6) 	load index value to ac
 48:    LDC  1,1,0 	load array size
 49:    MUL  0,1,0 	compute the offset
 50:    POP  1,0(6) 	load lhs adress to ac1
 51:    ADD  0,0,1 	compute the real index adress a[index]
 52:     LD  1,0(0) 	load value
 53:   PUSH  1,0(6) 	
* -> Id
 54:    LDA  0,-12(2) 	load id value
* <- Id
 55:    MOV  1,0,0 	load adress of lhs struct
 56:    LDC  0,0,0 	load offset of member
 57:    ADD  0,0,1 	compute the real adress if pointK
 58:     LD  0,0(0) 	copy bytes
 59:   PUSH  0,0(6) 	push a.x value into tmp
 60:    POP  1,0(6) 	pop right
 61:    POP  0,0(6) 	pop left
 62:    ADD  0,0,1 	op +
 63:   PUSH  0,0(6) 	op: load left
* <- Op
 64:    POP  0,0(6) 	move result to register
 65:    OUT  0,0,0 	output value in register[ac / fac]
 66:    MOV  3,2,0 	restore the caller sp
 67:     LD  2,0(2) 	resotre the caller fp
 68:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,61(7) 	skip the function body
* call main function
 69:    LDC  0,71(0) 	store the return adress
 70:    LDC  7,8(0) 	ujp to the function body
 71:   HALT  0,0,0 	
