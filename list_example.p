import list
typedef struct list list
typedef struct listNode listNode

// 构造一个具体的listNode
listNode * makeNode(int val)
{
	listNode  * node = createListNode()
	node->value = malloc(sizeof(int))
	*(int *(node->value)) = val // 大小一致,直接转换
	return node
}

list makeList()
{
	int compare(void * a, void * b)
	{
		int av = *(int *(a)) 
		int bv = *(int *(b)) 
		if (av < bv) return -1
		if (av > bv) return 1
		return 0
	}
	struct list l  = createList()
	l.match = compare
	return l
}


void test_insertSortedList()
{
	list l = makeList()
	l.self__insertSortedList(makeNode(-1)) 
	l.self__insertSortedList(makeNode(1))
	l.self__insertSortedList(makeNode(-20)) 
	l.self__insertSortedList(makeNode(-20)) 
	l.self__insertSortedList(makeNode(-20)) 
	l.self__insertSortedList(makeNode(-100000))
	l.self__insertSortedList(makeNode(2000))
 	l.self__insertSortedList(makeNode(100)) 

	listNode * cur = l.head->next
	while(cur != NULL)
	{
		write *(cur->value)
		cur = cur->next
	}
}


void test_appendList()
{
	list l = makeList()
	void opera(list * l,listNode * node){}
	l.self__append(makeNode(-1)) 
	l.self__append(makeNode(1))
	l.self__append(makeNode(-20)) 
	l.self__append(makeNode(-20)) 
	l.self__append(makeNode(-20)) 
	l.self__append(makeNode(-100000))
	l.self__append(makeNode(2000))
 	l.self__append(makeNode(100)) 

	listNode * cur = l.head->next
	while(cur != NULL)
	{
		write *(cur->value)
		cur = cur->next
	}
}

void test_removeList()
{
	list l = makeList()
	int i = 100

	l.self__insertSortedList(makeNode(-1)) 
	l.self__insertSortedList(makeNode(1))
	l.self__insertSortedList(makeNode(-20)) 
 	l.self__insertSortedList(makeNode(100)) 
	l.self__insertSortedList(makeNode(2001515)) 
 	l.self__insertSortedList(makeNode(5453)) 
 	l.self__insertSortedList(makeNode(5675541)) 


	listNode * cur = l.head->next
	l.self__removeList(&i)
	i = 2001515
	l.self__removeList(&i)
	i = 5453
	l.self__removeList(&i)

	cur = l.head->next
	while(cur != NULL)
	{
		write *(cur->value)
		cur = cur->next
	}
}

void test_pop()
{
	list l = makeList()
	l.self__insertSortedList(makeNode(-1)) 
	l.self__insertSortedList(makeNode(1))
	l.self__insertSortedList(makeNode(-20)) 
 	l.self__insertSortedList(makeNode(100)) 
	l.self__insertSortedList(makeNode(2001515)) 
 	l.self__insertSortedList(makeNode(5453)) 
 	l.self__insertSortedList(makeNode(5675541)) 

	l.self__popRight()
	l.self__popLeft()
	l.self__popLeft()

	listNode * cur = l.head->next
	while(cur != NULL)
	{
		write *(cur->value)
		cur = cur->next
	}
}


void main()
{
	test_insertSortedList()
	write "---------------"
	test_appendList()
	write "---------------"
	test_removeList()	
	write "---------------"
	test_pop()

}