let datesEntries = [];
let currentPage = 1;
const itemsPerPage = 12;

document.addEventListener('DOMContentLoaded', () => {
    loadDates();
    setupPagination();
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

    const datesIndex = normalizeDatesIndex(datesData);

    if (!datesIndex || Object.keys(datesIndex).length === 0) {
        datesList.innerHTML = '<p>Aucune date trouvée</p>';
        return;
    }

    datesEntries = Object.keys(datesIndex)
        .map(key => ({ id: key, dates: datesIndex[key] }))
        .filter(entry => Array.isArray(entry.dates) && entry.dates.length > 0)
        .sort((a, b) => Number(a.id) - Number(b.id));

    currentPage = 1;
    renderDatesPage();
}

function normalizeDatesIndex(data) {
    if (!data) return {};

    if (Array.isArray(data.index)) {
        const index = {};
        data.index.forEach(item => {
            if (!item || typeof item.id === 'undefined') return;
            index[item.id] = Array.isArray(item.dates) ? item.dates : [];
        });
        return index;
    }

    if (data.index && typeof data.index === 'object') {
        return data.index;
    }

    if (typeof data === 'object') {
        return data;
    }

    return {};
}

function formatDateLabel(value) {
    return String(value || '').replace(/^\*/, '').trim();
}

function renderDateItem(item, dates) {
    item.innerHTML = `
        <div class="date-list">
            ${dates.map(date => `<span class="date-tag">${formatDateLabel(date)}</span>`).join('')}
        </div>
    `;
}

function renderDatesPage() {
    const datesList = document.getElementById('datesList');
    const pageInfo = document.getElementById('pageInfo');
    const prevPage = document.getElementById('prevPage');
    const nextPage = document.getElementById('nextPage');

    datesList.innerHTML = '';

    const totalPages = Math.max(Math.ceil(datesEntries.length / itemsPerPage), 1);
    currentPage = Math.min(Math.max(currentPage, 1), totalPages);

    const start = (currentPage - 1) * itemsPerPage;
    const pageItems = datesEntries.slice(start, start + itemsPerPage);

    pageItems.forEach(entry => {
        const item = document.createElement('div');
        item.className = 'date-item';
        renderDateItem(item, entry.dates);
        datesList.appendChild(item);
    });

    pageInfo.textContent = `Page ${currentPage} / ${totalPages}`;
    prevPage.disabled = currentPage <= 1;
    nextPage.disabled = currentPage >= totalPages;
}

function setupPagination() {
    const prevPage = document.getElementById('prevPage');
    const nextPage = document.getElementById('nextPage');

    prevPage.addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage -= 1;
            renderDatesPage();
        }
    });

    nextPage.addEventListener('click', () => {
        const totalPages = Math.max(Math.ceil(datesEntries.length / itemsPerPage), 1);
        if (currentPage < totalPages) {
            currentPage += 1;
            renderDatesPage();
        }
    });
}
