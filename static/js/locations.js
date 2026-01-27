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

    locations.forEach(location => {
        const card = document.createElement('div');
        card.className = 'location-card';
        card.textContent = location.replace(/_/g, ' ');
        locationsList.appendChild(card);
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
