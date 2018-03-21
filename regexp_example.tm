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
* function entry:
* rep2post
  8:    LDA  3,-1(3) 	stack expand for function variable
  9:     GO  0,0,0 	go to label
 10:    MOV  1,2,0 	store the caller fp temporarily
 11:    MOV  2,3,0 	exchang the stack(context)
 12:   PUSH  1,0(3) 	push the caller fp
 13:   PUSH  0,0(3) 	push the return adress
 14:    LDA  3,-1(3) 	stack expand
 15:    LDC  0,0(0) 	load integer const
 16:   PUSH  0,0(6) 	store exp
 17:    LDA  0,-2(2) 	load id adress
 18:   PUSH  0,0(6) 	push array adress to mp
 19:    POP  1,0(6) 	move the adress of ID
 20:    POP  0,0(6) 	copy bytes
 21:     ST  0,0(1) 	copy bytes
* while stmt:
 22:  LABEL  1,0,0 	generate label
 23:     LD  0,3(2) 	load id value
 24:   PUSH  0,0(6) 	store exp
 25:    POP  0,0(6) 	pop the adress
 26:     LD  1,0(0) 	load bytes
 27:   PUSH  1,0(6) 	push bytes 
 28:    LDC  0,0(0) 	load integer const
 29:   PUSH  0,0(6) 	store exp
 30:    POP  1,0(6) 	pop right
 31:    POP  0,0(6) 	pop left
 32:    SUB  0,0,1 	op ==, convertd_type
 33:    JNE  0,2(7) 	br if true
 34:    LDC  0,0(0) 	false case
 35:    LDA  7,1(7) 	unconditional jmp
 36:    LDC  0,1(0) 	true case
 37:   PUSH  0,0(6) 	
 38:    POP  0,0(6) 	pop from the mp
 39:    JNE  0,1,7 	true case:, skip the break, execute the block code
 40:     GO  2,0,0 	go to label
 41:     LD  0,3(2) 	load id value
 42:   PUSH  0,0(6) 	store exp
 43:    POP  0,0(6) 	pop the adress
 44:     LD  1,0(0) 	load bytes
 45:   PUSH  1,0(6) 	push bytes 
 46:    LDC  0,40(0) 	load char const
 47:   PUSH  0,0(6) 	store exp
 48:    POP  0,0,6 	pop case exp
 49:    POP  1,0,6 	pop switch exp
 50:    SUB  0,0,1 	op ==, convertd_type
 51:    JEQ  0,2(7) 	go to case if statisfy
 52:     GO  5,0,0 	go to label
 53:    LDA  7,1(7) 	unconditional jmp
 54:     GO  4,0,0 	go to label
 55:  LABEL  4,0,0 	generate label
 56:    LDC  0,97(0) 	load char const
 57:   PUSH  0,0(6) 	store exp
 58:    POP  0,0(6) 	move result to register
 59:    OUT  0,1,0 	output value in register[ac / fac]
 60:     GO  3,0,0 	go to label
 61:  LABEL  5,0,0 	generate label
 62:     LD  0,3(2) 	load id value
 63:   PUSH  0,0(6) 	store exp
 64:    POP  0,0(6) 	pop the adress
 65:     LD  1,0(0) 	load bytes
 66:   PUSH  1,0(6) 	push bytes 
 67:    LDC  0,41(0) 	load char const
 68:   PUSH  0,0(6) 	store exp
 69:    POP  0,0,6 	pop case exp
 70:    POP  1,0,6 	pop switch exp
 71:    SUB  0,0,1 	op ==, convertd_type
 72:    JEQ  0,2(7) 	go to case if statisfy
 73:     GO  7,0,0 	go to label
 74:    LDA  7,1(7) 	unconditional jmp
 75:     GO  6,0,0 	go to label
 76:  LABEL  6,0,0 	generate label
 77:    LDC  0,98(0) 	load char const
 78:   PUSH  0,0(6) 	store exp
 79:    POP  0,0(6) 	move result to register
 80:    OUT  0,1,0 	output value in register[ac / fac]
 81:     GO  3,0,0 	go to label
 82:  LABEL  7,0,0 	generate label
 83:     LD  0,3(2) 	load id value
 84:   PUSH  0,0(6) 	store exp
 85:    POP  0,0(6) 	pop the adress
 86:     LD  1,0(0) 	load bytes
 87:   PUSH  1,0(6) 	push bytes 
 88:     GO  8,0,0 	go to label
 89:  LABEL  8,0,0 	generate label
 90:    LDC  0,99(0) 	load char const
 91:   PUSH  0,0(6) 	store exp
 92:    POP  0,0(6) 	move result to register
 93:    OUT  0,1,0 	output value in register[ac / fac]
 94:     GO  3,0,0 	go to label
 95:  LABEL  9,0,0 	generate label
 96:  LABEL  3,0,0 	generate label
 97:     LD  0,3(2) 	load id value
 98:   PUSH  0,0(6) 	store exp
 99:    POP  0,0(6) 	pop right
