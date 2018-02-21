/*
 ����ʵ��һ��ͨ�õ�˫������
*/

import pyb_example_2 

const void * NULL = 0 // Ϊ���Ժ����


// ����ڵ�����ݽṹ
struct listNode 
{

    // ǰ�ýڵ�
    struct listNode *prev

    // ���ýڵ�
    struct listNode *next

    // �ڵ��ֵ
    void *value
}

typedef struct listNode listNode


 // ��������ݽṹ
 struct list 
 {
    // ��ͷ�ڵ�
    listNode *head

    // �ڵ�
    listNode *tail

    // �����������Ľڵ�����
    int len

    // �ڵ�ֵ���ƺ���
    void* dup (void *ptr){}

    // �ڵ�ֵ�ͷź�����ע�ⲻ��ϵͳfree����
    void freeList (void *ptr){}

	// �ڵ�ֵ�ԱȺ��� -1 ���� С�� 0 ����, 1����
    int match (void *ptr, void *key){} 
	
	/*ɾ��һ�������ڵ��ֵ*/
	void self__removeList(void * val)
	{
		if(self->len <= 0) return
		self->len--
		listNode * cur = self->head->next
		while(cur != NULL && self->match(cur->value,val) != 0)
		{
			cur = cur->next
		}
			
		if(cur == NULL) return
		listNode * prev = cur->prev
		listNode * next = cur->next
		prev->next = next
		if(next != NULL) next->prev = prev
		if(cur == self->tail) {self->tail = prev }
		free(cur)
	}

	/**********appendһ���ڵ�***************/
	void self__append(listNode * node)
	{
		if(node == NULL) return
		self->len++	
		self->tail->next = node
		node->prev = self->tail
		node->next = NULL

		self->tail = node
	}


	/*********��˳�����һ���ڵ�***************/
void self__insertSortedList(listNode * node)
{
	if (node == NULL) return
	int x = 10
	self->len += 1
	listNode * cur = self->head
	while(cur->next != NULL )
	{
		if(self->match(cur->next->value, node->value) >= 0){ break }
		cur = cur->next
	}
	
	listNode * cur_next = cur->next
	cur->next = node
	node->next = cur_next
	node->prev = cur
	if(cur_next != NULL) {cur_next->prev = node} // case1 cur node cur->next
	else {self->tail = node	} // case2 cur node NULL
}

	void self__popRight()
	{
		if(self == NULL || self->len <= 0) return
		self->len--
		listNode * pre = self->tail->prev
		pre->next = NULL
		free(self->tail)
		self->tail = pre
	}

		void self__popLeft()
	{	
		if(self == NULL || self->len <= 0) return
		self->len--

		listNode * next = self->head->next->next // maybe NULL
		free(self->head->next)

		self->head->next = next
		if(next != NULL){
			next->prev = self->head
		} 
	}

} 
typedef struct list list
/*********����һ������ڵ�****************/
listNode * createListNode()
{
	listNode  * node = malloc(sizeof( listNode))
	node->prev = NULL 
	node->next = NULL
	node->value = NULL
	return node
}

/*********����һ��˫������***************/
list createList()
{
	list l
	void * NULL = 0 // Ϊ���Ժ����
	l.head =  createListNode()
	l.tail = l.head
	l.len = 0
	return l
}
