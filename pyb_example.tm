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
  9:    LDA  3,-1(3) 	stack expand
 10:    LDA  3,-1(3) 	stack expand
 11:    LDA  3,-2(3) 	stack expand
 12:    MOV  3,2,0 	resotre stack in struct
* function entry:
* main
 13:    LDC  0,16(0) 	get function adress
 14:     ST  0,0(5) 	set function adress
 16:    MOV  1,2,0 	store the caller fp temporarily
 17:    MOV  2,3,0 	exchang the stack(context)
 18:   PUSH  1,0(3) 	push the caller fp
 19:   PUSH  0,0(3) 	push the return adress
* -> Const
 20:    LDC  0,97(0) 	load char const
 21:     ST  0,0(4) 	store exp
 22:    LDC  0,97(0) 	load char const
 23:     ST  0,1(4) 	store exp
 24:    LDC  0,97(0) 	load char const
 25:     ST  0,2(4) 	store exp
 26:    LDC  0,97(0) 	load char const
 27:     ST  0,3(4) 	store exp
 28:    LDA  0,0(4) 	load char const
 29:   PUSH  0,0(6) 	store exp
* <- Const
 30:    POP  0,0(6) 	move result to register
 31:    OUT  0,2,0 	output value in register[ac / fac]
* -> Const
 32:    LDC  0,97(0) 	load char const
 33:     ST  0,0(4) 	store exp
 34:    LDC  0,98(0) 	load char const
 35:     ST  0,1(4) 	store exp
 36:    LDC  0,99(0) 	load char const
 37:     ST  0,2(4) 	store exp
 38:    LDC  0,100(0) 	load char const
 39:     ST  0,3(4) 	store exp
 40:    LDC  0,101(0) 	load char const
 41:     ST  0,4(4) 	store exp
 42:    LDC  0,115(0) 	load char const
 43:     ST  0,5(4) 	store exp
 44:    LDC  0,49(0) 	load char const
 45:     ST  0,6(4) 	store exp
 46:    LDC  0,57(0) 	load char const
 47:     ST  0,7(4) 	store exp
 48:    LDC  0,52(0) 	load char const
 49:     ST  0,8(4) 	store exp
 50:    LDC  0,53(0) 	load char const
 51:     ST  0,9(4) 	store exp
 52:    LDC  0,35(0) 	load char const
 53:     ST  0,10(4) 	store exp
 54:    LDC  0,123(0) 	load char const
 55:     ST  0,11(4) 	store exp
 56:    LDC  0,-60(0) 	load char const
 57:     ST  0,12(4) 	store exp
 58:    LDC  0,-89(0) 	load char const
 59:     ST  0,13(4) 	store exp
 60:    LDC  0,-51(0) 	load char const
 61:     ST  0,14(4) 	store exp
 62:    LDC  0,-11(0) 	load char const
 63:     ST  0,15(4) 	store exp
 64:    LDC  0,125(0) 	load char const
 65:     ST  0,16(4) 	store exp
 66:    LDA  0,0(4) 	load char const
 67:   PUSH  0,0(6) 	store exp
* <- Const
 68:    POP  0,0(6) 	move result to register
 69:    OUT  0,2,0 	output value in register[ac / fac]
 70:    LDA  3,-1(3) 	stack expand
* -> Const
 71:    LDC  0,49(0) 	load char const
 72:     ST  0,0(4) 	store exp
 73:    LDC  0,50(0) 	load char const
 74:     ST  0,1(4) 	store exp
 75:    LDC  0,51(0) 	load char const
 76:     ST  0,2(4) 	store exp
 77:    LDC  0,-60(0) 	load char const
 78:     ST  0,3(4) 	store exp
 79:    LDC  0,-89(0) 	load char const
 80:     ST  0,4(4) 	store exp
 81:    LDC  0,-51(0) 	load char const
 82:     ST  0,5(4) 	store exp
 83:    LDC  0,-11(0) 	load char const
 84:     ST  0,6(4) 	store exp
 85:    LDA  0,0(4) 	load char const
 86:   PUSH  0,0(6) 	store exp
* <- Const
 87:    LDA  1,-2(2) 	move the adress of ID
 88:    POP  0,0(6) 	copy bytes
 89:     ST  0,0(1) 	copy bytes
* ->index k
* -> Id
 90:     LD  0,-2(2) 	load id value
 91:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 92:    LDC  0,1(0) 	load integer const
 93:   PUSH  0,0(6) 	store exp
* <- Const
 94:    POP  0,0(6) 	load index value to ac
 95:    LDC  1,1,0 	load array size
 96:    MUL  0,1,0 	compute the offset
 97:    POP  1,0(6) 	load lhs adress to ac1
 98:    ADD  0,0,1 	compute the real index adress a[index]
 99:     LD  1,0(0) 	load bytes
100:   PUSH  1,0(6) 	push bytes 
101:    POP  0,0(6) 	move result to register
102:    OUT  0,1,0 	output value in register[ac / fac]
* ->Single Op
* ->index k
* -> Id
103:     LD  0,-2(2) 	load id value
104:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
105:    LDC  0,3(0) 	load integer const
106:   PUSH  0,0(6) 	store exp
* <- Const
107:    POP  0,0(6) 	load index value to ac
108:    LDC  1,1,0 	load array size
109:    MUL  0,1,0 	compute the offset
110:    POP  1,0(6) 	load lhs adress to ac1
111:    ADD  0,0,1 	compute the real index adress a[index]
112:     LD  1,0(0) 	load bytes
113:   PUSH  1,0(6) 	push bytes 
114:    POP  0,0(6) 	pop right
115:   PUSH  0,0(6) 	
* <-Single Op
116:    POP  0,0(6) 	move result to register
117:    OUT  0,0,0 	output value in register[ac / fac]
* ->index k
* -> Id
118:     LD  0,-2(2) 	load id value
119:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
120:    LDC  0,4(0) 	load integer const
121:   PUSH  0,0(6) 	store exp
* <- Const
122:    POP  0,0(6) 	load index value to ac
123:    LDC  1,1,0 	load array size
124:    MUL  0,1,0 	compute the offset
125:    POP  1,0(6) 	load lhs adress to ac1
126:    ADD  0,0,1 	compute the real index adress a[index]
127:     LD  1,0(0) 	load bytes
128:   PUSH  1,0(6) 	push bytes 
129:    POP  0,0(6) 	move result to register
130:    OUT  0,1,0 	output value in register[ac / fac]
131:    MOV  3,2,0 	restore the caller sp
132:     LD  2,0(2) 	resotre the caller fp
133:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 15:    LDA  7,118(7) 	skip the function body
* call main function
134:     LD  1,0(5) 	get main function adress
135:    LDC  0,137(0) 	store the return adress
136:    LDA  7,0(1) 	ujp to the function body
137:   HALT  0,0,0 	
