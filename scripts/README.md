# Scripts de test

Ce dossier contient des scripts utilitaires pour tester et explorer l'API Groupie Trackers en ligne de commande.

## Scripts disponibles

### mai.go
Script principal avec support de flags pour récupérer différents types de données.

**Usage :**
```bash
# Afficher les artistes
go run mai.go -type=artists

# Afficher les lieux
go run mai.go -type=locations

# Afficher les dates
go run mai.go -type=dates
```

### Artists.go
Script simple pour récupérer et afficher les données des artistes au format JSON.

**Usage :**
```bash
go run Artists.go
```

### Dates.go
Script simple pour récupérer et afficher les dates de concerts au format JSON.

**Usage :**
```bash
go run Dates.go
```

### Location.go
Script simple pour récupérer et afficher les lieux de concerts.

**Usage :**
```bash
go run Location.go
```

## Note
Ces scripts sont fournis à titre de test et de debug. L'application principale se trouve dans `server.go` à la racine du projet.
