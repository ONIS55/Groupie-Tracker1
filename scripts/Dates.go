package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
)

func main() {
	url := "https://groupietrackers.herokuapp.com/api/dates"
	resp, err := http.Get(url)
	if err != nil {
		log.Fatalf("Erreur lors de la requête: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		log.Fatalf("Statut inattendu: %s", resp.Status)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("Erreur lors de la lecture de la réponse: %v", err)
	}

	var pretty interface{}
	if err := json.Unmarshal(body, &pretty); err != nil {
		fmt.Println("Erreur lors du décodage JSON:", err)
		fmt.Println("Contenu brut:", string(body))
		return
	}

	prettyJSON, err := json.MarshalIndent(pretty, "", "  ")
	if err != nil {
		log.Fatalf("Erreur lors du formatage JSON: %v", err)
	}

	fmt.Println(string(prettyJSON))
}