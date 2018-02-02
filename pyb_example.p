/*import list
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

void test(list * l){
	write l
	write l->head
}

void example()
{
	void opera(list * l,listNode * node){}
	opera = insertSortedList
	list l = makeList()

	opera(&l,makeNode(1)) 
	opera(&l,makeNode(-1))
	opera(&l,makeNode(-20))
	opera(&l,makeNode(100))

	
	listNode * cur = l.head->next
	
	while(cur != NULL){
		write *(cur->value)
		cur = cur->next
	}


	write *(l.head->next->value)
	write *(l.tail->value)
}
*/

struct test{

	int x
	void self__f()
	{
		write self->x
		self->x += -11
	}

}

void main()
{
	void f(){}
	struct test t
	t.x = 100
	t.self__f()
	write t.x
	//example()
}