* File: pyb_example.tm
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
  9:    MOV  3,2,0 	resotre stack in struct
* function entry:
* g
 10:    LDC  0,13(0) 	get function adress
 11:     ST  0,0(5) 	set function adress
 13:    MOV  1,2,0 	store the caller fp temporarily
 14:    MOV  2,3,0 	exchang the stack(context)
 15:   PUSH  1,0(3) 	push the caller fp
 16:   PUSH  0,0(3) 	push the return adress
* -> Const
 17:    LDC  0,10086(0) 	load integer const
 18:   PUSH  0,0(6) 	store exp
* <- Const
 19:    MOV  3,2,0 	restore the caller sp
 20:     LD  2,0(2) 	resotre the caller fp
 21:  RETURN  0,-1,3 	return to the caller
 22:    MOV  3,2,0 	restore the caller sp
 23:     LD  2,0(2) 	resotre the caller fp
 24:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,12(7) 	skip the function body
* function entry:
* malloc
 25:    LDC  0,28(0) 	get function adress
 26:     ST  0,-1(5) 	set function adress
 28:    MOV  1,2,0 	store the caller fp temporarily
 29:    MOV  2,3,0 	exchang the stack(context)
 30:   PUSH  1,0(3) 	push the caller fp
 31:   PUSH  0,0(3) 	push the return adress
* -> Id
 32:     LD  0,1(2) 	load id value
 33:   PUSH  0,0(6) 	store exp
* <- Id
 34:    POP  0,0(6) 	get malloc parameters
 35:  MALLOC  0,0(0) 	system call for malloc
 36:    MOV  3,2,0 	restore the caller sp
 37:     LD  2,0(2) 	resotre the caller fp
 38:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 27:    LDA  7,11(7) 	skip the function body
* function entry:
* free
 39:    LDC  0,42(0) 	get function adress
 40:     ST  0,-2(5) 	set function adress
 42:    MOV  1,2,0 	store the caller fp temporarily
 43:    MOV  2,3,0 	exchang the stack(context)
 44:   PUSH  1,0(3) 	push the caller fp
 45:   PUSH  0,0(3) 	push the return adress
* -> Id
 46:     LD  0,1(2) 	load id value
 47:   PUSH  0,0(6) 	store exp
* <- Id
 48:    POP  0,0(6) 	get free parameters
 49:  FREE  0,0(0) 	system call for free
 50:    MOV  3,2,0 	restore the caller sp
 51:     LD  2,0(2) 	resotre the caller fp
 52:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 41:    LDA  7,11(7) 	skip the function body
* call main function
* File: pyb_example.tm
* Standard prelude:
 53:    LDC  6,65535(0) 	load mp adress
 54:     ST  0,0(0) 	clear location 0
 55:    LDC  5,4095(0) 	load gp adress from location 1
 56:     ST  0,1(0) 	clear location 1
 57:    LDC  4,2000(0) 	load gp adress from location 1
 58:    LDC  2,60000(0) 	load first fp from location 2
 59:    LDC  3,60000(0) 	load first sp from location 2
 60:     ST  0,2(0) 	clear location 2
* End of standard prelude.
 61:    LDA  3,-1(3) 	stack expand
 62:    LDA  3,-1(3) 	stack expand
 63:    MOV  3,2,0 	resotre stack in struct
* function entry:
* main
 64:    LDC  0,67(0) 	get function adress
 65:     ST  0,-3(5) 	set function adress
 67:    MOV  1,2,0 	store the caller fp temporarily
 68:    MOV  2,3,0 	exchang the stack(context)
 69:   PUSH  1,0(3) 	push the caller fp
 70:   PUSH  0,0(3) 	push the return adress
 71:    LDA  3,-20(3) 	stack expand
 72:    LDA  3,-20(3) 	stack expand
* -> assign
* -> Const
 73:    LDC  0,1(0) 	load integer const
 74:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 75:    LDA  0,-41(2) 	load id adress
 76:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* -> Const
 77:    LDC  0,0(0) 	load integer const
 78:   PUSH  0,0(6) 	store exp
* <- Const
 79:    POP  0,0(6) 	load index value to ac
 80:    LDC  1,2,0 	load array size
 81:    MUL  0,1,0 	compute the offset
 82:    POP  1,0(6) 	load lhs adress to ac1
 83:    ADD  0,0,1 	compute the real index adress a[index]
 84:   PUSH  0,0(6) 	push the adress mode into mp
 85:    POP  1,0,6 	load adress of lhs struct
 86:    LDC  0,0,0 	load offset of member
 87:    ADD  0,0,1 	compute the real adress if pointK
 88:   PUSH  0,0(6) 	
 89:    POP  1,0(6) 	move the adress of referenced
 90:    POP  0,0(6) 	copy bytes
 91:     ST  0,0(1) 	copy bytes
* <- assign
* ->index k
* -> Id
 92:    LDA  0,-41(2) 	load id adress
 93:   PUSH  0,0(6) 	push array adress to mp
* <- Id
* -> Const
 94:    LDC  0,0(0) 	load integer const
 95:   PUSH  0,0(6) 	store exp
* <- Const
 96:    POP  0,0(6) 	load index value to ac
 97:    LDC  1,2,0 	load array size
 98:    MUL  0,1,0 	compute the offset
 99:    POP  1,0(6) 	load lhs adress to ac1
100:    ADD  0,0,1 	compute the real index adress a[index]
101:   PUSH  0,0(6) 	push the adress mode into mp
102:    POP  1,0,6 	load adress of lhs struct
103:    LDC  0,0,0 	load offset of member
104:    ADD  0,0,1 	compute the real adress if pointK
105:   PUSH  0,0(6) 	
106:    POP  0,0(6) 	load adress from mp
107:     LD  1,0(0) 	copy bytes
108:   PUSH  1,0(6) 	push a.x value into tmp
109:    POP  0,0(6) 	move result to register
110:    OUT  0,0,0 	output value in register[ac / fac]
111:    MOV  3,2,0 	restore the caller sp
112:     LD  2,0(2) 	resotre the caller fp
113:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 66:    LDA  7,47(7) 	skip the function body
* function entry:
* f
114:    LDC  0,117(0) 	get function adress
115:     ST  0,-4(5) 	set function adress
117:    MOV  1,2,0 	store the caller fp temporarily
118:    MOV  2,3,0 	exchang the stack(context)
119:   PUSH  1,0(3) 	push the caller fp
120:   PUSH  0,0(3) 	push the return adress
121:    MOV  3,2,0 	restore the caller sp
122:     LD  2,0(2) 	resotre the caller fp
123:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
116:    LDA  7,7(7) 	skip the function body
* call main function
124:     LD  1,-3(5) 	get main function adress
125:    LDC  0,127(0) 	store the return adress
126:    LDA  7,0(1) 	ujp to the function body
127:   HALT  0,0,0 	
