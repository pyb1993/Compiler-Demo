/*
 用来实现一个通用的双端链表
*/

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
    void freeList (void *ptr){}

	// 节点值对比函数 -1 代表 小于 0 等于, 1大于
    int match (void *ptr, void *key){} 
	
	/*删除一个给定节点的值*/
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

	/**********append一个节点***************/
	void self__append(listNode * node)
	{
		if(node == NULL) return
		self->len++	
		self->tail->next = node
		node->prev = self->tail
		node->next = NULL

		self->tail = node
	}


	/*********按顺序插入一个节点***************/
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
