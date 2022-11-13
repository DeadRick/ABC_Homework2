	.file	"code.c"
	.intel_syntax noprefix
	.text
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
	push	rbp
	mov	rbp, rsp
	mov	rax, rdi
	mov	r8, rsi
	mov	rsi, rax
	mov	rdi, rdx
	mov	rdi, r8
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	pop	rbp
	ret
	.size	timespecDiff, .-timespecDiff
	.globl	isNum
	.type	isNum, @function
isNum:
	push	rbp
	mov	rbp, rsp
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al
	cmp	BYTE PTR -4[rbp], 49
	je	.L4
	cmp	BYTE PTR -4[rbp], 50
	je	.L4
	cmp	BYTE PTR -4[rbp], 51
	je	.L4
	cmp	BYTE PTR -4[rbp], 52
	je	.L4
	cmp	BYTE PTR -4[rbp], 53
	je	.L4
	cmp	BYTE PTR -4[rbp], 54
	je	.L4
	cmp	BYTE PTR -4[rbp], 55
	je	.L4
	cmp	BYTE PTR -4[rbp], 56
	je	.L4
	cmp	BYTE PTR -4[rbp], 57
	je	.L4
	cmp	BYTE PTR -4[rbp], 48
	jne	.L5
.L4:
	mov	eax, 1
	jmp	.L6
.L5:
	mov	eax, 0
.L6:
	pop	rbp
	ret
	.size	isNum, .-isNum
	.globl	countNum
	.type	countNum, @function
countNum:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -32[rbp], edx
	mov	DWORD PTR -8[rbp], 0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L14:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L16
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isNum
	mov	DWORD PTR -12[rbp], eax
	cmp	DWORD PTR -12[rbp], 1
	jne	.L11
	cmp	DWORD PTR -28[rbp], 0
	jne	.L13
	add	DWORD PTR -8[rbp], 1
	mov	DWORD PTR -28[rbp], 1
	jmp	.L13
.L11:
	cmp	DWORD PTR -28[rbp], 1
	jne	.L13
	mov	DWORD PTR -28[rbp], 0
.L13:
	add	DWORD PTR -4[rbp], 1
.L8:
	mov	eax, DWORD PTR -32[rbp]
	sub	eax, 1
	cmp	DWORD PTR -4[rbp], eax
	jl	.L14
	jmp	.L10
.L16:
	nop
.L10:
	mov	eax, DWORD PTR -8[rbp]
	leave
	ret
	.size	countNum, .-countNum
	.section	.rodata
.LC0:
	.string	"Elapsed %ld ns\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 20096
	mov	DWORD PTR -20084[rbp], edi
	mov	QWORD PTR -20096[rbp], rsi
	mov	DWORD PTR -8[rbp], 0
	cmp	DWORD PTR -20084[rbp], 2
	jne	.L18
	mov	rax, QWORD PTR -20096[rbp]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -20[rbp]
	mov	edi, eax
	call	srand@PLT
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	DWORD PTR -24[rbp], 20000
	mov	DWORD PTR -4[rbp], 0
	jmp	.L21
.L18:
	mov	eax, 1
	jmp	.L25
.L22:
	call	rand@PLT
	mov	ecx, eax
	mov	edx, -2130574327
	mov	eax, ecx
	imul	edx
	lea	eax, [rdx+rcx]
	sar	eax, 6
	mov	edx, eax
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	sal	edx, 7
	sub	edx, eax
	mov	eax, ecx
	sub	eax, edx
	mov	edx, eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	BYTE PTR -20080[rbp+rax], dl
	add	DWORD PTR -4[rbp], 1
.L21:
	cmp	DWORD PTR -4[rbp], 4999
	jle	.L22
	mov	DWORD PTR -4[rbp], 0
	jmp	.L23
.L24:
	mov	edx, DWORD PTR -24[rbp]
	mov	ecx, DWORD PTR -8[rbp]
	lea	rax, -20080[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	countNum
	mov	DWORD PTR -36[rbp], eax
	add	DWORD PTR -4[rbp], 1
.L23:
	cmp	DWORD PTR -4[rbp], 999
	jle	.L24
	lea	rax, -80[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdx, QWORD PTR -56[rbp]
	mov	rdi, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespecDiff
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L25:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
