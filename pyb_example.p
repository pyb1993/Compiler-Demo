import list

// ����һ�������listNode
struct listNode * makeNode(int val)
{
	int compare(void * a, void * b)
	{
		int av = int(*a) 
		int bv = int(*b)
		if (av < bv) return -1
		if (av > bv) return 1
		return 0
	}
	struct listNode  * node = createListNode()
	node->value = malloc(sizeof(int))
	*(node->value) = val // ��Сһ��,ֱ��ת��
	node->match = compare 
}

struct list makeList()
{

	struct list l = createList()
	return l
}
*

void main()
{
	//struct list l = makeList()
	//insertList(l,makeNode(1))
	//insertList(l,makeNode(2))
	//insertList(l,makeNode(3))

}