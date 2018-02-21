#ifndef _ANALYZE_H_
#define _ANALYZE_H_
/* Function buildSymtab constructs the symbol
 * table by preorder traversal of the syntax tree
 */
#include "globals.h"

void buildSymtab(TreeNode *);
void typeCheck(TreeNode *);

int var_size_of(TreeNode *);

void  insertNode(TreeNode * t, int scope_depth);
void  insertParam(TreeNode * t,int scope_depth);
void deleteVar(TreeNode * t,int scope_depth);
void deleteVarOfField(TreeNode * tree, int scope);
void deleteParams(TreeNode * tree, int scope);
void appendSelfToParamAndSetStruct(TreeNode * function_node);
void stInsertVar(TreeNode *, int);

void gen_converted_type(TreeNode * tree);
bool isExp(TreeNode * t, ExpKind ekind);
bool isStmt(TreeNode * t, StmtKind skind);
char * setStructInfo(char *, int mode);

extern int stack_offset ;


#endif
