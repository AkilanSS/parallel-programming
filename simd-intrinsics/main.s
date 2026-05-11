	.text
	.file	"main.cpp"
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function _Z9absSerialPfS_i
.LCPI0_0:
	.long	0x80000000                      # float -0
	.text
	.globl	_Z9absSerialPfS_i
	.p2align	4, 0x90
	.type	_Z9absSerialPfS_i,@function
_Z9absSerialPfS_i:                      # @_Z9absSerialPfS_i
	.cfi_startproc
# %bb.0:
	testl	%edx, %edx
	jle	.LBB0_3
# %bb.1:
	movl	%edx, %eax
	xorl	%ecx, %ecx
	vbroadcastss	.LCPI0_0(%rip), %xmm0   # xmm0 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	.p2align	4, 0x90
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	vmovss	(%rdi,%rcx,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
	vxorps	%xmm0, %xmm1, %xmm2
	vmaxss	%xmm1, %xmm2, %xmm1
	vmovss	%xmm1, (%rsi,%rcx,4)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB0_2
.LBB0_3:
	retq
.Lfunc_end0:
	.size	_Z9absSerialPfS_i, .Lfunc_end0-_Z9absSerialPfS_i
	.cfi_endproc
                                        # -- End function
	.globl	_Z9absVectorPfS_i               # -- Begin function _Z9absVectorPfS_i
	.p2align	4, 0x90
	.type	_Z9absVectorPfS_i,@function
_Z9absVectorPfS_i:                      # @_Z9absVectorPfS_i
	.cfi_startproc
# %bb.0:
	cmpl	$4, %edx
	jl	.LBB1_3
# %bb.1:
	addl	$-4, %edx
	movslq	%edx, %rax
	xorl	%ecx, %ecx
	vxorps	%xmm0, %xmm0, %xmm0
	.p2align	4, 0x90
.LBB1_2:                                # =>This Inner Loop Header: Depth=1
	vmovaps	(%rdi,%rcx,4), %xmm1
	vcmpltps	%xmm0, %xmm1, %xmm2
	vsubps	%xmm1, %xmm0, %xmm3
	vblendvps	%xmm2, %xmm3, %xmm1, %xmm1
	vmovaps	%xmm1, (%rsi,%rcx,4)
	addq	$4, %rcx
	cmpq	%rax, %rcx
	jle	.LBB1_2
.LBB1_3:
	retq
.Lfunc_end1:
	.size	_Z9absVectorPfS_i, .Lfunc_end1-_Z9absVectorPfS_i
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI2_0:
	.quad	0x412e848000000000              # double 1.0E+6
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI2_1:
	.long	0x3f800000                      # float 1
.LCPI2_2:
	.long	0x4e6e6b28                      # float 1.0E+9
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4000000000, %edx               # imm = 0xEE6B2800
	callq	posix_memalign@PLT
	xorl	%ebp, %ebp
	movl	$0, %r14d
	movl	$0, %ebx
	testl	%eax, %eax
	jne	.LBB2_2
# %bb.1:
	movq	(%rsp), %rbx
.LBB2_2:
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$4000000000, %edx               # imm = 0xEE6B2800
	callq	posix_memalign@PLT
	movq	(%rsp), %rcx
	.p2align	4, 0x90
.LBB2_3:                                # =>This Inner Loop Header: Depth=1
	testb	$1, %r14b
	movl	%r14d, %edx
	cmovnel	%ebp, %edx
	vcvtsi2ss	%edx, %xmm1, %xmm0
	vmovss	%xmm0, (%rbx,%r14,4)
	incq	%r14
	decl	%ebp
	cmpq	$1000000000, %r14               # imm = 0x3B9ACA00
	jne	.LBB2_3
# %bb.4:
	xorl	%r14d, %r14d
	testl	%eax, %eax
	cmoveq	%rcx, %r14
	movq	$-4, %r12
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	movq	%rax, %r15
	vxorps	%xmm0, %xmm0, %xmm0
	.p2align	4, 0x90
.LBB2_5:                                # =>This Inner Loop Header: Depth=1
	vmovaps	16(%rbx,%r12,4), %xmm1
	vcmpltps	%xmm0, %xmm1, %xmm2
	vsubps	%xmm1, %xmm0, %xmm3
	vblendvps	%xmm2, %xmm3, %xmm1, %xmm1
	vmovaps	%xmm1, 16(%r14,%r12,4)
	addq	$4, %r12
	cmpq	$999999993, %r12                # imm = 0x3B9AC9F9
	jb	.LBB2_5
# %bb.6:
	callq	_ZNSt3__16chrono12steady_clock3nowEv@PLT
	subq	%r15, %rax
	vcvtsi2sd	%rax, %xmm4, %xmm0
	vdivsd	.LCPI2_0(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	movq	_ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	.L.str(%rip), %rsi
	movl	$10, %edx
	callq	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	movq	%rax, %rdi
	movl	$1000000000, %esi               # imm = 0x3B9ACA00
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi@PLT
	leaq	.L.str.1(%rip), %rsi
	movl	$14, %edx
	movq	%rax, %rdi
	callq	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	movq	%rax, %rdi
	vmovsd	8(%rsp), %xmm0                  # 8-byte Reload
                                        # xmm0 = mem[0],zero
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEd@PLT
	leaq	.L.str.2(%rip), %rsi
	movl	$3, %edx
	movq	%rax, %rdi
	callq	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	movq	%rax, %r15
	movq	(%rax), %rax
	movq	-24(%rax), %rsi
	addq	%r15, %rsi
	movq	%rsp, %r12
	movq	%r12, %rdi
	callq	_ZNKSt3__18ios_base6getlocEv@PLT
.Ltmp0:
	movq	_ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r12, %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp1:
# %bb.7:
	movq	(%rax), %rcx
.Ltmp2:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
.Ltmp3:
# %bb.8:
	movl	%eax, %ebp
	movq	%rsp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movsbl	%bpl, %esi
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc@PLT
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv@PLT
	vmovss	4(%r14), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	vucomiss	.LCPI2_1(%rip), %xmm0
	jne	.LBB2_13
	jp	.LBB2_13
# %bb.9:
	movl	$3999999996, %eax               # imm = 0xEE6B27FC
	vmovss	(%r14,%rax), %xmm0              # xmm0 = mem[0],zero,zero,zero
	vucomiss	.LCPI2_2(%rip), %xmm0
	jne	.LBB2_13
	jp	.LBB2_13
# %bb.10:
	movq	_ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	leaq	.L.str.3(%rip), %rsi
	movl	$22, %edx
	callq	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	movq	%rax, %r15
	movq	(%rax), %rax
	movq	-24(%rax), %rsi
	addq	%r15, %rsi
	movq	%rsp, %r12
	movq	%r12, %rdi
	callq	_ZNKSt3__18ios_base6getlocEv@PLT
.Ltmp5:
	movq	_ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r12, %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp6:
# %bb.11:
	movq	(%rax), %rcx
.Ltmp7:
	movq	%rax, %rdi
	movl	$10, %esi
	callq	*56(%rcx)
.Ltmp8:
# %bb.12:
	movl	%eax, %ebp
	movq	%rsp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movsbl	%bpl, %esi
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc@PLT
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv@PLT
.LBB2_13:
	movq	%rbx, %rdi
	callq	free@PLT
	movq	%r14, %rdi
	callq	free@PLT
	xorl	%eax, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB2_16:
	.cfi_def_cfa_offset 64
.Ltmp9:
	jmp	.LBB2_15
.LBB2_14:
.Ltmp4:
.LBB2_15:
	movq	%rax, %rbx
	movq	%rsp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2, 0x0
GCC_except_table2:
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
	.uleb128 .Lfunc_end2-.Ltmp8             #   Call between .Ltmp8 and .Lfunc_end2
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
	je	.LBB3_10
# %bb.2:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %r8
	movq	40(%rbx,%rax), %r12
	movl	8(%rbx,%rax), %r13d
	cmpl	$-1, 144(%rbx,%rax)
	jne	.LBB3_7
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
.LBB3_7:
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
	jne	.LBB3_10
# %bb.9:
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	leaq	(%rbx,%rax), %rdi
	movl	32(%rbx,%rax), %esi
	orl	$5, %esi
.Ltmp23:
	callq	_ZNSt3__18ios_base5clearEj@PLT
.Ltmp24:
.LBB3_10:
	leaq	24(%rsp), %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev@PLT
.LBB3_11:
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
.LBB3_12:
	.cfi_def_cfa_offset 96
.Ltmp25:
	jmp	.LBB3_15
.LBB3_13:
.Ltmp19:
	movq	%rax, %r14
	leaq	8(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	jmp	.LBB3_16
.LBB3_14:
.Ltmp22:
.LBB3_15:
	movq	%rax, %r14
.LBB3_16:
	leaq	24(%rsp), %rdi
	callq	_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev@PLT
	jmp	.LBB3_18
.LBB3_17:
.Ltmp12:
	movq	%rax, %r14
.LBB3_18:
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
	jmp	.LBB3_11
.LBB3_20:
.Ltmp28:
	movq	%rax, %rbx
.Ltmp29:
	callq	__cxa_end_catch@PLT
.Ltmp30:
# %bb.21:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB3_22:
.Ltmp31:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end3:
	.size	_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m, .Lfunc_end3-_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.cfi_endproc
	.section	.gcc_except_table._ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,"aG",@progbits,_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m,comdat
	.p2align	2, 0x0
GCC_except_table3:
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
	.uleb128 .Lfunc_end3-.Ltmp30            #   Call between .Ltmp30 and .Lfunc_end3
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
	je	.LBB4_21
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
	jle	.LBB4_3
# %bb.2:
	movq	(%r13), %rax
	movq	%r13, %rdi
	movq	%rbx, %rdx
	callq	*96(%rax)
	cmpq	%rbx, %rax
	jne	.LBB4_21
.LBB4_3:
	testq	%rbp, %rbp
	jle	.LBB4_8
# %bb.4:
	cmpq	$22, %rbp
	ja	.LBB4_9
# %bb.5:
	leal	(,%rbp,2), %eax
	movb	%al, (%rsp)
	leaq	1(%rsp), %rbx
	jmp	.LBB4_10
.LBB4_8:
	movq	%r13, %rax
	jmp	.LBB4_17
.LBB4_9:
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
.LBB4_10:
	movzbl	28(%rsp), %esi                  # 1-byte Folded Reload
	movq	%rbx, %rdi
	movq	%rbp, %rdx
	callq	memset@PLT
	movb	$0, (%rbx,%rbp)
	testb	$1, (%rsp)
	je	.LBB4_12
# %bb.11:
	movq	16(%rsp), %rsi
	jmp	.LBB4_13
.LBB4_12:
	leaq	1(%rsp), %rsi
.LBB4_13:
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
	je	.LBB4_16
# %bb.15:
	movq	16(%rsp), %rdi
	movq	%r12, %r13
	movq	%rax, %r12
	callq	_ZdlPv@PLT
	movq	%r12, %rax
	movq	%r13, %r12
.LBB4_16:
	cmpq	%rbp, %rbx
	jne	.LBB4_21
.LBB4_17:
	subq	%r15, %r14
	testq	%r14, %r14
	jle	.LBB4_19
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
	jne	.LBB4_21
.LBB4_19:
	movq	$0, 24(%r12)
	jmp	.LBB4_22
.LBB4_21:
	xorl	%eax, %eax
.LBB4_22:
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
.LBB4_23:
	.cfi_def_cfa_offset 96
.Ltmp34:
	movq	%rax, %rbx
	testb	$1, (%rsp)
	je	.LBB4_25
# %bb.24:
	movq	16(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB4_25:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end4:
	.size	_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_, .Lfunc_end4-_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.cfi_endproc
	.section	.gcc_except_table._ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,"aG",@progbits,_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_,comdat
	.p2align	2, 0x0
GCC_except_table4:
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
	.uleb128 .Lfunc_end4-.Ltmp33            #   Call between .Ltmp33 and .Lfunc_end4
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
.Lfunc_end5:
	.size	__clang_call_terminate, .Lfunc_end5-__clang_call_terminate
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Processed "
	.size	.L.str, 11

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	" elements in: "
	.size	.L.str.1, 15

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	" ms"
	.size	.L.str.2, 4

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"Verification: Success!"
	.size	.L.str.3, 23

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
