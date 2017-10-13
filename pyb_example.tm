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
  9:    LDC  0,100(0) 	load integer const
* <- Const
 10:     ST  0,0(5) 	assign: store value
* <- assign
* enter the function
 11:    MOV  1,2,0 	store the caller fp temporarily
 12:    MOV  2,3,0 	exchang the stack(context)
 13:   PUSH  1,0(3) 	push the caller fp
 14:   PUSH  0,0(3) 	push the return adress
* -> Op
* -> Id
 15:     LD  0,0(5) 	load id value
* <- Id
 16:     ST  0,0(6) 	op: push left
* -> Const
 17:    LDC  0,20(0) 	load integer const
* <- Const
 18:     LD  1,0(6) 	op: load left
 19:    ADD  0,1,0 	op +
* <- Op
 20:    OUT  0,0,0 	output value in register[ac]
 21:    MOV  3,2,0 	restore the caller sp
 22:     LD  2,0(2) 	resotre the caller fp
 23:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* leave the function
* enter the function
 24:    MOV  1,2,0 	store the caller fp temporarily
 25:    MOV  2,3,0 	exchang the stack(context)
 26:   PUSH  1,0(3) 	push the caller fp
 27:   PUSH  0,0(3) 	push the return adress
 28:    LDA  0,1(7) 	store the return adress
 29:    LDC  7,11(0) 	ujp to the function body
 30:    MOV  3,2,0 	restore the caller sp
 31:     LD  2,0(2) 	resotre the caller fp
 32:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* leave the function
* call main function
  7:    LDC  0,33(0) 	store the return adress
  8:    LDC  7,24(0) 	ujp to the function body
 33:   HALT  0,0,0 	
