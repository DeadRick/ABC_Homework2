# ИДЗ2,  Демьяненко Виктор Николевич БПИ217 

## Задание:
ASCII-строка — строка, содержащая символы таблицы кодировки
ASCII. (https://ru.wikipedia.org/wiki/ASCII). Размер строки может
быть достаточно большим, чтобы вмещать многостраничные тексты, на-
пример, главы из книг, если задача связана с использованием файлов или
строк, порождаемых генератором случайных чисел. Тексты при этом мо-
гут не нести смыслового содержания. Для обработки в программе пред-
лагается использовать данные, содержащие символы только из первой
половины таблицы (коды в диапазоне 0–12710), что связано с исполь-
зованием кодировки UTF-8 в ОС Linux в качестве основной. Символы,
содержащие коды выше 12710, должны отсутствовать во входных данных
кроме оговоренных специально случаев.
## Вариант 26:
Разработать программу, которая определяет количество целых
чисел в ASCII-строке. числа состоят из цифр от 0 до 9. Раздели-
телями являются все другие символы.
## Отчет:
 - ### 4 балла:
 - Приведено решение задачи на C
 - Немодифицированная ассемблерная программа с комментариями
 -  Модифицированная ассемблерная программа с комментариями
 -  Тесты (всего 5 штук)
 -  ### 5 балла:
 -  Решение на C с передачей данных в функции через параметры и локальные переменные.
 -  - int flag = 0; (Локальные переменные)
 -  Ассемблерная программа с комментариями.
 -  ### 6 баллов:
 -  Решение на ассемблере с рефакторингом программы за счет максимального использования регистров процессор (См. Оптимизация)
 -  ### 7 баллов:
 -  Использование командной строки для ввода данных (реализовано в прошлых пунктах)
 -  Чтение из файла. Запись в файл.
 - ### 8 баллов:
 - Добавил генератор рандомных чисел, также передаю параметр в командной строке
 - Данные добавляются в массив рандомно
 - Зациклил выполнения основной функции
 - ### 9 баллов:
 - Протестировал оптимизации с разными флагами

## Флаги GCC
```
gcc -masm=intel \
    -fno-asynchronous-unwind-tables \
    -fno-jump-tables \
    -fno-stack-protector \
    -fno-exceptions \
    ./code.c \
    -S -o ./code.s
```

Файл с комментариями хранится в папке Comments

### Тесты:
- 1A: 1 2 3 4 5
- 1B: 5
---
- 2A: one1two2fourteen14
- 2B 3
---
- 3A: 123123a123
- 3B: 2
---
- 4A: 1 2 one 1212 three four five 001
- 4B: 4
---
- 5A: On the end of The World 3. I found how to be a 1st person. It could be easy, but I lost my 4s heart.
- 5B: 3

Код программы я начал реализовывать используя ввод с клавиатуры. Поставил ограничение на 20000 символов. Это вполне достаточно, чтобы поместилась небольшая глава из книги. Также я разбил код сразу на три функции: 
- isNum(char sum)
Функция определяет попадает ли символ ASCII на числовой диапазон [0; 9]. Если попадает, то возвращает 1 (true), иначе 0 (false).
- countNum(char *str, int flag, int size)
Функция ищет начало каждого символа, проверяя где находится начала цифры. Также происходит игнор различных символов ASCII, например ['a','z'] (считает нечисловые символы за разделители)
- main(int argc, char* argv[])
Непосредственно main в котором работает вся наша программа. Также туда я передаю параметры для будующего получения данных сразу же с компиляции программы.
## Код программы на C
``` C
#include <stdio.h>
#define MAX_LIMIT 20000

int isNum(char sum) {
    if (sum == '1' || sum == '2' || sum == '3' || sum == '4' || sum == '5'
    || sum == '6' || sum == '7' || sum == '8' || sum == '9' || sum == '0') 
    {
        return 1;
    }
    return 0;
}

int countNum(char *str, int flag, int size) {
    int check, i, cnt = 0;
   
   for(i = 0; i < size - 1; i++) {
        if (str[i] == 10) {
            break;
        }
        check = isNum(str[i]);
        if (check == 1) {
            if (flag == 0) {
                cnt++;
                flag = 1;
            }
        } else {
            if (flag == 1) {
                flag = 0;
            }
        }
       
   }
   return cnt;
}

int main(int argc, char* argv[])
{
   int flag = 0;
   char str[MAX_LIMIT];
   fgets(str, MAX_LIMIT, stdin);
   int size = sizeof(str) / sizeof(str[0]);
   int cnt = countNum(str, flag, size);
   printf("%d ", cnt);
   return 0;
}
```

Теперь же я использую флаги, которые описал в самом начале, чтобы получить код на ассемблере.
В данный момент, это код без всяких улучшений и модификация от меня. Также сразу его прокомментирую.

P.S. Да, мне было не лень комментировать каждую строчку кода. Так как я и так сижу в поезде от Питера до Москвы. За окном приятная ночь, все спят, а я делаю ДЗ по Ассемблеру. (Дедлайн еще не скоро)
# Код программы на Assembler
``` asm
	.file	"code.c"			# Информация о файле
	.intel_syntax noprefix		# Используем стайл Intel
	.text						
	.globl	isNum				# Задаем функцию isNum
	.type	isNum, @function	# Отмечаем, что это именно функция
isNum:							# int isNum(char num) {
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	mov	eax, edi				# Конец пролога
	mov	BYTE PTR -4[rbp], al	# char num (передали параметр в самой функции)
	cmp	BYTE PTR -4[rbp], 49	# num == '1' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 50	# num == '2' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 51	# num == '3' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 52	# num == '4' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 53	# num == '5' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 54	# num == '6' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 55	# num == '7' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 56	# num == '8' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 57	# num == '9' ?
	je	.L2						# then go in IF
	cmp	BYTE PTR -4[rbp], 48	# num == '0' ?
	jne	.L3						# then go out IF (go to ELSE)
.L2:							# return 0;
	mov	eax, 1					# eax := 1
	jmp	.L4						# go to epilog of function
.L3:							# ELSE
	mov	eax, 0					# eax := 0;
.L4:
	pop	rbp						# pop rbp 
	ret							# Возвращаем значение

	.size	isNum, .-isNum		# }
	.globl	countNum			# Теперь объявляем функцию countNum
	.type	countNum, @function # Всё также помечаем то, что это функция
countNum:
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	sub	rsp, 32					# Конец пролога функции
	mov	QWORD PTR -24[rbp], rdi # Передаем *str на стек в -24 позицию
	mov	DWORD PTR -28[rbp], esi	# rbp - 28 := esi (flag)
	mov	DWORD PTR -32[rbp], edx # rbp - 32 := edx (size)
	mov	DWORD PTR -8[rbp], 0	# cnt = 0; rbp - 8 = 0 (cnt)
	mov	DWORD PTR -4[rbp], 0	# i = 0; rbp - 4 = 0 (i)
	jmp	.L6						# then go to FOR
.L12:							# for(i = 0; i < size - 1; i++) {
	mov	eax, DWORD PTR -4[rbp]	# move rbp - 4 to eax (i)
	movsx	rdx, eax			# rdx := eax (i)
	mov	rax, QWORD PTR -24[rbp]	# rax := *str
	add	rax, rdx				# *str + i = str[i]
	movzx	eax, BYTE PTR [rax]	# str[i]
	cmp	al, 10					# str[i] == 10 (10 это \n)
	je	.L14					# if str[i] == 10 is true go to IF
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
	jne	.L9						# go to ELSE
	cmp	DWORD PTR -28[rbp], 0	# if (flag == 0)
	jne	.L11					# go out 
	add	DWORD PTR -8[rbp], 1	# cnt++;
	mov	DWORD PTR -28[rbp], 1	# flag = 1;
	jmp	.L11					# go to i++
.L9:							# if (flag == 1)
	cmp	DWORD PTR -28[rbp], 1	# flag == 1
	jne	.L11					# go out!
	mov	DWORD PTR -28[rbp], 0	# flag = 0
.L11:							# i++ section
	add	DWORD PTR -4[rbp], 1	# i++; rbp - 4 (i) += 1
.L6:							# i < size - 1
	mov	eax, DWORD PTR -32[rbp]	# size move to eax
	sub	eax, 1					# size - 1
	cmp	DWORD PTR -4[rbp], eax	# i < size - 1 ???
	jl	.L12					# if i < size - 1 is TRUE. Идём в for
	jmp	.L8						# Иначе выходим из for'а
.L14:							# if (str[i] == 10)
	nop							# break;
.L8:							# Секция после всех условий и циклов
	mov	eax, DWORD PTR -8[rbp]  # eax := rbp - 8 (cnt)
	leave						# leave function
	ret							# return
	.size	countNum, .-countNum# Эпилог функции
	.section	.rodata			# Функция завершена
.LC0:							# Задаем строку и main
	.string	"%d "				# Строка для вывода cnt
	.text						# Текстовая информация
	.globl	main				# Объявление main
	.type	main, @function		# Опять же, указываем, что это функция
main:							# main(int argc, char* argv[])
	push	rbp					# Пролог функции
	mov	rbp, rsp				# rbp := rsp
	sub	rsp, 20016				# rsb sub 20016 (str[MAX_LIMIT])
	mov	DWORD PTR -4[rbp], 0	# rbp - 4 (flag) := 0; flag = 0;
	mov	rdx, QWORD PTR stdin[rip] # fgets(str, MAX_LIMIT, stdin)
	lea	rax, -20016[rbp]		# move rbp - 20016[rbp] to rax
	mov	esi, 20000				# esi := 20000 (MAX_LIMIT)
	mov	rdi, rax				# rdi := rax
	call	fgets@PLT			# call fgets
	mov	DWORD PTR -8[rbp], 20000 # rbp - 8 (size) = 20000 (MAX_LIMIT)
	mov	edx, DWORD PTR -8[rbp]  # edx := rbp - 8 (size)
	mov	ecx, DWORD PTR -4[rbp]  # ecx := rbp - 4 (flag)
	lea	rax, -20016[rbp]		# rax := rbp - 20016 (str)
	mov	esi, ecx				# esi := ecx
	mov	rdi, rax				# rdi := rax (str)
	call	countNum			# countNum(edx, ecx, rdi)
	mov	DWORD PTR -12[rbp], eax	# rbp - 12 (cnt) := eax
	mov	eax, DWORD PTR -12[rbp]	# eax := rbp - 12 (cnt) (ЗАЧЕМ КОМПИЛЯТОР?!)
	mov	esi, eax				# esi := eax
	lea	rdi, .LC0[rip]			# %d to rdi
	mov	eax, 0					# eax := 0
	call	printf@PLT			# printf()
	mov	eax, 0					# eax := 0 return 0;
	leave						# exit main
	ret							# return
	.size	main, .-main		# end of main }
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0" # Всякая мета инфа
	.section	.note.GNU-stack,"",@progbits	# тут тоже мета инфа
```

Код успешно компилируется, хотя у меня изначально возникла проблема. Выдавало ошибку:
```stdin: Invalid version 2 (max 0)```
Исправил я эту ошибку тем, что правильно откомпилировал программу:
```sh
gcc -c mySource.c -o myObject.o
```

# Разбиение на три файла

Итак, сейчас у нас есть лишь один файл code.c (со всеми нужными расширениями), однако мне нужно получить три файла:
- main.c
- isnum.c
- cntnum.c

## main.c
```C
#include <stdio.h>
#define MAX_LIMIT 20000

int isNum(char num);

int countNum(char *str, int flag, int size);

int main()
{
	int flag = 0;
	char str[MAX_LIMIT];
	fgets(str, MAX_LIMIT, stdin);
	int size = sizeof(str) / sizeof(str[0]);
	int cnt = countNum(str, flag, size);
	printf("%d ", cnt);
	return 0;
}
```

## isnum.c
```C
int isNum(char num) {
	if (num == '1' || num == '2' || num == '3' || num == '4' || num == '5'
		|| num == '6' || num == '7' || num == '8' || num == '9' || num == '0') {
		return 1;
	}
	return 0;
}
```

## cntnum.c
```C
int isNum(char num);

int countNum(char *str, int flag, int size) {
	int check, i, cnt = 0;
	for(i = 0; i < size - 1; i++) {
		if (str[i] == 10)
			break;
		check = isNum(str[i]);
		if (check == 1) {
			if (flag == 0) {
				cnt++;
				flag = 1;
			}
		} else {
			if (flag == 1) {
				flag = 0;
			}
		}
	}
	return cnt;
}
```

### Компановка 
``` sh
gcc -c main.c -o main.o
gcc -c isnum.c -o isnum.o
gcc -c cntnum.c -o cntnum.o
gcc ./main.o ./isnum.o ./cntnum.o -o foo.exe
```

Всё слиновалось и скомпилировалось без каких-либо ошибок. Также всё проверил на тестах.

# Считывание из файла

Добавим два файла:
- input.txt

``` 123wow we got 505 text here! w00w! ```
- output.txt

Теперь нам осталось модифицировать наш main.c

## main.c (modified for files)
``` C
FILE *input, *output;
int flag = 0;
char str[MAX_LIMIT];
input = fopen("input.txt", "r");
fgets(str, MAX_LIMIT, input);
fclose(input);
int size = sizeof(str) / sizeof(str[0]);
int cnt = countNum(str, flag, size);
output = fopen("output.txt", "w");
fprintf(output, "%d", cnt);
fclose(output);
return 0;
```

Это код в main(), так что, если хотите посмотреть полный вариант, то загляните в папку Files > code.c. Остальные функции я не менял.

Программа компилируется и на выходе получаем записанную информацию в файл output.txt:

## output.txt
```
3
```

# Рандом и замер времени
Изменим файл main.c (вывожу только main(), так как поменял код только там. Опять же, если возникнут какие-либо вопросы, то вы можете посмотреть код в файле Random)

## main.c (modified for random and time)
``` C
	char* arg;
	int flag = 0, seed, i, cnt;
	struct timespec start, end;
	int64_t elapsed_ns;
	if (argc == 2) {
		arg = argv[1];
		seed = atoi(arg);
		srand(seed);
	} else {
		return 1;
	}
	clock_gettime(CLOCK_MONOTONIC, &start);
	char str[MAX_LIMIT];
	int n = rand() % 1000;
	int size = sizeof(str) / sizeof(str[0]);
	for (i = 0; i < n; ++i) {
		str[i] = (char)(rand() % 127);
	}
	for (i = 0; i < 1000; i++) {
		cnt = countNum(str, flag, size);
	}
	clock_gettime(CLOCK_MONOTONIC, &end);
	elapsed_ns = timespecDiff(end, start);
    // for (i = 0; i < n; ++i) {
    //     printf("%c", str[i]);
    // }
	printf("Elapsed %ld ns\n", elapsed_ns);
	return 0;

```
Ещё хочу подметить, что я начал передавать аргументы в main. Впрочем, сейчас всё сами и увидите. Также стоит отметить, что я создаю произвольную строку длинною в rand() % 1000. То есть, теоритически может получится строка длинною в 0. Дальше в цикле я добавлю рандомный символ из ASCII (так как в ASCII все символы расположены от 0 до 127).  Так что символ в массиве может быть и цифрой, и любым другим символом.

Ради интереса я посмотрел как выглядит сгенерированная мною строка. Результат меня обрадовал. Выглядело это как параграфы из эльфийской книги (обязательно с цифрами!). Этот код я закомментировал, так как это тот еще ящик Пандоры.

Вот то, что я получил при запуске программы:

```
./foo.exe 1

Elapsed 370796 ns
```
```
./foo.exe 10

Elapsed 616425 ns
```
```
./foo.exe 1000

Elapsed 42554 ns
```
```
./foo.exe 555

Elapsed 362100 ns
```

Ладно, для точного замера нужна строка константного размера, например 5000.
```
./foo.exe 1

Elapsed 713535 ns
```
```
./foo.exe 10

Elapsed 631258 ns
```
```
./foo.exe 100

Elapsed 250072 ns
```
```
./foo.exe 1000

Elapsed 76903 ns
```
```
./foo.exe 555

Elapsed 462012 ns
```
```
./foo.exe 123123

Elapsed 981111 ns
```

## Оптимизация
- Удалил ненужню информацию снизу (информация о системе)
- QWORD PTR -24[rbp] -> r12
- DWORD PTR -8[rbp] -> r13
- DWORD PTR -4[rbp] -> r14
- DWORD PTR -20[rbp] -> r15

## Таблица оптимизаций
Для теста были использован флаг оптимизации по скорости и флаг оптимизации по размеру.

|  | Program | Program_speed | Program_size |
| --- | ---| --- | --- |
| Размер ассемблерного кода | 4196 B | 3092 B | 2148 B |
| Размер исполняемого файла | 8618 B | 8406 B | 8406 B |
| Производительность        |72310 ns| 3805 ns| 5293 ns|