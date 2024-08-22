<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="path-to-object-list-tsv">file:/home/dschopper/data/R_Kraus-Samek_11789/001_src/Kraus-Online-objects.tsv</xsl:param>
    <xsl:template match="/">
        <xsl:variable name="objects" as="element(object)+">
            <xsl:for-each select="tokenize(unparsed-text($path-to-object-list-tsv),'&#10;')[position() gt 1]">
                <xsl:variable name="props">
                    <xsl:for-each select="tokenize(.,'&#9;')">
                        <xsl:variable name="name">
                            <xsl:choose>
                                <xsl:when test="position() eq 1">ID</xsl:when>
                                <xsl:when test="position() eq 2">Titel</xsl:when>
                                <xsl:when test="position() eq 3">Signatur</xsl:when>
                                <xsl:when test="position() eq 4">Hauptnummer</xsl:when>
                                <xsl:when test="position() eq 5">Nebennummer</xsl:when>
                                <xsl:when test="position() eq 6">Datum</xsl:when>
                                <xsl:when test="position() eq 7">AnzahlSeiten</xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:element name="{$name}">
                            <xsl:value-of select="replace(.,'&#xD;','')"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:variable>
                <object>
                    <xsl:if test="$props/Hauptnummer != '' and $props/Nebennummer != ''">
                        <xsl:attribute name="n" select="concat($props/Hauptnummer,'.',$props/Nebennummer)"/>
                    </xsl:if>
                    <xsl:sequence select="$props"/>
                </object>
            </xsl:for-each>
        </xsl:variable>
        <objects xmlns="">
            <xsl:for-each select="$objects">
                <xsl:sort select="@n" order="descending"/>
                <xsl:sequence select="."/>
            </xsl:for-each>
        </objects>
    </xsl:template>
</xsl:stylesheet>