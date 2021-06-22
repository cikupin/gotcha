package main

import (
	"fmt"
	"os"
	"os/signal"
)

func main() {
	fmt.Println("Waiting for signal termination....")

	c := make(chan os.Signal, 1)
	signal.Notify(c)

	termination := <-c
	fmt.Printf("\nReceive termination signal: %v\n", termination)
	fmt.Println("Application stopped...")
}
