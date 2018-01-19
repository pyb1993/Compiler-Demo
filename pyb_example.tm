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
* function entry:
* malloc
  8:    LDC  0,11(0) 	get function adress
  9:     ST  0,0(5) 	set function adress
 11:    MOV  1,2,0 	store the caller fp temporarily
 12:    MOV  2,3,0 	exchang the stack(context)
 13:   PUSH  1,0(3) 	push the caller fp
 14:   PUSH  0,0(3) 	push the return adress
* -> Id
 15:     LD  0,1(2) 	load id value
 16:   PUSH  0,0(6) 	store exp
* <- Id
 17:    POP  0,0(6) 	get malloc parameters
 18:  MALLOC  0,0(0) 	system call for malloc
 19:    MOV  3,2,0 	restore the caller sp
 20:     LD  2,0(2) 	resotre the caller fp
 21:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 10:    LDA  7,11(7) 	skip the function body
* function entry:
* free
 22:    LDC  0,25(0) 	get function adress
 23:     ST  0,-1(5) 	set function adress
 25:    MOV  1,2,0 	store the caller fp temporarily
 26:    MOV  2,3,0 	exchang the stack(context)
 27:   PUSH  1,0(3) 	push the caller fp
 28:   PUSH  0,0(3) 	push the return adress
* -> Id
 29:     LD  0,1(2) 	load id value
 30:   PUSH  0,0(6) 	store exp
* <- Id
 31:    POP  0,0(6) 	get free parameters
 32:  FREE  0,0(0) 	system call for free
 33:    MOV  3,2,0 	restore the caller sp
 34:     LD  2,0(2) 	resotre the caller fp
 35:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 24:    LDA  7,11(7) 	skip the function body
* call main function
* File: pyb_example.tm
* Standard prelude:
 36:    LDC  6,65535(0) 	load mp adress
 37:     ST  0,0(0) 	clear location 0
 38:    LDC  5,4095(0) 	load gp adress from location 1
 39:     ST  0,1(0) 	clear location 1
 40:    LDC  4,2000(0) 	load gp adress from location 1
 41:    LDC  2,60000(0) 	load first fp from location 2
 42:    LDC  3,60000(0) 	load first sp from location 2
 43:     ST  0,2(0) 	clear location 2
* End of standard prelude.
 44:    LDA  3,-1(3) 	stack expand
* -> Const
 45:    LDC  0,0(0) 	load integer const
 46:   PUSH  0,0(6) 	store exp
* <- Const
 47:    LDA  1,-2(5) 	move the adress of ID
 48:    POP  0,0(6) 	copy bytes
 49:     ST  0,0(1) 	copy bytes
 50:    LDA  3,-1(3) 	stack expand
 51:    LDA  3,-1(3) 	stack expand
 52:    LDA  3,-1(3) 	stack expand
 53:    MOV  3,2,0 	resotre stack in struct
 54:    LDA  3,-1(3) 	stack expand
 55:    LDA  3,-1(3) 	stack expand
 56:    LDA  3,-1(3) 	stack expand
* function entry:
* dup
 58:    MOV  1,2,0 	store the caller fp temporarily
 59:    MOV  2,3,0 	exchang the stack(context)
 60:   PUSH  1,0(3) 	push the caller fp
 61:   PUSH  0,0(3) 	push the return adress
 62:    MOV  3,2,0 	restore the caller sp
 63:     LD  2,0(2) 	resotre the caller fp
 64:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 57:    LDA  7,7(7) 	skip the function body
* function entry:
* free
 66:    MOV  1,2,0 	store the caller fp temporarily
 67:    MOV  2,3,0 	exchang the stack(context)
 68:   PUSH  1,0(3) 	push the caller fp
 69:   PUSH  0,0(3) 	push the return adress
 70:    MOV  3,2,0 	restore the caller sp
 71:     LD  2,0(2) 	resotre the caller fp
 72:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 65:    LDA  7,7(7) 	skip the function body
* function entry:
* match
 74:    MOV  1,2,0 	store the caller fp temporarily
 75:    MOV  2,3,0 	exchang the stack(context)
 76:   PUSH  1,0(3) 	push the caller fp
 77:   PUSH  0,0(3) 	push the return adress
 78:    MOV  3,2,0 	restore the caller sp
 79:     LD  2,0(2) 	resotre the caller fp
 80:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 73:    LDA  7,7(7) 	skip the function body
 81:    MOV  3,2,0 	resotre stack in struct
* call main function
