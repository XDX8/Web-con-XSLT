document.addEventListener("DOMContentLoaded", () => {
    const toggleButton = document.querySelector(".nav-toggle");
    const navBox = document.querySelector(".nav-box");

    if (toggleButton && navBox) {
        toggleButton.addEventListener("click", () => {
            const isOpen = navBox.classList.toggle("is-open");
            toggleButton.setAttribute("aria-expanded", String(isOpen));
        });
    }

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
