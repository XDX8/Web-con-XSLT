function actualizarHora() {
    const ahora = new Date();
    const hora = ahora.toLocaleTimeString("es-ES", { hour12: false });
    const nodoHora = document.getElementById("hora-actual");

    if (nodoHora) {
        nodoHora.textContent = hora;
    }
}

actualizarHora();
setInterval(actualizarHora, 1000);
