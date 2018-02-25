import pyb_example_2

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
	
	int hash_func(void * key){}
	int get_idx(void * key){return self->hash_func(key) % self->size}

	void slot_free(hash_slot* slot){}
	int equal(void * key1,void * key2){}

	void put(void * key, void * val)
	{
		int idx = self->get_idx(key)
		
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

	void* get(void * key){
		int idx = self->get_idx(key)
		hash_slot * slot = self->data + idx
		while(slot != NULL && slot->key != NULL && (self->equal(key,slot->key) != 1))
		{
			slot = slot->next
		}

		if(slot == NULL || slot->key == NULL){
			return NULL
		}
		return slot->val
	}

	void delete(void * key)
	{
		int idx = self->get_idx(key)
		hash_slot * slot = self->data + idx
		hash_slot * prev = NULL
		while(slot != NULL && slot->key != NULL && (self->equal(key,slot->key) != 1))
		{
			prev = slot
			slot = slot->next
		}

		if(slot == NULL || slot->key == NULL){
			return
		}
		else{
			self->slot_free(slot)
			slot->key = NULL
			slot->val = NULL
			if(prev != NULL){
				prev->next = slot->next
			}
		}
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