typedef struct test s
struct test{
	int a
	float b
}

void main()
{
	s x
	x.a = 1
	x.b = x.a * x.a
	write x.a
	write x.b
}