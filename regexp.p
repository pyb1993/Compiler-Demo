import pyb_example_2

struct paren_t
{
	int nalt
	int natoms
} 

struct regexp{	
	//将前缀转换成后缀
	
	char* test(){
		int natom
		write --natom
	}
	
	/*char* rep2post(char * re)
	{
		struct paren_t paren[100]
		struct paren_t* p = paren
		int nalt = 0
		int natom = 0
		char *dst
		char buf[1000]
		dst = buf

		while(*re != 0)
		{
			switch(*re)
			{
			case '(':
				while(natom > 1){
					--natom
					*(dst++) = '.'	
				}
				if(p >= paren + 100){
					return NULL
				}
				p->nalt	= nalt
				p->natom = natom
				p++
				nalt = 0
				natom = 0
				break
			case ')':
				if(p == paren)
					return NULL
				
				if(natom == 0)
					return NULL
				
				while(--natom > 0)
					*(dst++) = '.'

				while(nalt > 0){
					nalt--
					*dst = '|'
				}
				--p
				nalt = p->nalt
				natom = p->natom
				natom++
				break
			case '|':
				break
			default :
				write 'c'
				break
		    }
		 re++
		}
		return dst	
	}*/
}

