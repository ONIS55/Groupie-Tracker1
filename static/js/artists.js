let allArtists = [];

document.addEventListener('DOMContentLoaded', () => {
    loadArtists();
    setupSearch();
});

function loadArtists() {
    const loading = document.getElementById('loading');
    const error = document.getElementById('error');
    const artistsList = document.getElementById('artistsList');

    loading.style.display = 'block';
    error.style.display = 'none';
    artistsList.innerHTML = '';

    fetch('/api/artists')
        .then(response => {
            if (!response.ok) throw new Error('Erreur réseau');
            return response.json();
        })
        .then(data => {
            allArtists = data;
            displayArtists(allArtists);
            loading.style.display = 'none';
        })
        .catch(err => {
            console.error('Erreur:', err);
            error.textContent = 'Erreur lors du chargement des artistes';
            error.style.display = 'block';
            loading.style.display = 'none';
        });
}

function displayArtists(artists) {
    const artistsList = document.getElementById('artistsList');
    artistsList.innerHTML = '';

    if (artists.length === 0) {
        artistsList.innerHTML = '<p>Aucun artiste trouvé</p>';
        return;
    }

    artists.forEach(artist => {
        const card = document.createElement('div');
        card.className = 'artist-card';
        card.innerHTML = `
            <div class="artist-card-content">
                <h3>${artist.name}</h3>
                <p><strong>Membres:</strong> ${artist.members.length}</p>
                <p><strong>Créé:</strong> ${artist.creationDate}</p>
                <p><strong>Premier album:</strong> ${artist.firstAlbum}</p>
            </div>
        `;
        artistsList.appendChild(card);
    });
}

function setupSearch() {
    const searchInput = document.getElementById('searchInput');
    searchInput.addEventListener('keyup', (e) => {
        const query = e.target.value.toLowerCase();
        const filtered = allArtists.filter(artist =>
            artist.name.toLowerCase().includes(query)
        );
        displayArtists(filtered);
    });
}
