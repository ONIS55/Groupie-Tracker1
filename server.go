package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
)

const pexelsAPIKey = "eJvPoSvCTivdq3Y2jc7srffmrzRkgmfjQcHWJuBu84EaHazgAyg7IUgf"

func main() {
	// Servir les fichiers statiques
	http.Handle("/", http.FileServer(http.Dir("./static")))

	// Routes API
	http.HandleFunc("/api/artists", proxyAPI("artists"))
	http.HandleFunc("/api/locations", proxyAPI("locations"))
	http.HandleFunc("/api/dates", proxyAPI("dates"))
	http.HandleFunc("/api/city-image", handleCityImage)

	fmt.Println("=========================================")
	fmt.Println("🎵 Serveur Groupie Trackers démarré!")
	fmt.Println("=========================================")
	fmt.Println("Ouvrez votre navigateur:")
	fmt.Println("  http://localhost:8080")
	fmt.Println("")
	fmt.Println("Routes API disponibles:")
	fmt.Println("  - http://localhost:8080/api/artists")
	fmt.Println("  - http://localhost:8080/api/locations")
	fmt.Println("  - http://localhost:8080/api/dates")
	fmt.Println("=========================================")

	log.Fatal(http.ListenAndServe(":8080", nil))
}

// proxyAPI retourne un handler HTTP qui proxie les requêtes vers l'API Groupie Trackers
func proxyAPI(endpoint string) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		resp, err := http.Get("https://groupietrackers.herokuapp.com/api/" + endpoint)
		if err != nil {
			http.Error(w, "Erreur lors de la requête", http.StatusInternalServerError)
			return
		}
		defer resp.Body.Close()

		body, err := io.ReadAll(resp.Body)
		if err != nil {
			http.Error(w, "Erreur lors de la lecture", http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(body)
	}
}

// handleCityImage récupère une image de ville depuis l'API Pexels
func handleCityImage(w http.ResponseWriter, r *http.Request) {
	// Récupérer le nom de la ville depuis les paramètres
	cityName := r.URL.Query().Get("city")
	if cityName == "" {
		http.Error(w, "Paramètre 'city' manquant", http.StatusBadRequest)
		return
	}

	// Construire l'URL de l'API Pexels
	pexelsURL := fmt.Sprintf("https://api.pexels.com/v1/search?query=%s&per_page=1&orientation=landscape",
		url.QueryEscape(cityName+" city"))

	// Créer la requête vers Pexels
	req, err := http.NewRequest("GET", pexelsURL, nil)
	if err != nil {
		http.Error(w, "Erreur lors de la création de la requête", http.StatusInternalServerError)
		return
	}

	// Ajouter la clé API dans le header
	req.Header.Set("Authorization", pexelsAPIKey)

	// Effectuer la requête
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		http.Error(w, "Erreur lors de la requête Pexels", http.StatusInternalServerError)
		return
	}
	defer resp.Body.Close()

	// Lire la réponse
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		http.Error(w, "Erreur lors de la lecture de la réponse", http.StatusInternalServerError)
		return
	}

	// Parser la réponse JSON
	var pexelsResponse struct {
		Photos []struct {
			Src struct {
				Medium string `json:"medium"`
			} `json:"src"`
		} `json:"photos"`
	}

	if err := json.Unmarshal(body, &pexelsResponse); err != nil {
		http.Error(w, "Erreur lors du parsing JSON", http.StatusInternalServerError)
		return
	}

	// Retourner l'URL de l'image
	response := map[string]string{}
	if len(pexelsResponse.Photos) > 0 {
		response["imageUrl"] = pexelsResponse.Photos[0].Src.Medium
	} else {
		response["imageUrl"] = ""
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
