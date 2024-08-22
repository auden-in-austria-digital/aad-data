<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    extension-element-prefixes="saxon"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:ko="https://www.kraus.wienbibliothek.at/"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:param name="vol"/>
    <!-- At which page does the text body start? -->
    <xsl:param name="startBodyAtPage" as="xs:integer"/>
    <xsl:param name="base-path" as="xs:string"/>
    <xsl:param name="path-to-single-pages" select="concat($base-path,'/102_derived_tei/102_01_single-pages/',$vol,'/')"/>
    <xsl:param name="path-to-items" select="concat($base-path,'/102_derived_tei/102_02_items/',$vol,'/')"/>
    <xsl:strip-space elements="tei:div tei:head"/>
    <xsl:output indent="yes" saxon:suppress-indentation="head include" saxon:line-length="10000"/>
    <xsl:template name="pubStmt">
        <xsl:param name="inject" as="element()*"/>
        <publicationStmt>
            <publisher>Austrian Centre for Digital Humanities, Austrian Academy of Sciences</publisher>
            <address>
                <addrLine>Sonnenfelsgasse 19</addrLine>
                <addrLine>1010 Vienna</addrLine>
            </address>
            <pubPlace>Vienna</pubPlace>
            <date when="2020">2020</date>
            <availability>
                <licence target="http://creativecommons.org/licenses/by/4.0/">CC BY 4.0</licence>
            </availability>
            <xsl:sequence select="$inject"></xsl:sequence>
        </publicationStmt>
    </xsl:template>
    <xsl:template match="/" exclude-result-prefixes="#all">
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title type="main">Karl Kraus contra ...</title>
                        <title type="main">Die Prozeßakten der Kanzlei Oskar Samek in der Wiener Stadt- und Landesbibliothek</title>
                        <title type="volume">Band I, 1922-1927</title>
                        <title type="sub">Digitaler Volltext</title>
                        <respStmt>
                            <resp>Bearbeitet und kommentiert von</resp>
                            <persName>Hermann Böhm</persName>
                        </respStmt>
                        <respStmt>
                            <resp>Konvertierung nach TEI</resp>
                            <persName xml:id="ds">Daniel Schopper</persName>
                        </respStmt>
                        <respStmt>
                            <resp>Manuelle Nachbearbeitung</resp>
                            <persName></persName>
                        </respStmt>
                        <principal>
                            <persName>Katharina Prager</persName>
                        </principal>
                    </titleStmt>
                    <xsl:call-template name="pubStmt"/>
                    <sourceDesc>
                        <biblStruct>
                            <monogr>
                            <title level="m" type="main">Karl Kraus contra ...</title>
                            <title level="m" type="sub">Die Prozeßakten der Kanzlei Oskar Samek in der Wiener Stadt- und Landesbibliothek</title>
                            <respStmt>
                                <resp>Bearbeitet und kommentiert von</resp>
                                <persName>Hermann Böhm</persName>
                            </respStmt>
                            <imprint>
                                <biblScope unit="volume"><xsl:value-of select="replace($vol,'Vol','')"/></biblScope>
                                <publisher>
                                    <orgName>Stadt Wien, Magistratsabteilung 9 - Wiener Stadt- und Landesbibliothek</orgName>
                                </publisher>
                                <pubPlace>
                                    <placeName>Wien</placeName>
                                </pubPlace>
                                <date>1995</date>
                            </imprint>
                            </monogr>
                        </biblStruct>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <xsl:variable name="front-pages" as="item()*">
                    <xsl:for-each select="collection($path-to-single-pages)//tei:div[xs:integer(replace(@n,'\.jpg','')) lt $startBodyAtPage]">
                        <xsl:sort select="@n"/>
                        <xsl:sequence select="."/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:variable name="body-pages" as="document-node()">
                    <xsl:document>
                        <xsl:for-each select="collection($path-to-single-pages)//tei:div[xs:integer(replace(@n,'\.jpg','')) ge $startBodyAtPage]">
                            <xsl:sort select="@n"/>
                            <xsl:sequence select="."/>
                        </xsl:for-each>
                    </xsl:document>
                </xsl:variable>
                <front>
                    <xsl:apply-templates select="$front-pages"/>
                </front>
                <body>
                    <xsl:for-each-group select="$body-pages/tei:div[@type = 'page']/*" group-starting-with="self::tei:head[@level = '1']">
                        <xsl:choose>
                            <xsl:when test="current-group()[1]/self::tei:head[@level = '1']">
                                <xsl:variable name="head" select="current-group()[1]/self::tei:head[@level = '1']/(if (contains(.,'(')) then substring-before(.,'(') else .)"/>
                                <xsl:variable name="n" select="normalize-space(replace($head,'^(\d+)\s.+','$1'))"/>
                                <xsl:variable name="title" select="normalize-space(substring-after($head,$n))"/>
                                <div n="{$n} - {$title}">
                                    <xsl:for-each-group select="current-group()" group-starting-with="tei:head[@level = '2']">
                                        <xsl:choose>
                                            <xsl:when test="current-group()[1]/self::tei:head[@level = '2']">
                                                <xsl:variable name="head" select="current-group()[1]/self::tei:head[@level = '2']/(if (contains(.,'(')) then substring-before(.,'(') else .)"/>
                                                <xsl:variable name="n" select="@n"/>
                                                <xsl:variable name="title">
                                                    <xsl:choose>
                                                        <xsl:when test="normalize-space(substring-after($head,$n)) != ''">
                                                            <xsl:value-of select="normalize-space(substring-after($head,$n))"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:apply-templates select="$head"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <!--<xsl:variable name="filename" select="concat($n,'_',replace($title,'\P{L}',''),'.xml')"/>-->
                                                <xsl:variable name="filename" select="concat($n,'_',substring(replace($title,'\P{L}',''),1,20),'.xml')"/>
                                                <xsl:variable name="filepath" select="concat('../102_derived_tei/102_02_items/',$vol,'/',$filename)"/>
                                                <xsl:variable name="id" select="concat('i',$n)"/>
                                                <xsl:variable name="content" as="element(tei:div)">
                                                    <div n="{$n}" xml:id="{$id}" ana="{for $t in tokenize(@ko:ids,' ') return concat('ko:',$t)}">
                                                        <xsl:apply-templates select="current-group()"/>
                                                    </div>
                                                </xsl:variable>
                                                <xsl:if test="contains($n,'\P{N}')">
                                                    <xsl:message terminate="yes">Ill-formed n "<xsl:value-of select="$n"/>"</xsl:message>
                                                </xsl:if>
                                                <xsl:variable name="path-to-item" select="concat($path-to-items,'/',$filename)"/>
                                                <xsl:choose>
                                                    <xsl:when test="doc-available($path-to-item) and count(doc($path-to-item)//tei:change) gt 1">
                                                        <xsl:message>Einzeldokument '<xsl:value-of select="$filename"/>' ist manuell bearbeitet worden und wird daher *nicht* neu generiert.</xsl:message>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:result-document href="{$filename}" exclude-result-prefixes="#all" method="xml" saxon:suppress-indentation="tei:head">
                                                            <TEI>
                                                                <teiHeader>
                                                                    <fileDesc>
                                                                        <titleStmt>
                                                                            <title type="edition"><xsl:value-of select="normalize-space($title)"/></title>
                                                                            <xsl:for-each select="tokenize(@ko:titles,' / ')">
                                                                                <title type="kraus-online"><xsl:value-of select="."/></title>
                                                                            </xsl:for-each>
                                                                        </titleStmt>
                                                                        <xsl:call-template name="pubStmt">
                                                                            <xsl:with-param name="inject" as="element()*">
                                                                                <xsl:for-each select="tokenize(@ko:ids, ' ')">
                                                                                    <idno type="kraus-online"><xsl:value-of select="."/></idno>
                                                                                </xsl:for-each>
                                                                            </xsl:with-param>
                                                                        </xsl:call-template>
                                                                        <sourceDesc>
                                                                            <p>Extracted from the print edition, <xsl:value-of select="preceding::tei:pb[1]/@n"/></p>
                                                                        </sourceDesc>
                                                                    </fileDesc>
                                                                    <revisionDesc>
                                                                        <change n="generated" status="draft" who="#ds" when="{current-date()}"/>
                                                                    </revisionDesc>
                                                                </teiHeader>
                                                                <text>
                                                                    <body>
                                                                        <xsl:apply-templates select="$content"/>
