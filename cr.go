package main

import (
	"fmt"
	"unicode"
)

func letterValue(r rune) int {
	return int(unicode.ToLower(r)-'a') + 1
}

func extractNumber(s string) int {
	n := 0
	found := false
	for _, r := range s {
		if unicode.IsDigit(r) {
			found = true
			n = n*10 + int(r-'0')
		}
	}
	if found {
		return n
	}
	return -1
}

func main() {
	cmd := "c;c10"

	sum := letterValue(rune(cmd[0])) + letterValue(rune(cmd[2]))
	number := extractNumber(cmd)

	if sum == 6 && number >= 0 {
		fmt.Printf("var result int = %d\n", number)
	} else {
		fmt.Println("// BOX")
	}
}
