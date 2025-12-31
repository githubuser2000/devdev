package main

import (
	"fmt"
	"unicode"
)

func letterValue(r rune) int {
	return int(unicode.ToLower(r) - 'a' + 1)
}

// Buchstaben aufsummieren als Array mit '+'
func letterSumArray(s string) {
	first := true
	fmt.Print("[")
	for _, r := range s {
		if unicode.IsLetter(r) {
			if !first {
				fmt.Print(", '+', ")
			}
			fmt.Print(letterValue(r))
			first = false
		}
	}
	fmt.Println("]")
}

// Alle möglichen Aufsummierungen von n
func partitions(n int, arr []int, pos int) {
	if n == 0 {
		fmt.Print("[")
		for i:=0;i<pos;i++ {
			if i>0 { fmt.Print(", '+', ") }
			fmt.Print(arr[i])
		}
		fmt.Println("]")
		return
	}
	for i:=1;i<=n;i++ {
		arr[pos]=i
		partitions(n-i, arr, pos+1)
	}
}

// Spezielle Formel n=((2*n)-n) mit '*' und '-'
func specialFormula(n int) {
	fmt.Printf("[2, '*', %d, '-', %d]\n", n, n)
}

func meaning(sum int) string {
	switch sum {
	case 1: return "BOX"
	case 6: return "ZAHL"
	case 7: return "WINKEL"
	case 9: return "RAUM"
	default: return "ANDERE"
	}
}

func main() {
	cmd := "abc"
	fmt.Println("// Buchstabenaufsummierung:")
	letterSumArray(cmd)

	fmt.Println("// Alle Aufsummierungen von 3:")
	arr := make([]int, 10)
	partitions(3, arr, 0)

	fmt.Println("// Spezielle Formel für 9:")
	specialFormula(9)

	fmt.Println("// Bedeutungen:")
	for s:=1;s<=9;s++ {
		fmt.Printf("Summe %d: %s\n", s, meaning(s))
	}
}
