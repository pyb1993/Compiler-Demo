float f(int n)
{
	if (n <= 2)
		return 1
	else
		return f(n-1)+f(n-2)
}

float f2(int a,int b,float c)
{
    return a * b * c
}

void main()
{
	write f(f2(f2(4,f(4),0.4),1,1))
	write f(8) + f2(1,2,6)
	write f2(11,2,0.6)

}