#define MEMSIZE (65536 - 4096 - 1)
#define DADDR_SIZE (65536)

typedef struct header{
	struct header * next;
	unsigned usedsize;
	unsigned freesize;
} Header;

extern int dMem[DADDR_SIZE];
int pMalloc(unsigned nbytes);
void pFree(void *ap);



