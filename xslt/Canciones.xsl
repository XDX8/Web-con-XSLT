<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format name="es" decimal-separator="," grouping-separator="."/>

    <xsl:variable name="db" select="document('../xml/bd.xml')/Discografica"/>

    <xsl:key name="artistById" match="artists/artist" use="@id"/>
    <xsl:key name="albumById" match="albums/album" use="@id"/>

    <xsl:template name="resolveImageSrc">
        <xsl:param name="primary"/>
        <xsl:param name="secondary"/>
        <xsl:param name="tertiary"/>
        <xsl:param name="default"/>
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
            <xsl:when test="normalize-space($tertiary)">
                <xsl:call-template name="toAssetPath">
                    <xsl:with-param name="path" select="$tertiary"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="toAssetPath">
                    <xsl:with-param name="path" select="$default"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

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
                        <div class="songs-grid">
                            <xsl:for-each select="$db/songs/song">
                                <xsl:sort select="reproducciones" data-type="number" order="descending"/>
                                <xsl:if test="position() &lt;= 60">
                                    <xsl:variable name="albumData" select="key('albumById', albumId)"/>
                                    <div class="item media-item">
                                        <img class="cover-photo" alt="Portada del album">
                                            <xsl:attribute name="src">
                                                <xsl:call-template name="resolveImageSrc">
                                                    <xsl:with-param name="primary" select="image"/>
                                                    <xsl:with-param name="secondary" select="$albumData/image"/>
                                                    <xsl:with-param name="tertiary">
                                                        <xsl:if test="normalize-space(albumId)">
                                                            <xsl:value-of select="concat('assets/imgWeb/', albumId, '.jpg')"/>
                                                        </xsl:if>
                                                    </xsl:with-param>
                                                    <xsl:with-param name="default" select="'assets/imgWeb/default.jpg'"/>
                                                </xsl:call-template>
                                            </xsl:attribute>
                                        </img>
                                        <div>
                                            <strong class="truncate-title">
                                                <xsl:value-of select="position()"/>
                                                <xsl:text>. </xsl:text>
                                                <xsl:value-of select="title"/>
                                            </strong>
                                            <br/>
                                            Artista: <xsl:value-of select="key('artistById', artistId)/grupo"/>
                                        <br/>
                                         Reproducciones: <xsl:value-of select="format-number(number(reproducciones), '#.##0', 'es')"/>
                                            <xsl:if test="normalize-space(reproducir)">
                                                <audio class="song-player" controls="controls" preload="none">
                                                    <xsl:attribute name="src">
                                                        <xsl:call-template name="toAssetPath">
                                                            <xsl:with-param name="path" select="reproducir"/>
                                                        </xsl:call-template>
                                                    </xsl:attribute>
                                                </audio>
                                            </xsl:if>
                                    </div>
                                </div>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
