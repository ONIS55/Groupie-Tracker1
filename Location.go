package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	url := "https://groupietrackers.herokuapp.com/api/locations"

	resp, err := http.Get(url)
	if err != nil {
		log.Fatalf("Erreur lors de la requête: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		log.Fatalf("Statut inattendu: %s", resp.Status)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("Erreur lors de la lecture de la réponse: %v", err)
	}

	type LocationsResponse struct {
		Index []struct {
			ID        int      `json:"id"`
			Locations []string `json:"locations"`
		} `json:"index"`
	}

	var data LocationsResponse
	if err := json.Unmarshal(body, &data); err != nil {
		log.Fatalf("Erreur de parsing JSON: %v", err)
	}

	fmt.Println("Liste des lieux (locations):")
	for _, loc := range data.Index {
		for _, name := range loc.Locations {
			fmt.Println(name)
		}
	}
}
