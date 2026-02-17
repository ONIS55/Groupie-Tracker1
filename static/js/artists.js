let allArtists = [];
const artistLocationsById = new Map();
const artistDatesById = new Map();

document.addEventListener('DOMContentLoaded', async () => {
    await Promise.all([loadArtists(), loadLocations(), loadDates()]);
    setupSearch();
});

async function loadArtists() {
    const loading = document.getElementById('loading');
    const error = document.getElementById('error');
    const artistsList = document.getElementById('artistsList');

    loading.style.display = 'block';
    error.style.display = 'none';
    artistsList.innerHTML = '';

    try {
        const response = await fetch('/api/artists');
        if (!response.ok) throw new Error('Erreur réseau');
        const data = await response.json();
        allArtists = data;
        renderArtistBubbles(allArtists);
        displayArtists(allArtists);
    } catch (err) {
        console.error('Erreur:', err);
        error.textContent = 'Erreur lors du chargement des artistes';
        error.style.display = 'block';
    } finally {
        loading.style.display = 'none';
    }
}

async function loadLocations() {
    try {
        const response = await fetch('/api/locations');
        if (!response.ok) throw new Error('Erreur réseau');
        const data = await response.json();
        const index = Array.isArray(data.index) ? data.index : [];

        index.forEach(item => {
            if (!item || typeof item.id === 'undefined') return;
            artistLocationsById.set(item.id, item.locations || []);
        });
    } catch (err) {
        console.error('Erreur:', err);
    }
}

async function loadDates() {
    try {
        const response = await fetch('/api/dates');
        if (!response.ok) throw new Error('Erreur réseau');
        const data = await response.json();

        if (Array.isArray(data.index)) {
            data.index.forEach(item => {
                if (!item || typeof item.id === 'undefined') return;
                artistDatesById.set(item.id, item.dates || []);
            });
        } else if (data.index && typeof data.index === 'object') {
            Object.entries(data.index).forEach(([id, dates]) => {
                artistDatesById.set(Number(id), Array.isArray(dates) ? dates : []);
            });
        } else if (typeof data === 'object') {
            Object.entries(data).forEach(([id, dates]) => {
                artistDatesById.set(Number(id), Array.isArray(dates) ? dates : []);
            });
        }
    } catch (err) {
        console.error('Erreur:', err);
    }
}

function displayArtists(artists) {
    const artistsList = document.getElementById('artistsList');
    artistsList.innerHTML = '';

    if (artists.length === 0) {
        artistsList.innerHTML = '<p>Aucun artiste trouvé</p>';
        return;
    }

    artists.forEach(artist => {
        const card = document.createElement('a');
        card.href = `/artist-detail.html?id=${artist.id}`;
        card.className = 'artist-card';
        const hue = hashToHue(artist.name);
        card.style.backgroundColor = `hsl(${hue}, 70%, 92%)`;
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
    const advancedToggle = document.getElementById('advancedToggle');
    const advancedPanel = document.getElementById('advancedPanel');
    const filterByLocation = document.getElementById('filterByLocation');
    const filterByDate = document.getElementById('filterByDate');
    const filterByYear = document.getElementById('filterByYear');
    const locationInput = document.getElementById('locationInput');
    const dateInput = document.getElementById('dateInput');
    const yearFrom = document.getElementById('yearFrom');
    const yearTo = document.getElementById('yearTo');

    const applyFilters = () => {
        const query = normalize(searchInput.value);
        const locationQuery = normalize(locationInput.value);
        const dateQuery = normalize(dateInput.value);
        const yearFromValue = parseInt(yearFrom.value, 10);
        const yearToValue = parseInt(yearTo.value, 10);

        const filtered = allArtists.filter(artist => {
            if (query && !normalize(artist.name).includes(query)) {
                return false;
            }

            if (filterByLocation.checked && locationQuery) {
                const locations = artistLocationsById.get(artist.id) || [];
                const hasLocation = locations.some(loc => normalize(loc).includes(locationQuery));
                if (!hasLocation) return false;
            }

            if (filterByDate.checked && dateQuery) {
                const dates = artistDatesById.get(artist.id) || [];
                const hasDate = dates.some(date => normalize(date).includes(dateQuery));
                if (!hasDate) return false;
            }

            if (filterByYear.checked && (yearFrom.value || yearTo.value)) {
                const dates = artistDatesById.get(artist.id) || [];
                const years = dates.map(date => parseInt(String(date).split('-')[0], 10)).filter(Number.isFinite);
                const minYear = Number.isFinite(yearFromValue) ? yearFromValue : -Infinity;
                const maxYear = Number.isFinite(yearToValue) ? yearToValue : Infinity;
                const hasYear = years.some(year => year >= minYear && year <= maxYear);
                if (!hasYear) return false;
            }

            return true;
        });

        displayArtists(filtered);
    };

    advancedToggle.addEventListener('click', () => {
        const isOpen = advancedPanel.classList.toggle('is-open');
        advancedToggle.setAttribute('aria-expanded', String(isOpen));
    });

    searchInput.addEventListener('input', applyFilters);
    locationInput.addEventListener('input', applyFilters);
    dateInput.addEventListener('input', applyFilters);
    yearFrom.addEventListener('input', applyFilters);
    yearTo.addEventListener('input', applyFilters);
    filterByLocation.addEventListener('change', applyFilters);
    filterByDate.addEventListener('change', applyFilters);
    filterByYear.addEventListener('change', applyFilters);

    const bubbleList = document.getElementById('artistsBubbleList');
    bubbleList.addEventListener('click', (event) => {
        const button = event.target.closest('button[data-artist]');
        if (!button) return;
        searchInput.value = button.dataset.artist || '';
        applyFilters();

        if (!advancedPanel.classList.contains('is-open')) {
            advancedPanel.classList.add('is-open');
            advancedToggle.setAttribute('aria-expanded', 'true');
        }

        document.getElementById('artistsList').scrollIntoView({ behavior: 'smooth' });
    });
}

function renderArtistBubbles(artists) {
    const bubbleList = document.getElementById('artistsBubbleList');
    if (!bubbleList) return;

    bubbleList.innerHTML = '';

    artists.forEach(artist => {
        const button = document.createElement('button');
        button.type = 'button';
        button.className = 'artist-bubble';
        button.dataset.artist = artist.name;
        button.textContent = artist.name;
        const hue = hashToHue(artist.name);
        button.style.backgroundColor = `hsl(${hue}, 70%, 55%)`;
        bubbleList.appendChild(button);
    });
}
