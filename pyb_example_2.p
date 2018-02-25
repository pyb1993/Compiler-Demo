const void * NULL = 0

int * malloc(int n)
{
	asm(malloc,n)
}

void free(int * p)
{
	asm(free,p)
}

void printStr(char * str){
	while(*str != 0){
		write *(str++)
	}
}
