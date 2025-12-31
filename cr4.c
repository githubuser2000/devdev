#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int letter_value(char c) {
    return tolower(c) - 'a' + 1;
}

// Buchstaben aufsummieren und Array mit '+'
void letter_sum_array(const char *s) {
    printf("[");
    int first = 1;
    for(int i=0; s[i]; i++) {
        if(isalpha(s[i])) {
            if(!first) printf(", '+', ");
            printf("%d", letter_value(s[i]));
            first = 0;
        }
    }
    printf("]\n");
}

// Alle möglichen Summierungen von n
void partitions(int n, int *arr, int pos) {
    if(n==0) {
        printf("[");
        for(int i=0;i<pos;i++){
            if(i>0) printf(", '+', ");
            printf("%d", arr[i]);
        }
        printf("]\n");
        return;
    }
    for(int i=1;i<=n;i++){
        arr[pos] = i;
        partitions(n-i, arr, pos+1);
    }
}

// Spezielle Formel n=((2*n)-n) mit '*' und '-'
void special_formula(int n) {
    printf("[2, '*', %d, '-', %d]\n", n, n);
}

// Bedeutung nach Summe
const char* meaning(int sum) {
    switch(sum){
        case 1: return "BOX";
        case 6: return "ZAHL";
        case 7: return "WINKEL";
        case 9: return "RAUM";
        default: return "ANDERE";
    }
}

int main() {
    const char *cmd = "abc"; // Beispielbuchstaben
    printf("// Buchstabenaufsummierung:\n");
    letter_sum_array(cmd);

    printf("// Alle Aufsummierungen von 3:\n");
    int arr[10];
    partitions(3, arr, 0);

    printf("// Spezielle Formel für 9:\n");
    special_formula(9);

    printf("// Bedeutungen:\n");
    for(int s=1;s<=9;s++){
        printf("Summe %d: %s\n", s, meaning(s));
    }
}
