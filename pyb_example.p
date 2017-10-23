
void f(int **x,int **y)
{
	write *x
	write *y
	write **x
	write **y		
}

void main()
{
	int x 
	int y
	x = 1
	y = 2
	int * p
	p = &x
	int * q 
	q = &y
	f(&p,&q)
}