<!--                                                                        <xsl:sequence select="$content"/>-->
                                                                    </body>
                                                                </text>
                                                            </TEI>
                                                        </xsl:result-document>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude" xml:space="default">
                                                    <xsl:attribute name="href" select="$filename"/>
                                                    <xsl:attribute name="xpointer" select="$id"/>
                                                </xsl:element>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:apply-templates select="current-group()"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each-group>
                                </div>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="current-group()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each-group>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template match="tei:head[@level or @n]">
        <xsl:copy copy-namespaces="no" xml:space="default">
            <xsl:copy-of select="@* except (@level|@n)"/>
            <xsl:apply-templates select="node()"/>
            <xsl:if test="matches(normalize-space(.),'^\d+\.\d+$')">
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="following-sibling::*[1]/node()"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:div[@type = 'page']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="node() | @*" exclude-result-prefixes="#all">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@ko:*" priority="1"/>
    
    <!--This has been copied into the head element-->
    <xsl:template match="tei:*[preceding-sibling::*[1][self::tei:head[@level or @n][matches(normalize-space(.),'^\d+\.\d$')]]]" priority="1"/>
    
    <xsl:template match="tei:pb/@n">
        <xsl:attribute name="facs" select="."/>
    </xsl:template>
    
</xsl:stylesheet>