struct test
{
    int a
    void f1(int y){write y }//
}



void what(struct test x)
{
    x.a = 101
    //write x.a
    x.f1(x.a)
}


void main()
{
    struct test t
    what(t)
}
/*
bug记录:分配内存错误（分配了一个指针的内存，但是按照结构体来使用，最后导致内存overlap）
bug记录:fp和sp不统一,原因是结构体内部变量的分配导致sp减小(解决办法是保存-回复)

*/
