	.file	"simple.ispc"
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function simple___un_3C_unf_3E_un_3C_unf_3E_uni
.LCPI0_0:
	.long	0x40400000                      # float 3
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
.LCPI0_1:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
	.text
	.globl	simple___un_3C_unf_3E_un_3C_unf_3E_uni
	.p2align	4
	.type	simple___un_3C_unf_3E_un_3C_unf_3E_uni,@function
simple___un_3C_unf_3E_un_3C_unf_3E_uni: # @simple___un_3C_unf_3E_un_3C_unf_3E_uni
# %bb.0:
                                        # kill: def $edx killed $edx def $rdx
	leal	15(%rdx), %eax
	testl	%edx, %edx
	cmovnsl	%edx, %eax
	andl	$-16, %eax
	jle	.LBB0_1
# %bb.2:
	movl	%eax, %ecx
	xorl	%eax, %eax
	vbroadcastss	.LCPI0_0(%rip), %zmm0   # zmm0 = [3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0]
	.p2align	4
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	vmovups	(%rdi,%rax,4), %zmm1
	vcmpnltps	%zmm0, %zmm1, %k1
	vmulps	%zmm1, %zmm1, %zmm2
	vblendmps	%zmm1, %zmm2, %zmm1 {%k1}
	vsqrtps	%zmm1, %zmm2 {%k1}
	vmovups	%zmm2, (%rsi,%rax,4)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jb	.LBB0_3
# %bb.4:
	cmpl	%edx, %eax
	jge	.LBB0_6
.LBB0_5:
	vpbroadcastd	%eax, %zmm0
	vpord	.LCPI0_1(%rip), %zmm0, %zmm0
	vpbroadcastd	%edx, %zmm1
	vpcmpgtd	%zmm0, %zmm1, %k1
	shll	$2, %eax
	vmovups	(%rdi,%rax), %zmm0 {%k1} {z}
	vbroadcastss	.LCPI0_0(%rip), %zmm1   # zmm1 = [3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0]
	vcmpltps	%zmm1, %zmm0, %k2 {%k1}
	vcmpnltps	%zmm1, %zmm0, %k3 {%k1}
	vmulps	%zmm0, %zmm0, %zmm0 {%k2}
	vsqrtps	%zmm0, %zmm0 {%k3}
	vmovups	%zmm0, (%rsi,%rax) {%k1}
.LBB0_6:
	vzeroupper
	retq
.LBB0_1:
	xorl	%eax, %eax
	cmpl	%edx, %eax
	jl	.LBB0_5
	jmp	.LBB0_6
.Lfunc_end0:
	.size	simple___un_3C_unf_3E_un_3C_unf_3E_uni, .Lfunc_end0-simple___un_3C_unf_3E_un_3C_unf_3E_uni
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function simple
.LCPI1_0:
	.long	0x40400000                      # float 3
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
.LCPI1_1:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.long	8                               # 0x8
	.long	9                               # 0x9
	.long	10                              # 0xa
	.long	11                              # 0xb
	.long	12                              # 0xc
	.long	13                              # 0xd
	.long	14                              # 0xe
	.long	15                              # 0xf
	.text
	.globl	simple
	.p2align	4
	.type	simple,@function
simple:                                 # @simple
# %bb.0:
                                        # kill: def $edx killed $edx def $rdx
	leal	15(%rdx), %eax
	testl	%edx, %edx
	cmovnsl	%edx, %eax
	andl	$-16, %eax
	jle	.LBB1_1
# %bb.2:
	movl	%eax, %ecx
	xorl	%eax, %eax
	vbroadcastss	.LCPI1_0(%rip), %zmm0   # zmm0 = [3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0]
	.p2align	4
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	vmovups	(%rdi,%rax,4), %zmm1
	vcmpnltps	%zmm0, %zmm1, %k1
	vmulps	%zmm1, %zmm1, %zmm2
	vblendmps	%zmm1, %zmm2, %zmm1 {%k1}
	vsqrtps	%zmm1, %zmm2 {%k1}
	vmovups	%zmm2, (%rsi,%rax,4)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jb	.LBB1_3
# %bb.4:
	cmpl	%edx, %eax
	jge	.LBB1_6
.LBB1_5:
	vpbroadcastd	%eax, %zmm0
	vpord	.LCPI1_1(%rip), %zmm0, %zmm0
	vpbroadcastd	%edx, %zmm1
	vpcmpgtd	%zmm0, %zmm1, %k1
	shll	$2, %eax
	vmovups	(%rdi,%rax), %zmm0 {%k1} {z}
	vbroadcastss	.LCPI1_0(%rip), %zmm1   # zmm1 = [3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0,3.0E+0]
	vcmpltps	%zmm1, %zmm0, %k2 {%k1}
	vcmpnltps	%zmm1, %zmm0, %k3 {%k1}
	vmulps	%zmm0, %zmm0, %zmm0 {%k2}
	vsqrtps	%zmm0, %zmm0 {%k3}
	vmovups	%zmm0, (%rsi,%rax) {%k1}
.LBB1_6:
	vzeroupper
	retq
.LBB1_1:
	xorl	%eax, %eax
	cmpl	%edx, %eax
	jl	.LBB1_5
	jmp	.LBB1_6
.Lfunc_end1:
	.size	simple, .Lfunc_end1-simple
                                        # -- End function
	.ident	"Intel(r) Implicit SPMD Program Compiler (Intel(r) ISPC), 1.30.0 (build commit 3fc6d50cf24dc8b4 @ 20260204, LLVM 21.1.8)"
	.ident	"LLVM version 21.1.8 (https://github.com/llvm/llvm-project.git 2078da43e25a4623cab2d0d60decddf709aaea28)"
	.section	".note.GNU-stack","",@progbits
