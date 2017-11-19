

void main()
{

	(int [10]) *a
	int b[10][10]
	a = &b
	b[1][1] = 100
	write a[1][1]
	a[2][5] = 32
	write b[2][5]




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
}