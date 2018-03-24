* File: regexp_example.tm
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
  9:    LDC  0,0(0) 	load integer const
 10:   PUSH  0,0(6) 	store exp
 11:    LDA  0,0(5) 	load id adress
 12:   PUSH  0,0(6) 	push array adress to mp
 13:    POP  1,0(6) 	move the adress of ID
 14:    POP  0,0(6) 	copy bytes
 15:     ST  0,0(1) 	copy bytes
* function entry:
* malloc
 16:    LDA  3,-1(3) 	stack expand for function variable
 17:    LDC  0,20(0) 	get function adress
 18:     ST  0,-1(5) 	set function adress
 19:     GO  0,0,0 	go to label
 20:    MOV  1,2,0 	store the caller fp temporarily
 21:    MOV  2,3,0 	exchang the stack(context)
 22:   PUSH  1,0(3) 	push the caller fp
 23:   PUSH  0,0(3) 	push the return adress
 24:     LD  0,2(2) 	load id value
 25:   PUSH  0,0(6) 	store exp
 26:    POP  0,0(6) 	get malloc parameters
 27:  MALLOC  0,0(0) 	system call for malloc
 28:    MOV  3,2,0 	restore the caller sp
 29:     LD  2,0(2) 	resotre the caller fp
 30:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 31:  LABEL  0,0,0 	generate label
* function entry:
* free
 32:    LDA  3,-1(3) 	stack expand for function variable
 33:    LDC  0,36(0) 	get function adress
 34:     ST  0,-2(5) 	set function adress
 35:     GO  1,0,0 	go to label
 36:    MOV  1,2,0 	store the caller fp temporarily
 37:    MOV  2,3,0 	exchang the stack(context)
 38:   PUSH  1,0(3) 	push the caller fp
 39:   PUSH  0,0(3) 	push the return adress
 40:     LD  0,2(2) 	load id value
 41:   PUSH  0,0(6) 	store exp
 42:    POP  0,0(6) 	get free parameters
 43:  FREE  0,0(0) 	system call for free
 44:    MOV  3,2,0 	restore the caller sp
 45:     LD  2,0(2) 	resotre the caller fp
 46:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
 47:  LABEL  1,0,0 	generate label
* function entry:
* printStr
 48:    LDA  3,-1(3) 	stack expand for function variable
 49:    LDC  0,52(0) 	get function adress
 50:     ST  0,-3(5) 	set function adress
 51:     GO  2,0,0 	go to label
 52:    MOV  1,2,0 	store the caller fp temporarily
 53:    MOV  2,3,0 	exchang the stack(context)
 54:   PUSH  1,0(3) 	push the caller fp
 55:   PUSH  0,0(3) 	push the return adress
* while stmt:
 56:  LABEL  3,0,0 	generate label
 57:     LD  0,2(2) 	load id value
 58:   PUSH  0,0(6) 	store exp
 59:    POP  0,0(6) 	pop the adress
 60:     LD  1,0(0) 	load bytes
 61:   PUSH  1,0(6) 	push bytes 
 62:    LDC  0,0(0) 	load integer const
 63:   PUSH  0,0(6) 	store exp
 64:    POP  1,0(6) 	pop right
 65:    POP  0,0(6) 	pop left
 66:    SUB  0,0,1 	op ==, convertd_type
 67:    JNE  0,2(7) 	br if true
 68:    LDC  0,0(0) 	false case
 69:    LDA  7,1(7) 	unconditional jmp
 70:    LDC  0,1(0) 	true case
 71:   PUSH  0,0(6) 	
 72:    POP  0,0(6) 	pop from the mp
 73:    JNE  0,1,7 	true case:, skip the break, execute the block code
 74:     GO  4,0,0 	go to label
 75:     LD  0,2(2) 	load id value
 76:   PUSH  0,0(6) 	store exp
 77:    POP  0,0(6) 	pop right
 78:     LD  0,2(2) 	load id value
 79:   PUSH  0,0(6) 	store exp
 80:     LD  0,2(2) 	load id value
 81:   PUSH  0,0(6) 	store exp
 82:    LDC  0,1(0) 	load integer const
 83:   PUSH  0,0(6) 	store exp
 84:    POP  0,0(6) 	load index value to ac
 85:    LDC  1,1,0 	load pointkind size
 86:    MUL  0,1,0 	compute the offset
 87:    POP  1,0(6) 	load lhs adress to ac1
 88:    ADD  0,1,0 	compute the real index adress
 89:   PUSH  0,0(6) 	op: load left
 90:    LDA  0,2(2) 	load id adress
 91:   PUSH  0,0(6) 	push array adress to mp
 92:    POP  1,0(6) 	move the adress of ID
 93:    POP  0,0(6) 	copy bytes
 94:     ST  0,0(1) 	copy bytes
 95:    POP  0,0(6) 	pop the adress
 96:     LD  1,0(0) 	load bytes
 97:   PUSH  1,0(6) 	push bytes 
 98:    POP  0,0(6) 	move result to register
 99:    OUT  0,1,0 	output value in register[ac / fac]
