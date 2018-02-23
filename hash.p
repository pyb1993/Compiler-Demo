import list
typedef struct list list

struct hash_slot{
void * next
void * key
void * val
}

typedef struct hash_slot hash_slot
struct hash{
	hash_slot* data
	int size
	int capacity
	
	int hash_func(void * key){
		return 2
	}
	int equal(void * key1,void * key2)

	void self__put(void * key, void * val)
	{
		int idx = self->hash_func(key)
		
		hash_slot * slot = self->data + idx
		if(slot->key == NULL){
			slot->key = key
			slot->val = val
			slot->next = NULL
			return
		}		

		hash_slot * new_slot = malloc(sizeof(hash_slot))
		new_slot->key = key
		new_slot->val = val
		new_slot->next = slot->next
		slot->next = new_slot
		
	}
}

hash createHash(int size)
{
	if(size <= 0) {size = 5}
	hash h
	h.size = size
	h.capacity = 0
	h.data = malloc(sizeof(hash_slot)) * size
	int i = 0
	while(i < size)
	{
		h.data[i++].key = NULL
	}
	return h
}