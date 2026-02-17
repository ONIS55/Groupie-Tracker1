document.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const artistIdRaw = urlParams.get('id');

    // Validation de l'ID
    const artistId = parseId(artistIdRaw);
    if (!artistId) {
        window.location.href = '/artists.html';
        return;
    }

    loadArtistDetail(artistId);
});

async function loadArtistDetail(artistId) {
    const loading = document.getElementById('loading');
    const error = document.getElementById('error');
    const artistDetail = document.getElementById('artistDetail');

    loading.style.display = 'block';
    error.style.display = 'none';
    artistDetail.innerHTML = '';

    try {
        const [artistsResponse, locationsResponse, datesResponse] = await Promise.all([
            fetch('/api/artists'),
            fetch('/api/locations'),
            fetch('/api/dates')
        ]);

        if (!artistsResponse.ok || !locationsResponse.ok || !datesResponse.ok) {
            throw new Error('Erreur réseau');
        }

        const artists = await artistsResponse.json();
        const locationsData = await locationsResponse.json();
        const datesData = await datesResponse.json();

        const artist = artists.find(a => a.id === parseInt(artistId));
        
        if (!artist) {
            error.textContent = 'Artiste non trouvé';
            error.style.display = 'block';
            loading.style.display = 'none';
            return;
        }

        const locations = getLocationsForArtist(locationsData, artist.id);
        const dates = getDatesForArtist(datesData, artist.id);

        displayArtistDetail(artist, locations, dates);
        loading.style.display = 'none';
    } catch (err) {
        console.error('Erreur:', err);
        error.textContent = 'Erreur lors du chargement des détails';
        error.style.display = 'block';
        loading.style.display = 'none';
    }
}

function getLocationsForArtist(data, artistId) {
    if (Array.isArray(data.index)) {
        const item = data.index.find(i => i.id === artistId);
        return item ? item.locations || [] : [];
    }
    return [];
}

function getDatesForArtist(data, artistId) {
    if (Array.isArray(data.index)) {
        const item = data.index.find(i => i.id === artistId);
        return item ? item.dates || [] : [];
    }
    return [];
}

function displayArtistDetail(artist, locations, dates) {
    const artistDetail = document.getElementById('artistDetail');
    const hue = hashToHue(artist.name);
    
    artistDetail.innerHTML = `
        <div class="artist-detail-header" style="background: linear-gradient(135deg, hsl(${hue}, 70%, 55%) 0%, hsl(${(hue + 40) % 360}, 65%, 45%) 100%);">
            <img src="${artist.image}" alt="${artist.name}" class="artist-detail-image">
            <div class="artist-detail-info">
                <h1>${artist.name}</h1>
                <p class="artist-detail-date">🎂 Date de création: ${artist.creationDate}</p>
                <p class="artist-detail-album">💿 Premier album: ${artist.firstAlbum}</p>
            </div>
        </div>

        <div class="artist-detail-content">
            <section class="artist-detail-section">
                <h2>📜 Histoire</h2>
                <div class="artist-biography">
                    <p>${generateBiography(artist, locations, dates)}</p>
                </div>
            </section>

            <section class="artist-detail-section">
                <h2>🎤 Membres</h2>
                <div class="artist-members">
                    ${artist.members.map(member => `<span class="member-tag">${member}</span>`).join('')}
                </div>
            </section>

            <section class="artist-detail-section">
                <h2>🌍 Lieux de concert (${locations.length})</h2>
                <div class="artist-locations">
                    ${locations.length > 0 
                        ? locations.map(loc => `<span class="location-tag">${loc.replace(/_/g, ' ')}</span>`).join('')
                        : '<p>Aucun lieu disponible</p>'}
                </div>
            </section>

            <section class="artist-detail-section">
                <h2>📅 Dates de concert (${dates.length})</h2>
                <div class="artist-dates">
                    ${dates.length > 0 
                        ? dates.slice(0, 12).map(date => `<span class="date-badge">${date.replace(/^\*/, '')}</span>`).join('')
                        : '<p>Aucune date disponible</p>'}
                    ${dates.length > 12 ? `<p class="more-dates">+ ${dates.length - 12} autres dates</p>` : ''}
                </div>
            </section>

            <div class="artist-detail-actions">
                <a href="/artists.html" class="btn-back">← Retour aux artistes</a>
            </div>
        </div>
    `;
}

function generateBiography(artist, locations, dates) {
    const memberCount = artist.members.length;
    const memberText = memberCount === 1 ? 'un artiste solo' : `un groupe de ${memberCount} membres`;
    const creationYear = artist.creationDate;
    const firstAlbumYear = artist.firstAlbum.split('-').pop();
    const locationCount = locations.length;
    const concertCount = dates.length;
    
    let bio = `${artist.name} est ${memberText} formé en ${creationYear}. `;
    
    if (memberCount > 1) {
        bio += `Le groupe se compose de ${artist.members.join(', ')}. `;
    }
    
    bio += `Leur premier album est sorti en ${firstAlbumYear}. `;
    
    if (concertCount > 0) {
        bio += `Avec une carrière tournée vers la scène, ${artist.name} a donné ${concertCount} concert${concertCount > 1 ? 's' : ''} `;
        
        if (locationCount > 0) {
            bio += `dans ${locationCount} lieu${locationCount > 1 ? 'x' : ''} différent${locationCount > 1 ? 's' : ''} à travers le monde, `;
            
            const countries = [...new Set(locations.map(loc => loc.split('-').pop()).filter(Boolean))];
            if (countries.length > 0) {
                const countryList = countries.slice(0, 3).map(c => c.replace(/_/g, ' ')).join(', ');
                bio += `notamment ${countryList}`;
                if (countries.length > 3) {
                    bio += ` et bien d'autres pays`;
                }
                bio += '. ';
            }
        } else {
            bio += '. ';
        }
    }
    
    bio += `${artist.name} continue de marquer la scène musicale internationale avec son style unique et ses performances énergiques.`;
    
    return bio;
}
