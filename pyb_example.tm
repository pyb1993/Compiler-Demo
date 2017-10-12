* File: pyb_example.tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
  2:     LD  5,1(0) 	load gp adress from location 1
  3:     ST  0,1(0) 	clear location 2
  4:     LD  2,2(0) 	load first fp from location 2
  5:     LD  3,2(0) 	load first sp from location 2
  6:     ST  0,2(0) 	clear location 3
* End of standard prelude.
  7:     ST  7,0(5) 	load the function adress
  8:    MOV  1,7,0 	store return adress
  9:    MOV  2,3,0 	store the fp
 10:   PUSH  0,0(3) 	push the caller fp
 11:   PUSH  0,0(3) 	push the return adress
* -> Id
 12:     LD  0,-2(5) 	load id value
* <- Id
 13:    OUT  0,0,0 	output value in register[ac]
 14:     LD  0,-1(2) 	store the return adress
 15:    MOV  3,2,0 	restore the caller sp
 16:     LD  2,0(2) 	resotre the caller fp
 17:  return  0,0,0 	return to adress : reg[fp]+1
 18:     ST  7,-1(5) 	load the function adress
 19:    MOV  1,7,0 	store return adress
 20:    MOV  2,3,0 	store the fp
 21:   PUSH  0,0(3) 	push the caller fp
 22:   PUSH  0,0(3) 	push the return adress
 23:     LD  0,-1(2) 	store the return adress
 24:    MOV  3,2,0 	restore the caller sp
 25:     LD  2,0(2) 	resotre the caller fp
 26:  return  0,0,0 	return to adress : reg[fp]+1
 27:    LDA  7,-1(5) 	ujp to the function body
* End of execution.
 28:   HALT  0,0,0 	
