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
float n
n = 10
float f(int n)
{
	if (n <= 2)
		return 1
	else
		return f(n-1)+f(n-2)
}

float f2(int a,int b,float c)
{
    return a * b * c
}


void main()
{
	write f(f2(f2(4,f(4),0.4),1,1))
	write f(8) + f2(1,2,6)
}



*/


/*

void f(float *x,float *y)
{
	
	if(*x < *y)
		*x  = -*y
	else
		*y = -*x
		
}

void main()
{
	int x 
	int y
	x = 1
	y = 2
	f(&x,&y)
	write x
	write y

}



*/

/*
	(int [10]) *a
	int b[10][10]
	a = &b
	b[1][1] = 100
	write a[1][1]
	a[2][5] = 32
	write b[2][5]
	*/

	/*
	struct test b[6]
	struct test a[10]
	a[5].x = 1
	a[5].c.m = 10
	a[5].c.d = a[5].c.m * a[5].c.m
	b[3] = a[5]
	write b[3].x
	write b[3].c.d
	

	
	struct test a
	struct test b
	struct test c
	a.x = 10
	b.x = 100
	c.x = 1000
	struct test *x[2]
	x[0] = &b
	x[1] = &a
	write *(x[0]).x
	write *(x[1]).x
	*/


/*
to do list
1.0 todo support return stmt match check in the function
1.0 support local function: need to add the stack_depth
1. implement a simple macro: think the code as a stream of token, and replace the token while the tokenString is found in the macro table.
	the easy way is to call getToken with replaced tokenString and return the replaced token
	which is the preporcessor !
	to implement the procedure, we need to save the linebuf,
2. implement break
3. implement !,and,or
6  support three value expression
6  support switch case
8  define variable
9  auto x = 10; auto inference
10 import other file
*/