struct t2
{
	int c
}

struct test
{
	int a[3]
	int b
	struct t2 tt
}
struct test f(int b){
	struct test x
	x.b = b
	x.a[2] = 111
	return x
}

int ff()
{
return 2.3
}

void main()
{
	write ff()
	struct test x = f(22)
write x.b
write x.a[2]

}
