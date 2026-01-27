package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	url := "https://groupietrackers.herokuapp.com/api/artists"

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

	var pretty interface{}
	if err := json.Unmarshal(body, &pretty); err != nil {
		// Si ce n'est pas du JSON, on affiche le contenu brut
		fmt.Println(string(body))
		return
	}

	prettyJSON, err := json.MarshalIndent(pretty, "", "  ")
	if err != nil {
		fmt.Println(string(body))
		return
	}

	fmt.Println(string(prettyJSON))
}
