// Inicializa el menú móvil y el control de audio cuando el DOM está listo.
document.addEventListener("DOMContentLoaded", () => {
    // Botón hamburguesa y contenedor del menú.
    const toggleButton = document.querySelector(".nav-toggle");
    const navBox = document.querySelector(".nav-box");

    // Alterna la visibilidad del menú móvil y actualiza aria-expanded.
    if (toggleButton && navBox) {
        toggleButton.addEventListener("click", () => {
            const isOpen = navBox.classList.toggle("is-open");
            toggleButton.setAttribute("aria-expanded", String(isOpen));
        });
    }

    // Evita que suenen varios audios a la vez.
    const players = document.querySelectorAll("audio");
    players.forEach((player) => {
        player.addEventListener("play", () => {
            players.forEach((other) => {
                if (other !== player && !other.paused) {
                    other.pause();
                }
            });
        });
    });
});
