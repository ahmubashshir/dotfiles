#include <stdio.h>
#include <ctype.h>

static inline void urlencode(const char* str)
{
	if (str == NULL) return;

	while (*str) {
		unsigned char c = (unsigned char)*str;
		if (isalnum(c) || c == '-' || c == '_' || c == '.' || c == '~') {
			putchar(c);
		} else {
			printf("%%%02X", c);
		}
		str++;
	}
	putchar(10);
}

int main(int argc, char *argv[])
{
	if (argc <= 1) {
		printf("%s Help:\n%s <text0>[ text1[ ...]]\n", argv[0], argv[0]);
		return 1;
	} else {
		size_t idx;
		for (idx = 1; idx < argc; idx++)
			urlencode(argv[idx]);
		return 0;
	}
}
