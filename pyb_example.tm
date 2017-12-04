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
 12:    LDA  3,-100(3) 	stack expand
* -> assign
* -> Const
 13:    LDC  0,32(0) 	load integer const
 14:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* ->index k
* -> Id
 15:    LDA  0,-101(2) 	load id adress
 16:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* -> Const
 17:    LDC  0,2(0) 	load integer const
 18:   PUSH  0,0(6) 	store exp
* <- Const
 19:    POP  0,0(6) 	load index value to ac
 20:    LDC  1,10,0 	load array size
 21:    MUL  0,1,0 	compute the offset
 22:    POP  1,0(6) 	load lhs adress to ac1
 23:    ADD  0,0,1 	compute the real index adress a[index]
 24:   PUSH  0,0(6) 	push the adress mode into mp
* -> Const
 25:    LDC  0,2(0) 	load integer const
 26:   PUSH  0,0(6) 	store exp
* <- Const
 27:    POP  0,0(6) 	load index value to ac
 28:    LDC  1,1,0 	load array size
 29:    MUL  0,1,0 	compute the offset
 30:    POP  1,0(6) 	load lhs adress to ac1
 31:    ADD  0,0,1 	compute the real index adress a[index]
 32:   PUSH  0,0(6) 	push the adress mode into mp
 33:    POP  1,0(6) 	move the adress of referenced
 34:    POP  0,0(6) 	copy bytes
 35:     ST  0,0(1) 	copy bytes
* <- assign
 36:    LDA  3,-1(3) 	stack expand
* ->index k
* -> Id
 37:    LDA  0,-101(2) 	load id adress
 38:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* -> Const
 39:    LDC  0,2(0) 	load integer const
 40:   PUSH  0,0(6) 	store exp
* <- Const
 41:    POP  0,0(6) 	load index value to ac
 42:    LDC  1,10,0 	load array size
 43:    MUL  0,1,0 	compute the offset
 44:    POP  1,0(6) 	load lhs adress to ac1
 45:    ADD  0,0,1 	compute the real index adress a[index]
 46:   PUSH  0,0(6) 	push the adress mode into mp
 47:    LDA  1,-102(2) 	move the adress of ID
 48:    POP  0,0(6) 	copy bytes
 49:     ST  0,0(1) 	copy bytes
* ->index k
* ->index k
* -> Id
 50:    LDA  0,-101(2) 	load id adress
 51:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* -> Const
 52:    LDC  0,2(0) 	load integer const
 53:   PUSH  0,0(6) 	store exp
* <- Const
 54:    POP  0,0(6) 	load index value to ac
 55:    LDC  1,10,0 	load array size
 56:    MUL  0,1,0 	compute the offset
 57:    POP  1,0(6) 	load lhs adress to ac1
 58:    ADD  0,0,1 	compute the real index adress a[index]
 59:   PUSH  0,0(6) 	push the adress mode into mp
* -> Const
 60:    LDC  0,2(0) 	load integer const
 61:   PUSH  0,0(6) 	store exp
* <- Const
 62:    POP  0,0(6) 	load index value to ac
 63:    LDC  1,1,0 	load array size
 64:    MUL  0,1,0 	compute the offset
 65:    POP  1,0(6) 	load lhs adress to ac1
 66:    ADD  0,0,1 	compute the real index adress a[index]
 67:     LD  1,0(0) 	load bytes
 68:   PUSH  1,0(6) 	push bytes 
 69:    POP  0,0(6) 	move result to register
 70:    OUT  0,0,0 	output value in register[ac / fac]
* ->index k
* -> Id
 71:     LD  0,-102(2) 	load id value
 72:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 73:    LDC  0,2(0) 	load integer const
 74:   PUSH  0,0(6) 	store exp
* <- Const
 75:    POP  0,0(6) 	load index value to ac
 76:    LDC  1,1,0 	load array size
 77:    MUL  0,1,0 	compute the offset
 78:    POP  1,0(6) 	load lhs adress to ac1
 79:    ADD  0,0,1 	compute the real index adress a[index]
 80:     LD  1,0(0) 	load bytes
 81:   PUSH  1,0(6) 	push bytes 
 82:    POP  0,0(6) 	move result to register
 83:    OUT  0,0,0 	output value in register[ac / fac]
 84:    MOV  3,2,0 	restore the caller sp
 85:     LD  2,0(2) 	resotre the caller fp
 86:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,79(7) 	skip the function body
* call main function
 87:    LDC  0,89(0) 	store the return adress
 88:    LDC  7,8(0) 	ujp to the function body
 89:   HALT  0,0,0 	
