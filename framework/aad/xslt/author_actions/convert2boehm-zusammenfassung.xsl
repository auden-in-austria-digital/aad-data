<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:legalkraus="http://legalkraus.acdh.oeaw.ac.at" exclude-result-prefixes="xs" version="2.0">

  

 

<!-- Alles kopieren -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>


    <!-- Konvertieren -->
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:p">
            <xsl:element name="note">
                <xsl:attribute name="resp">
                    <xsl:text>#boehm</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="rend">
                    <xsl:text>italic</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="type">
                    <xsl:text>zusammenfassung</xsl:text>
                </xsl:attribute>
                <xsl:element name="p">
                    <xsl:attribute name="xml:space">
                        <xsl:value-of select="'preserve'"/>
                    </xsl:attribute>
                    <xsl:copy-of select="./node()"/>
                </xsl:element>    
            </xsl:element>
            
        
    </xsl:template>
    
</xsl:stylesheet>
