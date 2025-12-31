package main

import "fmt"

type Command struct {
    Table1 string
    Table2 string
    Value  int
}

func main() {
    cmds := []Command{
        {"a", "e", 10},
        {"b", "d", 10},
        {"c", "c", 10},
        {"d", "b", 10},
        {"e", "a", 10},
    }

    for _, cmd := range cmds {
        fmt.Printf("var result int = %d // from %s;%s\n", cmd.Value, cmd.Table1, cmd.Table2)
    }
}
