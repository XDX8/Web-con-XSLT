<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>

    <xsl:variable name="db" select="document('../xml/bd.xml')/Discografica"/>

    <xsl:key name="artistById" match="artists/artist" use="@id"/>

    <xsl:template name="resolveImageSrc">
        <xsl:param name="primary"/>
        <xsl:param name="secondary"/>
        <xsl:choose>
            <xsl:when test="normalize-space($primary)">
                <xsl:call-template name="toAssetPath">
                    <xsl:with-param name="path" select="$primary"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="normalize-space($secondary)">
                <xsl:call-template name="toAssetPath">
                    <xsl:with-param name="path" select="$secondary"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!--Combertir rutas en un formto "cosciente"-->
    <xsl:template name="toAssetPath">
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="not(normalize-space($path))"/>
            <xsl:when test="starts-with($path, '../') or starts-with($path, 'http://') or starts-with($path, 'https://')">
                <xsl:value-of select="$path"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('../', $path)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="../css/styles.css" />
                <link rel="icon" type="image/png" href="../assets/ico.png" />
                <script src="../js/nav.js" defer="defer"></script>
                <title>Discografica</title>
            </head>
            <body>
                <div class="nav-box">
                    <div class="logo">Discografica</div>
                    <button class="nav-toggle" type="button" aria-label="Abrir menu" aria-expanded="false">☰</button>
                    <ul class="nav-links">
                        <li>
                            <a href="../index.html">Home</a>
                        </li>
                        <li>
                            <a href="../xml/Canciones.xml">Canciones</a>
                        </li>
                        <li>
                            <a href="../xml/Albunes.xml">Albumes</a>
                        </li>
                        <li>
                            <a href="../xml/bd.xml">Artistas</a>
                        </li>
                    </ul>
                </div>
                <div class="principal">
                    <div class="columna-izquierda">
                        <div class="albums-grid">
                            <xsl:for-each select="$db/albums/album">
                                <xsl:sort select="year" data-type="number" order="descending"/>
                                <div class="item media-item">
                                    <img class="cover-photo" alt="Portada del album">
                                        <xsl:attribute name="src">
                                            <xsl:call-template name="resolveImageSrc">
                                                <xsl:with-param name="primary" select="image"/>
                                                <xsl:with-param name="secondary" select="concat('assets/imgWeb/', @id, '.jpg')"/>
                                            </xsl:call-template>
                                        </xsl:attribute>
                                    </img>
                                    <div>
                                        <strong class="truncate-title">
                                            <xsl:value-of select="title"/>
                                        </strong>
                                        <br/>
                                         Artista: <xsl:value-of select="key('artistById', artistId)/grupo"/>
                                    <br/>
                                    Año: <xsl:value-of select="year"/>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
