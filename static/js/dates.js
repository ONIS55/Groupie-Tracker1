document.addEventListener('DOMContentLoaded', () => {
    loadDates();
});

function loadDates() {
    const loading = document.getElementById('loading');
    const error = document.getElementById('error');
    const datesList = document.getElementById('datesList');

    loading.style.display = 'block';
    error.style.display = 'none';
    datesList.innerHTML = '';

    fetch('/api/dates')
        .then(response => {
            if (!response.ok) throw new Error('Erreur réseau');
            return response.json();
        })
        .then(data => {
            displayDates(data);
            loading.style.display = 'none';
        })
        .catch(err => {
            console.error('Erreur:', err);
            error.textContent = 'Erreur lors du chargement des dates';
            error.style.display = 'block';
            loading.style.display = 'none';
        });
}

function displayDates(datesData) {
    const datesList = document.getElementById('datesList');
    datesList.innerHTML = '';

    if (!datesData || Object.keys(datesData).length === 0) {
        datesList.innerHTML = '<p>Aucune date trouvée</p>';
        return;
    }

    Object.keys(datesData).forEach(artistId => {
        const dates = datesData[artistId];
        if (Array.isArray(dates) && dates.length > 0) {
            const item = document.createElement('div');
            item.className = 'date-item';
            item.innerHTML = `
                <h3>Artiste ID: ${artistId}</h3>
                <div class="date-list">
                    ${dates.map(date => `<div class="date-tag">${date}</div>`).join('')}
                </div>
            `;
            datesList.appendChild(item);
        }
    });
}
