import hash
typedef struct hash hash
typedef struct hash_slot hash_slot

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
		return sum 
	}

	hash h = createHash(0)	
	h.equal = equal
	h.hash_func = hash_func
	return h
}

void main()
{
	hash h = makeHash()
	h.put("1","2345")
	printStr(h.get("1"))
	h.put("nihao","fuck you")
	h.delete("1")
	printStr(h.get("1"))
	printStr(h.get("nihao"))

}