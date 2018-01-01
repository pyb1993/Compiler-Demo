void main()
{
	int * p = malloc(1011)	
	p[0] = 100
	p[1] = 200
	write p[0] + p[1]
	//free(p)
	p = malloc(2000)
	write p
}


int * malloc(int n)
{
	asm(malloc,n)
}

void free(int * p){
	asm(free,p)
}
