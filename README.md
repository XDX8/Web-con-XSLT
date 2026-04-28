# Documentación — Web con XML + XSLT

Este proyecto consiste en una web generada dinámicamente a partir de datos XML usando hojas de transformación XSLT.
La idea principal es separar **contenido (XML)** de **presentación (XSL)**, permitiendo generar HTML en el navegador.

---

##  Concepto general

* **XML (`bd.xml`)** → almacena todos los datos
* **XSLT** → transforma esos datos en HTML
* **CSS** → aplica estilos visuales

El navegador procesa el XML junto con la XSL y genera la página final automáticamente.

---

##  Estructura de datos (XML)

El archivo principal `bd.xml` actúa como base de datos:

```
    Discografica
    ├── artists
    │   └── artist (id)
    │       ├── grupo
    │       ├── image
    │       ├── reproducciones
    │       └── topSongs
    │           └── song (id)
    ├── albums
    │   └── album (id)
    │       ├── title
    │       ├── image
    │       └── year
    └── songs
        └── song (id)
            ├── title
            ├── genre
            ├── year
            └── reproducciones
```

---

## 🎤 Artistas

Cada artista contiene:

* **ID único** → clave para relacionar datos
* **Imagen** → ruta local
* **Nombre del grupo/artista**
* **Número de reproducciones** (formateado)
* **Top 5 canciones** (referencias por ID)

Esto permite reutilizar información sin duplicarla.

---

## Álbumes

Cada álbum está vinculado a un artista mediante su `id`:

* **Título**
* **Imagen**
* **Año de lanzamiento**

---

## Canciones

Las canciones contienen la información completa:

* **Título**
* **Género**
* **Año**
* **Reproducciones**
* **Imagen opcional** (para singles o EPs)

---

## Arquitectura de la web

### Archivos principales

* `bd.xml` → base de datos
* `xslt/*.xsl` → vistas
* `xml/*.xml` → XML puente
* `css/styles.css` → estilos

---

## Flujo de funcionamiento

```
XML → XSLT → HTML → CSS
```

1. Se abre un XML en el navegador
2. Este referencia una hoja XSL (`xml-stylesheet`)
3. La XSL transforma los datos a HTML
4. El HTML carga el CSS

---

## XML puente

No se puede abrir directamente un XSL en el navegador, por eso se usan XML intermedios:

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="xslt/artista.xsl"?>
<vista artistId="1"/>
```

Este XML:

* Activa la transformación XSL
* Pasa parámetros (como `artistId`)

---

## XSLT — Lógica de transformación

### 1. Inicialización

```xml
<xsl:output method="html"/>
```

Define que la salida será HTML.

---

### 2. Formato de datos

* Números grandes → `10.000.000`
* Uso de `format-number()`
* Variables para IDs reutilizables

---

### 3. Plantilla de imágenes

Sistema condicional:

```
primary → secondary → fallback
```

Funciona como:

* Si hay imagen de álbum → usarla
* Si no → usar imagen de canción

---

### 4. Listado de artistas

```xml
<xsl:for-each select="...">
<xsl:sort select="reproducciones" order="descending"/>
```

* Orden descendente por reproducciones
* Limitación de resultados:

```xml
position() < 6
```

---

### 5. Enlaces dinámicos

```
{id}.xml
```

Ventaja:

* Escalable automáticamente
* Funciona igual con pocos o muchos artistas

---

## XSL único para todos los artistas

Todos los XML usan:

```
xslt/artista.xsl
```

### Diferencia

Solo cambia:

```xml
/vista/@artistId
```

---

### Funcionamiento

El XSL:

1. Lee el ID del artista
2. Busca en `bd.xml`
3. Genera la vista completa:

   * Cabecera
   * Biografía
   * Álbumes
   * Top canciones

---

### Ventajas

* Menos duplicación de código
* Más fácil mantenimiento
* Mayor escalabilidad

---

## Reproducción de canciones

Se añade audio solo si existe:

```xml
<xsl:if test="normalize-space(reproducir)">
```

```html
<audio controls preload="none" class="song-player">
```

### Características

* Solo aparece si hay archivo
* Ruta generada dinámicamente
* No precarga el audio (optimización)

---

## Conclusión

Este proyecto demuestra cómo construir una web completa usando XML + XSLT:

### Puntos clave

* Separación entre datos y presentación
* Generación dinámica sin backend
* Escalabilidad basada en IDs
* Código reutilizable con XSL único
