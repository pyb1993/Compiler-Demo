#include "globals.h"
#include "symtable.h"
#include "code.h"
#include "cgen.h"
#include "util.h"
#include "tinytype.h"
#include "assert.h"
#include "analyze.h"
#include "compile.h"

#define checkInAdressMode() (in_adress_mode)


typedef void(*emitFunc)(int, int, int);
static bool in_adressMode = FALSE;
static char * current_function = NULL;

static int  genLabel();
static void emitLabel(int);
static void emitGoto(int);
static void setFunctionAdress(char * current_function,char *, int scope);
static void jumpToFunction(TreeNode *,char *,int scope);
static bool checkInMainModule();

static void cgen_assign(TreeNode *,TreeNode *,int);
static void cGenPushTemp(int size, int tar, int ori, int adress_reg);

static void __cGenST(int , int , int );
static void __cGenPUSH(int ,int, int );
static void __cgenPopFromTemp(int, int, int,int, emitFunc);
static void cgenOp(TreeNode*, TreeNode*, TokenType, int, int, int);

static void cgenCopyObj(int origin_reg, int target_reg, int offset, int target_adress_reg);
static void cgenPushObj(int origin_reg, int target_reg, int offset);
static void cgenCodeForInsertNode(TreeNode*,int);


static void cGen(TreeNode * tree, int scope,int start_label,int end_label,bool in_adress_mode);
static void cGenInAdressMode(TreeNode * tree, int scope, int start_label, int end_label);
static void cGenInValueMode(TreeNode * tree, int scope, int start_label, int end_label);
/*function used to get the relative register of specific type  */
static int get_reg(Type type);
static int get_reg1(Type type);
/*get the current env's stack*/
static int get_stack_bottom(int scope);
static void pushParam(TreeNode * t,ParamNode * p, int scope);
static void popParam(ParamNode * p);
// help
// get the A.x from tmpOffset
static void getRealAdressBy(TreeNode* tree);

static void setInAdressMode();
static void restoreAdressMode();
int look_label(int start_label,int end_label);// find the label representing the adress

