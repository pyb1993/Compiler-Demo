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
* -> assign
* -> Const
  7:    LDC  0,10(0) 	load integer const
  8:   PUSH  0,0(6) 	store exp
* <- Const
  9:    POP  0,0(6) 	copy bytes
 10:    MOV  9,0,0 	move register 
 11:     ST  9,0(5) 	copy bytes 
* <- assign
* function entry
 13:    MOV  1,2,0 	store the caller fp temporarily
 14:    MOV  2,3,0 	exchang the stack(context)
 15:   PUSH  1,0(3) 	push the caller fp
 16:   PUSH  0,0(3) 	push the return adress
* -> if
* -> Op
* -> Id
 17:     LD  0,1(2) 	load id value
 18:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 19:    LDC  0,2(0) 	load integer const
 20:   PUSH  0,0(6) 	store exp
* <- Const
 21:    POP  1,0(6) 	pop right
 22:    POP  0,0(6) 	pop left
 23:    SUB  0,0,1 	op <
 24:    JLE  0,2(7) 	br if true
 25:    LDC  0,0(0) 	false case
 26:    LDA  7,1(7) 	unconditional jmp
 27:    LDC  0,1(0) 	true case
 28:   PUSH  0,0(6) 	op: load left
* <- Op
* if: jump to else belongs here
* -> Const
 30:    LDC  0,1(0) 	load integer const
 31:   PUSH  0,0(6) 	store exp
* <- Const
 32:    POP  0,0(6) 	op: POP left
 33:    MOV  9,0,0 	move register reg(s) tp reg(r)
 34:   PUSH  9,0(6) 	op: push left
 35:    MOV  3,2,0 	restore the caller sp
 36:     LD  2,0(2) 	resotre the caller fp
 37:  RETURN  0,-1,3 	return to the caller
* if: jump to end belongs here
 29:    POP  0,0(6) 	pop the condition value
 30:    JEQ  0,8(7) 	if: jmp to else
* -> Op
* -> Op
* -> Id
 39:     LD  0,1(2) 	load id value
 40:    MOV  9,0,0 	move from one reg(s) to reg(r)
 41:   PUSH  9,0(6) 	store exp
* <- Id
* -> Const
 42:    LDC  9,1.000000(0)
  43:   PUSH  9,0(6) 	store exp
* <- Const
 44:    POP  10,0(6) 	pop right
 45:    POP  9,0(6) 	pop left
 46:    SUB  9,9,10 	op -
 47:   PUSH  9,0(6) 	op: load left
* <- Op
 48:    POP  9,0(6) 	pop exp 
 49:    MOV  0,9,0 	
 50:   PUSH  0,0(3) 	push parameter into stack
 51:    LDA  0,1(7) 	store the return adress
 52:    LDC  7,13(0) 	ujp to the function body
 53:    LDA  3,1(3) 	pop parameters
* -> Op
* -> Id
 54:     LD  0,1(2) 	load id value
 55:    MOV  9,0,0 	move from one reg(s) to reg(r)
 56:   PUSH  9,0(6) 	store exp
* <- Id
* -> Const
 57:    LDC  9,2.000000(0)
  58:   PUSH  9,0(6) 	store exp
* <- Const
 59:    POP  10,0(6) 	pop right
 60:    POP  9,0(6) 	pop left
 61:    SUB  9,9,10 	op -
 62:   PUSH  9,0(6) 	op: load left
* <- Op
 63:    POP  9,0(6) 	pop exp 
 64:    MOV  0,9,0 	
 65:   PUSH  0,0(3) 	push parameter into stack
 66:    LDA  0,1(7) 	store the return adress
 67:    LDC  7,13(0) 	ujp to the function body
 68:    LDA  3,1(3) 	pop parameters
 69:    POP  10,0(6) 	pop right
 70:    POP  9,0(6) 	pop left
 71:    ADD  9,9,10 	op +
 72:   PUSH  9,0(6) 	op: load left
* <- Op
 73:    POP  9,0(6) 	op: POP left
 74:   PUSH  9,0(6) 	op: push left
 75:    MOV  3,2,0 	restore the caller sp
 76:     LD  2,0(2) 	resotre the caller fp
 77:  RETURN  0,-1,3 	return to the caller
 38:    LDA  7,39(7) 	jmp to end
* <- if
 78:    MOV  3,2,0 	restore the caller sp
 79:     LD  2,0(2) 	resotre the caller fp
 80:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 12:    LDA  7,68(7) 	skip the function body
* function entry
 82:    MOV  1,2,0 	store the caller fp temporarily
 83:    MOV  2,3,0 	exchang the stack(context)
 84:   PUSH  1,0(3) 	push the caller fp
 85:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Op
* -> Id
 86:     LD  0,1(2) 	load id value
 87:    MOV  9,0,0 	move from one reg(s) to reg(r)
 88:   PUSH  9,0(6) 	store exp
* <- Id
* -> Id
 89:     LD  0,2(2) 	load id value
 90:    MOV  9,0,0 	move from one reg(s) to reg(r)
 91:   PUSH  9,0(6) 	store exp
* <- Id
 92:    POP  10,0(6) 	pop right
 93:    POP  9,0(6) 	pop left
 94:    MUL  9,9,10 	op *
 95:   PUSH  9,0(6) 	op: load left
* <- Op
* -> Id
 96:     LD  9,3(2) 	load id value
 97:   PUSH  9,0(6) 	store exp
* <- Id
 98:    POP  10,0(6) 	pop right
 99:    POP  9,0(6) 	pop left
100:    MUL  9,9,10 	op *
101:   PUSH  9,0(6) 	op: load left
* <- Op
102:    POP  9,0(6) 	op: POP left
103:    MOV  0,9,0 	move register reg(s) tp reg(r)
104:   PUSH  0,0(6) 	op: push left
105:    MOV  3,2,0 	restore the caller sp
106:     LD  2,0(2) 	resotre the caller fp
107:  RETURN  0,-1,3 	return to the caller
108:    MOV  3,2,0 	restore the caller sp
109:     LD  2,0(2) 	resotre the caller fp
110:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 81:    LDA  7,29(7) 	skip the function body
* function entry
112:    MOV  1,2,0 	store the caller fp temporarily
113:    MOV  2,3,0 	exchang the stack(context)
114:   PUSH  1,0(3) 	push the caller fp
115:   PUSH  0,0(3) 	push the return adress
* -> Const
