	.file	"code.c"
	.intel_syntax noprefix
	.text
	.globl	isNum
	.type	isNum, @function
isNum:
	push	rbp
	mov	rbp, rsp
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al
	cmp	BYTE PTR -4[rbp], 49
	je	.L2
	cmp	BYTE PTR -4[rbp], 50
	je	.L2
	cmp	BYTE PTR -4[rbp], 51
	je	.L2
	cmp	BYTE PTR -4[rbp], 52
	je	.L2
	cmp	BYTE PTR -4[rbp], 53
	je	.L2
	cmp	BYTE PTR -4[rbp], 54
	je	.L2
	cmp	BYTE PTR -4[rbp], 55
	je	.L2
	cmp	BYTE PTR -4[rbp], 56
	je	.L2
	cmp	BYTE PTR -4[rbp], 57
	je	.L2
	cmp	BYTE PTR -4[rbp], 48
	jne	.L3
.L2:
	mov	eax, 1
	jmp	.L4
.L3:
	mov	eax, 0
.L4:
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
	jmp	.L6
.L12:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L14
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
	jne	.L9
	cmp	DWORD PTR -28[rbp], 0
	jne	.L11
	add	DWORD PTR -8[rbp], 1
	mov	DWORD PTR -28[rbp], 1
	jmp	.L11
.L9:
	cmp	DWORD PTR -28[rbp], 1
	jne	.L11
	mov	DWORD PTR -28[rbp], 0
.L11:
	add	DWORD PTR -4[rbp], 1
.L6:
	mov	eax, DWORD PTR -32[rbp]
	sub	eax, 1
	cmp	DWORD PTR -4[rbp], eax
	jl	.L12
	jmp	.L8
.L14:
	nop
.L8:
	mov	eax, DWORD PTR -8[rbp]
	leave
	ret
	.size	countNum, .-countNum
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 20016
	mov	DWORD PTR -4[rbp], 0
	mov	rdx, QWORD PTR stdin[rip]
	lea	rax, -20016[rbp]
	mov	esi, 20000
	mov	rdi, rax
	call	fgets@PLT
	mov	DWORD PTR -8[rbp], 20000
	mov	edx, DWORD PTR -8[rbp]
	mov	ecx, DWORD PTR -4[rbp]
	lea	rax, -20016[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	countNum
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -12[rbp]
	mov	esi, eax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
