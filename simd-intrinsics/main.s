	.text
	.file	"main.cpp"
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z19clamped_relu_serialPfS_i
.LCPI0_0:
	.long	0x3f800000                      # float 1
	.text
	.globl	_Z19clamped_relu_serialPfS_i
	.p2align	4, 0x90
	.type	_Z19clamped_relu_serialPfS_i,@function
_Z19clamped_relu_serialPfS_i:           # @_Z19clamped_relu_serialPfS_i
	.cfi_startproc
# %bb.0:
	testl	%edx, %edx
	jle	.LBB0_3
# %bb.1:
	movl	%edx, %eax
	xorl	%ecx, %ecx
	vxorps	%xmm0, %xmm0, %xmm0
	vmovss	.LCPI0_0(%rip), %xmm1           # xmm1 = [1.0E+0,0.0E+0,0.0E+0,0.0E+0]
	.p2align	4, 0x90
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	vcmpgtss	(%rdi,%rcx,4), %xmm0, %k1
	vmovaps	%xmm1, %xmm2
	vmovss	%xmm0, %xmm2, %xmm2 {%k1}
	vmovss	%xmm2, (%rsi,%rcx,4)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB0_2
.LBB0_3:
	retq
.Lfunc_end0:
	.size	_Z19clamped_relu_serialPfS_i, .Lfunc_end0-_Z19clamped_relu_serialPfS_i
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z19clamped_relu_vectorPfS_i
.LCPI1_0:
	.long	0x3f800000                      # float 1
	.text
	.globl	_Z19clamped_relu_vectorPfS_i
	.p2align	4, 0x90
	.type	_Z19clamped_relu_vectorPfS_i,@function
_Z19clamped_relu_vectorPfS_i:           # @_Z19clamped_relu_vectorPfS_i
	.cfi_startproc
# %bb.0:
	vzeroall
	cmpl	$8, %edx
	jl	.LBB1_3
# %bb.1:
	addl	$-8, %edx
	movslq	%edx, %rax
	xorl	%ecx, %ecx
	vxorps	%xmm0, %xmm0, %xmm0
	vbroadcastss	.LCPI1_0(%rip), %ymm1   # ymm1 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
	.p2align	4, 0x90
.LBB1_2:                                # =>This Inner Loop Header: Depth=1
	vmovaps	(%rdi,%rcx,4), %ymm2
	vmaxps	%ymm0, %ymm2, %ymm2
	vminps	%ymm1, %ymm2, %ymm2
	vmovaps	%ymm2, (%rsi,%rcx,4)
	addq	$8, %rcx
	cmpq	%rax, %rcx
	jle	.LBB1_2
.LBB1_3:
	vzeroupper
	retq
.Lfunc_end1:
	.size	_Z19clamped_relu_vectorPfS_i, .Lfunc_end1-_Z19clamped_relu_vectorPfS_i
	.cfi_endproc
                                        # -- End function
	.globl	_Z15fizzbuzz_serialPiS_i        # -- Begin function _Z15fizzbuzz_serialPiS_i
	.p2align	4, 0x90
	.type	_Z15fizzbuzz_serialPiS_i,@function
_Z15fizzbuzz_serialPiS_i:               # @_Z15fizzbuzz_serialPiS_i
	.cfi_startproc
# %bb.0:
	testl	%edx, %edx
	jle	.LBB2_3
# %bb.1:
	movl	%edx, %eax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	movl	(%rdi,%rcx,4), %edx
	leal	-1(%rdx), %r8d
	movl	%edx, %r9d
	addl	%edx, %r9d
	testb	$1, %dl
	cmovnel	%r8d, %r9d
	movl	%r9d, (%rsi,%rcx,4)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB2_2
.LBB2_3:
	retq
.Lfunc_end2:
	.size	_Z15fizzbuzz_serialPiS_i, .Lfunc_end2-_Z15fizzbuzz_serialPiS_i
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z15fizzbuzz_vectorPiS_i
.LCPI3_0:
	.long	1                               # 0x1
	.text
	.globl	_Z15fizzbuzz_vectorPiS_i
	.p2align	4, 0x90
	.type	_Z15fizzbuzz_vectorPiS_i,@function
_Z15fizzbuzz_vectorPiS_i:               # @_Z15fizzbuzz_vectorPiS_i
	.cfi_startproc
# %bb.0:
	vzeroall
	cmpl	$8, %edx
	jl	.LBB3_3
