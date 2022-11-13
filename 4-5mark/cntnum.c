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
