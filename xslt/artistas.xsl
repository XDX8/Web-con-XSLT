<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format name="es" decimal-separator="," grouping-separator="."/>

    <xsl:key name="artistById" match="artists/artist" use="@id"/>
    <xsl:key name="albumById" match="albums/album" use="@id"/>

    <xsl:template name="resolveImageSrc">
        <xsl:param name="primary"/>
        <xsl:param name="secondary"/>
        <xsl:param name="tertiary"/>
        <xsl:param name="default"/>
        <xsl:choose>
            <xsl:when test="normalize-space($primary)">
                <xsl:value-of select="$primary"/>
            </xsl:when>
            <xsl:when test="normalize-space($secondary)">
                <xsl:value-of select="$secondary"/>
            </xsl:when>
            <xsl:when test="normalize-space($tertiary)">
                <xsl:value-of select="$tertiary"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$default"/>
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
                            <a href="Canciones.xml">Canciones</a>
                        </li>
                        <li>
                            <a href="Albunes.xml">Álbumes</a>
                        </li>
                        <li>
                            <a href="bd.xml">Artistas</a>
                        </li>
                    </ul>
                </div>
                <div class="principal">
                    <div class="columna-izquierda">
                        <xsl:for-each select="Discografica/artists/artist">
                            <xsl:sort select="reproducciones" data-type="number" order="descending"/>
                            <xsl:if test="position() &lt;= 6">
                                <div class="item artist-item">
                                    <img class="artist-photo">
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="concat('../', image)"/>
                                        </xsl:attribute>
                                    </img>
                                    <div>
                                        <strong>
                                            <xsl:value-of select="position()"/>
                                                <xsl:text>. </xsl:text>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="concat(@id, '.xml')"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="grupo"/>
                                            </a>
                                        </strong>
                                        <br/>
                                        Reproducciones: <xsl:value-of select="format-number(number(reproducciones), '#.##0', 'es')"/>
                                    </div>
                                </div>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>