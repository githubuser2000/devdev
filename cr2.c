#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

int letter_value(char c) {
    return tolower(c) - 'a' + 1;
}

// Zahl aus Klammer / String extrahieren
double extract_number(const char *s) {
    char buf[64];
    int j = 0;
    for (int i = 0; s[i] && j < 63; i++) {
        if (isdigit(s[i]) || s[i] == '/' || s[i] == '-' || s[i] == '.') {
            buf[j++] = s[i];
        }
    }
    buf[j] = 0;
    if (strchr(buf, '/')) { // Bruch
        int p, q;
        sscanf(buf, "%d/%d", &p, &q);
        return (double)p / q;
    }
    return atof(buf);
}

// Cotangens
double cot(double x) {
    return 1.0 / tan(x);
}

const char* meaning(int sum) {
    switch(sum) {
        case 1: return "ID";
        case 2: return "KANTE";
        case 3: return "HAKEN/KOORDINATE";
        case 4: return "LINIE";
        case 5: return "BOX";
        case 6: return "ZAHL";
        case 7: return "WINKEL";
        case 8: return "RAUM";
        default: return "INVALID";
    }
}

int main() {
    const char *cmd = "a;g(1/2)"; // Beispiel

    char left = cmd[0];
    char right = cmd[2];
    int sum = letter_value(left) + letter_value(right);

    printf("// Befehl: %s\n", meaning(sum));

    if (sum == 6) { // Zahl
        double num = extract_number(cmd);
        printf("double value = %f;\n", num);
    } else if (sum == 7) { // Winkel
        double num = extract_number(cmd);
        double angle = tan(num); // default
        printf("double tan_theta = %f;\n", angle);
        printf("double cot_theta = %f;\n", cot(num));
    } else if (sum == 5) {
        printf("// BOX: leerer Befehl\n");
    }
}
