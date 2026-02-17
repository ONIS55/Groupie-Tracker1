<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explication Code - Groupie Tracker</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
            background: #f8f9fa;
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 40px;
            border-bottom: 4px solid #3498db;
            padding-bottom: 15px;
        }

        h2 {
            color: #2980b9;
            font-size: 1.8em;
            margin-top: 40px;
            margin-bottom: 20px;
            border-left: 5px solid #3498db;
            padding-left: 15px;
            background: #ecf0f1;
            padding: 15px;
            border-radius: 5px;
        }

        h3 {
            color: #34495e;
            font-size: 1.4em;
            margin-top: 30px;
            margin-bottom: 15px;
            padding-left: 10px;
            border-left: 3px solid #95a5a6;
        }

        h4 {
            color: #555;
            font-size: 1.1em;
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        p {
            margin-bottom: 15px;
            text-align: justify;
        }

        ul {
            margin: 15px 0;
            padding-left: 30px;
        }

        ul li {
            margin: 8px 0;
            line-height: 1.7;
        }

        .code-block {
            background: #2c3e50;
            color: #ecf0f1;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            font-family: 'Courier New', monospace;
            font-size: 0.95em;
            overflow-x: auto;
            border-left: 5px solid #3498db;
        }

        .highlight {
            background: #fff3cd;
            padding: 15px;
            border-left: 4px solid #ffc107;
            margin: 20px 0;
            border-radius: 5px;
        }

        .info-box {
            background: #e8f5e9;
            padding: 15px;
            border-left: 4px solid #4caf50;
            margin: 20px 0;
            border-radius: 5px;
        }

        .warning-box {
            background: #ffebee;
            padding: 15px;
            border-left: 4px solid #f44336;
            margin: 20px 0;
            border-radius: 5px;
        }

        .architecture {
            background: #e3f2fd;
            padding: 25px;
            border-radius: 8px;
            margin: 25px 0;
            border: 2px solid #2196f3;
        }

        .flow {
            font-family: 'Courier New', monospace;
            background: #263238;
            color: #aed581;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            white-space: pre;
            overflow-x: auto;
        }

        strong {
            color: #2c3e50;
            font-weight: 600;
        }

        code {
            background: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            color: #e74c3c;
            font-family: 'Courier New', monospace;
            font-size: 0.95em;
        }

        .section {
            margin-bottom: 50px;
            page-break-inside: avoid;
        }

        .emoji {
            font-size: 1.2em;
        }

        footer {
            margin-top: 60px;
            padding-top: 20px;
            border-top: 2px solid #ecf0f1;
            text-align: center;
            color: #7f8c8d;
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }

            .container {
                box-shadow: none;
            }

            .section {
                page-break-inside: avoid;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><span class="emoji">🎵</span> EXPLICATION CODE - GROUPIE TRACKER</h1>

        <div class="architecture">
            <h2><span class="emoji">🏗️</span> Architecture du Projet</h2>

            <div class="flow">API externe (groupietrackers.herokuapp.com)
           ↓
   Serveur Go (proxy)
           ↓
   Frontend JS (fetch)
           ↓
   Affichage HTML</div>

            <p><strong>Structure des dossiers :</strong></p>
            <div class="code-block">
/home/onis/Ynov/Groupi-Tracker/
├── server.go                    ← Serveur backend Go
├── README.md                     ← Documentation
├── scripts/                      ← Scripts de test
│   ├── README.md
│   ├── mai.go
│   ├── Artists.go
│   ├── Dates.go
│   └── Location.go
└── static/                       ← Fichiers frontend
    ├── index.html               ← Page d'accueil
    ├── artists.html             ← Liste des artistes
    ├── artist-detail.html       ← Détail d'un artiste
    ├── locations.html           ← Lieux de concert
    ├── dates.html               ← Dates de concert
    ├── css/
    │   └── style.css            ← 630 lignes de styles
    └── js/
        ├── utils.js             ← Fonctions partagées
        ├── city-images.js       ← Gestion images Pexels
        ├── artists.js           ← Logique page artistes
        ├── artist-detail.js     ← Logique détail artiste
        ├── locations.js         ← Logique page lieux
        └── dates.js             ← Logique page dates
            </div>
        </div>

        <div class="section">
            <h2><span class="emoji">⚙️</span> Backend (Go)</h2>

            <h3>1. server.go - Serveur principal</h3>

            <p><strong>Rôle :</strong> Serveur HTTP qui sert les fichiers statiques et proxie les requêtes vers l'API externe</p>

            <h4>Ligne 12 : Clé API Pexels</h4>
            <ul>
                <li>Stocke la clé API pour récupérer les images de villes</li>
                <li>Sécurisé côté serveur (non exposé au client)</li>
            </ul>

            <h4>Ligne 16 : Servir les fichiers statiques</h4>
            <ul>
                <li><code>http.FileServer(http.Dir("./static"))</code> : Sert tous les fichiers du dossier static/</li>
                <li>Exemple : <code>http://localhost:8080/artists.html</code> → <code>./static/artists.html</code></li>
            </ul>

            <h4>Lignes 19-22 : Routes API</h4>
            <ul>
                <li><code>/api/artists</code> → récupère la liste des 52 artistes</li>
                <li><code>/api/locations</code> → récupère les lieux de concert</li>
                <li><code>/api/dates</code> → récupère les dates de concert</li>
                <li><code>/api/city-image</code> → récupère une image de ville depuis Pexels</li>
            </ul>

            <h4>Ligne 36 : Lancement du serveur</h4>
            <ul>
                <li>Lance le serveur sur le port 8080</li>
                <li><code>log.Fatal()</code> arrête le programme en cas d'erreur</li>
            </ul>

            <h4>Lignes 40-53 : proxyAPI() - Fonction proxy unifiée</h4>
            <div class="info-box">
                <strong>Amélioration du refactoring :</strong> Au lieu de 3 fonctions identiques (getArtists, getLocations, getDates),
                une seule fonction <code>proxyAPI(endpoint)</code> gère les 3 endpoints.
            </div>
            <ul>
                <li><strong>Ligne 42 :</strong> Fait une requête GET vers l'API externe</li>
                <li><strong>Ligne 47 :</strong> <code>defer resp.Body.Close()</code> ferme la connexion automatiquement à la fin</li>
                <li><strong>Ligne 49 :</strong> Lit tout le contenu de la réponse</li>
                <li><strong>Lignes 50-51 :</strong> Renvoie le JSON directement au client</li>
            </ul>

            <h4>Lignes 56-118 : handleCityImage() - Récupère images Pexels</h4>
            <ul>
                <li><strong>Ligne 58 :</strong> Récupère le paramètre <code>?city=...</code> de l'URL</li>
                <li><strong>Lignes 65-66 :</strong> Construit l'URL Pexels avec le nom de la ville + " city"</li>
                <li><strong>Ligne 76 :</strong> Ajoute la clé API dans le header Authorization</li>
                <li><strong>Lignes 95-101 :</strong> Structure anonyme pour parser le JSON Pexels</li>
                <li><strong>Ligne 103 :</strong> <code>json.Unmarshal()</code> convertit le JSON en structure Go</li>
                <li><strong>Lignes 110-114 :</strong> Retourne l'URL de l'image ou chaîne vide si aucune image</li>
                <li><strong>Ligne 117 :</strong> Encode et envoie la réponse JSON au client</li>
            </ul>
        </div>

        <div class="section">
            <h2><span class="emoji">🧩</span> Frontend - Fichiers Utilitaires</h2>

            <h3>1. utils.js - Fonctions partagées (51 lignes)</h3>

            <div class="info-box">
                <strong>Amélioration du refactoring :</strong> Évite la duplication de code. Ces 4 fonctions étaient
                répétées dans plusieurs fichiers, maintenant elles sont centralisées.
            </div>

            <h4>Lignes 8-16 : hashToHue(value)</h4>
            <ul>
                <li><strong>Rôle :</strong> Génère une couleur unique (teinte HSL 0-360) basée sur un texte</li>
                <li><strong>Ligne 12 :</strong> <code>(hash << 5) - hash</code> = multiplication par 32 - hash (algorithme de hash)</li>
                <li><strong>Ligne 13 :</strong> <code>hash |= 0</code> convertit en entier 32 bits</li>
                <li><strong>Ligne 15 :</strong> <code>Math.abs(hash) % 360</code> limite entre 0 et 359</li>
                <li><strong>Utilisation :</strong> Même nom = même couleur à chaque fois</li>
            </ul>

            <h4>Lignes 23-28 : normalize(value)</h4>
            <ul>
                <li><strong>Rôle :</strong> Normalise un texte pour la recherche</li>
                <li><code>.toLowerCase()</code> : "Paris" → "paris"</li>
                <li><code>.trim()</code> : Supprime les espaces au début/fin</li>
                <li><code>.replace(/_/g, ' ')</code> : "new_york" → "new york"</li>
            </ul>

            <h4>Lignes 35-41 : parseId(id)</h4>
            <ul>
                <li><strong>Rôle :</strong> Valide qu'un ID est un nombre positif</li>
                <li><strong>Ligne 36 :</strong> <code>parseInt(id, 10)</code> convertit en nombre (base 10)</li>
                <li><strong>Ligne 37 :</strong> Retourne <code>null</code> si NaN ou < 1</li>
                <li><strong>Sécurité :</strong> Empêche les IDs invalides</li>
            </ul>

            <h4>Lignes 48-50 : formatDateLabel(value)</h4>
            <ul>
                <li><strong>Rôle :</strong> Supprime l'astérisque devant les dates</li>
                <li><code>.replace(/^\*/, '')</code> : "*2015-06-20" → "2015-06-20"</li>
            </ul>

            <h3>2. city-images.js - Gestion images Pexels (43 lignes)</h3>

            <h4>Ligne 2 : imageCache = new Map()</h4>
            <ul>
                <li><strong>Rôle :</strong> Cache les URLs d'images pour éviter les requêtes répétées</li>
                <li>Structure : <code>"paris-france" → "https://images.pexels.com/..."</code></li>
            </ul>

            <h4>Lignes 5-36 : getCityImageUrl(location)</h4>
            <ul>
                <li><strong>Ligne 7-9 :</strong> Vérifie le cache, retourne immédiatement si trouvé</li>
                <li><strong>Lignes 13-16 :</strong> Extrait le nom de la ville : "paris-france" → "paris"</li>
                <li><strong>Ligne 20 :</strong> Fait une requête vers <code>/api/city-image?city=...</code></li>
                <li><strong>Ligne 25 :</strong> Sauvegarde dans le cache</li>
                <li><strong>Lignes 33-35 :</strong> Fallback vers Lorem Picsum si Pexels échoue</li>
            </ul>

            <h4>Lignes 39-42 : getFallbackImageUrl(location)</h4>
            <ul>
                <li><strong>Ligne 40 :</strong> Calcule un ID unique entre 0 et 999</li>
                <li>Formule : <code>(hashToHue × 10 + longueur × 7) % 1000</code></li>
                <li><strong>Ligne 41 :</strong> Retourne une URL Lorem Picsum (400×300px)</li>
            </ul>
        </div>

        <div class="section">
            <h2><span class="emoji">🎭</span> Frontend - Pages Principales</h2>

            <h3>1. artists.html - Page liste des artistes</h3>

            <h4>Structure HTML :</h4>
            <ul>
                <li><strong>Lignes 26-29 :</strong> Sidebar avec bulles d'artistes cliquables</li>
                <li><strong>Ligne 34 :</strong> Champ de recherche principale</li>
                <li><strong>Ligne 36 :</strong> Bouton 🔍 pour recherche avancée</li>
                <li><strong>Lignes 41-66 :</strong> Panneau de filtres avancés (Lieux, Dates, Années)</li>
                <li><strong>Ligne 68 :</strong> Grille d'artistes (remplie par JavaScript)</li>
                <li><strong>Lignes 79-80 :</strong> Scripts : utils.js PUIS artists.js (ordre important!)</li>
            </ul>

            <h3>2. artists.js - Logique page artistes (201 lignes)</h3>

            <h4>Lignes 1-3 : Variables globales</h4>
            <ul>
                <li><code>allArtists = []</code> : Tableau de tous les artistes</li>
                <li><code>artistLocationsById = new Map()</code> : Map ID → lieux</li>
                <li><code>artistDatesById = new Map()</code> : Map ID → dates</li>
            </ul>

            <h4>Lignes 5-8 : Initialisation</h4>
            <ul>
                <li><strong>Ligne 6 :</strong> <code>Promise.all([])</code> charge 3 APIs EN PARALLÈLE (plus rapide!)</li>
                <li><strong>Ligne 7 :</strong> Configure les événements de recherche</li>
            </ul>

            <h4>Lignes 10-33 : loadArtists()</h4>
            <ul>
                <li><strong>Ligne 20 :</strong> <code>fetch('/api/artists')</code> récupère les données</li>
                <li><strong>Ligne 21 :</strong> <code>if (!response.ok)</code> vérifie le code HTTP</li>
                <li><strong>Ligne 24 :</strong> Affiche les bulles dans la sidebar</li>
                <li><strong>Ligne 25 :</strong> Affiche les cartes d'artistes</li>
                <li><strong>Ligne 31 :</strong> <code>finally</code> cache le "Chargement..." dans tous les cas</li>
            </ul>

            <h4>Lignes 35-49 : loadLocations()</h4>
            <ul>
                <li><strong>Ligne 44 :</strong> <code>artistLocationsById.set(item.id, item.locations)</code></li>
                <li>Crée une Map : <code>1 → ["paris-france", "london-uk", ...]</code></li>
            </ul>

            <h4>Lignes 51-74 : loadDates()</h4>
            <div class="highlight">
                <strong>Gestion de 3 formats différents de l'API :</strong>
                <ul>
                    <li>Format 1 : <code>{ index: [{ id: 1, dates: [...] }] }</code></li>
                    <li>Format 2 : <code>{ index: { "1": [...], "2": [...] } }</code></li>
                    <li>Format 3 : <code>{ "1": [...], "2": [...] }</code></li>
                </ul>
            </div>

            <h4>Lignes 76-101 : displayArtists(artists)</h4>
            <ul>
                <li><strong>Ligne 86 :</strong> Crée un élément <code>&lt;a&gt;</code> (lien cliquable)</li>
                <li><strong>Ligne 87 :</strong> Lien vers <code>/artist-detail.html?id=...</code></li>
                <li><strong>Lignes 89-90 :</strong> Génère une couleur HSL unique par artiste</li>
                <li><strong>Lignes 91-98 :</strong> HTML avec nom, membres, date création, premier album</li>
            </ul>

            <h4>Lignes 103-182 : setupSearch() - Recherche avancée</h4>
            <ul>
                <li><strong>Ligne 115 :</strong> Fonction <code>applyFilters()</code> applique tous les critères</li>
                <li><strong>Ligne 122 :</strong> <code>filter()</code> crée un nouveau tableau filtré</li>
                <li><strong>Ligne 123 :</strong> Filtre par nom d'artiste</li>
                <li><strong>Lignes 127-131 :</strong> Filtre par lieu (si checkbox cochée)</li>
                <li><strong>Ligne 129 :</strong> <code>some()</code> = true si AU MOINS un lieu correspond</li>
                <li><strong>Lignes 133-137 :</strong> Filtre par date exacte</li>
                <li><strong>Lignes 139-146 :</strong> Filtre par plage d'années</li>
                <li><strong>Ligne 141 :</strong> Extrait les années des dates : "2015-06-20" → 2015</li>
                <li><strong>Lignes 154-157 :</strong> Toggle du panneau de recherche avancée</li>
                <li><strong>Lignes 159-166 :</strong> Événements <code>input</code> pour filtrage temps réel</li>
                <li><strong>Lignes 168-181 :</strong> Clic sur une bulle remplit la recherche et scroll vers les résultats</li>
            </ul>

            <h4>Lignes 184-200 : renderArtistBubbles(artists)</h4>
            <ul>
                <li>Crée des boutons colorés dans la sidebar</li>
                <li><strong>Ligne 194 :</strong> <code>button.dataset.artist</code> crée l'attribut <code>data-artist="nom"</code></li>
                <li><strong>Ligne 197 :</strong> Couleur plus saturée que les cartes (55% vs 92%)</li>
            </ul>

            <h3>3. artist-detail.html - Page détail d'un artiste</h3>

            <h4>Structure HTML :</h4>
            <ul>
                <li><strong>Ligne 23 :</strong> Conteneur <code>&lt;div id="artistDetail"&gt;</code> VIDE</li>
                <li>Tout le HTML est généré dynamiquement par JavaScript</li>
                <li><strong>Lignes 32-33 :</strong> Scripts : utils.js PUIS artist-detail.js</li>
            </ul>

            <h3>4. artist-detail.js - Logique détail artiste (172 lignes)</h3>

            <h4>Lignes 1-13 : Initialisation et validation ID</h4>
            <ul>
                <li><strong>Ligne 2 :</strong> <code>URLSearchParams</code> parse <code>?id=5</code></li>
                <li><strong>Ligne 6 :</strong> <code>parseId()</code> valide que l'ID est un nombre > 0</li>
                <li><strong>Ligne 8 :</strong> Redirige vers /artists.html si ID invalide</li>
            </ul>

            <h4>Lignes 15-59 : loadArtistDetail(artistId)</h4>
            <ul>
                <li><strong>Lignes 25-29 :</strong> 3 requêtes API en PARALLÈLE avec Promise.all()</li>
                <li><strong>Ligne 39 :</strong> <code>find()</code> recherche l'artiste avec cet ID</li>
                <li><strong>Lignes 48-49 :</strong> Récupère les lieux et dates spécifiques</li>
            </ul>

            <h4>Lignes 77-130 : displayArtistDetail() - Génère tout le HTML</h4>
            <ul>
                <li><strong>Ligne 82 :</strong> En-tête avec gradient de couleur unique (2 teintes)</li>
                <li><strong>Ligne 83 :</strong> Image de l'artiste</li>
                <li><strong>Lignes 94-96 :</strong> Section Histoire avec biographie auto-générée</li>
                <li><strong>Lignes 100-103 :</strong> Section Membres (tags cliquables)</li>
                <li><strong>Lignes 107-112 :</strong> Section Lieux (tous les lieux)</li>
                <li><strong>Lignes 116-122 :</strong> Section Dates (12 premières + compteur)</li>
                <li><strong>Ligne 119 :</strong> <code>slice(0, 12)</code> limite à 12 dates affichées</li>
                <li><strong>Ligne 121 :</strong> Affiche "+ X autres dates" si plus de 12</li>
            </ul>

            <h4>Lignes 132-171 : generateBiography() - Génère une bio intelligente</h4>
            <div class="info-box">
                <strong>Génération automatique :</strong> Crée un texte descriptif cohérent en français basé sur les données.
            </div>
            <ul>
                <li><strong>Lignes 134-135 :</strong> Détermine "artiste solo" ou "groupe de X membres"</li>
                <li><strong>Ligne 143 :</strong> <code>join(', ')</code> crée la liste des membres</li>
                <li><strong>Ligne 149 :</strong> Compte et format des concerts</li>
                <li><strong>Lignes 154-160 :</strong> Extrait les pays uniques :
                    <ul>
                        <li><code>map()</code> : "paris-france" → "france"</li>
                        <li><code>filter(Boolean)</code> : Supprime les valeurs vides</li>
                        <li><code>new Set()</code> : Élimine les doublons</li>
                        <li><code>[...]</code> : Convertit Set en tableau</li>
                    </ul>
                </li>
                <li><strong>Ligne 156 :</strong> <code>slice(0, 3)</code> prend les 3 premiers pays</li>
            </ul>

            <h3>5. locations.html - Page des lieux</h3>

            <h4>Structure HTML :</h4>
            <ul>
                <li><strong>Ligne 26 :</strong> Champ de recherche</li>
                <li><strong>Ligne 29 :</strong> Grille de cartes de lieux</li>
                <li><strong>Lignes 38-40 :</strong> Scripts : utils.js, city-images.js, locations.js</li>
            </ul>

            <h3>6. locations.js - Logique page lieux (101 lignes)</h3>

            <h4>Lignes 17-40 : loadLocations()</h4>
            <ul>
                <li><strong>Ligne 24 :</strong> <code>new Set()</code> pour extraire les lieux uniques</li>
                <li><strong>Lignes 25-29 :</strong> Double boucle pour collecter tous les lieux</li>
                <li><strong>Ligne 30 :</strong> <code>Array.from(locationsSet).sort()</code> trie alphabétiquement</li>
            </ul>

            <h4>Lignes 42-89 : displayLocations() - Chargement progressif</h4>
            <div class="info-box">
                <strong>Progressive Enhancement :</strong> Affiche un gradient immédiatement, charge les images en arrière-plan.
            </div>
            <ul>
                <li><strong>Lignes 57-63 :</strong> Gradient multi-couleurs (4 teintes avec alpha)</li>
                <li><strong>Ligne 65 :</strong> Applique le gradient immédiatement</li>
                <li><strong>Ligne 67 :</strong> Ajoute la carte au DOM (AVANT l'image!)</li>
                <li><strong>Ligne 71 :</strong> Charge l'image ASYNCHRONEMENT</li>
                <li><strong>Lignes 74-78 :</strong> Remplace par l'image quand chargée :
                    <ul>
                        <li>Overlay noir semi-transparent (10-25%)</li>
                        <li><code>backgroundSize: 'cover'</code> : Remplit le conteneur</li>
                        <li><code>backgroundPosition: 'center'</code> : Centre l'image</li>
                    </ul>
                </li>
                <li><strong>Lignes 79-82 :</strong> Garde le gradient si l'image échoue</li>
            </ul>

            <h4>Lignes 91-100 : setupSearch()</h4>
            <ul>
                <li><strong>Ligne 93 :</strong> Événement <code>keyup</code> sur chaque touche relâchée</li>
                <li><strong>Ligne 96 :</strong> Filtre et réaffiche en temps réel</li>
            </ul>

            <h3>7. dates.html - Page des dates</h3>

            <h4>Structure HTML :</h4>
            <ul>
                <li><strong>Ligne 25 :</strong> Liste de dates</li>
                <li><strong>Lignes 26-30 :</strong> Contrôles de pagination (Précédent / Page X/Y / Suivant)</li>
                <li><strong>Ligne 39 :</strong> Script : dates.js (pas besoin de utils.js ou city-images.js)</li>
            </ul>

            <h3>8. dates.js - Logique page dates (136 lignes)</h3>

            <h4>Lignes 1-3 : Variables globales</h4>
            <ul>
                <li><code>datesEntries = []</code> : Toutes les entrées de dates</li>
                <li><code>currentPage = 1</code> : Page actuelle</li>
                <li><code>itemsPerPage = 12</code> : Nombre d'items par page</li>
            </ul>

            <h4>Lignes 36-54 : displayDates(datesData)</h4>
            <ul>
                <li><strong>Ligne 40 :</strong> Normalise le format de l'API</li>
                <li><strong>Ligne 47 :</strong> <code>Object.keys()</code> récupère toutes les clés</li>
                <li><strong>Ligne 48 :</strong> <code>map()</code> transforme en objets <code>{ id, dates }</code></li>
                <li><strong>Ligne 49 :</strong> <code>filter()</code> garde seulement les valides</li>
                <li><strong>Ligne 50 :</strong> <code>sort()</code> trie par ID numérique</li>
            </ul>

            <h4>Lignes 56-77 : normalizeDatesIndex() - Gère 4 formats d'API</h4>
            <ul>
                <li>Format 1 : Tableau d'objets avec index</li>
                <li>Format 2 : Objet index avec sous-objets</li>
                <li>Format 3 : Objet direct</li>
                <li>Format 4 : null/undefined → objet vide</li>
            </ul>

            <h4>Lignes 91-115 : renderDatesPage() - Pagination</h4>
            <ul>
                <li><strong>Ligne 99 :</strong> <code>Math.ceil()</code> arrondit vers le haut : 13/12 = 1.08 → 2 pages</li>
                <li><strong>Ligne 100 :</strong> Empêche <code>currentPage</code> d'être invalide</li>
                <li><strong>Ligne 102 :</strong> Calcul de l'index de départ : Page 2 = (2-1)*12 = 12</li>
                <li><strong>Ligne 103 :</strong> <code>slice()</code> extrait 12 éléments</li>
                <li><strong>Lignes 113-114 :</strong> Active/désactive les boutons selon la page</li>
            </ul>

            <h4>Lignes 117-135 : setupPagination()</h4>
            <ul>
                <li><strong>Lignes 121-126 :</strong> Bouton "Précédent" décrémente la page</li>
                <li><strong>Lignes 128-134 :</strong> Bouton "Suivant" incrémente la page</li>
            </ul>
        </div>

        <div class="section">
            <h2><span class="emoji">🎨</span> Fonctionnalités Clés</h2>

            <div class="highlight">
                <h3>1. Couleurs Dynamiques Uniques</h3>
                <ul>
                    <li><strong>Algorithme :</strong> Hash du nom → Teinte HSL (0-360)</li>
                    <li><strong>Avantage :</strong> Même nom = toujours la même couleur</li>
                    <li><strong>Utilisation :</strong> Cartes d'artistes, bulles, en-têtes, lieux</li>
                </ul>
                <div class="code-block">
hashToHue("Queen")   → 234  (violet)
hashToHue("Beatles") → 156  (vert)

hsl(234, 70%, 92%)  = Violet clair</div>
            </div>

            <div class="highlight">
                <h3>2. Recherche Avancée Multi-Critères</h3>
                <ul>
                    <li><strong>Nom d'artiste :</strong> Recherche textuelle en temps réel</li>
                    <li><strong>Lieux :</strong> Filtre par ville/pays (ex: "paris")</li>
                    <li><strong>Dates :</strong> Recherche par date exacte (ex: "2015-06-20")</li>
                    <li><strong>Années :</strong> Plage d'années (De/À)</li>
                    <li><strong>Combinable :</strong> Tous les filtres peuvent être combinés</li>
                </ul>
            </div>

            <div class="highlight">
                <h3>3. Pagination Intelligente</h3>
                <ul>
                    <li><strong>Page dates :</strong> 12 items par page</li>
                    <li><strong>Calcul dynamique :</strong> Nombre total de pages ajusté automatiquement</li>
                    <li><strong>Boutons désactivés :</strong> Précédent (page 1) / Suivant (dernière page)</li>
                </ul>
            </div>

            <div class="highlight">
                <h3>4. Biographie Automatique</h3>
                <ul>
                    <li><strong>Génération :</strong> Texte cohérent en français basé sur les données</li>
                    <li><strong>Contenu :</strong> Type (solo/groupe), membres, historique, statistiques</li>
                    <li><strong>Adaptation :</strong> Singulier/pluriel, compteurs dynamiques</li>
                </ul>
            </div>

            <div class="highlight">
                <h3>5. Images Dynamiques avec Fallback</h3>
                <ul>
                    <li><strong>Source principale :</strong> API Pexels (photos réelles de villes)</li>
                    <li><strong>Cache :</strong> Map pour éviter requêtes répétées</li>
                    <li><strong>Fallback :</strong> Lorem Picsum si Pexels échoue</li>
                    <li><strong>Progressive Enhancement :</strong> Gradient → Image chargée asynchronement</li>
                </ul>
            </div>

            <div class="highlight">
                <h3>6. Performance Optimisée</h3>
                <ul>
                    <li><strong>Promise.all() :</strong> Requêtes API en parallèle (300ms au lieu de 900ms)</li>
                    <li><strong>Cache Map :</strong> Images de villes (0ms au lieu de 500ms)</li>
                    <li><strong>Pagination :</strong> Limite l'affichage (12/page au lieu de tout)</li>
                    <li><strong>Chargement asynchrone :</strong> Images chargées en arrière-plan</li>
                </ul>
            </div>
        </div>

        <div class="section architecture">
            <h2><span class="emoji">🔄</span> Flux de Données Détaillé</h2>

            <h3>Exemple : Chargement de la page artistes</h3>

            <div class="flow">
1. Utilisateur → http://localhost:8080/artists.html

2. Serveur Go (server.go ligne 16):
   └─ http.FileServer envoie: ./static/artists.html

3. Navigateur parse HTML:
   ├─ Charge /css/style.css
   ├─ Charge /js/utils.js
   │  └─ Définit: hashToHue(), normalize(), parseId(), formatDateLabel()
   └─ Charge /js/artists.js
      └─ Exécute le code JavaScript

4. JavaScript - DOMContentLoaded (ligne 5):
   └─ Promise.all([
         fetch('/api/artists'),      → 300ms
         fetch('/api/locations'),    → 300ms
         fetch('/api/dates')         → 300ms
      ])
      └─ TOTAL: 300ms (parallèle) au lieu de 900ms (séquentiel)

5. loadArtists() (ligne 10):
   └─ fetch('/api/artists')
      └─ Serveur Go ligne 19: proxyAPI("artists")
         └─ GET https://groupietrackers.herokuapp.com/api/artists
            └─ Reçoit: [{ id:1, name:"Queen", members:[...], ... }, ...]
               └─ Renvoie JSON au navigateur
      └─ response.json() parse le JSON
      └─ renderArtistBubbles(allArtists)
         └─ Crée 52 boutons colorés dans la sidebar
      └─ displayArtists(allArtists)
         └─ Pour chaque artiste:
            ├─ Crée <a class="artist-card">
            ├─ hue = hashToHue(artist.name)
            ├─ backgroundColor = hsl(hue, 70%, 92%)
            └─ innerHTML avec nom, membres, dates
         └─ appendChild() ajoute au DOM

6. setupSearch() (ligne 103):
   └─ Configure les événements:
      ├─ searchInput.addEventListener('input', applyFilters)
      ├─ locationInput.addEventListener('input', applyFilters)
      └─ ...

7. Utilisateur tape "que" dans la recherche:
   └─ Événement 'input' déclenché
      └─ applyFilters()
         └─ filtered = allArtists.filter(...)
            └─ normalize("Queen").includes("que") → true ✓
            └─ normalize("Beatles").includes("que") → false ✗
         └─ displayArtists([Queen])
            └─ Affiche seulement Queen

8. Utilisateur clique sur Queen:
   └─ Navigateur suit le lien: /artist-detail.html?id=1
      └─ (Voir flux artist-detail ci-dessous)
            </div>

            <h3>Exemple : Page détail d'un artiste</h3>

            <div class="flow">
1. URL: /artist-detail.html?id=5

2. artist-detail.js ligne 2:
   └─ urlParams.get('id') → "5"
   └─ parseId("5") → 5 (validé)

3. loadArtistDetail(5) ligne 15:
   └─ Promise.all([
         fetch('/api/artists'),
         fetch('/api/locations'),
         fetch('/api/dates')
      ])

4. Ligne 39:
   └─ artist = artists.find(a => a.id === 5)
      └─ Trouve l'artiste avec ID 5

5. Lignes 48-49:
   └─ locations = getLocationsForArtist(locationsData, 5)
      └─ ["paris-france", "london-uk", ...]
   └─ dates = getDatesForArtist(datesData, 5)
      └─ ["*2015-06-20", "2015-07-15", ...]

6. displayArtistDetail(artist, locations, dates) ligne 77:
   └─ innerHTML = `
         <div class="artist-detail-header">
            <img src="${artist.image}">
            <h1>${artist.name}</h1>
            ...
         </div>
         <section>
            <h2>📜 Histoire</h2>
            <p>${generateBiography(artist, locations, dates)}</p>
         </section>
         ...
      `

7. generateBiography() ligne 132:
   └─ Construit le texte:
      "Queen est un groupe de 4 membres formé en 1970.
       Le groupe se compose de Freddie Mercury, Brian May, ...
       Avec 150 concerts dans 45 lieux différents..."

8. Utilisateur voit la page complète avec tous les détails!
            </div>
        </div>

        <div class="section">
            <h2><span class="emoji">⚡</span> Améliorations du Refactoring</h2>

            <div class="info-box">
                <h3>Avant le refactoring :</h3>
                <ul>
                    <li>❌ Fonction <code>hashToHue()</code> dupliquée dans 3 fichiers</li>
                    <li>❌ 3 fonctions serveur identiques (getArtists, getLocations, getDates)</li>
                    <li>❌ Pas de validation des IDs</li>
                    <li>❌ Pas de documentation</li>
                    <li>❌ server.go dans le mauvais dossier</li>
                </ul>

                <h3>Après le refactoring :</h3>
                <ul>
                    <li>✅ <strong>utils.js</strong> : 4 fonctions partagées (hashToHue, normalize, parseId, formatDateLabel)</li>
                    <li>✅ <strong>proxyAPI()</strong> : Une seule fonction pour 3 endpoints</li>
                    <li>✅ <strong>Validation ID</strong> : parseId() empêche les IDs invalides</li>
                    <li>✅ <strong>README.md</strong> : Documentation complète (130+ lignes)</li>
                    <li>✅ <strong>Structure</strong> : server.go à la racine, scripts/ pour les tests</li>
                    <li>✅ <strong>Pexels API</strong> : Images réelles de villes avec fallback</li>
                    <li>✅ <strong>Cache</strong> : Map pour images (performance)</li>
                </ul>
            </div>

            <div class="warning-box">
                <h3>⚠️ Points d'Attention</h3>
                <ul>
                    <li><strong>Ordre des scripts :</strong> utils.js DOIT être chargé AVANT les autres</li>
                    <li><strong>Cache busting :</strong> <code>?v=20260216</code> force rechargement CSS/JS si modifié</li>
                    <li><strong>Sécurité :</strong> Clé API Pexels côté serveur uniquement</li>
                    <li><strong>Fallback :</strong> Lorem Picsum si Pexels ne répond pas</li>
                    <li><strong>Validation :</strong> Toujours valider les IDs avec parseId()</li>
                </ul>
            </div>
        </div>

        <div class="section">
            <h2><span class="emoji">📊</span> Technologies et Concepts Utilisés</h2>

            <h3>Backend</h3>
            <ul>
                <li><strong>Go 1.x</strong> : Langage de programmation compilé</li>
                <li><strong>net/http</strong> : Package HTTP standard de Go</li>
                <li><strong>Proxy API</strong> : Évite les problèmes CORS</li>
                <li><strong>defer</strong> : Fermeture automatique des ressources</li>
                <li><strong>Structures anonymes</strong> : Parsing JSON flexible</li>
            </ul>

            <h3>Frontend</h3>
            <ul>
                <li><strong>HTML5</strong> : Structure sémantique (nav, section, footer)</li>
                <li><strong>CSS3</strong> : Flexbox, Grid, animations, responsive</li>
                <li><strong>JavaScript ES6+</strong> : async/await, arrow functions, template literals</li>
                <li><strong>Fetch API</strong> : Requêtes HTTP modernes</li>
                <li><strong>Promise.all()</strong> : Exécution parallèle</li>
                <li><strong>Map</strong> : Structure de données clé-valeur performante</li>
                <li><strong>Set</strong> : Élimination des doublons</li>
                <li><strong>Array methods</strong> : map(), filter(), find(), some(), forEach()</li>
                <li><strong>DOM Manipulation</strong> : createElement(), appendChild(), innerHTML</li>
                <li><strong>Event Listeners</strong> : addEventListener() pour interactivité</li>
            </ul>

            <h3>APIs Externes</h3>
            <ul>
                <li><strong>Groupie Trackers API</strong> : Artistes, lieux, dates</li>
                <li><strong>Pexels API</strong> : Images de villes (avec authentification)</li>
                <li><strong>Lorem Picsum</strong> : Images de fallback (sans auth)</li>
            </ul>

            <h3>Patterns et Concepts</h3>
            <ul>
                <li><strong>DRY (Don't Repeat Yourself)</strong> : utils.js évite duplication</li>
                <li><strong>Progressive Enhancement</strong> : Gradient → Image</li>
                <li><strong>Lazy Loading</strong> : Images chargées asynchronement</li>
                <li><strong>Caching</strong> : Map pour stocker les résultats</li>
                <li><strong>Error Handling</strong> : try/catch, validation, fallbacks</li>
                <li><strong>Responsive Design</strong> : Adapté mobile/tablette/desktop</li>
                <li><strong>Accessibility</strong> : aria-label, aria-expanded</li>
            </ul>
        </div>

        <div class="section">
            <h2><span class="emoji">🎯</span> Résumé Final</h2>

            <p><strong>Groupie-Tracker</strong> est une application web moderne qui affiche des informations sur 52 artistes de musique avec leurs lieux et dates de concert.</p>

            <h3>Caractéristiques principales :</h3>
            <ul>
                <li>✅ <strong>52 artistes</strong> avec détails complets (membres, albums, dates)</li>
                <li>✅ <strong>Recherche avancée</strong> multi-critères (nom, lieu, date, année)</li>
                <li>✅ <strong>Images réelles</strong> des villes via Pexels API</li>
                <li>✅ <strong>Biographies automatiques</strong> générées intelligemment</li>
                <li>✅ <strong>Couleurs uniques</strong> par artiste (algorithme de hash)</li>
                <li>✅ <strong>Interface intuitive</strong> avec bulles cliquables et filtres</li>
                <li>✅ <strong>Performance optimisée</strong> (parallélisme, cache, pagination)</li>
                <li>✅ <strong>Code maintenant refactorisé</strong> et bien structuré</li>
            </ul>

            <h3>Architecture technique :</h3>
            <ul>
                <li><strong>Backend :</strong> Serveur Go avec proxy API</li>
                <li><strong>Frontend :</strong> HTML5, CSS3, JavaScript ES6+</li>
                <li><strong>APIs :</strong> Groupie Trackers + Pexels</li>
                <li><strong>Fichiers :</strong> 12 fichiers (1 Go + 5 HTML + 6 JS)</li>
            </ul>

            <h3>🎓 Concepts démontres :</h3>
            <ul>
                <li>Serveur HTTP en Go</li>
                <li>Proxy API pour CORS</li>
                <li>Requêtes asynchrones (async/await)</li>
                <li>Manipulation du DOM</li>
                <li>Algorithmes de hash</li>
                <li>Pagination</li>
                <li>Cache et optimisation</li>
                <li>Génération de contenu dynamique</li>
                <li>Filtrage temps réel</li>
                <li>Progressive Enhancement</li>
            </ul>
        </div>

        <footer>
            <p><strong>📄 Document d'explication - Groupie Tracker</strong></p>
            <p>Généré le 17 février 2026</p>
            <p><em>Pour imprimer en PDF : Ctrl+P → Enregistrer au format PDF</em></p>
        </footer>
    </div>
</body>
</html>