/* Procedure genStmt generates code at a statement node */
static void genStmt( TreeNode * tree,int scope,int start_label,int end_label, bool in_adress_mode)
{
    TreeNode * p1, * p2, * p3;
    int savedLoc1,savedLoc2,currentLoc;
    int loc;
	TypeInfo type;
    switch (tree->kind.stmt)
	{            
        case IfK :
            if (TraceCode) emitComment("-> if");

			int else_label = genLabel();
			int if_end_label = genLabel();

			/* generate code for test expression */
			cGenInValueMode(tree->child[0], scope + 1, -1, -1);
			emitRM("POP", ac, 0, mp, "pop from the mp");
			emitRO("JNE", ac, 1, pc, "true case:, execute if part");
			emitGoto(else_label);// 直接进入else命令的判断
			cGenInValueMode(tree->child[1], scope + 1, start_label, end_label);//执行if的语句
			emitGoto(if_end_label);// if 执行完之后直接进入结束位置
			
			emitLabel(else_label);
            emitComment("if: jump to else");
			cGenInValueMode(tree->child[2], scope + 1, start_label, end_label);// 执行else部分的语句
			emitLabel(if_end_label);
			
            if (TraceCode)  emitComment("<- if") ;
            break; /* if_k */
		case SwitchK:
			{
				int switch_end_label = genLabel();// the label before repeat
				TreeNode * case_seq = tree->child[1]->child[0];
				while (case_seq != NULL)
				{
					cGenInValueMode(tree->child[0], scope + 1, start_label, end_label);
					cGenInValueMode(case_seq->child[0], scope + 1, start_label, end_label);// case exp;
					int case_start_label = genLabel();
					int case_end_label = genLabel();

					emitRO("POP", ac, 0, mp, "pop case exp");
					emitRO("POP", ac1, 0, mp, "pop switch exp");
					emitRO("SUB", ac, ac, ac1, "op ==, convertd_type");
					emitRM("JEQ", ac, 2, pc, "go to case if statisfy");
					emitGoto(case_end_label);// case 不满足,go to case结束位置
					emitRM("LDA", pc, 1, pc, "unconditional jmp");
					emitGoto(case_start_label);// case 满足: go to case内部代码

					emitLabel(case_start_label);// generate start label
					cGenInValueMode(case_seq->child[1], scope + 1, start_label, switch_end_label);// case stmt;
					emitLabel(case_end_label);// generate start label
					deleteVarOfField(case_seq->child[1], scope + 1);// 清除所有的局部变量
					case_seq = case_seq->sibling;
				}
				emitLabel(switch_end_label);// generate start label
				break;
			}
        case RepeatK:/*gen code for while statement*/
            if (TraceCode) emitComment("-> repeat");
			int new_start_label = genLabel();// the label before repeat
			int new_end_label = genLabel();

			TreeNode * test = tree->child[0];
			TreeNode * body = tree->child[1];
			emitComment("while stmt:");
			emitLabel(new_start_label);// generate start label

			cGenInValueMode(test, scope + 1, -1, -1);// test condition code
			emitRM("POP", ac, 0, mp, "pop from the mp");
			emitRO("JNE", ac, 1, pc, "true case:, skip the break, execute the block code");
			emitGoto(new_end_label);

			/* generate code for body */
			cGenInValueMode(body, scope, new_start_label, new_end_label);
			emitGoto(new_start_label);
            emitRestore();
			emitLabel(new_end_label);// generate a label
			if (TraceCode)  emitComment("<- repeat") ;
            break; /* repeat */
		case BreakK:
			emitGoto(end_label);
			break;
		case BlockK:
			cGen(tree->child[0], scope + 1, start_label, end_label, in_adress_mode);
			deleteVarOfField(tree->child[0], scope + 1);
			break;
		case ContinueK:
			emitGoto(start_label);
			break;
        case ReadK:
            loc = st_lookup(tree->attr.name);
			type = st_lookup_type(tree->attr.name);
			//todo, optimize follow code. DRY
			emitRO("IN", get_reg(getBasicType(type)), 0, 0, "read integer/float value");
			emitRM("ST", get_reg(getBasicType(type)), loc, get_stack_bottom(scope), "assign: store value");//mem[reg[gp]+loc] =  reg[ac]
			break;
    
		case WriteK:
            /* generate code for expression to write */
			cGenInValueMode(tree->child[0], scope, start_label, end_label);
			type = tree->child[0]->type;
			int mode = 0;// 0代表数,1代表字符,2代表字符串
			emitRM("POP", get_reg(getBasicType(type)), 0, mp, "move result to register");
			if (is_basic_type(type, Char)) mode = 1;
			else if (is_basic_type(type, String)) mode = 2;
			emitRO("OUT", get_reg(getBasicType(type)), mode, 0, "output value in register[ac / fac]");
            break;
		case AsmK:
			if (strcmp(tree->attr.name, "malloc") == 0)
			{	
				// malloc(n)
				cGen(tree->child[0], scope, start_label, end_label, 0);// n
				emitRM("POP", ac, 0, mp, "get malloc parameters");
				emitSYS("MALLOC", 0, 0, 0, "system call for malloc");
			}
			else if (strcmp(tree->attr.name, "free") == 0)
			{
				// free(p)
				cGen(tree->child[0], scope, start_label, end_label, 0);// p
				emitRM("POP", ac, 0, mp, "get free parameters");
				emitSYS("FREE", 0, 0, 0, "system call for free");
			}
			break;
		case ReturnK:
			if (tree->child[0] != NULL) 
			{ 
				cGenInValueMode(tree->child[0], scope, start_label, end_label);
				TypeInfo ctype = tree->child[0]->converted_type;
				TypeInfo return_type = *st_lookup_type(current_function).func_type.return_type;
				int vsize = var_size_of_type(return_type);			
				int origin_reg = get_reg(getBasicType(ctype));
				int target_reg = get_reg(getBasicType(return_type));
				if (vsize == 1 && origin_reg != target_reg){
					emitRM("POP",origin_reg,  0, mp, "op: POP left");
					emitRO("MOV", target_reg,origin_reg, 0, "move register reg(s) tp reg(r)");
					emitRM("PUSH", target_reg, 0, mp, "op: push left");
				}
			}

			emitRO("MOV", sp, fp, 0, "restore the caller sp");// restore the sp;reg[sp] = reg[fp]
			emitRM("LD", fp, 0, fp, "resotre the caller fp");//resotre the fp;reg[fp] = dMem[reg[fp]]
			emitRO("RETURN", 0, -1, sp, "return to the caller");
			break;
		
		case DeclareK:
			/*deal with the function  */
			if (is_basic_type(tree->type,Func)) 
			{
				current_function = tree->attr.name;
				emitComment("function entry:");
				emitComment(current_function);

				char * last_current = current_function;
				if (scope > 0) insertNode(tree, scope);

				insertParam(tree->child[0], scope + 1);
				// set function adress
				if (setStructInfo(NULL, 0) == NULL ){
					setFunctionAdress(tree->attr.name, NULL,scope);
				}
				else{// declare function in struct
					setFunctionAdress(tree->attr.name, setStructInfo(NULL, 0),scope);
				}
				int skip_adress = emitSkip(1);

				// assume the caller move return adress in reg[ac]
				emitRO("MOV", ac1, fp, 0,"store the caller fp temporarily");// store the caller fp
				emitRO("MOV", fp,  sp, 0, "exchang the stack(context)");//reg[fp] = reg[sp]

				emitRM("PUSH", ac1, 0, sp, "push the caller fp");//dMem[reg[sp]--] = ac1 
				emitRM("PUSH", ac,  0, sp, "push the return adress");// dMem[reg[sp]--] = return adress;assume the caller sotre the return adress reg[pc] in reg[ac]
				
				cGenInValueMode(tree->child[1], scope + 1, start_label, end_label);// generate code for the function body,insert local variable
				deleteParams(tree->child[0], scope + 1);
				deleteVarOfField(tree->child[1], scope + 1);

				//todo this should be moved to return node
				emitRO("MOV", sp, fp, 0, "restore the caller sp");// restore the sp;reg[sp] = reg[fp]
				emitRM("LD", fp, 0, fp, "resotre the caller fp");//resotre the fp;reg[fp] = dMem[reg[fp]]
				emitRO("RETURN", 0, -1, sp, "return to adress : reg[fp]+1");// execute reg[pc] = return adress
				emitComment("function end");
				int leave_adress = emitSkip(0);
				emitBackup(skip_adress);
				emitRM_Abs("LDA",pc,leave_adress,"skip the function body");
				emitRestore();
				current_function = last_current;
			}
			else// variable
			{
                cgenCodeForInsertNode(tree,scope);
			}

			if (tree->child[2] != NULL){
				cgen_assign(tree, tree->child[2], scope);
			}

			break;
		case StructDefineK:
		{
			char * last_sname = setStructInfo(tree->attr.name,1);
            
			cGenInValueMode(tree->child[0], scope + 1, start_label, end_label);// will insert all function
            deleteVarOfField(tree->child[0],scope + 1 );
            emitRO("MOV",sp,fp,0,"resotre stack in struct");
            setStructInfo(last_sname, 1);//restore
			break;
		}
        default:
            break;
    }
}

