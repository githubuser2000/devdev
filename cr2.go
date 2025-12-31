package main

import (
	"fmt"
	"strconv"
	"strings"
	"unicode"
	"math"
)

func letterValue(r rune) int {
	return int(unicode.ToLower(r)-'a') + 1
}

func extractNumber(s string) float64 {
	var buf string
	for _, r := range s {
		if unicode.IsDigit(r) || r == '/' || r == '-' || r == '.' {
			buf += string(r)
		}
	}
	if strings.Contains(buf, "/") {
		parts := strings.Split(buf, "/")
		p, _ := strconv.Atoi(parts[0])
		q, _ := strconv.Atoi(parts[1])
		return float64(p) / float64(q)
	}
	n, _ := strconv.ParseFloat(buf, 64)
	return n
}

func meaning(sum int) string {
	switch sum {
	case 1: return "ID"
	case 2: return "KANTE"
	case 3: return "HAKEN/KOORDINATE"
	case 4: return "LINIE"
	case 5: return "BOX"
	case 6: return "ZAHL"
	case 7: return "WINKEL"
	case 8: return "RAUM"
	default: return "INVALID"
	}
}

func main() {
	cmd := "a;g(1/2)"
	left := rune(cmd[0])
	right := rune(cmd[2])
	sum := letterValue(left) + letterValue(right)

	fmt.Println("// Befehl:", meaning(sum))

	if sum == 6 { // Zahl
		num := extractNumber(cmd)
		fmt.Printf("value := %f\n", num)
	} else if sum == 7 { // Winkel
		num := extractNumber(cmd)
		fmt.Printf("tan_theta := %f\n", math.Tan(num))
		fmt.Printf("cot_theta := %f\n", 1/math.Tan(num))
	} else if sum == 5 {
		fmt.Println("// BOX")
	}
}/
