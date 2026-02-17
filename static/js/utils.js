// Fonctions utilitaires partagées

/**
 * Génère une teinte (hue) unique basée sur le hash d'une chaîne
 * @param {string} value - La chaîne à hasher
 * @returns {number} Une valeur entre 0 et 360 pour la teinte HSL
 */
function hashToHue(value) {
    const text = String(value || '');
    let hash = 0;
    for (let i = 0; i < text.length; i += 1) {
        hash = (hash << 5) - hash + text.charCodeAt(i);
        hash |= 0;
    }
    return Math.abs(hash) % 360;
}

/**
 * Normalise une chaîne pour la recherche (minuscules, trim, remplace _)
 * @param {string} value - La chaîne à normaliser
 * @returns {string} La chaîne normalisée
 */
function normalize(value) {
    return String(value || '')
        .toLowerCase()
        .trim()
        .replace(/_/g, ' ');
}

/**
 * Valide et parse un ID numérique
 * @param {string|number} id - L'ID à valider
 * @returns {number|null} L'ID parsé ou null si invalide
 */
function parseId(id) {
    const parsed = parseInt(id, 10);
    if (isNaN(parsed) || parsed < 1) {
        return null;
    }
    return parsed;
}

/**
 * Formate une date en supprimant l'astérisque initial si présent
 * @param {string} value - La date à formater
 * @returns {string} La date formatée
 */
function formatDateLabel(value) {
    return String(value || '').replace(/^\*/, '').trim();
}
