// Awesome squirrel simulator
package main

import (
	"fmt"
	"time"
)

// Squirrel represents a squirrel
type Squirrel struct {
	icon string
}

func main() {
	s := Squirrel{" 🐿️"}
	r := ""
	for {
		time.Sleep(500 * time.Millisecond)
		r += s.icon
		fmt.Println(r)
	}
}
