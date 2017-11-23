
struct test
{
	int x
	int y
	int z
}

void f(struct test t,struct test *t2)
{	
	t = *t2
}


void main()
{
	struct test t
	t.x = 12
	t.y = 2
	struct test *t2 = &t
	t = *t2
	write 1
}