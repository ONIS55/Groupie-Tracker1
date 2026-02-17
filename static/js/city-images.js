// Cache pour éviter de faire plusieurs requêtes pour la même ville
const imageCache = new Map();

// Fonction pour obtenir l'URL de l'image d'une ville via l'API Pexels
async function getCityImageUrl(location) {
    // Vérifier le cache d'abord
    if (imageCache.has(location)) {
        return imageCache.get(location);
    }

    // Extraire le nom de la ville depuis le format "city-country"
    // Exemple: "paris-france" -> "paris", "new_york-usa" -> "new york"
    const cityName = location
        .split('-')[0]  // Prendre la partie avant le tiret
        .replace(/_/g, ' ')  // Remplacer les underscores par des espaces
        .trim();

    try {
        // Appeler notre proxy serveur qui contacte Pexels
        const response = await fetch(`/api/city-image?city=${encodeURIComponent(cityName)}`);
        const data = await response.json();

        if (data.imageUrl && data.imageUrl !== "") {
            // Mettre en cache et retourner
            imageCache.set(location, data.imageUrl);
            return data.imageUrl;
        }
    } catch (error) {
        console.error('Erreur lors de la récupération de l\'image pour', location, error);
    }

    // Fallback: utiliser Lorem Picsum si Pexels échoue
    const fallbackUrl = getFallbackImageUrl(location);
    imageCache.set(location, fallbackUrl);
    return fallbackUrl;
}

// Fonction de fallback avec Lorem Picsum
function getFallbackImageUrl(location) {
    const imageId = Math.abs(hashToHue(location) * 10 + location.length * 7) % 1000;
    return `https://picsum.photos/id/${imageId}/400/300`;
}
