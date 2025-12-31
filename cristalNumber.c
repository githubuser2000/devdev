#include <stdio.h>
#include <string.h>

typedef struct {
    char table1[32];
    char table2[32];
    int value;
} Command;

int main() {
    // Beispiel-Input: Tabelle + Wert
    Command cmds[] = {
        {"a", "e", 10},
        {"b", "d", 10},
        {"c", "c", 10},
        {"d", "b", 10},
        {"e", "a", 10}
    };

    int n = sizeof(cmds)/sizeof(cmds[0]);

    for(int i = 0; i < n; i++) {
        printf("int result = %d; // from %s;%s\n", cmds[i].value, cmds[i].table1, cmds[i].table2);
    }

    return 0;
}
