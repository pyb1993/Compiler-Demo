int n
float k
k = 2
read n
int t1
int t2
t1 = 1
t2 = 1
while(k < n + 3)
{
	int tmp
	tmp = t1
	t1 = t2
	t2 = tmp + t2
	k = k + 1
}
write t2
write t2 / 3.0

/*
to do list
1.1 check the assign,read,write
1. implement a simple macro: think the code as a stream of token, and replace the token while the tokenString is found in the macro table.
	the easy way is to call getToken with replaced tokenString and return the replaced token
	which is the preporcessor !
	to implement the procedure, we need to save the linebuf,
2. implement break
3. implement !,and,or
4  implement function
5  implement array
6  implement struct
7  implement closure
8  define variable
9  auto x = 10; auto inference
10 import other file
11 continuation
*/