100:     LD  0,3(2) 	load id value
101:   PUSH  0,0(6) 	store exp
102:    LDC  0,1(0) 	load integer const
103:   PUSH  0,0(6) 	store exp
104:    POP  0,0(6) 	load index value to ac
105:    LDC  1,1,0 	load pointkind size
106:    MUL  0,1,0 	compute the offset
107:    POP  1,0(6) 	load lhs adress to ac1
108:    ADD  0,1,0 	compute the real index adress
109:   PUSH  0,0(6) 	op: load left
110:    LDA  0,3(2) 	load id adress
111:   PUSH  0,0(6) 	push array adress to mp
112:    POP  1,0(6) 	move the adress of ID
113:    POP  0,0(6) 	copy bytes
114:     ST  0,0(1) 	copy bytes
115:     GO  1,0,0 	go to label
116:  LABEL  2,0,0 	generate label
117:    MOV  3,2,0 	restore the caller sp
118:     LD  2,0(2) 	resotre the caller fp
119:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
120:  LABEL  0,0,0 	generate label
* call main function
* File: regexp_example.tm
* Standard prelude:
121:    LDC  6,65535(0) 	load mp adress
122:     ST  0,0(0) 	clear location 0
123:    LDC  5,4095(0) 	load gp adress from location 1
124:     ST  0,1(0) 	clear location 1
125:    LDC  4,2000(0) 	load gp adress from location 1
126:    LDC  2,60000(0) 	load first fp from location 2
127:    LDC  3,60000(0) 	load first sp from location 2
128:     ST  0,2(0) 	clear location 2
* End of standard prelude.
* function entry:
* main
129:    LDC  0,132(0) 	get function adress
130:     ST  0,0(5) 	set function adress
131:     GO  10,0,0 	go to label
132:    MOV  1,2,0 	store the caller fp temporarily
133:    MOV  2,3,0 	exchang the stack(context)
134:   PUSH  1,0(3) 	push the caller fp
135:   PUSH  0,0(3) 	push the return adress
136:    LDA  3,-1(3) 	stack expand
137:    LDC  1,10(0) 	get function adress from struct
138:     ST  1,1(3) 	Init Struct Instance
* push function parameters
139:    LDC  0,40(0) 	load char const
140:     ST  0,-6(4) 	store exp
141:    LDC  0,40(0) 	load char const
142:     ST  0,-5(4) 	store exp
143:    LDC  0,93(0) 	load char const
144:     ST  0,-4(4) 	store exp
145:    LDC  0,115(0) 	load char const
146:     ST  0,-3(4) 	store exp
147:    LDC  0,41(0) 	load char const
148:     ST  0,-2(4) 	store exp
149:    LDA  0,-6(4) 	load char const
150:   PUSH  0,0(6) 	store exp
151:    POP  0,0(6) 	copy bytes
152:   PUSH  0,0(3) 	PUSH bytes
153:    LDA  0,-2(2) 	load id adress
154:   PUSH  0,0(6) 	push array adress to mp
155:    POP  0,0(6) 	
156:   PUSH  0,0(3) 	
157:    LDA  0,0(2) 	load env
158:   PUSH  0,0(3) 	store env
* call function: 
* rep2post
159:    LDA  0,-2(2) 	load id adress
160:   PUSH  0,0(6) 	push array adress to mp
161:    POP  1,0,6 	load adress of lhs struct
162:    LDC  0,0,0 	load offset of member
163:    ADD  0,0,1 	compute the real adress if pointK
164:   PUSH  0,0(6) 	
165:    POP  0,0(6) 	load adress from mp
166:     LD  1,0(0) 	copy bytes
167:   PUSH  1,0(6) 	push a.x value into tmp
168:    LDC  0,170(0) 	store the return adress
169:    POP  7,0(6) 	ujp to the function body
170:    LDA  3,1(3) 	pop parameters
171:    LDA  3,1(3) 	pop env
172:    LDA  3,1(3) 	pop parameters
173:    MOV  3,2,0 	restore the caller sp
174:     LD  2,0(2) 	resotre the caller fp
175:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end:
176:  LABEL  10,0,0 	generate label
* call main function
177:     LD  1,0(5) 	get main function adress
178:    LDC  0,180(0) 	store the return adress
179:    LDA  7,0(1) 	ujp to the function body
180:   HALT  0,0,0 	
