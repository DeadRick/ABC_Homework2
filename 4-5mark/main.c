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
