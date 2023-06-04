package main

/*
  #include "hello.c"
  #include "sum.c"
*/
import "C"
import (
	"errors"
	"log"
	"fmt"
)

func main() {
	err := Hello()
	if err != nil {
		log.Fatal(err)
	}
}

func Hello() error {
	_, err := C.Hello()
	if err != nil {
		return errors.New("error calling Hello function: " + err.Error())
	}
	fmt.Printf("%v :", C.Sum(4, 2))
	return nil
}
