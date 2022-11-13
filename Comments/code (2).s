	.file	"code.c"			# Имя файла
	.intel_syntax noprefix		# Intel стиль
	.text						# Текст
	.globl	timespecDiff		# объявляем функцию
	.type	timespecDiff, @function	# Указываем, что это функция
timespecDiff:					# int64_t timespecDiff(struct timespec timeA, struct timespec timeB)
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	mov	rax, rdi				# rax := rdi
	mov	r8, rsi					# r8 := rsi
	mov	rsi, rax				# rsi := rax
	mov	rdi, rdx				# rdi := rdx
	mov	rdi, r8					# rdi := r8
	mov	QWORD PTR -32[rbp], rsi	# rbp - 32 := rsi (timeA)
	mov	QWORD PTR -24[rbp], rdi # rbp - 24 := rdi (timeB)
	mov	QWORD PTR -48[rbp], rdx # rbp - 48 := rdx (nsecA)
	mov	QWORD PTR -40[rbp], rcx	# rbp - 40 := rcx (nsecB)
	mov	rax, QWORD PTR -32[rbp]	# rax := rbp - 32 (timeA)		 USELESS!
	mov	QWORD PTR -8[rbp], rax	# rbp - 8 (nsecA) := rax (timeA) USELESS!
	mov	rax, QWORD PTR -8[rbp]	# rax (timeA) := rbp - 8 (nsecA)
	imul	rax, rax, 1000000000 # rax (timeA) *= 1000000000
	mov	QWORD PTR -8[rbp], rax	# rbp - 8 (nsecA) = rax (timeA);
	mov	rax, QWORD PTR -24[rbp]	# rax (timeA) = rbp - 24 (timeB)
	add	QWORD PTR -8[rbp], rax	# rbp - 8 (nsecA) += rax (timeB)
	mov	rax, QWORD PTR -48[rbp]	# rax (timeB) := rbp - 48 (nsecA)
	mov	QWORD PTR -16[rbp], rax	# rbp - 16 (nsecB) = rax (nsecA)
	mov	rax, QWORD PTR -16[rbp] # rax (nsecA) = rbp - 16 (nsecA)
	imul	rax, rax, 1000000000 # rax (timeA) *= 1000000000
	mov	QWORD PTR -16[rbp], rax	# rbp - 16 (nsecA) := rax (nsecA)
	mov	rax, QWORD PTR -40[rbp]	# rax (nsecA) := rbp - 40 (nsecB)
	add	QWORD PTR -16[rbp], rax	# rbp - 16 (nsecA) += rax (nsecB)
	mov	rax, QWORD PTR -8[rbp]	# rax (nsecB) := rbp - 8 (nsecA)
	sub	rax, QWORD PTR -16[rbp]	# rax (nsecA) -= rbp - 16 (nsecB)
	pop	rbp						# pop rbp (from callstack)
	ret							# return
	.size	timespecDiff, .-timespecDiff # }
	.globl	isNum				# Объявляем isNum
	.type	isNum, @function	# Отмечаем, что это функция
isNum:							# int isNum(char num) {
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	mov	eax, edi				# Конец пролога
	mov	BYTE PTR -4[rbp], al	# char num (передали параметр в самой функции)
	cmp	BYTE PTR -4[rbp], 49	# num == '1' ?
	je	.L4 					# then go in IF
	cmp	BYTE PTR -4[rbp], 50	# num == '2' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 51	# num == '3' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 52	# num == '4' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 53	# num == '5' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 54	# num == '6' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 55	# num == '7' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 56	# num == '8' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 57	# num == '9' ?
	je	.L4						# then go in IF
	cmp	BYTE PTR -4[rbp], 48	# num == '0' ?
	jne	.L5						# then go out IF (go to ELSE)
.L4:							# return 0;
	mov	eax, 1					# eax := 1
	jmp	.L6						# go to epilog of function
.L5:							# ELSE
	mov	eax, 0					# eax := 0;
