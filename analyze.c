/****************************************************/
/* File: analyze.c                                  */
/* Semantic analyzer implementation                 */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "symtable.h"
#include "analyze.h"

/* counter for variable memory locations */
static int location = 0;

/* Procedure traverse is a generic recursive
 * syntax tree traversal routine:
 * it applies preProc in preorder and postProc
 * in postorder to tree pointed to by t
 */
static void traverse( TreeNode * t, void (* preProc) (TreeNode *), void (* postProc) (TreeNode *))
{
    if (t != NULL)
    {
        preProc(t);
        for (int i=0; i < MAXCHILDREN; i++)
        {
                traverse(t->child[i],preProc,postProc);
        }
        postProc(t);
        traverse(t->sibling,preProc,postProc);
    }
}

static void defineError(TreeNode * t ,char * msg){
    fprintf(listing,"Define error at line %d: %s\n",t->lineno,msg);
    Error = TRUE;
}

static int var_size_of(Type);
static bool is_relative_type(Type a, Type b);

/* nullProc is a do-nothing procedure to
 * generate preorder-only or postorder-only
 * traversals from traverse
 */
static void nullProc(TreeNode * t) { }

/* Procedure insertNode inserts
 * identifiers stored in t into
 * the symbol table
 */
static void insertNode( TreeNode * t)
{
    switch (t->nodekind)
    { case StmtK:
            switch (t->kind.stmt)
        {
            case DeclareK:
                if (t->type == Func)
                {
                    /*
                     possible method:
                     t has the attribute of parameters list and return type
                     the symtable should also contain the type info.
                     */
                    defineError(t,"func type not implemented");
                }
                else
                {
                    if (st_lookup(t->attr.name) == -1)
                    {
                        int var_szie = var_size_of(t->type);
                        st_insert(t->attr.name,t->lineno,location++,var_szie);
                    }
                    else
                    {
                        defineError(t,"duplicate definition");
                    }
                }
                
                break;
            case AssignK:
            case ReadK:
                if (st_lookup(t->attr.name) == -1)// todo there are look up two times, can be optimized
                /* not yet in table, so treat as new definition */
                    defineError(t,"undefined variable");
                else
                /* already in table, so ignore location,
                 add line number of use only */
                    st_insert(t->attr.name,t->lineno,0,1);
                break;
            default:
                break;
        }
            break;
        case ExpK:
            switch (t->kind.exp)
        {
            case IdK:
                if (st_lookup(t->attr.name) == -1)
                /* not yet in table, undefined variable */
                    defineError(t,"undefined variable");
                else
                    st_insert(t->attr.name,t->lineno,0,1);
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}

/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
void buildSymtab(TreeNode * syntaxTree)
{ traverse(syntaxTree,insertNode,nullProc);
    if (TraceAnalyze)
    { fprintf(listing,"\nSymbol table:\n\n");
        printSymTab(listing);
    }
}

static void typeError(TreeNode * t, char * message)
{   fprintf(listing,"Type error at line %d: %s\n",t->lineno,message);
    Error = TRUE;
}

int var_size_of(Type type){
    return MEMUNITSIXE;
}


/* Procedure checkNode performs
 * type checking at a single tree node
 */
static void checkNode(TreeNode * t)
{
    switch (t->nodekind)
    { case ExpK:
            switch (t->kind.exp)
        { case OpK:
                if ((t->child[0]->type != RInteger) ||
                    (t->child[1]->type != RInteger))
                    typeError(t,"Op applied to non-integer");
                if ((t->attr.op == EQ) || (t->attr.op == LT))
                    t->type = RBoolean;
                else
                    t->type = RInteger;
                break;
            case ConstK:
            case IdK:
                t->type = RInteger;
                break;
            default:
                break;
        }
            break;
        case StmtK:
            switch (t->kind.stmt)
        { case IfK:
                if (t->child[0]->type != RBoolean || t->child[0]->type != LBoolean)
                    typeError(t->child[0],"if test is not Boolean");
                break;
            case AssignK:
                /*
                 now,just deal with the basic type
                 */
                st_lookup(t->attr.name);
                Type id_type = st_lookup_type(t->attr.name);
                if (is_relative_type(id_type,t->child[1]->type))
                    typeError(t->child[0],"assignment of different value");
                break;
            case WriteK:
                if (t->child[0]->type != RInteger)
                    typeError(t->child[0],"write of non-integer value");
                break;
            case RepeatK:
                if (t->child[1]->type == RInteger)
                    typeError(t->child[1],"repeat test is not Boolean");
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}

/*
 check if type a and type b is the same or relative LType,RType
 */
bool is_relative_type(Type a, Type b)
{
    if (a == b)
        return true;
    else if (a + b == 2 * LRBOUND)
        return true;

    return false;
}

/* Procedure typeCheck performs type checking 
 * by a postorder syntax tree traversal
 */
void typeCheck(TreeNode * syntaxTree)
{ traverse(syntaxTree,nullProc,checkNode);
}
