let allLocations = [];

document.addEventListener('DOMContentLoaded', () => {
    loadLocations();
    setupSearch();
});

function loadLocations() {
    const loading = document.getElementById('loading');
    const error = document.getElementById('error');
    const locationsList = document.getElementById('locationsList');

    loading.style.display = 'block';
    error.style.display = 'none';
    locationsList.innerHTML = '';

    fetch('/api/locations')
        .then(response => {
            if (!response.ok) throw new Error('Erreur réseau');
            return response.json();
        })
        .then(data => {
            // Extraire tous les lieux uniques
            const locationsSet = new Set();
            data.index.forEach(item => {
                item.locations.forEach(loc => {
                    locationsSet.add(loc);
                });
            });
            allLocations = Array.from(locationsSet).sort();
            displayLocations(allLocations);
            loading.style.display = 'none';
        })
        .catch(err => {
            console.error('Erreur:', err);
            error.textContent = 'Erreur lors du chargement des lieux';
            error.style.display = 'block';
            loading.style.display = 'none';
        });
}

function displayLocations(locations) {
    const locationsList = document.getElementById('locationsList');
    locationsList.innerHTML = '';

    if (locations.length === 0) {
        locationsList.innerHTML = '<p>Aucun lieu trouvé</p>';
        return;
    }

    locations.forEach(async (location) => {
        const card = document.createElement('div');
        card.className = 'location-card';
        const hue = hashToHue(location);

        // Gradient de secours pendant le chargement de l'image
        const gradient = `
            linear-gradient(135deg,
                hsla(${hue}, 75%, 45%, 0.9) 0%,
                hsla(${(hue + 30) % 360}, 70%, 50%, 0.85) 35%,
                hsla(${(hue + 60) % 360}, 65%, 55%, 0.8) 70%,
                hsla(${(hue + 90) % 360}, 60%, 40%, 0.9) 100%)
        `;

        card.style.background = gradient;
        card.innerHTML = `<span class="location-name">${location.replace(/_/g, ' ')}</span>`;
        locationsList.appendChild(card);

        // Charger l'image de manière asynchrone (via Pexels)
        try {
            const imageUrl = await getCityImageUrl(location);
            if (imageUrl) {
                const img = new Image();
                img.onload = () => {
                    card.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.1), rgba(0,0,0,0.25)), url(${imageUrl})`;
                    card.style.backgroundSize = 'cover';
                    card.style.backgroundPosition = 'center';
                };
                img.onerror = () => {
                    // Si l'image ne charge pas, garder le gradient
                    console.log('Image failed to load for:', location);
                };
                img.src = imageUrl;
            }
        } catch (error) {
            console.error('Error loading image for', location, error);
        }
    });
}

function setupSearch() {
    const searchInput = document.getElementById('searchInput');
    searchInput.addEventListener('keyup', (e) => {
        const query = e.target.value.toLowerCase();
        const filtered = allLocations.filter(location =>
            location.toLowerCase().includes(query)
        );
        displayLocations(filtered);
    });
}
