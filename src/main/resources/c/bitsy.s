	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 10
	.globl	_printList
	.align	4, 0x90
_printList:                             ## @printList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
Ltmp3:
	.cfi_offset %rbx, -56
Ltmp4:
	.cfi_offset %r12, -48
Ltmp5:
	.cfi_offset %r13, -40
Ltmp6:
	.cfi_offset %r14, -32
Ltmp7:
	.cfi_offset %r15, -24
	movq	%rdi, -48(%rbp)
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$0, -52(%rbp)
	leaq	L_.str1(%rip), %r13
	leaq	LJTI0_0(%rip), %rbx
	leaq	L_.str4(%rip), %r14
	leaq	L_.str5(%rip), %r15
	leaq	L_.str6(%rip), %r12
	jmp	LBB0_1
	.align	4, 0x90
LBB0_11:                                ##   in Loop: Header=BB0_1 Depth=1
	incl	-52(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-52(%rbp), %eax
	movq	-48(%rbp), %rcx
	cmpl	(%rcx), %eax
	jge	LBB0_12
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	cmpl	$0, -52(%rbp)
	jle	LBB0_4
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	xorl	%eax, %eax
	movq	%r13, %rdi
	callq	_printf
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	movslq	-52(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	(%rcx,%rax), %eax
	cmpq	$5, %rax
	ja	LBB0_11
## BB#5:                                ##   in Loop: Header=BB0_1 Depth=1
	movslq	(%rbx,%rax,4), %rax
	addq	%rbx, %rax
	jmpq	*%rax
LBB0_6:                                 ##   in Loop: Header=BB0_1 Depth=1
	movslq	-52(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movq	8(%rcx,%rax), %rsi
	xorl	%eax, %eax
	leaq	L_.str2(%rip), %rdi
	callq	_printf
	incl	-52(%rbp)
	jmp	LBB0_1
LBB0_7:                                 ##   in Loop: Header=BB0_1 Depth=1
	movslq	-52(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movsd	8(%rcx,%rax), %xmm0
	movb	$1, %al
	leaq	L_.str3(%rip), %rdi
	callq	_printf
	incl	-52(%rbp)
	jmp	LBB0_1
LBB0_8:                                 ##   in Loop: Header=BB0_1 Depth=1
	movslq	-52(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	testb	$1, 8(%rcx,%rax)
	movq	%r15, %rdi
	cmovneq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	incl	-52(%rbp)
	jmp	LBB0_1
LBB0_10:                                ##   in Loop: Header=BB0_1 Depth=1
	movslq	-52(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movq	8(%rcx,%rax), %rdi
	callq	_printList
	jmp	LBB0_11
LBB0_9:                                 ##   in Loop: Header=BB0_1 Depth=1
	xorl	%eax, %eax
	movq	%r12, %rdi
	callq	_printf
	incl	-52(%rbp)
	jmp	LBB0_1
LBB0_12:
	leaq	L_.str7(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
	.align	2, 0x90
L0_0_set_6 = LBB0_6-LJTI0_0
L0_0_set_7 = LBB0_7-LJTI0_0
L0_0_set_8 = LBB0_8-LJTI0_0
L0_0_set_10 = LBB0_10-LJTI0_0
L0_0_set_11 = LBB0_11-LJTI0_0
L0_0_set_9 = LBB0_9-LJTI0_0
LJTI0_0:
	.long	L0_0_set_6
	.long	L0_0_set_7
	.long	L0_0_set_8
	.long	L0_0_set_10
	.long	L0_0_set_11
	.long	L0_0_set_9

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI1_0:
	.quad	0                       ## double 0
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_listsEqual
	.align	4, 0x90
_listsEqual:                            ## @listsEqual
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp8:
	.cfi_def_cfa_offset 16
Ltmp9:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp10:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$40, %rsp
Ltmp11:
	.cfi_offset %rbx, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	(%rsi), %eax
	je	LBB1_2
## BB#1:
	movb	$0, -9(%rbp)
	jmp	LBB1_18
LBB1_2:
	movl	$0, -36(%rbp)
	leaq	LJTI1_0(%rip), %rbx
	jmp	LBB1_3
	.align	4, 0x90
LBB1_16:                                ##   in Loop: Header=BB1_3 Depth=1
	incl	-36(%rbp)
LBB1_3:                                 ## =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	(%rcx), %eax
	jge	LBB1_17
## BB#4:                                ##   in Loop: Header=BB1_3 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	(%rcx,%rax), %ecx
	movq	-32(%rbp), %rdx
	movq	8(%rdx), %rdx
	cmpl	(%rdx,%rax), %ecx
	jne	LBB1_5
## BB#6:                                ##   in Loop: Header=BB1_3 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	(%rcx,%rax), %eax
	cmpq	$6, %rax
	ja	LBB1_15
## BB#7:                                ##   in Loop: Header=BB1_3 Depth=1
	movslq	(%rbx,%rax,4), %rax
	addq	%rbx, %rax
	jmpq	*%rax
LBB1_8:                                 ##   in Loop: Header=BB1_3 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movq	8(%rcx,%rax), %rdi
	movq	-32(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	8(%rcx,%rax), %rsi
	callq	_strcmp
	testl	%eax, %eax
	je	LBB1_16
	jmp	LBB1_9
LBB1_10:                                ##   in Loop: Header=BB1_3 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movsd	8(%rcx,%rax), %xmm0
	movq	-32(%rbp), %rcx
	movq	8(%rcx), %rcx
	subsd	8(%rcx,%rax), %xmm0
	ucomisd	LCPI1_0(%rip), %xmm0
	jne	LBB1_11
	jnp	LBB1_16
LBB1_11:
	movb	$0, -9(%rbp)
	jmp	LBB1_18
LBB1_12:                                ##   in Loop: Header=BB1_3 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movzbl	8(%rcx,%rax), %ecx
	andl	$1, %ecx
	movq	-32(%rbp), %rdx
	movq	8(%rdx), %rdx
	movzbl	8(%rdx,%rax), %eax
	andl	$1, %eax
	cmpl	%eax, %ecx
	je	LBB1_16
	jmp	LBB1_13
LBB1_14:                                ##   in Loop: Header=BB1_3 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movq	8(%rcx,%rax), %rdi
	movq	-32(%rbp), %rcx
	movq	8(%rcx), %rcx
	movq	8(%rcx,%rax), %rsi
	callq	_listsEqual
	testb	%al, %al
	jne	LBB1_16
LBB1_15:
	movb	$0, -9(%rbp)
LBB1_18:
	movb	-9(%rbp), %al
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
LBB1_17:
	movb	$1, -9(%rbp)
	jmp	LBB1_18
LBB1_5:
	movb	$0, -9(%rbp)
	jmp	LBB1_18
LBB1_9:
	movb	$0, -9(%rbp)
	jmp	LBB1_18
LBB1_13:
	movb	$0, -9(%rbp)
	jmp	LBB1_18
	.cfi_endproc
	.align	2, 0x90
L1_0_set_8 = LBB1_8-LJTI1_0
L1_0_set_10 = LBB1_10-LJTI1_0
L1_0_set_12 = LBB1_12-LJTI1_0
L1_0_set_14 = LBB1_14-LJTI1_0
L1_0_set_16 = LBB1_16-LJTI1_0
LJTI1_0:
	.long	L1_0_set_8
	.long	L1_0_set_10
	.long	L1_0_set_12
	.long	L1_0_set_14
	.long	L1_0_set_16
	.long	L1_0_set_16
	.long	L1_0_set_16

	.globl	_isEmpty
	.align	4, 0x90
_isEmpty:                               ## @isEmpty
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp12:
	.cfi_def_cfa_offset 16
Ltmp13:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp14:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	cmpl	$0, (%rdi)
	sete	%al
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_listResize
	.align	4, 0x90
_listResize:                            ## @listResize
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp15:
	.cfi_def_cfa_offset 16
Ltmp16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp17:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rax
	addl	(%rax), %esi
	cmpl	%esi, 4(%rax)
	jge	LBB3_2
## BB#1:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdi
	movl	-12(%rbp), %eax
	addl	$10, %eax
	movslq	%eax, %rsi
	shlq	$4, %rsi
	callq	_GC_realloc
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movl	-12(%rbp), %eax
	addl	$10, %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 4(%rcx)
LBB3_2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, (%rcx)
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_initList
	.align	4, 0x90
_initList:                              ## @initList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp18:
	.cfi_def_cfa_offset 16
Ltmp19:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp20:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	$16, %edi
	callq	_GC_malloc
	movq	%rax, -16(%rbp)
	movl	-4(%rbp), %eax
	addl	$10, %eax
	movslq	%eax, %rdi
	shlq	$4, %rdi
	callq	_GC_malloc
	movq	-16(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
	movl	-4(%rbp), %eax
	addl	$10, %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 4(%rcx)
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_listCopy
	.align	4, 0x90
_listCopy:                              ## @listCopy
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp21:
	.cfi_def_cfa_offset 16
Ltmp22:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp23:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	(%rdi), %edi
	callq	_initList
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	%rax, %rdi
	callq	_addListToList
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_addListToList
	.align	4, 0x90
_addListToList:                         ## @addListToList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp24:
	.cfi_def_cfa_offset 16
Ltmp25:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp26:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$56, %rsp
Ltmp27:
	.cfi_offset %rbx, -24
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -28(%rbp)
	movl	%eax, -32(%rbp)
	movl	$0, -36(%rbp)
	leaq	LJTI6_0(%rip), %rbx
	jmp	LBB6_1
	.align	4, 0x90
LBB6_9:                                 ##   in Loop: Header=BB6_1 Depth=1
	incl	-32(%rbp)
	incl	-36(%rbp)
LBB6_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-24(%rbp), %rcx
	addl	(%rcx), %eax
	cmpl	%eax, -32(%rbp)
	jge	LBB6_10
## BB#2:                                ##   in Loop: Header=BB6_1 Depth=1
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	(%rcx,%rax), %eax
	cmpq	$3, %rax
	jbe	LBB6_3
## BB#8:                                ##   in Loop: Header=BB6_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	_addNullToList
	jmp	LBB6_9
	.align	4, 0x90
LBB6_3:                                 ##   in Loop: Header=BB6_1 Depth=1
	movslq	(%rbx,%rax,4), %rax
	addq	%rbx, %rax
	jmpq	*%rax
LBB6_4:                                 ##   in Loop: Header=BB6_1 Depth=1
	movq	-16(%rbp), %rdi
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movq	8(%rcx,%rax), %rsi
	callq	_addStringToList
	jmp	LBB6_9
LBB6_5:                                 ##   in Loop: Header=BB6_1 Depth=1
	movq	-16(%rbp), %rdi
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movsd	8(%rcx,%rax), %xmm0
	callq	_addNumberToList
	jmp	LBB6_9
LBB6_6:                                 ##   in Loop: Header=BB6_1 Depth=1
	movq	-16(%rbp), %rdi
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movzbl	8(%rcx,%rax), %esi
	andl	$1, %esi
	callq	_addBooleanToList
	jmp	LBB6_9
LBB6_7:                                 ##   in Loop: Header=BB6_1 Depth=1
	movq	-16(%rbp), %rdi
	movl	-32(%rbp), %esi
	incl	%esi
	callq	_listResize
	movslq	-32(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	$3, (%rcx,%rax)
	movslq	-36(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movq	8(%rcx,%rax), %rax
	movq	%rax, -48(%rbp)
	movl	(%rax), %edi
	callq	_initList
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rsi
	movq	%rax, %rdi
	callq	_addListToList
	movslq	-32(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movq	8(%rdx), %rdx
	shlq	$4, %rcx
	movq	%rax, 8(%rdx,%rcx)
	jmp	LBB6_9
LBB6_10:
	movq	-16(%rbp), %rax
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc
	.align	2, 0x90
L6_0_set_4 = LBB6_4-LJTI6_0
L6_0_set_5 = LBB6_5-LJTI6_0
L6_0_set_6 = LBB6_6-LJTI6_0
L6_0_set_7 = LBB6_7-LJTI6_0
LJTI6_0:
	.long	L6_0_set_4
	.long	L6_0_set_5
	.long	L6_0_set_6
	.long	L6_0_set_7

	.globl	_addStringToList
	.align	4, 0x90
_addStringToList:                       ## @addStringToList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp28:
	.cfi_def_cfa_offset 16
Ltmp29:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp30:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %esi
	movl	%esi, -20(%rbp)
	movq	-8(%rbp), %rdi
	incl	%esi
	callq	_listResize
	movslq	-20(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	$0, (%rcx,%rax)
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movq	-8(%rbp), %rdx
	movq	8(%rdx), %rdx
	shlq	$4, %rcx
	movq	%rax, 8(%rdx,%rcx)
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_addNumberToList
	.align	4, 0x90
_addNumberToList:                       ## @addNumberToList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp31:
	.cfi_def_cfa_offset 16
Ltmp32:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp33:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movsd	%xmm0, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %esi
	movl	%esi, -20(%rbp)
	movq	-8(%rbp), %rdi
	incl	%esi
	callq	_listResize
	movslq	-20(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	$1, (%rcx,%rax)
	movsd	-16(%rbp), %xmm0
	movslq	-20(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movsd	%xmm0, 8(%rcx,%rax)
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_addBooleanToList
	.align	4, 0x90
_addBooleanToList:                      ## @addBooleanToList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp34:
	.cfi_def_cfa_offset 16
Ltmp35:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp36:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movb	%sil, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %esi
	movl	%esi, -16(%rbp)
	movq	-8(%rbp), %rdi
	incl	%esi
	callq	_listResize
	movslq	-16(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	$2, (%rcx,%rax)
	movb	-9(%rbp), %al
	movslq	-16(%rbp), %rcx
	movq	-8(%rbp), %rdx
	movq	8(%rdx), %rdx
	shlq	$4, %rcx
	andb	$1, %al
	movb	%al, 8(%rdx,%rcx)
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_addNullToList
	.align	4, 0x90
_addNullToList:                         ## @addNullToList
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp37:
	.cfi_def_cfa_offset 16
Ltmp38:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp39:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	(%rdi), %esi
	movl	%esi, -12(%rbp)
	movq	-8(%rbp), %rdi
	incl	%esi
	callq	_listResize
	movslq	-12(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	8(%rcx), %rcx
	shlq	$4, %rax
	movl	$5, (%rcx,%rax)
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main2
	.align	4, 0x90
_main2:                                 ## @main2
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp40:
	.cfi_def_cfa_offset 16
Ltmp41:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp42:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	xorl	%eax, %eax
	callq	_GC_init
	movl	$5, %edi
	callq	_initList
	movq	%rax, -8(%rbp)
	movl	$4, %edi
	callq	_initList
	movq	%rax, -16(%rbp)
	movl	$1600, %edi             ## imm = 0x640
	callq	_GC_malloc
	movq	%rax, -24(%rbp)
	movl	$2, (%rax)
	movq	-24(%rbp), %rax
	movb	$1, 8(%rax)
	movq	-24(%rbp), %rax
	movl	$0, 16(%rax)
	movq	-24(%rbp), %rax
	leaq	L_.str8(%rip), %rcx
	movq	%rcx, 24(%rax)
	movq	-24(%rbp), %rax
	movl	$1, 32(%rax)
	movq	-24(%rbp), %rax
	movabsq	$4638369846219558093, %rcx ## imm = 0x405ECCCCCCCCCCCD
	movq	%rcx, 40(%rax)
	movq	-24(%rbp), %rax
	movl	$5, 48(%rax)
	movq	-24(%rbp), %rax
	movl	$3, 64(%rax)
	movq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, 72(%rcx)
	movq	-8(%rbp), %rax
	movl	$5, (%rax)
	movq	-8(%rbp), %rax
	movl	$5, 4(%rax)
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-8(%rbp), %rdi
	callq	_printList
	leaq	L_.str9(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	-8(%rbp), %rdi
	callq	_listCopy
	movq	%rax, %rdi
	callq	_printList
	leaq	L_.str10(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"["

L_.str1:                                ## @.str1
	.asciz	", "

L_.str2:                                ## @.str2
	.asciz	"\"%s\""

L_.str3:                                ## @.str3
	.asciz	"%g"

L_.str4:                                ## @.str4
	.asciz	"true"

L_.str5:                                ## @.str5
	.asciz	"false"

L_.str6:                                ## @.str6
	.asciz	"null"

L_.str7:                                ## @.str7
	.asciz	"]"

L_.str8:                                ## @.str8
	.asciz	"hello world"

L_.str9:                                ## @.str9
	.asciz	"\n\n"

L_.str10:                               ## @.str10
	.asciz	"\n"


.subsections_via_symbols
