int * malloc(int n)
{
	asm(malloc,n)
}

void free(int * p)
{
	asm(free,p)
}

