// Pinta la hora actual en la interfaz.
function actualizarHora() {
    const ahora = new Date();
    const hora = ahora.toLocaleTimeString("es-ES", { hour12: false });
    const nodoHora = document.getElementById("hora-actual");

    // Solo actualiza si existe el elemento destino.
    if (nodoHora) {
        nodoHora.textContent = hora;
    }
}

// Actualiza al cargar y después cada segundo.
actualizarHora();
setInterval(actualizarHora, 1000);
