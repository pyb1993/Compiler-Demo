struct test1
{
	int m	

}

struct test
{
	int a
	int b
	float c
}


void main()
{
	struct test* x
	struct test t

	x = &t
	*x.b = 10
	*x.c = t.b + 5
	write t.c
}