.L6:							# end of function
	pop	rbp						# pop rbp 
	ret							# Возвращаем значение
	.size	isNum, .-isNum		# }
	.globl	countNum			# Теперь объявляем функцию countNum
	.type	countNum, @function # Всё также помечаем то, что это функция
countNum:						# countNum func
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	sub	rsp, 32					# Конец пролога функции
	mov	QWORD PTR -24[rbp], rdi # Передаем *str на стек в -24 позицию
	mov	DWORD PTR -28[rbp], esi	# rbp - 28 := esi (flag)
	mov	DWORD PTR -32[rbp], edx # rbp - 32 := edx (size)
	mov	DWORD PTR -8[rbp], 0	# cnt = 0; rbp - 8 = 0 (cnt)
	mov	DWORD PTR -4[rbp], 0	# i = 0; rbp - 4 = 0 (i)
	jmp	.L8						# then go to FOR
.L14:							# for(i = 0; i < size - 1; i++) {
	mov	eax, DWORD PTR -4[rbp]	# move rbp - 4 to eax (i)
	movsx	rdx, eax			# rdx := eax (i)
	mov	rax, QWORD PTR -24[rbp]	# rax := *str
	add	rax, rdx				# *str + i = str[i]
	movzx	eax, BYTE PTR [rax]	# str[i]
	cmp	al, 10					# str[i] == 10 (10 это \n)
	je	.L16					# if str[i] == 10 is true go to IF
	mov	eax, DWORD PTR -4[rbp]  # move rbp - 4 (i) to eax
	movsx	rdx, eax			# rdx := eax (i)
	mov	rax, QWORD PTR -24[rbp] # rax := *str
	add	rax, rdx				# *str + i = str[i]
	movzx	eax, BYTE PTR [rax] # str[i]
	movsx	eax, al				# copy al (str[i]) into eax
	mov	edi, eax				# move eax to edi
	call	isNum				# then call isNum
	mov	DWORD PTR -12[rbp], eax # move eax (i) in rbp - 12 (check) 
	cmp	DWORD PTR -12[rbp], 1	# if (check == 1)
	jne	.L11					# go to ELSE
	cmp	DWORD PTR -28[rbp], 0	# if (flag == 0)
	jne	.L13					# go out 
	add	DWORD PTR -8[rbp], 1	# cnt++;
	mov	DWORD PTR -28[rbp], 1	# flag = 1;
	jmp	.L13					# go to i++
.L11:							# if (flag == 1)
	cmp	DWORD PTR -28[rbp], 1	# flag == 1
	jne	.L13					# go out!
	mov	DWORD PTR -28[rbp], 0	# flag = 0
.L13:							# i++ section
	add	DWORD PTR -4[rbp], 1	# i++; rbp - 4 (i) += 1
.L8:
	mov	eax, DWORD PTR -32[rbp]	# size move to eax
	sub	eax, 1					# size - 1
	cmp	DWORD PTR -4[rbp], eax	# i < size - 1 ???
	jl	.L14					# if i < size - 1 is TRUE. Идём в for
	jmp	.L10					# Иначе выходим из for'а
.L16:							# if (str[i] == 10)
	nop							# break;
.L10:							# Секция после всех условий и циклов
	mov	eax, DWORD PTR -8[rbp]  # eax := rbp - 8 (cnt)
	leave						# leave function
	ret							# return
	.size	countNum, .-countNum# Эпилог функции
	.section	.rodata			# Функция завершена
.LC0:							# Задаем строку и main
	.string	"Elapsed %ld ns\n"	# Строка для вывода времени
	.text						# Текстовая информация
	.globl	main				# Объявление main
	.type	main, @function		# Опять же, указываем, что это функция
main:							# main(int argc, char* argv[])
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	sub	rsp, 20096						# Коец пролога функции
	mov	DWORD PTR -20084[rbp], edi		# rbp - 20084 (argc) := edi
	mov	QWORD PTR -20096[rbp], rsi		# rbp - 20096 (argv) := rsi
	mov	DWORD PTR -8[rbp], 0			# rbp - 8 (flag) := 0
	cmp	DWORD PTR -20084[rbp], 2		# if (argc == 2) {
	jne	.L18							#
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
