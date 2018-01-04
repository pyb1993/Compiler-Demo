* File: .tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
  2:     LD  5,1(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:     LD  2,2(0) 	load first fp from location 2
  5:     LD  3,2(0) 	load first sp from location 2
  6:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* main
  7:    LDC  0,10(0) 	get function adress
  8:     ST  0,0(5) 	set function adress
 10:    MOV  1,2,0 	store the caller fp temporarily
 11:    MOV  2,3,0 	exchang the stack(context)
 12:   PUSH  1,0(3) 	push the caller fp
 13:   PUSH  0,0(3) 	push the return adress
 14:    LDA  3,-1(3) 	stack expand
* -> Const
 15:    LDC  0,1011(0) 	load integer const
 16:   PUSH  0,0(6) 	store exp
* <- Const
 17:    POP  0,0(6) 	copy bytes
 18:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* malloc
* -> Id
 19:     LD  0,-1(5) 	load id value
 20:   PUSH  0,0(6) 	store exp
* <- Id
 21:    LDC  0,23(0) 	store the return adress
 22:    POP  7,0(6) 	ujp to the function body
 23:    LDA  3,1(3) 	pop parameters
 24:    LDA  1,-2(2) 	move the adress of ID
 25:    POP  0,0(6) 	copy bytes
 26:     ST  0,0(1) 	copy bytes
* -> assign
* -> Const
 27:    LDC  0,100(0) 	load integer const
 28:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 29:     LD  0,-2(2) 	load id value
 30:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 31:    LDC  0,0(0) 	load integer const
 32:   PUSH  0,0(6) 	store exp
* <- Const
 33:    POP  0,0(6) 	load index value to ac
 34:    LDC  1,1,0 	load array size
 35:    MUL  0,1,0 	compute the offset
 36:    POP  1,0(6) 	load lhs adress to ac1
 37:    ADD  0,0,1 	compute the real index adress a[index]
 38:   PUSH  0,0(6) 	push the adress mode into mp
 39:    POP  1,0(6) 	move the adress of referenced
 40:    POP  0,0(6) 	copy bytes
 41:     ST  0,0(1) 	copy bytes
* <- assign
* -> assign
* -> Const
 42:    LDC  0,200(0) 	load integer const
 43:   PUSH  0,0(6) 	store exp
* <- Const
* ->index k
* -> Id
 44:     LD  0,-2(2) 	load id value
 45:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 46:    LDC  0,1(0) 	load integer const
 47:   PUSH  0,0(6) 	store exp
* <- Const
 48:    POP  0,0(6) 	load index value to ac
 49:    LDC  1,1,0 	load array size
 50:    MUL  0,1,0 	compute the offset
 51:    POP  1,0(6) 	load lhs adress to ac1
 52:    ADD  0,0,1 	compute the real index adress a[index]
 53:   PUSH  0,0(6) 	push the adress mode into mp
 54:    POP  1,0(6) 	move the adress of referenced
 55:    POP  0,0(6) 	copy bytes
 56:     ST  0,0(1) 	copy bytes
* <- assign
* -> Op
* ->index k
* -> Id
 57:     LD  0,-2(2) 	load id value
 58:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 59:    LDC  0,0(0) 	load integer const
 60:   PUSH  0,0(6) 	store exp
* <- Const
 61:    POP  0,0(6) 	load index value to ac
 62:    LDC  1,1,0 	load array size
 63:    MUL  0,1,0 	compute the offset
 64:    POP  1,0(6) 	load lhs adress to ac1
 65:    ADD  0,0,1 	compute the real index adress a[index]
 66:     LD  1,0(0) 	load bytes
 67:   PUSH  1,0(6) 	push bytes 
* ->index k
* -> Id
 68:     LD  0,-2(2) 	load id value
 69:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 70:    LDC  0,1(0) 	load integer const
 71:   PUSH  0,0(6) 	store exp
* <- Const
 72:    POP  0,0(6) 	load index value to ac
 73:    LDC  1,1,0 	load array size
 74:    MUL  0,1,0 	compute the offset
 75:    POP  1,0(6) 	load lhs adress to ac1
 76:    ADD  0,0,1 	compute the real index adress a[index]
 77:     LD  1,0(0) 	load bytes
 78:   PUSH  1,0(6) 	push bytes 
 79:    POP  1,0(6) 	pop right
 80:    POP  0,0(6) 	pop left
 81:    ADD  0,0,1 	op +
 82:   PUSH  0,0(6) 	op: load left
* <- Op
 83:    POP  0,0(6) 	move result to register
 84:    OUT  0,0,0 	output value in register[ac / fac]
* -> assign
* -> Const
 85:    LDC  0,2000(0) 	load integer const
 86:   PUSH  0,0(6) 	store exp
* <- Const
 87:    POP  0,0(6) 	copy bytes
 88:   PUSH  0,0(3) 	PUSH bytes
* call function: 
* malloc
* -> Id
 89:     LD  0,-1(5) 	load id value
 90:   PUSH  0,0(6) 	store exp
* <- Id
 91:    LDC  0,93(0) 	store the return adress
 92:    POP  7,0(6) 	ujp to the function body
 93:    LDA  3,1(3) 	pop parameters
 94:    LDA  1,-2(2) 	move the adress of ID
 95:    POP  0,0(6) 	copy bytes
 96:     ST  0,0(1) 	copy bytes
* <- assign
* -> Id
 97:     LD  0,-2(2) 	load id value
 98:   PUSH  0,0(6) 	store exp
* <- Id
 99:    POP  0,0(6) 	move result to register
100:    OUT  0,0,0 	output value in register[ac / fac]
101:    MOV  3,2,0 	restore the caller sp
102:     LD  2,0(2) 	resotre the caller fp
103:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  9:    LDA  7,94(7) 	skip the function body
* function entry:
* malloc
104:    LDC  0,107(0) 	get function adress
105:     ST  0,-1(5) 	set function adress
107:    MOV  1,2,0 	store the caller fp temporarily
108:    MOV  2,3,0 	exchang the stack(context)
109:   PUSH  1,0(3) 	push the caller fp
110:   PUSH  0,0(3) 	push the return adress
* -> Id
111:     LD  0,1(2) 	load id value
112:   PUSH  0,0(6) 	store exp
* <- Id
113:    POP  0,0(6) 	get malloc parameters
114:  MALLOC  0,0(0) 	system call for malloc
115:    MOV  3,2,0 	restore the caller sp
116:     LD  2,0(2) 	resotre the caller fp
117:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
106:    LDA  7,11(7) 	skip the function body
* function entry:
* free
118:    LDC  0,121(0) 	get function adress
119:     ST  0,-2(5) 	set function adress
121:    MOV  1,2,0 	store the caller fp temporarily
122:    MOV  2,3,0 	exchang the stack(context)
123:   PUSH  1,0(3) 	push the caller fp
124:   PUSH  0,0(3) 	push the return adress
* -> Id
125:     LD  0,1(2) 	load id value
126:   PUSH  0,0(6) 	store exp
* <- Id
127:    POP  0,0(6) 	get free parameters
128:  FREE  0,0(0) 	system call for free
129:    MOV  3,2,0 	restore the caller sp
130:     LD  2,0(2) 	resotre the caller fp
131:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
120:    LDA  7,11(7) 	skip the function body
* call main function
132:     LD  1,0(5) 	get main function adress
133:    LDC  0,135(0) 	store the return adress
134:    LDA  7,0(1) 	ujp to the function body
135:   HALT  0,0,0 	
