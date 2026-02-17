document.addEventListener("DOMContentLoaded", () => {
    const container = document.getElementById("cityImages");
    const loading = document.getElementById("loading");
    const error = document.getElementById("error");

    const cityImages = {
        "paris": "/images/cities/paris.jpg",
        "london": "/images/cities/london.jpg",
        "new york": "/images/cities/newyork.jpg",
        "tokyo": "/images/cities/tokyo.jpg",
        "berlin": "/images/cities/berlin.jpg"
    };

    fetch("https://groupietrackers.herokuapp.com/api/locations")
        .then(response => {
            if (!response.ok) {
                throw new Error("Erreur lors du chargement des données");
            }
            return response.json();
        })
        .then(data => {
            loading.style.display = "none";

            data.forEach(artist => {
                artist.locations.forEach(location => {
                    const city = location.split("-")[0].replace("_", " ").toLowerCase();
                    const imageSrc = cityImages[city] || "/images/cities/default.jpg";

                    const card = document.createElement("div");
                    card.className = "city-card";

                    card.innerHTML = `
                        <img src="${imageSrc}" alt="${city}">
                        <h3>${city.toUpperCase()}</h3>
                    `;

                    container.appendChild(card);
                });
            });
        })
        .catch(err => {
            loading.style.display = "none";
            error.textContent = err.message;
        });
});
