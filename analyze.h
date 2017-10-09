
#ifndef _ANALYZE_H_
#define _ANALYZE_H_
/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */

void buildSymtab(TreeNode *);

/* Procedure typeCheck performs type checking
 * by a postorder syntax tree traversal
 */
void typeCheck(TreeNode *);
void  insertNode(TreeNode * t, int scope_depth);
int  insertParam(TreeNode * t,int scope_depth);
void deleteNode(TreeNode * t,int scope_depth);

static void gen_converted_type(TreeNode * tree);



#endif
