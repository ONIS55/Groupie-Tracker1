package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
)

func main() {
	// Servir les fichiers statiques
	http.Handle("/", http.FileServer(http.Dir("./static")))

	// Routes API
	http.HandleFunc("/api/artists", handleArtists)
	http.HandleFunc("/api/locations", handleLocations)
	http.HandleFunc("/api/dates", handleDates)

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

func handleArtists(w http.ResponseWriter, r *http.Request) {
	resp, err := http.Get("https://groupietrackers.herokuapp.com/api/artists")
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

func handleLocations(w http.ResponseWriter, r *http.Request) {
	resp, err := http.Get("https://groupietrackers.herokuapp.com/api/locations")
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

func handleDates(w http.ResponseWriter, r *http.Request) {
	resp, err := http.Get("https://groupietrackers.herokuapp.com/api/dates")
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
