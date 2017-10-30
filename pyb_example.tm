* ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍýýýý««««««««þîþîþîþîþîþîþîþpyb_example.tm
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
* ->index k
* ->index k
* -> Id
 12:    LDA  0,1(2) 	load id value
 13:   PUSH  0,0(6) 	store exp
* <- Id
* -> Const
 14:    LDC  0,0(0) 	load integer const
 15:   PUSH  0,0(6) 	store exp
* <- Const
 16:    POP  0,0(6) 	load index value to ac
 17:    LDC  1,10,0 	load array size
 18:    MUL  0,1,0 	compute the offset
 19:    POP  1,0(6) 	load lhs adress to ac1
 20:    ADD  0,0,1 	compute the real index adress a[index]
 21:   PUSH  0,0(6) 	
* -> Const
 22:    LDC  0,0(0) 	load integer const
 23:   PUSH  0,0(6) 	store exp
* <- Const
 24:    POP  0,0(6) 	load index value to ac
 25:    LDC  1,1,0 	load array size
 26:    MUL  0,1,0 	compute the offset
 27:    POP  1,0(6) 	load lhs adress to ac1
 28:    ADD  0,0,1 	compute the real index adress a[index]
 29:     LD  1,0(0) 	load value
 30:   PUSH  1,0(6) 	
 31:    POP  0,0(6) 	move result to register
 32:    OUT  0,0,0 	output value in register[ac / fac]
 33:    MOV  3,2,0 	restore the caller sp
 34:     LD  2,0(2) 	resotre the caller fp
 35:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,28(7) 	skip the function body
* function entry
 37:    MOV  1,2,0 	store the caller fp temporarily
 38:    MOV  2,3,0 	exchang the stack(context)
 39:   PUSH  1,0(3) 	push the caller fp
 40:   PUSH  0,0(3) 	push the return adress
 41:   PUSH  0,0(3) 	stack expand
* -> Id
 42:    LDA  0,-101(2) 	load id value
 43:   PUSH  0,0(6) 	store exp
* <- Id
 44:    POP  0,0(6) 	pop exp 
 45:   PUSH  0,0(3) 	push parameter into stack
 46:    LDA  0,1(7) 	store the return adress
 47:    LDC  7,8(0) 	ujp to the function body
 48:    LDA  3,1(3) 	pop parameters
 49:    MOV  3,2,0 	restore the caller sp
 50:     LD  2,0(2) 	resotre the caller fp
 51:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 36:    LDA  7,15(7) 	skip the function body
* call main function
 52:    LDC  0,54(0) 	store the return adress
 53:    LDC  7,37(0) 	ujp to the function body
 54:   HALT  0,0,0 	
