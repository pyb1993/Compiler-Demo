struct fuck
{
	int a
}


int g()
{
	return 10086
}

int * malloc(int n)
{
	asm(malloc,n)
}

void free(int * p){
	asm(free,p)
}
