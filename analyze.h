
#ifndef _ANALYZE_H_
#define _ANALYZE_H_
/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */

void buildSymtab(TreeNode *);
void typeCheck(TreeNode *);
int var_size_of(TreeNode *);
void  insertNode(TreeNode * t, int scope_depth);
int  _insertParam(TreeNode * t,int scope_depth);
void deleteNode(TreeNode * t,int scope_depth);
void gen_converted_type(TreeNode * tree);

#endif
