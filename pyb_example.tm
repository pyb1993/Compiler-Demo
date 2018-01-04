* File: pyb_example.tm
* Standard prelude:
  0:    LDC  6,65535(0) 	load mp adress
  1:     ST  0,0(0) 	clear location 0
  2:    LDC  5,4095(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 1
  4:    LDC  2,60000(0) 	load first fp from location 2
  5:    LDC  3,60000(0) 	load first sp from location 2
  6:     ST  0,2(0) 	clear location 2
* End of standard prelude.
  7:    LDA  3,-1(3) 	stack expand
  8:    MOV  3,2,0 	resotre stack in struct
* function entry:
* g
  9:    LDC  0,12(0) 	get function adress
 10:     ST  0,0(5) 	set function adress
 12:    MOV  1,2,0 	store the caller fp temporarily
 13:    MOV  2,3,0 	exchang the stack(context)
 14:   PUSH  1,0(3) 	push the caller fp
 15:   PUSH  0,0(3) 	push the return adress
* -> Const
 16:    LDC  0,10086(0) 	load integer const
 17:   PUSH  0,0(6) 	store exp
* <- Const
 18:    MOV  3,2,0 	restore the caller sp
 19:     LD  2,0(2) 	resotre the caller fp
 20:  RETURN  0,-1,3 	return to the caller
 21:    MOV  3,2,0 	restore the caller sp
 22:     LD  2,0(2) 	resotre the caller fp
 23:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
 11:    LDA  7,12(7) 	skip the function body
* call main function
