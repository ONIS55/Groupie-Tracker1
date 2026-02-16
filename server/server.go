package server

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"
	"strconv"
)

type Artist struct {
	Id           int      `json:"id"`
	Name         string   `json:"name"`
	Image        string   `json:"image"`
	Members      []string `json:"members"`
	CreationDate int      `json:"creationDate"`
	FirstAlbum   string   `json:"firstAlbum"`
}

var tmpl = template.Must(template.ParseFiles(
	"templates/layout.html",
	"templates/index.html",
	"templates/artist.html",
))

// =========================
// LANCER LE SERVEUR
// =========================
func StartServer() {

	// fichiers static (css/js/images)
	http.Handle("/static/", http.StripPrefix("/static/",
		http.FileServer(http.Dir("static"))))

	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/artist", artistHandler)

	log.Println("🚀 Server started on http://localhost:8080")
	http.ListenAndServe(":8080", nil)
}

// =========================
// PAGE D'ACCUEIL
// =========================
func homeHandler(w http.ResponseWriter, r *http.Request) {

	artists, err := fetchArtists()
	if err != nil {
		http.Error(w, "Erreur API", http.StatusInternalServerError)
		return
	}

	tmpl.ExecuteTemplate(w, "layout", artists)
}

// =========================
// PAGE ARTISTE
// =========================
func artistHandler(w http.ResponseWriter, r *http.Request) {

	idStr := r.URL.Query().Get("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "ID invalide", http.StatusBadRequest)
		return
	}

	artists, err := fetchArtists()
	if err != nil {
		http.Error(w, "Erreur API", http.StatusInternalServerError)
		return
	}

	for _, artist := range artists {
		if artist.Id == id {
			tmpl.ExecuteTemplate(w, "layout", artist)
			return
		}
	}

	http.NotFound(w, r)
}

// =========================
// FETCH API
// =========================
func fetchArtists() ([]Artist, error) {

	resp, err := http.Get("https://groupietrackers.herokuapp.com/api/artists")
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var artists []Artist
	err = json.NewDecoder(resp.Body).Decode(&artists)
	if err != nil {
		return nil, err
	}

	return artists, nil
}
