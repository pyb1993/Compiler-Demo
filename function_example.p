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

int f3(int x){
	return x + x
}


void f4(){
	int a[10]
	int x = 101
	void f3(){
		write x
		x += 10
		a[1] = 5
	}
	f3()
	f3()
	write x
	write a[1]

}


void f5()
{

	int y = -2
	void g1(){
		int x = -1
		y += 10
	}

	void g2(){
		g1()
		write y
	}

	g2()
}

void f6()
{
	int x = -3
	void g(){
		x =  x * 100
	}
	
	void g1(){
		int t = 40
		g()
		write x
	}

	void g2(){
		int u = -50
		void g3()
		{
			write u
			g() // x => -30000
			//write x  // 600
		}
		g3()
	}

	g1()
	g2()

}


void main()
{
	write f3(100)
	write f(f2(f2(4,f(4),0.4),1,1))
	write f(8) + f2(1,2,6)
	write f2(11,2,0.6)

	f4()
	f5()	
	f6()
}