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
 13:   PUSH  0,0(3) 	stack expand
* -> assign
* ->Single Op
 14:    LDA  0,-102,2 	LDA the var adress
 15:   PUSH  0,0(6) 	op: load left
 16:    POP  0,0(6) 	copy bytes
 17:     ST  0,-2(2) 	copy bytes 
* <- assign
* -> assign
* -> Const
 18:    LDC  0,100(0) 	load integer const
 19:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* ->index k
* -> Id
 20:    LDA  0,-102(2) 	load id adress
* <- Id
 21:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 22:    LDC  0,1(0) 	load integer const
 23:   PUSH  0,0(6) 	store exp
* <- Const
 24:    POP  0,0(6) 	load index value to ac
 25:    LDC  1,10,0 	load array size
 26:    MUL  0,1,0 	compute the offset
 27:    POP  1,0(6) 	load lhs adress to ac1
 28:    ADD  0,0,1 	compute the real index adress a[index]
 29:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 30:    LDC  0,1(0) 	load integer const
 31:   PUSH  0,0(6) 	store exp
* <- Const
 32:    POP  0,0(6) 	load index value to ac
 33:    LDC  1,1,0 	load array size
 34:    MUL  0,1,0 	compute the offset
 35:    POP  1,0(6) 	load lhs adress to ac1
 36:    ADD  0,0,1 	compute the real index adress a[index]
 37:    MOV  1,0,0 	move adress to ac1
 38:    POP  0,0(6) 	copy bytes
 39:     ST  0,0(1) 	copy bytes 
* <- assign
* ->index k
* ->index k
* -> Id
 40:     LD  0,-2(2) 	load id value
 41:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 42:    LDC  0,1(0) 	load integer const
 43:   PUSH  0,0(6) 	store exp
* <- Const
 44:    POP  0,0(6) 	load index value to ac
 45:    LDC  1,10,0 	load array size
 46:    MUL  0,1,0 	compute the offset
 47:    POP  1,0(6) 	load lhs adress to ac1
 48:    ADD  0,0,1 	compute the real index adress a[index]
 49:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 50:    LDC  0,1(0) 	load integer const
 51:   PUSH  0,0(6) 	store exp
* <- Const
 52:    POP  0,0(6) 	load index value to ac
 53:    LDC  1,1,0 	load array size
 54:    MUL  0,1,0 	compute the offset
 55:    POP  1,0(6) 	load lhs adress to ac1
 56:    ADD  0,0,1 	compute the real index adress a[index]
 57:     LD  1,0(0) 	copy bytes
 58:   PUSH  1,0(6) 	push a.x value into tmp
 59:    POP  0,0(6) 	move result to register
 60:    OUT  0,0,0 	output value in register[ac / fac]
* -> assign
* -> Const
 61:    LDC  0,32(0) 	load integer const
 62:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* ->index k
* -> Id
 63:     LD  0,-2(2) 	load id value
 64:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 65:    LDC  0,2(0) 	load integer const
 66:   PUSH  0,0(6) 	store exp
* <- Const
 67:    POP  0,0(6) 	load index value to ac
 68:    LDC  1,10,0 	load array size
 69:    MUL  0,1,0 	compute the offset
 70:    POP  1,0(6) 	load lhs adress to ac1
 71:    ADD  0,0,1 	compute the real index adress a[index]
 72:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 73:    LDC  0,5(0) 	load integer const
 74:   PUSH  0,0(6) 	store exp
* <- Const
 75:    POP  0,0(6) 	load index value to ac
 76:    LDC  1,1,0 	load array size
 77:    MUL  0,1,0 	compute the offset
 78:    POP  1,0(6) 	load lhs adress to ac1
 79:    ADD  0,0,1 	compute the real index adress a[index]
 80:    MOV  1,0,0 	move adress to ac1
 81:    POP  0,0(6) 	copy bytes
 82:     ST  0,0(1) 	copy bytes 
* <- assign
* ->index k
* ->index k
* -> Id
 83:    LDA  0,-102(2) 	load id adress
* <- Id
 84:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 85:    LDC  0,2(0) 	load integer const
 86:   PUSH  0,0(6) 	store exp
* <- Const
 87:    POP  0,0(6) 	load index value to ac
 88:    LDC  1,10,0 	load array size
 89:    MUL  0,1,0 	compute the offset
 90:    POP  1,0(6) 	load lhs adress to ac1
 91:    ADD  0,0,1 	compute the real index adress a[index]
 92:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 93:    LDC  0,5(0) 	load integer const
 94:   PUSH  0,0(6) 	store exp
* <- Const
 95:    POP  0,0(6) 	load index value to ac
 96:    LDC  1,1,0 	load array size
 97:    MUL  0,1,0 	compute the offset
 98:    POP  1,0(6) 	load lhs adress to ac1
 99:    ADD  0,0,1 	compute the real index adress a[index]
100:     LD  1,0(0) 	copy bytes
101:   PUSH  1,0(6) 	push a.x value into tmp
102:    POP  0,0(6) 	move result to register
103:    OUT  0,0,0 	output value in register[ac / fac]
104:    MOV  3,2,0 	restore the caller sp
105:     LD  2,0(2) 	resotre the caller fp
106:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,99(7) 	skip the function body
* call main function
107:    LDC  0,109(0) 	store the return adress
108:    LDC  7,8(0) 	ujp to the function body
109:   HALT  0,0,0 	
