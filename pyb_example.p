import pyb_example_2

void main()
{
	int * p = malloc(1011)	
	p[0] = 100
	p[1] = 200
	write p[0] + p[1]
	write p
	write g()
	struct fuck f
	f.a = 22
	write f.a
}


int * malloc(int n)
{
	asm(malloc,n)
}

void free(int * p){
	asm(free,p)
}
