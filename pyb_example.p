struct test{
int a
int b[10]
float c
}

void f(void * s){
	(struct test *(s))->b[2] = 100
	/*/*write 10000*/ /ss*/*/ /*sss*/
}

void main()
{
	void * p
	struct test t
	f(&t)
	write t.b[2]

}