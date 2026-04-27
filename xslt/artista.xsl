<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format name="es" decimal-separator="," grouping-separator="."/>

    <xsl:variable name="db" select="document('../xml/bd.xml')/Discografica"/>
    <xsl:variable name="artistId" select="/vista/@artistId"/>
    <xsl:variable name="artist" select="$db/artists/artist[@id=$artistId]"/>
    <xsl:variable name="bio">
        <xsl:call-template name="getBio">
            <xsl:with-param name="id" select="$artistId"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:template name="getBio">
        <xsl:param name="id"/>
        <xsl:choose>
            <xsl:when test="$id='NF'">NF, nombre artístico de Nathan Feuerstein, es un rapero estadounidense conocido por su estilo emocional y autobiográfico. Su música mezcla hip hop con elementos cinematográficos, abordando temas como ansiedad, depresión, conflictos familiares y experiencias personales. Sus álbumes, incluidos Mansion, The Search y Clouds, han recibido elogios por su autenticidad y la capacidad de conectar con oyentes jóvenes que buscan profundidad lírica. A diferencia de otros raperos, NF evita colaboraciones frecuentes con artistas comerciales, manteniendo un enfoque introspectivo en su obra. Su sonido combina producción pulida, instrumentales intensas y una narrativa que refleja luchas internas y superación personal. Gracias a su autenticidad y consistencia, ha consolidado una base de fans leales y se ha posicionado como uno de los artistas de rap emocional más influyentes de su generación.</xsl:when>
            <xsl:when test="$id='mgk'">Colson Baker, conocido como Machine Gun Kelly, es un cantante, rapero y actor de Cleveland. Comenzó su carrera con mixtapes y ganó notoriedad tras firmar con un sello importante en 2011. Inicialmente reconocido por su estilo de rap rápido y lírico, con álbumes como Lace Up y Bloom, MGK se transformó hacia el rock emo y pop punk en trabajos como Tickets to My Downfall y Mainstream Sellout, consiguiendo su primera nominación al Grammy. También ha incursionado en cine, destacando en The Dirt y Taurus. Su música aborda experiencias personales, relaciones y emociones intensas, lo que le ha permitido conectar con una audiencia amplia y diversa. A lo largo de su carrera ha colaborado con múltiples artistas, mostrando versatilidad y capacidad de reinvención, consolidándose como uno de los referentes modernos del rock contemporáneo.</xsl:when>
            <xsl:when test="$id='bmth'">Bring Me The Horizon es una banda británica originaria de Sheffield, conocida por su evolución constante desde el deathcore hasta el rock alternativo y electrónico. Fundada en 2004, se hizo famosa con álbumes como Count Your Blessings y Sempiternal, caracterizados por riffs pesados y voces agresivas, mientras que trabajos posteriores como amo y Post Human: Survival Horror muestran un enfoque más experimental y melódico. La banda ha destacado por combinar elementos de metal, electrónica y pop, y sus letras abordan temas como ansiedad, relaciones, política y crítica social. Con una presencia escénica enérgica y una constante reinvención de su sonido, ha logrado atraer a un público diverso y mantenerse relevante en la escena del rock moderno.</xsl:when>
            <xsl:when test="$id='babymetal'">BABYMETAL es un grupo japonés que fusiona metal con J-pop, formado en 2010. Compuesto originalmente por tres integrantes jóvenes, se caracteriza por combinaciones de riffs pesados, coros pop y coreografías sincronizadas, creando un estilo único conocido como “kawaii metal”. Álbumes como BABYMETAL y Metal Galaxy han consolidado su popularidad global, llevándolos a escenarios internacionales y festivales de metal. La banda ha desafiado convenciones del género al combinar el concepto idol japonés con metal extremo, atrayendo tanto a fans del pop como del rock pesado.</xsl:when>
            <xsl:when test="$id='yungblud'">YUNGBLUD, nombre artístico de Dominic Harrison, es un cantante y compositor británico que mezcla punk, rock alternativo y pop. Su música se centra en la juventud, la rebeldía y la crítica social, abordando temas como identidad, salud mental y política, lo que lo ha convertido en un referente generacional. Desde sus primeros sencillos hasta álbumes como 21st Century Liability y Weird!, combina energía punk con melodías pegajosas y letras comprometidas.</xsl:when>
            <xsl:when test="$id='limpbizkit'">Limp Bizkit es una banda estadounidense de nu metal formada en 1994 en Jacksonville, Florida. Su estilo combina rap, rock y metal, caracterizado por riffs pesados, vocales agresivas y ritmos de hip hop. Alcanzaron fama mundial con álbumes como Significant Other (1999) y Chocolate Starfish and the Hot Dog Flavored Water (2000), impulsados por sencillos como “Nookie” y “Break Stuff”. La banda fue un referente clave del nu metal a finales de los 90 y principios de los 2000.</xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$artist/description"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="resolveImageSrc">
        <xsl:param name="primary"/>
        <xsl:param name="secondary"/>
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
                <title>
                    <xsl:value-of select="$artist/grupo"/>
                </title>
            </head>
            <body>
                <div class="nav-box">
                    <div class="logo">
                        Discografica: <xsl:value-of select="$artist/grupo"/>
                    </div>
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
                    <div class="bloque-artista-unico">
                        <div class="distribucion-artista">
                            <div class="info-principal-artista">
                                <div class="info-artista">
                                    <xsl:attribute name="style">
                                        <xsl:text>background-image:url('</xsl:text>
                                        <xsl:call-template name="toAssetPath">
                                            <xsl:with-param name="path" select="$artist/image"/>
                                        </xsl:call-template>
                                        <xsl:text>')</xsl:text>
                                    </xsl:attribute>
                                    <div class="capa-artista">
                                        <h1>
                                            <xsl:value-of select="$artist/grupo"/>
                                        </h1>
                                        <p>Reproducciones: <xsl:value-of select="format-number(number($artist/reproducciones), '#.##0', 'es')"/>
                                        </p>
                                    </div>
                                </div>

                                <div class="biografia-artista">
                                    <h2>BiografÃ­a</h2>
                                    <p>
                                        <xsl:value-of select="$bio"/>
                                    </p>
                                </div>

                                <div class="seccion-artista">
                                    <h2>Albumes</h2>
                                    <div class="albums-grid">
                                        <xsl:for-each select="$db/albums/album[artistId=$artistId]">
                                            <xsl:sort select="year" data-type="number" order="descending"/>
                                            <div class="item media-item">
                                                <img class="cover-photo" alt="Portada del album">
                                                    <xsl:attribute name="src">
                                                        <xsl:call-template name="toAssetPath">
                                                            <xsl:with-param name="path" select="image"/>
                                                        </xsl:call-template>
                                                    </xsl:attribute>
                                                </img>
                                                <div>
                                                    <strong class="truncate-title">
                                                        <xsl:value-of select="title"/>
                                                    </strong>
                                                    <br/>
                                                    AÃ±o: <xsl:value-of select="year"/>
                                                </div>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </div>
                            </div>

                            <div class="top-canciones-derecha">
                                <h2>Top Canciones</h2>
                                <div class="songs-grid">
                                    <xsl:for-each select="$artist/topSongs/song">
                                        <xsl:variable name="songId" select="."/>
                                        <xsl:variable name="songData" select="$db/songs/song[@id=$songId][1]"/>
                                        <xsl:variable name="albumData" select="$db/albums/album[@id=$songData/albumId][1]"/>
                                        <div class="item media-item">
                                            <img class="cover-photo" alt="Portada de la cancion">
                                                <xsl:attribute name="src">
                                                    <xsl:call-template name="resolveImageSrc">
                                                        <xsl:with-param name="primary" select="$songData/image"/>
                                                        <xsl:with-param name="secondary" select="$albumData/image"/>
                                                        <xsl:with-param name="default" select="'../assets/imgWeb/default.jpg'"/>
                                                    </xsl:call-template>
                                                </xsl:attribute>
                                            </img>
                                            <div>
                                                <strong class="truncate-title">
                                                    <xsl:choose>
                                                        <xsl:when test="normalize-space($songData/title)">
                                                            <xsl:value-of select="$songData/title"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="."/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </strong>
                                                <br/>
                                                <xsl:if test="$songData/reproducciones">
                                                    Reproducciones: <xsl:value-of select="format-number(number($songData/reproducciones), '#.##0', 'es')"/>
                                                </xsl:if>
                                            </div>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
