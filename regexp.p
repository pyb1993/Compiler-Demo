import pyb_example_2

struct paren_t
{
	int nalt
	int natom
} 

struct regexp{	
	//将前缀转换成后缀
	char buf[1000]

	char* rep2post(char * re)
	{
		struct paren_t paren[100]
		struct paren_t* p = paren
		int nalt = 0
		int natom = 0
		char *dst
		dst = self->buf

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
				
			case '|':
				if(natom == 0)
					return NULL
				while(--natom > 0)
					*(dst++) = '.'
				nalt++

			case '*':
			case '+':
			case '?':
				if(natom == 0)
					return NULL
				*(dst++) = *re
				
			default :
				if(natom > 1)
				{
					--natom
					*(dst++) = '.'
				}
				
				*(dst++) = *re
				natom++
	
		    }
		 re++
		}
		if(p != paren)
			return NULL
		while(--natom > 0)
			*(dst++) = '.'
		while(nalt > 0){
			*(dst++) = '|'
			nalt--
		}
		*dst = 0
		return self->buf
	}// end of re2post
}