100:     GO  3,0,0 	go to label
101:  LABEL  4,0,0 	generate label
102:    MOV  3,2,0 	restore the caller sp
103:     LD  2,0(2) 	resotre the caller fp
104:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
105:  LABEL  2,0,0 	generate label
* call main function
* File: regexp_example.tm
* Standard prelude:
106:    LDC  6,65535(0) 	load mp adress
107:     ST  0,0(0) 	clear location 0
108:    LDC  5,4095(0) 	load gp adress from location 1
109:     ST  0,1(0) 	clear location 1
110:    LDC  4,2000(0) 	load gp adress from location 1
111:    LDC  2,60000(0) 	load first fp from location 2
112:    LDC  3,60000(0) 	load first sp from location 2
113:     ST  0,2(0) 	clear location 2
* End of standard prelude.
114:    LDA  3,-1(3) 	stack expand
115:    LDA  3,-1(3) 	stack expand
* function entry:
* test
116:    LDA  3,-1(3) 	stack expand for function variable
117:     GO  5,0,0 	go to label
118:    MOV  1,2,0 	store the caller fp temporarily
119:    MOV  2,3,0 	exchang the stack(context)
120:   PUSH  1,0(3) 	push the caller fp
121:   PUSH  0,0(3) 	push the return adress
122:    LDA  3,-1(3) 	stack expand
123:     LD  0,-2(2) 	load id value
124:   PUSH  0,0(6) 	store exp
125:    POP  0,0(6) 	pop right
126:     LD  0,-2(2) 	load id value
127:   PUSH  0,0(6) 	store exp
128:    LDC  0,1(0) 	load integer const
129:   PUSH  0,0(6) 	store exp
130:    POP  1,0(6) 	pop right
131:    POP  0,0(6) 	pop left
132:    SUB  0,0,1 	op -
133:   PUSH  0,0(6) 	op: load left
134:    LDA  0,-2(2) 	load id adress
135:   PUSH  0,0(6) 	push array adress to mp
136:    POP  1,0(6) 	move the adress of ID
137:    POP  0,0(6) 	copy bytes
138:     ST  0,0(1) 	copy bytes
139:     LD  0,-2(2) 	load id value
140:   PUSH  0,0(6) 	store exp
141:    POP  0,0(6) 	move result to register
142:    OUT  0,0,0 	output value in register[ac / fac]
143:    MOV  3,2,0 	restore the caller sp
144:     LD  2,0(2) 	resotre the caller fp
145:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
146:  LABEL  5,0,0 	generate label
* call main function
* File: regexp_example.tm
* Standard prelude:
147:    LDC  6,65535(0) 	load mp adress
148:     ST  0,0(0) 	clear location 0
149:    LDC  5,4095(0) 	load gp adress from location 1
150:     ST  0,1(0) 	clear location 1
151:    LDC  4,2000(0) 	load gp adress from location 1
152:    LDC  2,60000(0) 	load first fp from location 2
153:    LDC  3,60000(0) 	load first sp from location 2
154:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* main
155:    LDC  0,158(0) 	get function adress
156:     ST  0,-4(5) 	set function adress
157:     GO  6,0,0 	go to label
158:    MOV  1,2,0 	store the caller fp temporarily
159:    MOV  2,3,0 	exchang the stack(context)
160:   PUSH  1,0(3) 	push the caller fp
161:   PUSH  0,0(3) 	push the return adress
162:    LDC  0,111(0) 	load integer const
163:   PUSH  0,0(6) 	store exp
164:    POP  0,0(6) 	move result to register
165:    OUT  0,0,0 	output value in register[ac / fac]
166:    MOV  3,2,0 	restore the caller sp
167:     LD  2,0(2) 	resotre the caller fp
168:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
169:  LABEL  6,0,0 	generate label
* call main function
170:     LD  1,-4(5) 	get main function adress
171:    LDC  0,173(0) 	store the return adress
172:    LDA  7,0(1) 	ujp to the function body
173:   HALT  0,0,0 	
