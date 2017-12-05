struct t2{
	int c
}

struct test{
	int a[3]
	int b
	struct t2 tt


}


void main()
{
	struct test t
	int *p = &t.tt.c
	*p = 33
	write p
	write t.b
	write t.tt.c
}
