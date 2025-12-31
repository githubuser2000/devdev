#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

int letter_value(char c) {
    return tolower(c) - 'a' + 1;
}

double extract_number(const char *s) {
    char buf[64];
    int j = 0;
    for (int i = 0; s[i] && j < 63; i++) {
        if (isdigit(s[i]) || s[i] == '/' || s[i] == '-' || s[i] == '.') {
            buf[j++] = s[i];
        }
    }
    buf[j] = 0;
    if (strchr(buf, '/')) {
        int p, q;
        sscanf(buf, "%d/%d", &p, &q);
        return (double)p / q;
    }
    return atof(buf);
}

double cot(double x) {
    return 1.0 / tan(x);
}

const char* meaning(int sum) {
    switch(sum) {
        case 5: return "BOX";
        case 6: return "ZAHL";
        case 7: return "WINKEL";
        case 8: return "RAUM";
        default: return "INVALID";
    }
}

int main() {
    const char *cmd = "d;h(3;1/2,cot(1/2);0,0,0;1,0,0;p1,p2)";

    char l = cmd[0];
    char r = cmd[2];
    int sum = letter_value(l) + letter_value(r);

    printf("// Befehl: %s\n", meaning(sum));

    if (sum == 6) {
        double num = extract_number(cmd);
        printf("double value = %f;\n", num);
    } else if (sum == 7) {
        double num = extract_number(cmd);
        printf("double tan_theta = %f;\n", tan(num));
        printf("double cot_theta = %f;\n", cot(num));
    } else if (sum == 8) {
        int dim_count = 3; // Beispiel aus Klammer
        double angles[3] = {0.5, cot(1.0/2), M_PI/4}; // Beispiel
        double points[3][3] = {{0,0,0},{1,0,0},{0,1,0}};
        const char* ids[3] = {"p1","p2","p3"};

        printf("// RAUM: dim_count=%d\n", dim_count);
        for (int i=0;i<dim_count;i++) {
            printf("Angle %d: tan=%f cot=%f\n", i+1, angles[i], cot(angles[i]));
            printf("Point %d: (%f,%f,%f) id=%s\n", i+1, points[i][0], points[i][1], points[i][2], ids[i]);
        }
    } else if (sum == 5) {
        printf("// BOX: leerer Befehl\n");
    }
}
