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
		if (av < bv) return -10
		if (av > bv) return 10
		return 0
	}
	list l  = createList()
	l.match = compare
	return l
}


void test_insertSortedList()
{
	list l = makeList()
	l.insertSortedList(makeNode(-1)) 
	l.insertSortedList(makeNode(1))
	l.insertSortedList(makeNode(-20)) 
	l.insertSortedList(makeNode(-20)) 
	l.insertSortedList(makeNode(-20)) 
	l.insertSortedList(makeNode(-100000))
	l.insertSortedList(makeNode(2000))
 	l.insertSortedList(makeNode(100)) 

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
	l.append(makeNode(-1)) 
	l.append(makeNode(1))
	l.append(makeNode(-20)) 
	l.append(makeNode(-20)) 
	l.append(makeNode(-20)) 
	l.append(makeNode(-100000))
	l.append(makeNode(2000))
 	l.append(makeNode(100)) 

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

	l.insertSortedList(makeNode(-1)) 
	l.insertSortedList(makeNode(1))
	l.insertSortedList(makeNode(-20)) 
 	l.insertSortedList(makeNode(100)) 
	l.insertSortedList(makeNode(2001515)) 
 	l.insertSortedList(makeNode(5453)) 
 	l.insertSortedList(makeNode(5675541)) 


	listNode * cur = l.head->next
	l.removeList(&i)
	i = 2001515
	l.removeList(&i)
	i = 5453
	l.removeList(&i)

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
	l.insertSortedList(makeNode(-1)) 
	l.insertSortedList(makeNode(1))
	l.insertSortedList(makeNode(-20)) 
 	l.insertSortedList(makeNode(100)) 
	l.insertSortedList(makeNode(2001515)) 
 	l.insertSortedList(makeNode(5453)) 
 	l.insertSortedList(makeNode(5675541)) 

	l.popRight()
	l.popLeft()
	l.popLeft()

	listNode * cur = l.head->next
	while(cur != NULL)
	{
		write *(cur->value)
		cur = cur->next
	}
}

void testMatch(){
	list l = makeList()
	int a = 1
	int b = 1

	write l.match(&a,&b)
}


void main()
{
	testMatch()
	
	test_insertSortedList()
	write "---------------"
	test_appendList()
	write "---------------"
	test_removeList()	
	write "---------------"
	test_pop()
	

}