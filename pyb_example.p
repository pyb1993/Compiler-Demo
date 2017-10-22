/*
int * p
int x
x = 10
p = &x

void main()
{
	write x
	*p = 100
	write x
}
*/

float n
n = 10
float f(int n)
{
	if (n <= 2)
		return 1
	else
		return f(n-1) + f(n-2)
}

float f2(int a,int b,float c)
{
    return a * b * c
}


void main()
{
	write f(f2(f2(4,f(4),0.4),1,1))
	//write f(8) + f2(1,2,6)
}

