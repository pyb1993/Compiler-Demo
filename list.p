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
    void free (void *ptr){}

	// �ڵ�ֵ�ԱȺ��� -1 ���� С�� 0 ����, 1����
    int match (void *ptr, void *key){} 
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


/*********��˳�����һ���ڵ�***************/
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

/**********appendһ���ڵ�***************/
void append(list * l,listNode * node)
{
	if(l == NULL ) return
	if(node == NULL) return
		
	l->tail->next = node
	node->prev = l->tail
	node->next = NULL

	l->tail = node
}


// ɾ��һ���ڵ�
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

