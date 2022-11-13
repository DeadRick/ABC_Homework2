#include <stdio.h>
#define MAX_LIMIT 20000

int isNum(char num) {
	if (num == '1' || num == '2' || num == '3' || num == '4' || num == '5'
		|| num == '6' || num == '7' || num == '8' || num == '9' || num == '0') {
		return 1;
	}
	return 0;
}

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

int main()
{
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
}