/* Procedure genExp generates code at an expression node */
static void genExp( TreeNode * tree,int scope,int start_label,int end_label,bool in_adress_mode)
{
	int loc;
    TreeNode * p1;
	TypeInfo type = tree->converted_type;
	int integer;
	float float_num;
	int vsize = 0;
	int origin_reg = -1, target_reg = -1;
	switch (tree->kind.exp) 
	{       
        case ConstK :
            if (TraceCode) emitComment("-> Const") ;
            /* gen code to load integer constant using LDC */
            switch (getBasicType(type)) 
			{
			case Integer:
				 integer = integer_from_node(tree);
				 emitRM("LDC", ac, integer, 0, "load integer const");// reg[ac] = tree->ttr.val.integer
				 emitRM("PUSH", ac, 0, mp,"store exp");
				 break;
			case Float:
				 float_num = float_from_node(tree);
				 emitLDCF("LDC", fac, float_num, 0, "load float const");// reg[ac] = tree->ttr.val.integer
				 emitRM("PUSH", fac,0, mp, "store exp");
				 break;
			case Char:
				 emitRM("LDC", ac, tree->attr.val.integer, 0, "load char const");// reg[ac] = tree->ttr.val.integer
				 emitRM("PUSH", ac, 0, mp, "store exp");
				break;
			case String:
				if (tree->attr.name != NULL){
					int i = 0;
					char * name = tree->attr.name;
					for (int i = 0; *name != '\0'; i++){
						emitRM("LDC", ac, *name, 0, "load char const");// reg[ac] = tree->ttr.val.integer
						emitRM("ST", ac, tree->attr.val.integer + i, cp, "store exp");
						name++;
					}
					free(tree->attr.name);
					tree->attr.name = NULL;
				}
				emitRM("LDA", ac, tree->attr.val.integer , cp, "load char const");// reg[ac] = tree->ttr.val.integer
				emitRM("PUSH", ac, 0, mp, "store exp");
				break;
			default:
				assert(!"BUG in ConstK,unknwon expression type");
				break;
			}
            if (TraceCode)  emitComment("<- Const") ;
            break; /* ConstK */
          
        case IdK :
            if (TraceCode) emitComment("-> Id");
            loc = st_lookup(tree->attr.name);
			
			if (checkInAdressMode() || is_basic_type(tree->converted_type, Array))
			{
				emitRM("LDA", ac, loc, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id adress");// reg[ac] = Mem[reg[gp] + loc]			
				emitRM("PUSH", ac, 0, mp, "push array adress to mp");
			}
			else
			{
				int vsize = var_size_of(tree);
				for (int i = 0; i < vsize; ++i)
				{
					emitRM("LD", get_reg(getBasicType(tree->type)), loc + i, get_stack_bottom(st_lookup_scope(tree->attr.name)), "load id value");// reg[ac] = Mem[reg[gp] + loc]			
					emitRO("MOV", get_reg(getBasicType(type)), get_reg(getBasicType(tree->type)), 0, "move from one reg(s) to reg(r)");// tiny machine wuold analyze the instruction 
					emitRM("PUSH", get_reg(getBasicType(type)), 0, mp, "store exp");
				}
			}
			if (TraceCode)  emitComment("<- Id");
            break; /* IdK */
		case FuncallK:
			//todo :tail recursion optimize
			assert(tree->attr.name != NULL);
			TreeNode *e = tree->child[0];
			FuncType ftype = tree->child[1]->type.func_type;
			ParamNode *p = ftype.params;
			pushParam(e, p, scope + 1);
			emitComment("call function: ");
			emitComment(tree->attr.name);
			jumpToFunction(tree, NULL, scope);
			popParam(p);
			break;
		case SingleOpK:
			if (TraceCode) emitComment("->Single Op");
			p1 = tree->child[0];
			// todo optimize following code. bad smell
			if (tree->attr.op != ADRESS && tree->attr.op != UNREF && tree->attr.op != SIZEOF)
			{
				cGenInValueMode(p1, scope, start_label, end_label);
				origin_reg = get_reg(getBasicType(p1->converted_type));
				target_reg = get_reg(getBasicType(type));
				
				emitRM("POP", origin_reg, 0, mp, "pop right");
				emitRO("MOV", target_reg, origin_reg, 0, "convert type");
			}

			switch (tree->attr.op)
			{
                case NEG:
                    emitRO("NEG", target_reg, 0, 0, "single op (-)");// fac = -fac || ac = -ac
                    emitRM("PUSH", target_reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
                    break;
				case MMINUS:
				case PPLUS:// ++x => x = x + 1 || --x => x - 1
				{
					// 这里需要复用 +,因为存在pointer和integer的区别
					TreeNode * op_node = newExpNode(OpK);
					TreeNode * const_node = newExpNode(ConstK);
					const_node->type = createTypeFromBasic(Integer);
					const_node->converted_type = const_node->type;
					const_node->attr.val.integer = 1;

					op_node->child[0] = tree->child[0];
					op_node->child[1] = const_node;
					op_node->attr.op = tree->attr.op;
					op_node->converted_type = op_node->type = tree->child[0]->converted_type;

					if (tree->return_type.typekind == Before){
						cgen_assign(tree->child[0], op_node, scope);
						if (!tree->empty_exp) genExp(tree->child[0], scope, start_label, end_label, false);// generate value
					}
					else if (tree->return_type.typekind == After)
					{
						if (!tree->empty_exp) genExp(tree->child[0], scope, start_label, end_label, false);// generate value
						cgen_assign(tree->child[0], op_node, scope);
					}
					free(const_node);
					free(op_node);
					break;
				}
	
				case ADRESS:
					// todo support &p[1][2] || &(*(xxxx))
					cGenInAdressMode(p1, scope, start_label, end_label);
					break;
				case UNREF:
					// todo remove the bad smell
					assert(p1 != NULL);
					if (checkInAdressMode())
					{
						cGenInValueMode(p1, scope, start_label, end_label);
						emitRM("POP", ac, 0, mp, "pop the adress");
					}
					else
					{
						cGenInValueMode(p1, scope, start_label, end_label);
						emitRM("POP", ac, 0, mp, "pop the adress");
						vsize = var_size_of(tree);
						TypeInfo ptype = *p1->converted_type.point_type.pointKind;
						TypeInfo ptype_ori = *p1->type.point_type.pointKind;
						target_reg = get_reg1(ptype.typekind);
						origin_reg = get_reg1(ptype_ori.typekind);
						cGenPushTemp(vsize, target_reg, origin_reg, ac);
					}
					break;
				case CONVERSION:		
					emitRM("PUSH",target_reg,0,mp,"");
					break;
				case SIZEOF:
					target_reg = get_reg(getBasicType(type));
					emitRO("LDC", ac, var_size_of_type(tree->return_type), 0, "load size of exp");
					emitRO("MOV", target_reg, ac, 0, "");
					emitRM("PUSH",target_reg, 0,mp,"");
					break;
				default:
                    assert(!"not implemented single op");
                    break;
			}
            if (TraceCode) emitComment("<-Single Op");

			break;
		case AssignK:
			if (TraceCode) emitComment("-> assign");
			cgen_assign(tree->child[0], tree->child[1], scope);
			if (!tree->empty_exp)
			{
				// generate value for write  x = y
				cGenInValueMode(tree->child[0], scope, start_label, end_label);
			}
			if (TraceCode)  emitComment("<- assign");
			break; /* assign_k */
		case IndexK:
			if (TraceCode) emitComment("->index k");
			
			vsize = var_size_of(tree);
			// todo skip the adress
			bool adress_mode = checkInAdressMode() || \
				 is_basic_type(tree->converted_type, Array);

			if (is_basic_type(tree->child[0]->converted_type, Pointer)){
				cGenInValueMode(tree->child[0], scope,start_label,end_label);
			}
			else{
				cGenInAdressMode(tree->child[0], scope, start_label, end_label);
			}

			cGenInValueMode(tree->child[1], scope,start_label,end_label);
			emitRM("POP", ac, 0, mp, "load index value to ac");
			emitRO("LDC", ac1, vsize, 0, "load array size");
			emitRO("MUL", ac, ac1, ac, "compute the offset");

			emitRM("POP", ac1, 0, mp, "load lhs adress to ac1");
			emitRO("ADD", ac, ac, ac1, "compute the real index adress a[index]");
			
			if (!adress_mode)
			{
				origin_reg = get_reg1(getBasicType(tree->type));
				target_reg = get_reg1(getBasicType(tree->converted_type));
				cGenPushTemp(vsize, target_reg, origin_reg, ac);
			}
			else
			{
				emitRM("PUSH", ac, 0, mp, "push the adress mode into mp");
			}
			break;
		case ArrowK:
			// todo merge Arrow and point
			if (!checkInAdressMode())
			{
				cGenInValueMode(tree->child[0], scope, start_label, end_label);//get pointer
				getRealAdressBy(tree);
				emitRM("POP", ac, 0, mp, "load adress from mp");
				// now need to produce the real value rather than Adress
				origin_reg = get_reg1(getBasicType(tree->type));
				target_reg = get_reg1(getBasicType(tree->converted_type));
				vsize = var_size_of(tree);

				for (int i = 0; i < vsize; ++i)
				{
					// move bytes tmpOffset to tmpOffset
					// todo optimize
					emitRM("LD", origin_reg, i, ac, "copy bytes");//reg[ac] =  dMem[reg[ac]]
					emitRO("MOV", target_reg, origin_reg, 0, "move register ");
					emitRM("PUSH", target_reg, 0, mp, "push a.x value into tmp");
				}
			}
			else
			{
				// copy from memory to memory
				cGenInValueMode(tree->child[0], scope, start_label, end_label);//generate the adress
				getRealAdressBy(tree);
			}
			break;
		case PointK:
			if (!checkInAdressMode())
			{
				cGenInAdressMode(tree->child[0], scope,start_label,end_label);//generate the adress
				getRealAdressBy(tree);
				emitRM("POP", ac, 0, mp, "load adress from mp");
				// now need to produce the real value rather than Adress
				origin_reg = get_reg1(getBasicType(tree->type));
				target_reg = get_reg1(getBasicType(tree->converted_type));
				vsize = var_size_of(tree);
				
				for (int i = 0; i < vsize; ++i)
				{
					// move bytes tmpOffset to tmpOffset
					emitRM("LD", origin_reg, i, ac, "copy bytes");//reg[ac] =  dMem[reg[ac]]
					emitRO("MOV", target_reg, origin_reg, 0, "move register ");
					emitRM("PUSH", target_reg, 0, mp, "push a.x value into tmp");
				}
			}
			else
			{
				// copy from memory to memory
				cGenInAdressMode(tree->child[0], scope,start_label,end_label);//generate the adress
				getRealAdressBy(tree);
			}
			break;
		case OpK :
            if (TraceCode) emitComment("-> Op") ;
			cgenOp(tree->child[0],tree->child[1], tree->attr.op, scope, start_label, end_label);
            if (TraceCode)  emitComment("<- Op") ;
            break; /* OpK */
            
        default:
            break;
    }
} /* genExp */

/* Procedure cGen recursively generates code by
 * tree traversal
 */
static void cGen( TreeNode * tree,int scope,int start_label,int end_label,bool in_adress_mode)
{ if (tree != NULL)
	{ 
		switch (tree->nodekind) 
		{
			case StmtK:
				genStmt(tree,scope,start_label,end_label,in_adress_mode);			
				break;
			case ExpK:
				genExp(tree,scope,-1,-1,in_adress_mode);
				break;
			default:
				break;
		}
		cGen(tree->sibling,scope,start_label,end_label,false);
	}
}


void codeGen(TreeNode * syntaxTree, char * codefile)
{ 
	char *s = copyString("File: ");
    strcat(s,codefile);
    emitComment(s);
    /* generate st\andard prelude */
    emitComment("Standard prelude:");
	emitRM("LDC", mp, MP_ADRESS, 0, "load mp adress");//reg[mp] = dMem[reg[ac]] 
    emitRM("ST",ac,0,ac,"clear location 0");// dMem[reg[ac] + 0] = reg[ac]
	
	emitRM("LDC", gp, GP_ADRESS, 0, "load gp adress from location 1");
	emitRM("ST", ac, 1, ac, "clear location 1");

	emitRM("LDC", cp, CONST_ADRESS, 0, "load gp adress from location 1");

	emitRM("LDC", fp, FIRST_FP, 0, "load first fp from location 2");
	emitRM("LDC", sp, FIRST_FP, 0, "load first sp from location 2");
	emitRM("ST", ac, 2, ac, "clear location 2");

    emitComment("End of standard prelude.");
	/* generate code for TINY program */
	cGen(syntaxTree,0,-1,-1,false);
		
	emitComment("call main function");
	jumpToFunction(NULL,"main", 0);
	//todo: check if in the MainModule
	if (st_get_node("main") != NULL)	emitRO("HALT", 0, 0, 0, "");// finish
}

int genLabel(void)
{
	static int label = 0;
	return label++; 
}

void emitLabel(int label)
{
	assert(label >= 0);
	emitRO("LABEL", label++, 0, 0, "generate label");// finish
}

void emitGoto(int label)
{
	assert(label >= 0 );
	emitRO("GO", label, 0, 0, "go to label");// finish
}

int get_reg(Type type)
{
	if (type == Float)
	{
		return fac;
	}
	else if ((type == Integer) || (type == Boolean) || (type == Func) ||
			(type == Pointer) || (type == Array) || (type == Struct) ||
			(type == Char) || (type == String) || (type == Void))
	{
		return ac;
	}
	else
	{
		assert(!"get reg is not implemented for other type");
		return 0;
	}
}

int get_reg1(Type type)
{
	return get_reg(type) + 1;
}

int get_stack_bottom(int scope)
{
	assert(scope >= 0);
	if (scope == 0) return gp;
	else return fp;
}
// push param from right to left
void pushParam(TreeNode * e,ParamNode * p,int scope)
{
	if (e != NULL)
	{
		pushParam(e->sibling, p->next_param, scope);
	}
	else
    {
		assert(p == NULL);
		return;
	}
	genExp(e, scope,-1,-1,false);// very important! cannot use cGen to avoid cGen generate exp list automatically

	int exp_reg = get_reg(getBasicType(e->converted_type));
	int par_reg = get_reg(getBasicType(*p->type));
	int vsize = var_size_of(e);
	if (is_basic_type(e->type, Array)) vsize = 1;
	cgenPushObj(exp_reg, par_reg, vsize);
}
/*pop parameters*/
void popParam(ParamNode * p)
{
	int param_size = 0;
	while (p != NULL)
	{
		param_size += var_size_of_type(*p->type);
		p = p->next_param;
	}

	emitRM("LDA",sp, param_size, sp, "pop parameters");
}

void setInAdressMode()
{
	in_adressMode = TRUE;
}

void restoreAdressMode()
{
	in_adressMode = FALSE;
}

// compute and store Adress of A.x in ac
void getRealAdressBy( TreeNode* tree)
{
	StructType stype;
	switch (tree->kind.exp)
	{
	case PointK:
		 stype = getStructType(tree->child[0]->type.sname);
		break;
	case ArrowK:
		 stype = getStructType(tree->child[0]->type.point_type.pointKind->sname);
		break;
	}
	Member* member = getMember(stype, tree->attr.name);
	int offset = member->offset;
	emitRO("POP", ac1, 0, mp, "load adress of lhs struct");
	emitRO("LDC", ac, offset, 0, "load offset of member");
	emitRO("ADD", ac, ac, ac1, "compute the real adress if pointK");
	emitRM("PUSH", ac, 0, mp, "");
}

void cgen_assign(TreeNode * left, TreeNode * right, int scope)
{
	cGenInValueMode(right, scope, -1, -1);// load value 

	// emit COPY tmp to dMem[reg[(gp or fp) + loc] from tmpOffset(in reverse) vsize bytes
	int origin_reg = get_reg(getBasicType(right->converted_type));
	int target_reg = get_reg(getBasicType(left->converted_type));
	int vsize = var_size_of(left);

	if (isExp(left,IdK) || isStmt(left,DeclareK))
	{
		char * name = left->attr.name;
		int loc = st_lookup(name);// get the memory location of identifier
		int var_stack_bottom = get_stack_bottom(st_lookup_scope(name));
		emitRM("LDA", ac1, loc, var_stack_bottom, "move the adress of ID");
	}
	else if (isExp(left, SingleOpK))
	{
		//  *..p = ffff 
		// todo run in the adress mode
		assert(left->attr.op == UNREF || !"illegal left operand on assign");
		cGenInValueMode(left->child[0], scope, -1, -1);
		emitRM("POP", ac1, 0, mp, "move the adress of referenced");
	}
	else if (isExp(left, IndexK) || isExp(left,PointK) || isExp(left,ArrowK))
	{
		cGenInAdressMode(left, scope, -1, -1);
		emitRM("POP", ac1, 0, mp, "move the adress of referenced");
	}
	cgenCopyObj(origin_reg, target_reg, vsize, ac1);
}

void cgenOp(TreeNode * left,TreeNode * right,TokenType op, int scope,int start_label, int end_label)
{
	TreeNode *p1 = left;
	TreeNode *p2 = right;
	TypeInfo type = p1->converted_type;
	/* gen code for ac = left arg */
	cGenInValueMode(p1, scope, start_label, end_label);
	cGenInValueMode(p2, scope, start_label, end_label);
	// todo

	if (is_basic_type(left->type, Pointer))
	{
		int vsize = vsize = var_size_of_type(*left->type.point_type.pointKind);
		switch (op)
		{
		case PLUS:
		case PPLUS:
		case PLUSASSIGN:
			emitRM("POP", ac, 0, mp, "load index value to ac");
			emitRO("LDC", ac1, vsize, 0, "load pointkind size");
			emitRO("MUL", ac, ac1, ac, "compute the offset");

			emitRM("POP", ac1, 0, mp, "load lhs adress to ac1");
			emitRO("ADD", ac, ac1, ac, "compute the real index adress");
			emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
			return;
		case MINUS:
		case MMINUS:
		case MINUSASSIGN:
			emitRM("POP", ac, 0, mp, "load index value to ac");
			emitRO("LDC", ac1, vsize, 0, "load pointkind size");
			emitRO("MUL", ac, ac1, ac, "compute the offset");

			emitRM("POP", ac1, 0, mp, "load lhs adress to ac1");
			emitRO("SUB", ac, ac1, ac, "compute the real index adress");
			emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
			return;
		}
	}

	int origin_reg = get_reg(getBasicType(p1->converted_type));
	int origin_reg1 = get_reg1(getBasicType(p2->converted_type));
	int reg = get_reg(getBasicType(type));
	int reg1 = get_reg1(getBasicType(type));

	emitRM("POP", origin_reg1, 0, mp, "pop right");
	emitRO("MOV", reg1, origin_reg1, 0, "convert type");

	emitRM("POP", origin_reg, 0, mp, "pop left");
	emitRO("MOV", reg, origin_reg, 0, "convert type");
	
	switch (op)
	{
	case PPLUS:
	case PLUSASSIGN:
	case PLUS:
		emitRO("ADD", reg, reg, reg1, "op +");// ac = ac1 op ac
		emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
		break;
	case MMINUS:
	case MINUSASSIGN:
	case MINUS:
		emitRO("SUB", reg, reg, reg1, "op -");
		emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
		break;
	case TIMES:
		emitRO("MUL", reg, reg, reg1, "op *");
		emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
		break;
	case OVER:
		emitRO("DIV", reg, reg, reg1, "op /");
		emitRM("PUSH", reg, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
		break;
	case LT:
	case GT:
	case LE:
	case GE:
	{
		char op_code[4] = "JLT";
		if (op == LT || op == LE)
		{
			emitRO("SUB", reg, reg, reg1, "op <");
			op_code[2] = (op == LT ? 'T' : 'E');
		}
		else
		{
			emitRO("SUB", reg, reg, reg1, "op <");
			op_code[1] = 'G';
			op_code[2] = (op == GT ? 'T' : 'E');
		}

		/* now the op_code is JLE,JLT,GLE,GLT*/
		emitRM(op_code, ac, 2, pc, "br if true");
		emitRM("LDC", ac, 0, ac, "false case");
		emitRM("LDA", pc, 1, pc, "unconditional jmp");
		emitRM("LDC", ac, 1, ac, "true case");
		emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
		break;
	}
	case EQ:
	case NOTEQ:
		{
		emitRO("SUB", reg, reg, reg1, "op ==, convertd_type");
		emitRM(op == EQ ? "JEQ" : "JNE", ac, 2, pc, "br if true");
		emitRM("LDC", ac, 0, ac, "false case");
		emitRM("LDA", pc, 1, pc, "unconditional jmp");
		emitRM("LDC", ac, 1, ac, "true case");
		emitRM("PUSH", ac, 0, mp, "op: load left"); //reg[ac1] = mem[reg[mp] + tmpoffset]
		break;
		}
	default:
		emitComment("BUG: Unknown operator");
		break;
	} /* case op */
}

// 将内存的内容从 adress_reg加载到origin_reg,然后从origin_reg->target_reg,然后压到mp
void cGenPushTemp(int vsize, int target_reg, int origin_reg, int adress_reg)
{
	for (int loc = 0; loc < vsize; ++loc)
	{
		emitRM("LD", origin_reg, loc, adress_reg, "load bytes");//
		emitRO("MOV", target_reg, origin_reg, 0, "move between reg");
		emitRM("PUSH", target_reg, 0, mp, "push bytes ");
	}
}

void cGenInAdressMode(TreeNode * tree, int scope, int start_label, int end_label){
	cGen(tree, scope, start_label, end_label, true);
}

void cGenInValueMode(TreeNode * tree, int scope, int start_label, int end_label){
	cGen(tree, scope, start_label, end_label, false);
}


/* 从mp开始,连续拷贝vsize大小的内存到
   target_adress_reg 开始的地方
   (经过 origin_reg -> target_reg的转换)		
*/
 void cgenCopyObj(int origin_reg, int target_reg, int offset, int target_adress_reg)
{
	__cgenPopFromTemp(origin_reg, target_reg, offset, target_adress_reg, __cGenST);
}

 //  pop from mp and push to sp
 /*  从mp开始, 连续拷贝vsize大小的内存到stack的栈底(内存压缩)
	 target_adress_reg 开始的地方
	 (经过 origin_reg->target_reg的转换)
 */
void cgenPushObj(int origin_reg, int target_reg, int offset)
{
	__cgenPopFromTemp(origin_reg, target_reg, offset, sp, __cGenPUSH);
}

 //pop and do something
 void __cgenPopFromTemp(int origin_reg, int target_reg, int offset, int adress_reg, emitFunc f)
 {
	 while (offset-- > 0)
	 {
		 emitRM("POP", origin_reg, 0, mp, "copy bytes");//reg[ac] =  dMem[reg[mp] + (++tmpOffset) ]
		 emitRO("MOV", target_reg, origin_reg, 0, "copy bytes");
		 f(target_reg, offset, adress_reg);// do something
	 }
 }

 void __cGenST(int target_reg, int offset, int target_adress_reg)
 {
	 emitRM("ST", target_reg, offset, target_adress_reg, "copy bytes");
 }

 void __cGenPUSH(int target_reg, int offset, int target_adress_reg)
 {
	 emitRM("PUSH", target_reg, 0, target_adress_reg, "PUSH bytes");
 }

 void setFunctionAdress(char * fname,char * struct_name, int scope)
 {
	 if (struct_name == NULL)
	 {
		 int entry_adress = emitSkip(0) + 3;
		 int loc = st_lookup(fname);
		 emitRM("LDC", ac, entry_adress, 0, "get function adress");
		 emitRM("ST", ac, loc, get_stack_bottom(scope), "set function adress");
	 }
	 else
	 {
         // set adress for struct type
         StructType stype = getStructType(struct_name);
         Member * mem = getMember(stype,fname);
         mem->typeinfo.func_type.adress = emitSkip(0) + 1;
	 }
 }

 void jumpToFunction(TreeNode * tree,char * main_func,int scope)
 {
	 if (main_func != NULL )
	 {
		 //处理不属于主模块的情况
		 if (st_get_node(main_func) == NULL) return;
		 int loc = st_lookup(main_func);
		 emitRM("LD",ac1,loc,gp,"get main function adress");
		 emitRM("LDC", ac, emitSkip(0) + 2, 0, "store the return adress");
		 emitRM("LDA", pc, 0, ac1, "ujp to the function body");
	 }
	 else{
		 cGenInValueMode(tree->child[1], scope, -1, -1);// now adress in mp
		 emitRM("LDC", ac, emitSkip(0) + 2, 0, "store the return adress");
		 emitRM("POP", pc, 0, mp, "ujp to the function body");
	 }
 }

void initStructInstance(TreeNode * t,int scope)
 {
     StructType stype = getStructType(t->type.sname);
     Member * members = stype.members;
     for(Member * mem = members; mem != NULL; mem = mem->next_member)
     {
         if(is_basic_type(mem->typeinfo, Func ))
         {
             int offset = mem->offset;
             emitRM("LDC",ac1, mem->typeinfo.func_type.adress, 0,"get function adress from struct");
             emitRM("ST", ac1, offset,sp,"Init Struct Instance");
         }
     }
 }

void cgenCodeForInsertNode(TreeNode * t, int scope)
{
    if(scope > 0) insertNode(t,scope);
    
    int vsize = var_size_of(t);
    emitRM("LDA",sp,-vsize,sp,"stack expand");

    if(is_basic_type(t->type,Struct))
    {
        initStructInstance(t,scope);
    }
}

static bool checkInMainModule()
{
	return st_get_node("main") != NULL;
}