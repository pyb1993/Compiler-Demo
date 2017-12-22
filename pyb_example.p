struct test 
{
	int a
	int f(){}
}

int f()
{
	return 100 * 100
}

int g(){
	return 200
}
void main()
{
	struct test t
	t.f = g
	write t.f()

}