# %bb.1:
	addl	$-8, %edx
	movslq	%edx, %rax
	xorl	%ecx, %ecx
	vpbroadcastd	.LCPI3_0(%rip), %ymm0   # ymm0 = [1,1,1,1,1,1,1,1]
	vpcmpeqd	%ymm1, %ymm1, %ymm1
	.p2align	4, 0x90
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	vmovdqu	(%rdi,%rcx,4), %ymm2
	vptestnmd	%ymm0, %ymm2, %k1
	vpaddd	%ymm1, %ymm2, %ymm3
	vpaddd	%ymm2, %ymm2, %ymm3 {%k1}
	vmovdqu	%ymm3, (%rsi,%rcx,4)
	addq	$8, %rcx
	cmpq	%rax, %rcx
	jle	.LBB3_2
.LBB3_3:
	vzeroupper
	retq
.Lfunc_end3:
	.size	_Z15fizzbuzz_vectorPiS_i, .Lfunc_end3-_Z15fizzbuzz_vectorPiS_i
	.cfi_endproc
                                        # -- End function
	.globl	_Z18fixed_power_serialPfiS_i    # -- Begin function _Z18fixed_power_serialPfiS_i
	.p2align	4, 0x90
	.type	_Z18fixed_power_serialPfiS_i,@function
_Z18fixed_power_serialPfiS_i:           # @_Z18fixed_power_serialPfiS_i
	.cfi_startproc
# %bb.0:
                                        # kill: def $esi killed $esi def $rsi
	testl	%ecx, %ecx
	jle	.LBB4_7
# %bb.1:
	movl	%ecx, %eax
	leal	1(%rsi), %ecx
	xorl	%r8d, %r8d
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_3:                                #   in Loop: Header=BB4_2 Depth=1
	vmovaps	%xmm0, %xmm1
.LBB4_6:                                #   in Loop: Header=BB4_2 Depth=1
	vmovss	%xmm1, (%rdx,%r8,4)
	incq	%r8
	cmpq	%rax, %r8
	je	.LBB4_7
.LBB4_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_5 Depth 2
	vmovss	(%rdi,%r8,4), %xmm0             # xmm0 = mem[0],zero,zero,zero
	cmpl	$2, %esi
	jl	.LBB4_3
# %bb.4:                                #   in Loop: Header=BB4_2 Depth=1
	movl	%ecx, %r9d
	vmovaps	%xmm0, %xmm1
	.p2align	4, 0x90
.LBB4_5:                                #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulss	%xmm1, %xmm0, %xmm1
	decl	%r9d
	cmpl	$2, %r9d
	jg	.LBB4_5
	jmp	.LBB4_6
.LBB4_7:
	retq
.Lfunc_end4:
	.size	_Z18fixed_power_serialPfiS_i, .Lfunc_end4-_Z18fixed_power_serialPfiS_i
	.cfi_endproc
                                        # -- End function
	.globl	_Z18fixed_power_vectorPfiS_i    # -- Begin function _Z18fixed_power_vectorPfiS_i
	.p2align	4, 0x90
	.type	_Z18fixed_power_vectorPfiS_i,@function
_Z18fixed_power_vectorPfiS_i:           # @_Z18fixed_power_vectorPfiS_i
	.cfi_startproc
# %bb.0:
                                        # kill: def $esi killed $esi def $rsi
	cmpl	$8, %ecx
	jge	.LBB5_1
.LBB5_7:
	vzeroupper
	retq
.LBB5_1:
	addl	$-8, %ecx
	movslq	%ecx, %rax
	leal	1(%rsi), %ecx
	xorl	%r8d, %r8d
	jmp	.LBB5_2
	.p2align	4, 0x90
.LBB5_3:                                #   in Loop: Header=BB5_2 Depth=1
	vmovaps	%ymm0, %ymm1
.LBB5_6:                                #   in Loop: Header=BB5_2 Depth=1
	vmovups	%ymm1, (%rdx,%r8,4)
	addq	$8, %r8
	cmpq	%rax, %r8
	jg	.LBB5_7
.LBB5_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_5 Depth 2
	vmovups	(%rdi,%r8,4), %ymm0
	cmpl	$2, %esi
	jl	.LBB5_3
# %bb.4:                                #   in Loop: Header=BB5_2 Depth=1
	movl	%ecx, %r9d
	vmovaps	%ymm0, %ymm1
	.p2align	4, 0x90
