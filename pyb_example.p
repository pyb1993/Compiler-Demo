// test a[1] (p + 5)[1] f(3)[1]
/*void f(int a[1][2])
{

	int x 
	x = a[0][1]
}*/

void main()
{
	int a[20][10]
	int i
	i = 1
	
	a[0][0] = 1
	a[0][1] = 1

	while(i < 20)
	{
	 a[0][i] = a[0][i-1] + a[0][i-2]
	 i = i + 1
	}
	write a[0][6]
	a[1][2] = a[0][15]
	write a[10][2]
	
	
}