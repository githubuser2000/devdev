#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

int letter_value(char c) {
    return tolower(c) - 'a' + 1;
}

// Buchstaben aufsummieren + '+'
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

// Alle möglichen Aufsummierungen von n
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

// Winkel → 2 Zahlen ohne Betrag + 1
void print_winkel(int a, int b) {
    printf("[1, '+', %d, '+', %d]\n", a, b);
}

// Raum → Dimensionen, Winkel, Punkte, IDs
void print_raum(int dim_count, double angles[], double points[][3], const char* ids[]) {
    printf("// RAUM: dim_count=%d\n", dim_count);
    for(int i=0;i<dim_count;i++){
        printf("Angle %d: %f\n", i+1, angles[i]);
        printf("Point %d: (%f,%f,%f) id=%s\n", i+1, points[i][0], points[i][1], points[i][2], ids[i]);
    }
}

int main() {
    const char *cmd = "abc";

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

    printf("// Beispiel WINKEL (Summe 7):\n");
    print_winkel(2,3);

    printf("// Beispiel RAUM (Summe 9):\n");
    int dim_count = 3;
    double angles[3] = {0.5, M_PI/4, M_PI/6};
    double points[3][3] = {{0,0,0},{1,0,0},{0,1,0}};
    const char* ids[3] = {"p1","p2","p3"};
    print_raum(dim_count, angles, points, ids);
}
