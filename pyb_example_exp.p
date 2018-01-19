int n
float k
k = 2
read n
int t1
int t2
t1 = 1
t2 = 1
while(k < n + 3)
{
	int tmp
	tmp = t1
	t1 = t2
	t2 = tmp + t2
	k = k + 1
}
write t2
write t2 / 3.0

/*
float n
n = 10
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
}



*/


/*

void f(float *x,float *y)
{
	
	if(*x < *y)
		*x  = -*y
	else
		*y = -*x
		
}

void main()
{
	int x 
	int y
	x = 1
	y = 2
	f(&x,&y)
	write x
	write y

}



*/

/*
	(int [10]) *a
	int b[10][10]
	a = &b
	b[1][1] = 100
	write a[1][1]
	a[2][5] = 32
	write b[2][5]
	*/

	/*
	struct test b[6]
	struct test a[10]
	a[5].x = 1
	a[5].c.m = 10
	a[5].c.d = a[5].c.m * a[5].c.m
	b[3] = a[5]
	write b[3].x
	write b[3].c.d
	
	struct test a
	struct test b
	struct test c
	a.x = 10
	b.x = 100
	c.x = 1000
	struct test *x[2]
	x[0] = &b
	x[1] = &a
	write *(x[0]).x
	write *(x[1]).x
	*/

/*
to do list
1.0 todo support return stmt match check in the function
1. implement a simple macro: think the code as a stream of token, and replace the token while the tokenString is found in the macro table.
	the easy way is to call getToken with replaced tokenString and return the replaced token
	which is the preporcessor!
	to implement the procedure, we need to save the linebuf,
3. implement !,and,or
6  support three value expression
6  support switch case
9  auto x = 10; auto inference || 实现动态类型
10 10.3 实现一个双端链表

11 todo 实现
12 tail recursion
13 检查stack expand的时候是否和堆冲突
16 实现typedef
bug 记录:struct里面的变量导致sp指针的变化
bug 记录:内存分配了一个指针导致overlap	
bug 记录: 	int * p = malloc(101)	
			*p = 100
			这样的代码会导致parse错误,原因在于这样的语义具有二义性:
				[0] int *p = malloc(101) * p = 100
				[1] int *p = malloc(101); *p = 100
				解决办法是函数调用不跳过LineEnd(既调用matchWithoutSkipLineEnd)	
feature 记录: 利用类型中的is_const变量实现了const类型,同时规定只有const char *能够接常量字符串			
			  需要注意const struct 不但自己不能赋值,包括里面的成员也不可以被赋值		

feature 记录: 实现了 switch-case结果,case的conditon可以是任意表达式;
			  case 语句出现break会使得整个switch结束,否则会继续匹配下一个满足条件的case
			  每一个case存在一个自己的作用域,所以可以实现为 case 'A' :{} {} {}
			  也可以是 case 'B' : {},还可以是case 'C';xxx xxx xxx
			  每一个case无论有没有{}都是相互独立的
bug 记录: 嵌套注释没有处理好
		/*/*write 10000*/ /*ss*/*/ /*sss*/
		利用comment_num来处理嵌套注释
bug 记录: /***comment****/这样的注释会导致注释状态无法结束。
			原因是 忘记在判断*之后ungetNextChar(),导致跳过了下一个*,直接到了/,
			无法匹配*/，而 /*comment*/就不存在这样的问题


feature 记录: 实现强制类型转换,
	1： parse方面区分 (int *) a,((int *)[10]) a, (struct test *) a ,能根据前缀调用delcare_stmt 或者 parseExp
	2:  挂在singleOpK下面,限制1个byte的类型转换
feature 记录:实现sizeof(exp) 和 sizeof(type)
	1. 将sizeof实现为一个singleOpK操作的节点,而不是函数节点
	2. 这样做的原因是：* 实现为函数需要处理输入是type的情况,要为此打破函数的统一parse结构,不划算
					 * 实现为函数,如果有其他的操作也是类似于sizeof这样,那么也要实现为函数,那么又要去改变函数parse的可能路径
					    打破了open-close原则(即修改的时候必须要破坏原来的代码结构,而不是新增平行的结构)	 	
					 * 函数和sizeof唯一的共同点在后面有一个(),但是函数还需要增加指令的跳转,函数可能会返回一个除了int 
					  以外的类型,函数可能会后面接上[],->,.等操作。这些不同点导致远远多于共同点。
                     综上所述,单独处理sizeof会好得多。 
*/