.LBB5_5:                                #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm1, %ymm0, %ymm1
	decl	%r9d
	cmpl	$2, %r9d
	jg	.LBB5_5
	jmp	.LBB5_6
.Lfunc_end5:
	.size	_Z18fixed_power_vectorPfiS_i, .Lfunc_end5-_Z18fixed_power_vectorPfiS_i
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z17clampedExp_serialPfPiS_i
.LCPI6_0:
	.long	0x3f800000                      # float 1
.LCPI6_1:
	.long	0x411fff97                      # float 9.99989986
	.text
	.globl	_Z17clampedExp_serialPfPiS_i
	.p2align	4, 0x90
	.type	_Z17clampedExp_serialPfPiS_i,@function
_Z17clampedExp_serialPfPiS_i:           # @_Z17clampedExp_serialPfPiS_i
	.cfi_startproc
# %bb.0:
	testl	%ecx, %ecx
	jle	.LBB6_6
# %bb.1:
	movl	%ecx, %eax
	xorl	%ecx, %ecx
	vmovss	.LCPI6_0(%rip), %xmm0           # xmm0 = [1.0E+0,0.0E+0,0.0E+0,0.0E+0]
	vmovss	.LCPI6_1(%rip), %xmm1           # xmm1 = [9.99989986E+0,0.0E+0,0.0E+0,0.0E+0]
	jmp	.LBB6_2
	.p2align	4, 0x90
.LBB6_5:                                #   in Loop: Header=BB6_2 Depth=1
	vminss	%xmm2, %xmm1, %xmm2
	vmovss	%xmm2, (%rdx,%rcx,4)
	incq	%rcx
	cmpq	%rax, %rcx
	je	.LBB6_6
.LBB6_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_4 Depth 2
	movl	(%rsi,%rcx,4), %r8d
	vmovaps	%xmm0, %xmm2
	testl	%r8d, %r8d
	jle	.LBB6_5
