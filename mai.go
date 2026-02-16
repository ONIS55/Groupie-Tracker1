package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http" i
	"os"
	"sort"
)

func fetch(url string) []byte {
	resp, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}
	return body
}

func printArtists(body []byte) {
	var artists []struct {
		Name string `json:"name"`
	}

	json.Unmarshal(body, &artists)

	fmt.Println("Artistes:")
	for i, artist := range artists {
		fmt.Printf("%d. %s\n", i+1, artist.Name)
	}
}

func printLocations(body []byte) {
	var data struct {
		Index []struct {
			Locations []string `json:"locations"`
		} `json:"index"`
	}

	json.Unmarshal(body, &data)

	locationMap := make(map[string]bool)
	for _, item := range data.Index {
		for _, location := range item.Locations {
			locationMap[location] = true
		}
	}

	var locations []string
	for location := range locationMap {
		locations = append(locations, location)
	}
	sort.Strings(locations)

	fmt.Println("Lieux:")
	for i, location := range locations {
		fmt.Printf("%d. %s\n", i+1, location)
	}
}

func printDates(body []byte) {
	var data struct {
		Index map[string][]string `json:"index"`
	}

	json.Unmarshal(body, &data)

	fmt.Println("Dates de concerts:")
	for artistID := range data.Index {
		fmt.Printf("\nArtiste ID %s:\n", artistID)
		for _, date := range data.Index[artistID] {
			fmt.Printf("  - %s\n", date)
		}
	}
}

func main() {
	t := flag.String("type", "artists", "Type: artists, locations, ou dates")
	flag.Parse()

	baseURL := "https://groupietrackers.herokuapp.com/api/"

	var url string
	if *t == "artists" {
		url = baseURL + "artists"
	} else if *t == "locations" {
		url = baseURL + "locations"
	} else if *t == "dates" {
		url = baseURL + "dates"
	} else {
		fmt.Println("Erreur: utilise -type=artists, -type=locations, ou -type=dates")
		os.Exit(1)
	}

	body := fetch(url)

	if *t == "artists" {
		printArtists(body)
	} else if *t == "locations" {
		printLocations(body)
	} else if *t == "dates" {
		printDates(body)
	}
}
