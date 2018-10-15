# Compiler-Demo
土办法做编译器

[TOC]

### 关于P语言编译器的设计与实现

####P语言简介.   
>p语言是一种类似C语言语法的语言,涵盖了c语言的大部分语法和部分拓展。 
下面简单介绍一下该语言的特性和设计思路和实现。  
  参考书籍：[Compiler Construction(编译原理以及实践)](https://book.douban.com/subject/2709089/)  

----------
#### Feature介绍
>**
**0. 函数特性**  
.0. 支持函数递归  
.1 局部函数(在结构体和函数内部定义函数)  
.2 first class特性,函数即变量。  
.3 非局部函数可以直接互相调用,摆脱了定义顺序的依赖**  
**1. 类型特性**  
.0 支持强制类型转换(暂时只支持一个单位大小的转换) //int(1.5),float(1),void *(p)  
.1 实现typedef和sizeof  
.2 实现const 类型  
.3 支持基本类型嵌套声明 (((float *) [1][2]) *)//指向float * [1][2]的指针  
.4 支持int 和 float的自动转换 // 1 + 0.5 => 1.5  
.5 支持字符串 write "are you okay" => 输出 are you okay  
.6  声明即定义(没有也不需要声明)  
**2.表达式特性**  
 .0 switch case可以用表达式作为case的进入条件(c要求是常量)  
 .1 支持连等表达式 f(1) + a = b = c = d  
 .2 实现了 比较,赋值,逻辑,.,->,[],a++,++a,--a,a--,+= 等常用运算符号  
 .3 实现了 比较,赋值,逻辑,.,->,[],a++,++a,--a,a--,+= 等常用运算符号  
 **3. 书写特性**  
.0 支持使用{}定义任意嵌套作用域  
.1 行尾不需要写分号  
.2 实现注释和嵌套注释和检查(/*ffffff/*嵌套fdsdfds嵌套*/*/)  
.3  实现任意嵌套的if-else和while语句,以及相应的break与continue.  
**4. 运行时和相关成果**   
.0 支持动态内存分配// malloc/free  
.1 用p语言本身实现了一个通用双端list  
**5. 其他**  
.0 实现import(类似python),可以分模块书写代码	  
	
---
	
>**目前已经用p语言本身实现了一个支持通用类型的双端链表(按顺序插入(需要链表提供比较函数),append,remove,popRight,popLeft等操作),p语言代码如下**
```
/* 用来实现一个通用的双端链表*/
import pyb_example_2 
const void * NULL = 0 // 为了以后兼容

// 链表节点的数据结构
struct listNode 
{
    // 前置节点
    struct listNode *prev

    // 后置节点
    struct listNode *next

    // 节点的值
    void *value
}

typedef struct listNode listNode


 // 链表的数据结构
 struct list 
 {
    // 表头节点
    listNode *head

    // 节点
    listNode *tail

    // 链表所包含的节点数量
    int len


    // 节点值复制函数
    void* dup (void *ptr){}

    // 节点值释放函数，注意不是系统free函数
    void free (void *ptr){}

	// 节点值对比函数 -1 代表 小于 0 等于, 1大于
    int match (void *ptr, void *key){} 
} 
typedef struct list list

/*********创建一个链表节点****************/
listNode * createListNode()
{
	listNode  * node = malloc(sizeof( listNode))

	node->prev = NULL 
	node->next = NULL
	node->value = NULL
	return node
}

/*********创建一个双端链表***************/
list createList()
{
	list l
	void * NULL = 0 // 为了以后兼容
	l.head =  createListNode()
	l.tail = l.head
	l.len = 0
	return l
}


/*********按顺序插入一个节点***************/
void insertSortedList(list * l, listNode * node)
{
	if (node == NULL) return
	
	l->len += 1
	listNode * cur = l->head

	while(cur->next != NULL )
	{
		if(l->match(cur->next->value, node->value) >= 0){ break }
		cur = cur->next
	}
	
	listNode * cur_next = cur->next
	cur->next = node
	node->next = cur_next
	node->prev = cur
	if(cur_next != NULL) {cur_next->prev = node} // case1 cur node cur->next
	else {l->tail = node	} // case2 cur node NULL
}

/**********append一个节点***************/
void append(list * l,listNode * node)
{
	if(l == NULL ) return
	if(node == NULL) return
		
	l->tail->next = node
	node->prev = l->tail
	node->next = NULL

	l->tail = node
}


// 删除一个节点
void popRight( list * l)
{
	if(l == NULL || l->len <= 0) return
	l->len--

	listNode * pre = l->tail->prev
	pre->next = NULL
	free(l->tail)
	l->tail = pre
}

void popLeft(list * l)
{	
	if(l == NULL || l->len <= 0) return
	l->len--

	listNode * next = l->head->next->next // maybe NULL
	free(l->head->next)

	l->head->next = next
	if(next != NULL){
		next->prev = l->head
	} 
}

void removeList(list * l,void * val)
{
	if(l == NULL || l->len <= 0) return
	l->len--
	listNode * cur = l->head->next
	while(cur != NULL && l->match(cur->value,val) != 0)
	{
		cur = cur->next
	}

	if(cur == NULL) return

	listNode * prev = cur->prev
	listNode * next = cur->next
	prev->next = next
	if(next != NULL) next->prev = prev
	if(cur == l->tail) l->tail = NULL 
	free(cur)
}
```
----

----
#### 一. 基本架构 :
- **词法分析(scanner/tokenizer)  **
- **文法分析(parser) **
- **语义分析(semantic analysis) **
- **生成中间代码(code generation) ** 
- **运行时环境(run-time environment)**
- 
##### 1.1 词法分析部分 (300+行)
>**
词法分析就是将整个源程序当作输入,从中解析出以token为单位的基本元素。


数字(1,2222,1.987) 
字符串/字符("hello word",'a','?'...)
运算符(+ - * / ++ -- += -= [ ] { } ( ) : \ = == < > <= >= != ! && || . -> 等符号)
变量名(add,remove,get,number,test,checkParameter)
关键字(if,else,while,continue,switch,case,break,def,struct,return,int,float,char,const...)
注释(//,/**/)  note:可以嵌套

>**
实现思路:
最传统/简单/土制 的办法就是手写一个状态机,这里的状态机实现是一个有穷自动机(DFA),处理p语言的token足够了。具体过程简略说明一下(和传统的实现没有区别):
0 所有token用枚举(enum)表示
1 初始状态是start,遇到单独的字符比如,:,{这种就直接将状态变成DONE,同时记录当前token.
2 遇到不能确定的字符,举几个例子:就需要将状态变成一个中间状态(比如 PLUS_START),然后根据接下来的字符进行状态的保持或者变化。比如开头遇到一个数字,就需要看接下来会不会遇到浮点数。如果直到遇到一个 不是数字且不是浮点数 的字符,状态变为DONE,同时token也确定了(中间可能需要记录token对应的字符串)
3 很多时候需要回退,比如开头是一个<,判断下一个字符是不是 =,结果发现不是。这时候需要记录原来的token,改变状态为DONE,但是提前判断的字符也不能丢掉,于是要回退一个字符,这样下一次状态机的开头就是这个字符了

----------

##### 1.2 parser部分(1100行)
parser就是把前一个模块的token组装起来,构造语法节点。举个例子:

    int a 这样一行,scanner部分读取到的首先是int,我们获得int之后,要立刻判断接下来的可能的语法
     int a
     int x = 任意表达式
     int f(void)
     int(1.5)
	
----------

###### 实现思路( EBNF,下推自动机和递归下降分析):
下推自动机是带一个栈的自动机, 并且有一系列的状态变换函数:状态 ╳ 输入字符或 ε ╳ 栈顶 → 新状态 ╳ 替换栈顶其中替换栈顶操作可以把栈顶替换成 0 个或多个元素.

---------------------------------------------------------------------------------------------
>**
所谓*EBNF*,其实是一种上下文无关的文法表示方法,比如
exp => factor [+ -] exp //[]代表可以选择一个		
   factor => term [* /] exp
   term => [1 1.5 ]
上面就是一个最最简化的,关于表达式的EBNF表示。左边代表某种文法(表达式,if语句),右边代表这种文法的一种可能的符号推导。 		

   可以看到ENBF其实也是在描述当前的状态(正在进行的文法规则替换)和已经替换过的部分(栈顶),如果一个文法规则的替换全部都换成了终结的token(不能被继续替换了比如 term 就是 整数或者浮点数),那么该文法的具体形式就确定了

------

   递归下降是一种实现ENBF的方法,采取右递归的方式,首先进行可能的替换(比如把当前输入(栈顶)替换成一个factor,然后再递归的替换剩下的部分)。而factor的替换其实又归纳到先替换左边的输入为term,然后替换右边的为一个exp(这里又递归到exp上面去了)。通过这种[自顶向下的方式],就可以构造出一个表达式的语法节点。

---------------
###### 代码举例

```
// 处理各种逻辑表达 eg:&&,||,!
TreeNode * conditionExp()
{
	TreeNode * t = compare_exp();// a < b
	while (token == AND || token == OR)
	{
		TreeNode * p = newExpNode(OpK);
		if (p != NULL)
		{
			p->child[0] = t;
			p->attr.op = token;
			matchWithoutSkipLineEnd(token);
			p->child[1] = compare_exp();
			t = p;
		}
	}
	return t;
}
```
###### 实现的细节:
- *1.*  要注意表达式的优先级,这体现在选择递归函数的顺序
- *2*. 要注意if statement else等语法的悬挂问题(最近`else`匹配最近的if)
- *3*. 没有使用;作为换行的结束,而是使用自然的换行标志,所以解析难度增加,比如:
	

```
int * p = malloc(101)	
*p = 100
这样的代码可能会导致parse错误,原因在于这样的语义具有二义性:
		[0] int *p = malloc(101) * p = 100
		[1] int *p = malloc(101); *p = 100
解决办法是函数调用不跳过换行,因为第一种解析在语法上来讲是不对的,因此解析=右边的时候,需要注意遇到换行自动结束解析。

但是有的时候换行是需要跳过的,比如
	if (){换行
	}
所以需要小心区分
```
3. 类型声明也相对比较复杂(支持结构体内的函数和结构体成员),比如
	
    typedef struct  ohMyGod complicated
    struct ohMyGod{
	int a
	int *a1
	int ******a2
	float b[1]
	float b1[1][2][3]..[10]
	float* b2[1][2][3]
	struct test t
	int f(int a,int b){....}
	(struct test*) f2(struct stu s[10],int f3(void * m[10])){     } 
	}// end
需要能够支持类型的嵌套声明和处理可能的 `typedef`

4. 需要大量的回退/向前探索才能确定需要解析的文法.


---
##### 1.3 语义分析部分(700+行)
语义分析就是确定语法树上面各个节点声明变量的符号表,作用域范围,各个表达式的类型和一定的语法检查。
- **1. 符号表和作用域**
	符号表的设计是一个hash表,里面存储了每一个变量的名字(key),变量的类型。当进入一个作用域的时候,需要生成该作用域的所有变量,当退出作用域的时候,需要删除里面的所有变量。
- **2. 类型检查**
.2.1 *类型的检查主要涉及到*
.2.2 *类型转换*,比如 `1 + 3 * (f(1) - 6)` 的类型由f(1)的类型决定(整数或者浮点数),这需要依靠一个对表达式子树的后序遍历来实现的。再比如`*p`的类型是`p`所指向的类型,`p->x`的类型是x的类型等等。
.2.3 *错误的检查*,比如`p->x`,那么`p`就一定是一个指针. `p->x++`,那么x就一定是一个指针或者整数。
- **3 类型声明的处理**
	比如`struct test {xxxx}`需要处理test是否重定义,里面的语法声明是否正确,同时还要记录这个类型的信息,方便下面分析 `struct test t; t.x`的时候调用。
- **4 函数**
	要考虑函数调用和定义是否冲突(或者类型是否可以转换),返回值是否和定义兼容,函数里面的语句是否又定义了局部函数,函数是否和其他变量重名等等因素。			

---
##### 1.4 代码生成(1000+行)
	代码生成主要用来生成自定义的汇编代码,然后再交给stack based的虚拟机去解释运行。
这里需要定义好大约30种汇编语句,分别是从寄存器加载,从内存加载,存储,加减乘除等运算。然后将前面的语法树翻译成相应的汇编代码。同时涉及到了定义的8个寄存器。还涉及整数和浮点数的存储与相互转换。

这里有几个比较麻烦的点:
- **1.** 需要把语义分析时候产生的符号表再生成一遍,因为局部的变量在退出时候已经被删除了。但是全局变量并没有被删除,这就产生了一个微妙的case,必须小心处理两种不同作用域下产生的变量和函数。同时还会带来一个好处,那就是全局函数之间的互相调用不需要提前声明(p语言也没有实现函数声明,定义就是声明,和python一样)
- **2.**  需要处理好函数调用时上下文帧栈环境的保存和恢复,原理很简单,就是在栈顶寄存器之下保存调用者栈顶的位置和调用处代码的位置。但是同时涉及参数的空间分配(入栈),局部变量的分配,返回时参数的出栈,返回值的处理(或者没有返回值),返回时和上下文环境恢复等实现,以及定义函数之后不能直接运行函数,必须跳过当前生成的汇编代码,直到真正调用时才执行。和最后的main函数的特殊处理。正确的实现有一定难度,出现的bug不容易调试。
- **3.**  要处理好first class特性(函数就是变量),这又涉及到结构体里面的函数怎么在声明一个结构体变量的时候初始化,已经修改一个结构体变量的局部函数的实现
`struct test t
{
int function(int a,int b)
return a - b
}
t.function(1,2)//-1
 t.function = add// add is also a function
t.function(1,2)//3
`
同时还涉及到局部函数里面对上一层函数(或者结构体)局部变量的引用(这个特性需要禁止,因为实际上是在跨栈进行调用局部变量)	
- **4.** 处理好取地址模式和取值模式
   问题在于在非常复杂的表达式解析里面,很难确定到底是要产生地址的值还是变量的值。比如`a = t.x` 和` t.x = a`这两个表达式下面就要求分别产生值和地址。
   再比如`p->b.c->d[e.f] = g = f(t.x) + 10`这样的链式调用中,其实最后只需要{f的值},{d的地址}和{g的地址},以及f(t.x)的结果就可以确定最终的值,如果把中间所有的值都生成出来时极大的浪费。
   这就需要通过全局变量的保存和恢复来进行判断当前到底是取值还是地址,因为只有上层的调用者才能确定信息,而局部的表达式t.x是没有办法知道自己位置的。其实这相当于大部分case下的代码生成都出现了一个小小的分支(value OR adress),这需要小心的处理才不会出现bug。
   
- **5.** 以上所有问题和没有提及的问题都是交错在一起的,A问题里面完全可以出现B问题,B问题里面又要解决C问题,C问题里又绕回A问题,要用统一严谨的架构(而决不是打补丁的模式)来解决,否则后期根本无法添加新的feature和fix bug。

----------

##### 1.5 运行时环境(800+行)
简单来讲就是一个栈式虚拟机的实现,用来解释运行汇编代码。中间还涉及了malloc/free的实现(自己实现简单的内存分配算法,模拟操作系统的调用,这样就实现了在p语言中的动态内存分配)。
##### 主要工作
- **1** 检查生成汇编的格式
- **2** 将生成的汇编从字符串变成结构体
- **3** 检查汇编目标寄存器以及存储器地址的范围正确性
- **4** 分配好初始化过程各个寄存器的值
- **5** 处理好不同寄存器之间值的转换(主要是整数和浮点数的相互转换) 

---
#### 二 辅助工具
- 符号表的实现(200+行),
- 工具函数(200行)
- 类型结构体和相关操作的实现(300+行)，
- import模块的实现(80+行),
- 各个头文件(600+行)。

----
#### 三 TODO LIST
    0 实现一个以字符串为key的通用hash表
    1 实现self.x操作,定义在结构体内的函数将具有类似成员函数的功能
    2 实现一个宏(要能处理宏的嵌套定义)
    3 用p语言中的malloc/free作为基础,实现一个基于freeList池的内存分配器,避免直接和原始低效率的free/malloc打交道
    4 用p语言实现一个内置的简易正则表达式引擎(本质上用一个DFA/NFA状态机来描述正则文法进行匹配)
    5 看书 & 源码
