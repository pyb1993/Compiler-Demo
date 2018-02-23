import hash
typedef struct hash hash

hash makeHash()
{
	
	int equal(char * s1,char * s2){
		while(*s1 != 0 && *s2 != 0 && (*s1 == *s2)){
			s1++
			s2++
		}

		return (*s1 == 0) && (*s2 == 0)
	}

	int hash_func(char * key){
		int sum = 0
		while(*key != 0){
			sum += *key
			key++
		}
		return sum / 10000
	}

	hash h = createHash(0)	
	h.equal = equal
	h.hash_func = hash_func
	return h
}

void main(){

	hash h = makeHash()
	h.self__put("1","234")
	write 1233
}