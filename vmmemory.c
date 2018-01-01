#include "vmmemory.h"
#include "globals.h"

int dMem[DADDR_SIZE];//extern variable
static Header *memptr = NULL;// the last pointer to used memory
static Header * mem = (Header *)(dMem + 4096);
static const int INTSIZE = sizeof(int);
static const int HADERSIZE = sizeof(Header);
int pMalloc(unsigned n_int_bytes)
{
	Header *p, *newp;
	int nbytes = n_int_bytes * INTSIZE;
	unsigned nunits = ((nbytes + HADERSIZE - 1) / HADERSIZE) + 1;
	if (memptr == NULL)
	{
		memptr->next = memptr = mem;
		memptr->usedsize = 1;
		memptr->freesize = MEMSIZE - 1;
	}
	p = memptr;
	while (p->next != memptr && (p->freesize < nunits)) { p = p->next;}
	if (p->freesize < nunits) return NULL; // no available block

	newp = p + p->usedsize;
	newp->usedsize = nunits;
	newp->freesize = p->freesize - nunits;
	newp->next = p->next;
	p->next = newp;
	p->freesize = 0;
	memptr = newp;
	
	return ((newp + 1) - mem) * (HADERSIZE / INTSIZE) + 4096;
}

void pFree(Header *ap)
{
	Header *bp, *p, *prev;
	bp = ap - 1;
	prev = memptr, p = memptr->next;
	while ((p != bp) && (p != memptr)){
		prev = p;
		p = p->next;
	}
	if (p != bp) return;

	prev->freesize += p->usedsize + p->freesize;
	prev->next = p->next;
	memptr = prev;
}