# %bb.3:                                #   in Loop: Header=BB6_2 Depth=1
	vmovss	(%rdi,%rcx,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	incl	%r8d
	vmovaps	%xmm0, %xmm2
	.p2align	4, 0x90
.LBB6_4:                                #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulss	%xmm2, %xmm3, %xmm2
	decl	%r8d
	cmpl	$1, %r8d
	jg	.LBB6_4
	jmp	.LBB6_5
.LBB6_6:
	retq
.Lfunc_end6:
	.size	_Z17clampedExp_serialPfPiS_i, .Lfunc_end6-_Z17clampedExp_serialPfPiS_i
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z17clampedExp_vectorPfPiS_i
.LCPI7_0:
	.long	0x3f800000                      # float 1
.LCPI7_1:
	.long	0x411fff97                      # float 9.99989986
	.text
	.globl	_Z17clampedExp_vectorPfPiS_i
	.p2align	4, 0x90
	.type	_Z17clampedExp_vectorPfPiS_i,@function
_Z17clampedExp_vectorPfPiS_i:           # @_Z17clampedExp_vectorPfPiS_i
	.cfi_startproc
# %bb.0:
	cmpl	$8, %ecx
	jge	.LBB7_1
.LBB7_6:
	vzeroupper
	retq
.LBB7_1:
	addl	$-8, %ecx
	movslq	%ecx, %rax
	xorl	%ecx, %ecx
	vbroadcastss	.LCPI7_0(%rip), %ymm0   # ymm0 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
	vpxor	%xmm1, %xmm1, %xmm1
	vpcmpeqd	%ymm2, %ymm2, %ymm2
	vbroadcastss	.LCPI7_1(%rip), %ymm3   # ymm3 = [9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0]
	jmp	.LBB7_2
	.p2align	4, 0x90
.LBB7_5:                                #   in Loop: Header=BB7_2 Depth=1
	vminps	%ymm5, %ymm3, %ymm4
	vmovups	%ymm4, (%rdx,%rcx,4)
	addq	$8, %rcx
	cmpq	%rax, %rcx
	jg	.LBB7_6
.LBB7_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_4 Depth 2
	vmovdqu	(%rsi,%rcx,4), %ymm4
	vpcmpgtd	%ymm1, %ymm4, %ymm5
	vptest	%ymm5, %ymm5
	vmovaps	%ymm0, %ymm5
	je	.LBB7_5
# %bb.3:                                #   in Loop: Header=BB7_2 Depth=1
	vmovups	(%rdi,%rcx,4), %ymm6
	vpcmpgtd	%ymm1, %ymm4, %k1
	vmovaps	%ymm0, %ymm5
	.p2align	4, 0x90
.LBB7_4:                                #   Parent Loop BB7_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm6, %ymm5, %ymm5 {%k1}
	vpaddd	%ymm2, %ymm4, %ymm4
	vpcmpgtd	%ymm1, %ymm4, %k1
	vpcmpgtd	%ymm1, %ymm4, %ymm7
	vptest	%ymm7, %ymm7
	jne	.LBB7_4
	jmp	.LBB7_5
.Lfunc_end7:
	.size	_Z17clampedExp_vectorPfPiS_i, .Lfunc_end7-_Z17clampedExp_vectorPfPiS_i
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function main
.LCPI8_0:
	.long	0x3f800000                      # float 1
.LCPI8_1:
	.long	0x411fff97                      # float 9.99989986
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0
.LCPI8_2:
	.long	1                               # 0x1
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	6                               # 0x6
	.long	1                               # 0x1
	.long	3                               # 0x3
.LCPI8_3:
	.long	0x40400000                      # float 3
	.long	0x40800000                      # float 4
	.long	0x40a00000                      # float 5
	.long	0x3f800000                      # float 1
	.long	0x40800000                      # float 4
	.long	0x41100000                      # float 9
	.long	0x40000000                      # float 2
	.long	0x3f800000                      # float 1
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception0
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	xorl	%eax, %eax
	leaq	.L__const.main.input(%rip), %rcx
	leaq	.L__const.main.exp(%rip), %rdx
	vmovss	.LCPI8_0(%rip), %xmm0           # xmm0 = [1.0E+0,0.0E+0,0.0E+0,0.0E+0]
	vmovss	.LCPI8_1(%rip), %xmm1           # xmm1 = [9.99989986E+0,0.0E+0,0.0E+0,0.0E+0]
	jmp	.LBB8_1
	.p2align	4, 0x90
.LBB8_4:                                #   in Loop: Header=BB8_1 Depth=1
	vminss	%xmm2, %xmm1, %xmm2
	vmovss	%xmm2, 16(%rsp,%rax,4)
	incq	%rax
	cmpq	$8, %rax
	je	.LBB8_5
.LBB8_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_3 Depth 2
	movl	(%rdx,%rax,4), %esi
	vmovaps	%xmm0, %xmm2
	testl	%esi, %esi
	jle	.LBB8_4
# %bb.2:                                #   in Loop: Header=BB8_1 Depth=1
	vmovss	(%rcx,%rax,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	incl	%esi
	vmovaps	%xmm0, %xmm2
	.p2align	4, 0x90
.LBB8_3:                                #   Parent Loop BB8_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulss	%xmm2, %xmm3, %xmm2
	decl	%esi
	cmpl	$1, %esi
	jg	.LBB8_3
	jmp	.LBB8_4
.LBB8_5:
	xorl	%r15d, %r15d
	movq	_ZNSt3__14coutE@GOTPCREL(%rip), %rbx
	leaq	.L.str(%rip), %r14
	.p2align	4, 0x90
.LBB8_6:                                # =>This Inner Loop Header: Depth=1
	vmovss	16(%rsp,%r15,4), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEf@PLT
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	incq	%r15
	cmpq	$8, %r15
	jne	.LBB8_6
# %bb.7:
	movq	(%rbx), %rax
	addq	-24(%rax), %rbx
	leaq	8(%rsp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_ZNKSt3__18ios_base6getlocEv@PLT
.Ltmp0:
	movq	_ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp1:
# %bb.8:
	movq	(%rax), %rcx
.Ltmp2:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
.Ltmp3:
# %bb.9:
	movl	%eax, %ebx
	leaq	8(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movsbl	%bl, %esi
	movq	_ZNSt3__14coutE@GOTPCREL(%rip), %rbx
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc@PLT
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv@PLT
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	vptest	%ymm0, %ymm0
	jne	.LBB8_13
# %bb.10:
	vbroadcastss	.LCPI8_0(%rip), %ymm1   # ymm1 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
	jmp	.LBB8_15
.LBB8_13:
	kxnorw	%k0, %k0, %k1
	vmovdqa	.LCPI8_2(%rip), %ymm2           # ymm2 = [1,4,1,4,1,6,1,3]
	vbroadcastss	.LCPI8_0(%rip), %ymm1   # ymm1 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
	vmovaps	.LCPI8_3(%rip), %ymm3           # ymm3 = [3.0E+0,4.0E+0,5.0E+0,1.0E+0,4.0E+0,9.0E+0,2.0E+0,1.0E+0]
	vpxor	%xmm4, %xmm4, %xmm4
	.p2align	4, 0x90
.LBB8_14:                               # =>This Inner Loop Header: Depth=1
	vmulps	%ymm3, %ymm1, %ymm1 {%k1}
	vpaddd	%ymm0, %ymm2, %ymm2
	vpcmpgtd	%ymm4, %ymm2, %k1
	vpcmpgtd	%ymm4, %ymm2, %ymm5
	vptest	%ymm5, %ymm5
	jne	.LBB8_14
.LBB8_15:
	vbroadcastss	.LCPI8_1(%rip), %ymm0   # ymm0 = [9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0,9.99989986E+0]
	vminps	%ymm1, %ymm0, %ymm0
	vmovups	%ymm0, 16(%rsp)
	xorl	%r15d, %r15d
	movq	_ZNSt3__14coutE@GOTPCREL(%rip), %rbx
	leaq	.L.str(%rip), %r14
	.p2align	4, 0x90
.LBB8_16:                               # =>This Inner Loop Header: Depth=1
	vmovss	16(%rsp,%r15,4), %xmm0          # xmm0 = mem[0],zero,zero,zero
	movq	%rbx, %rdi
	vzeroupper
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEf@PLT
	movl	$1, %edx
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	incq	%r15
	cmpq	$8, %r15
	jne	.LBB8_16
# %bb.17:
	movq	(%rbx), %rax
	addq	-24(%rax), %rbx
	leaq	8(%rsp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_ZNKSt3__18ios_base6getlocEv@PLT
.Ltmp5:
	movq	_ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp6:
# %bb.18:
	movq	(%rax), %rcx
.Ltmp7:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
.Ltmp8:
# %bb.19:
	movl	%eax, %ebx
	leaq	8(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movsbl	%bl, %esi
	movq	_ZNSt3__14coutE@GOTPCREL(%rip), %rbx
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc@PLT
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv@PLT
	xorl	%eax, %eax
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB8_20:
	.cfi_def_cfa_offset 80
.Ltmp9:
	jmp	.LBB8_12
.LBB8_11:
.Ltmp4:
.LBB8_12:
	movq	%rax, %rbx
	leaq	8(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end8:
	.size	main, .Lfunc_end8-main
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table8:
.Lexception0:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Lfunc_begin0-.Lfunc_begin0    # >> Call Site 1 <<
	.uleb128 .Ltmp0-.Lfunc_begin0           #   Call between .Lfunc_begin0 and .Ltmp0
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp0-.Lfunc_begin0           # >> Call Site 2 <<
	.uleb128 .Ltmp3-.Ltmp0                  #   Call between .Ltmp0 and .Ltmp3
	.uleb128 .Ltmp4-.Lfunc_begin0           #     jumps to .Ltmp4
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp3-.Lfunc_begin0           # >> Call Site 3 <<
	.uleb128 .Ltmp5-.Ltmp3                  #   Call between .Ltmp3 and .Ltmp5
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp5-.Lfunc_begin0           # >> Call Site 4 <<
	.uleb128 .Ltmp8-.Ltmp5                  #   Call between .Ltmp5 and .Ltmp8
	.uleb128 .Ltmp9-.Lfunc_begin0           #     jumps to .Ltmp9
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp8-.Lfunc_begin0           # >> Call Site 5 <<
	.uleb128 .Lfunc_end8-.Ltmp8             #   Call between .Ltmp8 and .Lfunc_end8
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end0:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,"axG",@progbits,_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,comdat
	.hidden	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m # -- Begin function _ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	4, 0x90
	.type	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,@function
_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: # @_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
.Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception1
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
.Ltmp10:
	leaq	24(%rsp), %rdi
	movq	%rbx, %rsi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_@PLT
.Ltmp11:
# %bb.1:
	cmpb	$0, 24(%rsp)
	je	.LBB9_10
# %bb.2:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %r8
	movq	40(%rbx,%rax), %r12
	movl	8(%rbx,%rax), %r13d
	cmpl	$-1, 144(%rbx,%rax)
	jne	.LBB9_7
# %bb.3:
.Ltmp13:
	leaq	8(%rsp), %rdi
	movq	%r8, 16(%rsp)                   # 8-byte Spill
	movq	%r8, %rsi
	callq	_ZNKSt3__18ios_base6getlocEv@PLT
.Ltmp14:
# %bb.4:
.Ltmp15:
	movq	_ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp16:
# %bb.5:
	movq	(%rax), %rcx
.Ltmp17:
	movq	%rax, %rdi
	movl	$32, %esi
	callq	*56(%rcx)
.Ltmp18:
# %bb.6:
	movl	%eax, %ebp
	leaq	8(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movsbl	%bpl, %eax
	movq	16(%rsp), %r8                   # 8-byte Reload
	movl	%eax, 144(%r8)
.LBB9_7:
	movsbl	144(%r8), %r9d
	andl	$176, %r13d
	addq	%r15, %r14
	cmpl	$32, %r13d
	movq	%r15, %rdx
	cmoveq	%r14, %rdx
.Ltmp20:
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rcx
	callq	_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
.Ltmp21:
# %bb.8:
	testq	%rax, %rax
	jne	.LBB9_10
# %bb.9:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %rdi
	movl	32(%rbx,%rax), %esi
	orl	$5, %esi
.Ltmp23:
	callq	_ZNSt3__18ios_base5clearEj@PLT
.Ltmp24:
.LBB9_10:
	leaq	24(%rsp), %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev@PLT
.LBB9_11:
	movq	%rbx, %rax
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB9_12:
	.cfi_def_cfa_offset 96
.Ltmp25:
	jmp	.LBB9_15
.LBB9_13:
.Ltmp19:
	movq	%rax, %r14
	leaq	8(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	jmp	.LBB9_16
.LBB9_14:
.Ltmp22:
.LBB9_15:
	movq	%rax, %r14
.LBB9_16:
	leaq	24(%rsp), %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev@PLT
	jmp	.LBB9_18
.LBB9_17:
.Ltmp12:
	movq	%rax, %r14
.LBB9_18:
	movq	%r14, %rdi
	callq	__cxa_begin_catch@PLT
	movq	(%rbx), %rax
	movq	-24(%rax), %rdi
	addq	%rbx, %rdi
.Ltmp26:
	callq	_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv@PLT
.Ltmp27:
# %bb.19:
	callq	__cxa_end_catch@PLT
	jmp	.LBB9_11
.LBB9_20:
.Ltmp28:
	movq	%rax, %rbx
.Ltmp29:
	callq	__cxa_end_catch@PLT
.Ltmp30:
# %bb.21:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_22:
.Ltmp31:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end9:
	.size	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m, .Lfunc_end9-_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.cfi_endproc
	.section	.gcc_except_table._ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,"aG",@progbits,_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,comdat
	.p2align	2, 0x0
GCC_except_table9:
.Lexception1:
	.byte	255                             # @LPStart Encoding = omit
	.byte	155                             # @TType Encoding = indirect pcrel sdata4
	.uleb128 .Lttbase0-.Lttbaseref0
.Lttbaseref0:
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end1-.Lcst_begin1
.Lcst_begin1:
	.uleb128 .Ltmp10-.Lfunc_begin1          # >> Call Site 1 <<
	.uleb128 .Ltmp11-.Ltmp10                #   Call between .Ltmp10 and .Ltmp11
	.uleb128 .Ltmp12-.Lfunc_begin1          #     jumps to .Ltmp12
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp13-.Lfunc_begin1          # >> Call Site 2 <<
	.uleb128 .Ltmp14-.Ltmp13                #   Call between .Ltmp13 and .Ltmp14
	.uleb128 .Ltmp22-.Lfunc_begin1          #     jumps to .Ltmp22
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp15-.Lfunc_begin1          # >> Call Site 3 <<
	.uleb128 .Ltmp18-.Ltmp15                #   Call between .Ltmp15 and .Ltmp18
	.uleb128 .Ltmp19-.Lfunc_begin1          #     jumps to .Ltmp19
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp20-.Lfunc_begin1          # >> Call Site 4 <<
	.uleb128 .Ltmp21-.Ltmp20                #   Call between .Ltmp20 and .Ltmp21
	.uleb128 .Ltmp22-.Lfunc_begin1          #     jumps to .Ltmp22
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp23-.Lfunc_begin1          # >> Call Site 5 <<
	.uleb128 .Ltmp24-.Ltmp23                #   Call between .Ltmp23 and .Ltmp24
	.uleb128 .Ltmp25-.Lfunc_begin1          #     jumps to .Ltmp25
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp24-.Lfunc_begin1          # >> Call Site 6 <<
	.uleb128 .Ltmp26-.Ltmp24                #   Call between .Ltmp24 and .Ltmp26
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp26-.Lfunc_begin1          # >> Call Site 7 <<
	.uleb128 .Ltmp27-.Ltmp26                #   Call between .Ltmp26 and .Ltmp27
	.uleb128 .Ltmp28-.Lfunc_begin1          #     jumps to .Ltmp28
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp27-.Lfunc_begin1          # >> Call Site 8 <<
	.uleb128 .Ltmp29-.Ltmp27                #   Call between .Ltmp27 and .Ltmp29
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp29-.Lfunc_begin1          # >> Call Site 9 <<
	.uleb128 .Ltmp30-.Ltmp29                #   Call between .Ltmp29 and .Ltmp30
	.uleb128 .Ltmp31-.Lfunc_begin1          #     jumps to .Ltmp31
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp30-.Lfunc_begin1          # >> Call Site 10 <<
	.uleb128 .Lfunc_end9-.Ltmp30            #   Call between .Ltmp30 and .Lfunc_end9
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end1:
	.byte	1                               # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                               #   No further actions
	.p2align	2, 0x0
                                        # >> Catch TypeInfos <<
	.long	0                               # TypeInfo 1
.Lttbase0:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text._ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,"axG",@progbits,_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,comdat
	.hidden	_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ # -- Begin function _ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak	_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	4, 0x90
	.type	_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,@function
_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: # @_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
.Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception2
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	testq	%rdi, %rdi
	je	.LBB10_21
# %bb.1:
	movq	%r8, %r12
	movq	%rcx, %r14
	movq	%rdx, %r15
	movq	%rdi, %r13
	movl	%r9d, 28(%rsp)                  # 4-byte Spill
	movq	%rcx, %rax
	subq	%rsi, %rax
	movq	24(%r8), %rcx
	xorl	%ebp, %ebp
	subq	%rax, %rcx
	cmovgq	%rcx, %rbp
	movq	%rdx, %rbx
	subq	%rsi, %rbx
	testq	%rbx, %rbx
	jle	.LBB10_3
# %bb.2:
	movq	(%r13), %rax
	movq	%r13, %rdi
	movq	%rbx, %rdx
	callq	*96(%rax)
	cmpq	%rbx, %rax
	jne	.LBB10_21
.LBB10_3:
	testq	%rbp, %rbp
	jle	.LBB10_8
# %bb.4:
	cmpq	$22, %rbp
	ja	.LBB10_9
# %bb.5:
	leal	(,%rbp,2), %eax
	movb	%al, (%rsp)
	leaq	1(%rsp), %rbx
	jmp	.LBB10_10
.LBB10_8:
	movq	%r13, %rax
	jmp	.LBB10_17
.LBB10_9:
	movabsq	$9223372036854775800, %rax      # imm = 0x7FFFFFFFFFFFFFF8
	andq	%rbp, %rax
	addq	$8, %rax
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	movq	%rbp, %r12
	orq	$7, %r12
	cmpq	$23, %r12
	cmoveq	%rax, %r12
	incq	%r12
	movq	%r12, %rdi
	callq	_Znwm@PLT
	movq	%rax, %rbx
	movq	%rax, 16(%rsp)
	orq	$1, %r12
	movq	%r12, (%rsp)
	movq	32(%rsp), %r12                  # 8-byte Reload
	movq	%rbp, 8(%rsp)
.LBB10_10:
	movzbl	28(%rsp), %esi                  # 1-byte Folded Reload
	movq	%rbx, %rdi
	movq	%rbp, %rdx
	callq	memset@PLT
	movb	$0, (%rbx,%rbp)
	testb	$1, (%rsp)
	je	.LBB10_12
# %bb.11:
	movq	16(%rsp), %rsi
	jmp	.LBB10_13
.LBB10_12:
	leaq	1(%rsp), %rsi
.LBB10_13:
	movq	(%r13), %rax
.Ltmp32:
	movq	%r13, %rdi
	movq	%rbp, %rdx
	callq	*96(%rax)
.Ltmp33:
# %bb.14:
	movq	%rax, %rbx
	xorl	%eax, %eax
	cmpq	%rbp, %rbx
	cmoveq	%r13, %rax
	testb	$1, (%rsp)
	je	.LBB10_16
# %bb.15:
	movq	16(%rsp), %rdi
	movq	%r12, %r13
	movq	%rax, %r12
	callq	_ZdlPv@PLT
	movq	%r12, %rax
	movq	%r13, %r12
.LBB10_16:
	cmpq	%rbp, %rbx
	jne	.LBB10_21
.LBB10_17:
	subq	%r15, %r14
	testq	%r14, %r14
	jle	.LBB10_19
# %bb.18:
	movq	(%rax), %rcx
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	movq	%rax, %rbx
	callq	*96(%rcx)
	movq	%rax, %rcx
	movq	%rbx, %rax
	cmpq	%r14, %rcx
	jne	.LBB10_21
.LBB10_19:
	movq	$0, 24(%r12)
	jmp	.LBB10_22
.LBB10_21:
	xorl	%eax, %eax
.LBB10_22:
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB10_23:
	.cfi_def_cfa_offset 96
.Ltmp34:
	movq	%rax, %rbx
	testb	$1, (%rsp)
	je	.LBB10_25
# %bb.24:
	movq	16(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB10_25:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end10:
	.size	_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_, .Lfunc_end10-_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.cfi_endproc
	.section	.gcc_except_table._ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,"aG",@progbits,_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,comdat
	.p2align	2, 0x0
GCC_except_table10:
.Lexception2:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end2-.Lcst_begin2
.Lcst_begin2:
	.uleb128 .Lfunc_begin2-.Lfunc_begin2    # >> Call Site 1 <<
	.uleb128 .Ltmp32-.Lfunc_begin2          #   Call between .Lfunc_begin2 and .Ltmp32
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp32-.Lfunc_begin2          # >> Call Site 2 <<
	.uleb128 .Ltmp33-.Ltmp32                #   Call between .Ltmp32 and .Ltmp33
	.uleb128 .Ltmp34-.Lfunc_begin2          #     jumps to .Ltmp34
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp33-.Lfunc_begin2          # >> Call Site 3 <<
	.uleb128 .Lfunc_end10-.Ltmp33           #   Call between .Ltmp33 and .Lfunc_end10
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end2:
	.p2align	2, 0x0
                                        # -- End function
	.section	.text.__clang_call_terminate,"axG",@progbits,__clang_call_terminate,comdat
	.hidden	__clang_call_terminate          # -- Begin function __clang_call_terminate
	.weak	__clang_call_terminate
	.p2align	4, 0x90
	.type	__clang_call_terminate,@function
__clang_call_terminate:                 # @__clang_call_terminate
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	__cxa_begin_catch@PLT
	callq	_ZSt9terminatev@PLT
.Lfunc_end11:
	.size	__clang_call_terminate, .Lfunc_end11-__clang_call_terminate
	.cfi_endproc
                                        # -- End function
	.type	.L__const.main.input,@object    # @__const.main.input
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	4, 0x0
.L__const.main.input:
	.long	0x40400000                      # float 3
	.long	0x40800000                      # float 4
	.long	0x40a00000                      # float 5
	.long	0x3f800000                      # float 1
	.long	0x40800000                      # float 4
	.long	0x41100000                      # float 9
	.long	0x40000000                      # float 2
	.long	0x3f800000                      # float 1
	.size	.L__const.main.input, 32

	.type	.L__const.main.exp,@object      # @__const.main.exp
	.p2align	4, 0x0
.L__const.main.exp:
	.long	1                               # 0x1
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	4                               # 0x4
	.long	1                               # 0x1
	.long	6                               # 0x6
	.long	1                               # 0x1
	.long	3                               # 0x3
	.size	.L__const.main.exp, 32

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	" "
	.size	.L.str, 2

	.section	".linker-options","e",@llvm_linker_options
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.p2align	3, 0x0
	.type	DW.ref.__gxx_personality_v0,@object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __gxx_personality_v0
	.addrsig_sym _Unwind_Resume
	.addrsig_sym _ZNSt3__14coutE
	.addrsig_sym _ZNSt3__15ctypeIcE2idE
