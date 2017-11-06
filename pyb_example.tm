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
 14:    MOV  3,2,0 	restore the caller sp
 15:     LD  2,0(2) 	resotre the caller fp
 16:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* function end
  7:    LDA  7,9(7) 	skip the function body
* call main function
 17:    LDC  0,19(0) 	store the return adress
 18:    LDC  7,8(0) 	ujp to the function body
 19:   HALT  0,0,0 	
