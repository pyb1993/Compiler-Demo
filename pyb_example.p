struct test1
{
	int m	

}

struct test
{
	int a
	int b
	int c[10]
	struct test1 t1 
}

void main()
{
	struct test t
	t.c[5] = 10
	t.a = 2
	write t.c[5] + t.a
}