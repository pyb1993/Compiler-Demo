
int y = 2

int f(int x,int y)
{	
	y = 2 + 9
	return x+y
}

void main()
{
	float x
	int c
	c = x = 1 + (y = f(2,3))
	write x
	write c
	write y

}