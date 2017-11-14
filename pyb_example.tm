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
 14:   PUSH  0,0(3) 	stack expand
* -> assign
* -> Const
 15:    LDC  0,10(0) 	load integer const
 16:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 17:    LDC  0,10(0) 	load integer const
 18:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 19:    LDA  0,-6(2) 	load id adress
* <- Id
 20:    MOV  1,0,0 	load adress of lhs struct
 21:    LDC  0,0,0 	load offset of member
 22:    ADD  0,0,1 	compute the real adress if pointK
 23:    MOV  1,0,0 	move adress to ac1
 24:    POP  0,0(6) 	copy bytes
 25:     ST  0,0(1) 	copy bytes 
* <- assign
* -> assign
* -> Const
 26:    LDC  0,100(0) 	load integer const
 27:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 28:    LDC  0,100(0) 	load integer const
 29:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 30:    LDA  0,-11(2) 	load id adress
* <- Id
 31:    MOV  1,0,0 	load adress of lhs struct
 32:    LDC  0,0,0 	load offset of member
 33:    ADD  0,0,1 	compute the real adress if pointK
 34:    MOV  1,0,0 	move adress to ac1
 35:    POP  0,0(6) 	copy bytes
 36:     ST  0,0(1) 	copy bytes 
* <- assign
* -> assign
* -> Const
 37:    LDC  0,1000(0) 	load integer const
 38:   PUSH  0,0(6) 	store exp
* <- Const
* -> Const
 39:    LDC  0,1000(0) 	load integer const
 40:   PUSH  0,0(6) 	store exp
* <- Const
* -> Id
 41:    LDA  0,-16(2) 	load id adress
* <- Id
 42:    MOV  1,0,0 	load adress of lhs struct
 43:    LDC  0,0,0 	load offset of member
 44:    ADD  0,0,1 	compute the real adress if pointK
 45:    MOV  1,0,0 	move adress to ac1
 46:    POP  0,0(6) 	copy bytes
 47:     ST  0,0(1) 	copy bytes 
* <- assign
 48:   PUSH  0,0(3) 	stack expand
* -> assign
* ->Single Op
 49:    LDA  0,-11,2 	LDA the var adress
 50:   PUSH  0,0(6) 	op: load left
* ->index k
* -> Id
 51:    LDA  0,-18(2) 	load id adress
* <- Id
 52:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 53:    LDC  0,0(0) 	load integer const
 54:   PUSH  0,0(6) 	store exp
* <- Const
 55:    POP  0,0(6) 	load index value to ac
 56:    LDC  1,1,0 	load array size
 57:    MUL  0,1,0 	compute the offset
 58:    POP  1,0(6) 	load lhs adress to ac1
 59:    ADD  0,0,1 	compute the real index adress a[index]
 60:    MOV  1,0,0 	move adress to ac1
 61:    POP  0,0(6) 	copy bytes
 62:     ST  0,0(1) 	copy bytes 
* <- assign
* -> assign
* ->Single Op
 63:    LDA  0,-6,2 	LDA the var adress
 64:   PUSH  0,0(6) 	op: load left
* ->index k
* -> Id
 65:    LDA  0,-18(2) 	load id adress
* <- Id
 66:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 67:    LDC  0,1(0) 	load integer const
 68:   PUSH  0,0(6) 	store exp
* <- Const
 69:    POP  0,0(6) 	load index value to ac
 70:    LDC  1,1,0 	load array size
 71:    MUL  0,1,0 	compute the offset
 72:    POP  1,0(6) 	load lhs adress to ac1
 73:    ADD  0,0,1 	compute the real index adress a[index]
 74:    MOV  1,0,0 	move adress to ac1
 75:    POP  0,0(6) 	copy bytes
 76:     ST  0,0(1) 	copy bytes 
* <- assign
* ->Single Op
* ->index k
* -> Id
 77:    LDA  0,-18(2) 	load id adress
* <- Id
 78:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 79:    LDC  0,0(0) 	load integer const
 80:   PUSH  0,0(6) 	store exp
* <- Const
 81:    POP  0,0(6) 	load index value to ac
 82:    LDC  1,1,0 	load array size
 83:    MUL  0,1,0 	compute the offset
 84:    POP  1,0(6) 	load lhs adress to ac1
 85:    ADD  0,0,1 	compute the real index adress a[index]
 86:     LD  1,0(0) 	copy bytes
 87:   PUSH  1,0(6) 	push a.x value into tmp
 88:    POP  0,0(6) 	pop the adress
 89:    MOV  1,0,0 	load adress of lhs struct
 90:    LDC  0,0,0 	load offset of member
 91:    ADD  0,0,1 	compute the real adress if pointK
 92:     LD  1,0(0) 	copy bytes
 93:   PUSH  1,0(6) 	push a.x value into tmp
 94:    POP  0,0(6) 	move result to register
 95:    OUT  0,0,0 	output value in register[ac / fac]
* ->Single Op
* ->index k
* -> Id
 96:    LDA  0,-18(2) 	load id adress
* <- Id
 97:   PUSH  0,0(6) 	sotre lhs adress
* -> Const
 98:    LDC  0,1(0) 	load integer const
 99:   PUSH  0,0(6) 	store exp
* <- Const
100:    POP  0,0(6) 	load index value to ac
101:    LDC  1,1,0 	load array size
102:    MUL  0,1,0 	compute the offset
103:    POP  1,0(6) 	load lhs adress to ac1
104:    ADD  0,0,1 	compute the real index adress a[index]
105:     LD  1,0(0) 	copy bytes
106:   PUSH  1,0(6) 	push a.x value into tmp
107:    POP  0,0(6) 	pop the adress
108:    MOV  1,0,0 	load adress of lhs struct
109:    LDC  0,0,0 	load offset of member
110:    ADD  0,0,1 	compute the real adress if pointK
111:     LD  1,0(0) 	copy bytes
112:   PUSH  1,0(6) 	push a.x value into tmp
113:    POP  0,0(6) 	move result to register
114:    OUT  0,0,0 	output value in register[ac / fac]
115:    MOV  3,2,0 	restore the caller sp
116:     LD  2,0(2) 	resotre the caller fp
117:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,110(7) 	skip the function body
* call main function
118:    LDC  0,120(0) 	store the return adress
119:    LDC  7,8(0) 	ujp to the function body
120:   HALT  0,0,0 	
