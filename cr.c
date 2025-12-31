#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

int letter_value(char c) {
    return tolower(c) - 'a' + 1;
}

int extract_number(const char *s) {
    while (*s && !isdigit(*s)) s++;
    return *s ? atoi(s) : -1;
}

int main() {
    const char *cmd = "b;d(10)";

    char left = cmd[0];
    char right = cmd[2];

    int sum = letter_value(left) + letter_value(right);
    int number = extract_number(cmd);

    if (sum == 6 && number >= 0) {
        printf("int result = %d;\n", number);
    } else {
        printf("// BOX: no operation\n");
    }
}
