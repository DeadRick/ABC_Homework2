#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MAX_LIMIT 20000

int64_t timespecDiff(struct timespec timeA, struct timespec timeB) {
	int64_t nsecA, nsecB;
	nsecA = timeA.tv_sec;
	nsecA *= 1000000000;
	nsecA += timeA.tv_nsec;


	nsecB = timeB.tv_sec;
	nsecB *= 1000000000;
	nsecB += timeB.tv_nsec;

	return nsecA - nsecB;
}

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

int main(int argc, char** argv)
{
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
	int size = sizeof(str) / sizeof(str[0]);
	for (i = 0; i < 5000; ++i) {
		str[i] = (char)(rand() % 127);
	}
	for (i = 0; i < 1000; i++) {
		cnt = countNum(str, flag, size);
	}
	clock_gettime(CLOCK_MONOTONIC, &end);
	elapsed_ns = timespecDiff(end, start);
//	for (i = 0; i < 5000; ++i) {
//		printf("%c", str[i]);
//	}
	printf("Elapsed %ld ns\n", elapsed_ns);
	return 0;
}
