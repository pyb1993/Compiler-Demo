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

 // ��������ݽṹ
 struct list 
 {
    // ��ͷ�ڵ�
    struct listNode *head

    // �ڵ�
    struct listNode *tail

    // �����������Ľڵ�����
    int len


    // �ڵ�ֵ���ƺ���
    void* dup (void *ptr){}

    // �ڵ�ֵ�ͷź�����ע�ⲻ��ϵͳfree����
    void free (void *ptr){}

	// �ڵ�ֵ�ԱȺ��� -1 ���� С�� 0 ����, 1����
    int match (void *ptr, void *key){} 
} 

/*********����һ������ڵ�****************/
struct listNode * createListNode()
{
	struct listNode  * node = malloc(sizeof(struct listNode))

	node->prev = NULL 
	node->next = NULL
	node->value = NULL
	return node
}

/*********����һ��˫������***************/
struct list createList()
{
	struct list l
	void * NULL = 0 // Ϊ���Ժ����
	l.head =  createListNode()
	l.tail = l.head
	l.len = 0
	return l
}


/*********��˳�����һ���ڵ�***************/
void insertSortedList(struct list * l,struct listNode * node)
{
	if (node == NULL) return
	
	l->len += 1
	struct listNode * cur = l->head

	while(cur->next != NULL )
	{
		if(l->match(cur->next->value, node->value) >= 0){ break }
		cur = cur->next
	}
	
	struct listNode * cur_next = cur->next
	cur->next = node
	node->next = cur_next
	node->prev = cur
	if(cur_next != NULL) {cur_next->prev = node} // case1 cur node cur->next
	else {l->tail = node	} // case2 cur node NULL
}

/**********appendһ���ڵ�******************************************/
void append(struct list * l,struct listNode * node)
{
	if(l == NULL ) return
	if(node == NULL) return
	
	
	l->tail->next = node
	node->prev = l->tail
	node->next = NULL
	l->tail = node
}


// ɾ��һ���ڵ�
void removeList(struct list * l,void * value)
{
	if(value == NULL) return	
	
}
