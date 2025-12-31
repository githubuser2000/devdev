package main

import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

func letterValue(r rune) int {
	return int(r - 'a' + 1)
}

func extractNumber(s string) float64 {
	buf := ""
	for _, r := range s {
		if ('0' <= r && r <= '9') || r == '/' || r == '-' || r == '.' {
			buf += string(r)
		}
	}
	if strings.Contains(buf, "/") {
		parts := strings.Split(buf, "/")
		p,_ := strconv.Atoi(parts[0])
		q,_ := strconv.Atoi(parts[1])
		return float64(p)/float64(q)
	}
	n,_ := strconv.ParseFloat(buf,64)
	return n
}

func cot(x float64) float64 {
	return 1.0 / math.Tan(x)
}

func meaning(sum int) string {
	switch sum {
	case 5: return "BOX"
	case 6: return "ZAHL"
	case 7: return "WINKEL"
	case 8: return "RAUM"
	default: return "INVALID"
	}
}

func main() {
	cmd := "d;h(3;1/2,cot(1/2);0,0,0;1,0,0;p1,p2)"

	sum := letterValue(rune(cmd[0])) + letterValue(rune(cmd[2]))
	fmt.Println("// Befehl:", meaning(sum))

	if sum == 6 {
		num := extractNumber(cmd)
		fmt.Printf("value := %f\n", num)
	} else if sum == 7 {
		num := extractNumber(cmd)
		fmt.Printf("tan_theta := %f\n", math.Tan(num))
		fmt.Printf("cot_theta := %f\n", cot(num))
	} else if sum == 8 {
		dim_count := 3
		angles := []float64{0.5, cot(0.5), math.Pi/4}
		points := [][]float64{{0,0,0},{1,0,0},{0,1,0}}
		ids := []string{"p1","p2","p3"}

		fmt.Printf("// RAUM: dim_count=%d\n", dim_count)
		for i:=0;i<dim_count;i++ {
			fmt.Printf("Angle %d: tan=%f cot=%f\n", i+1, angles[i], cot(angles[i]))
			fmt.Printf("Point %d: (%f,%f,%f) id=%s\n", i+1, points[i][0], points[i][1], points[i][2], ids[i])
		}
	} else if sum == 5 {
		fmt.Println("// BOX: leerer Befehl")
	}
}
