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
  9:    LDC  9,100.000000(0) * <- Const
 10:     ST  9,0(5) 	assign: store value
* <- assign
* enter the function
 11:    MOV  1,2,0 	store the caller fp temporarily
 12:    MOV  2,3,0 	exchang the stack(context)
 13:   PUSH  1,0(3) 	push the caller fp
 14:   PUSH  0,0(3) 	push the return adress
* -> assign
* -> Const
 15:    LDC  0,100(0) 	load integer const
* <- Const
 16:    MOV  9,0,0 	move register reg(s) tp reg(r)
 17:     ST  9,-2(2) 	assign: store value
* <- assign
* -> Op
* -> Id
 18:     LD  9,-2(2) 	load id value
* <- Id
 19:     ST  9,0(6) 	op: push left
* -> Const
 20:    LDC  9,20.754299(0) * <- Const
 21:     LD  10,0(6) 	op: load left
 22:    ADD  9,10,9 	op +
* <- Op
 23:    OUT  9,0,0 	output value in register[ac]
 24:    MOV  3,2,0 	restore the caller sp
 25:     LD  2,0(2) 	resotre the caller fp
 26:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* leave the function
* enter the function
 27:    MOV  1,2,0 	store the caller fp temporarily
 28:    MOV  2,3,0 	exchang the stack(context)
 29:   PUSH  1,0(3) 	push the caller fp
 30:   PUSH  0,0(3) 	push the return adress
 31:    LDA  0,1(7) 	store the return adress
 32:    LDC  7,11(0) 	ujp to the function body
 33:    MOV  3,2,0 	restore the caller sp
 34:     LD  2,0(2) 	resotre the caller fp
 35:  RETURN  0,-1,3 	return to adress : reg[fp]+1
* leave the function
* call main function
  7:    LDC  0,36(0) 	store the return adress
  8:    LDC  7,27(0) 	ujp to the function body
 36:   HALT  0,0,0 	
