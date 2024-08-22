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


    <!-- head in head durch head und p ersetzen -->
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:head[tei:head]">
            <xsl:element name="head">
                <xsl:for-each select="@*">
                    <xsl:copy/>
                </xsl:for-each>
                <xsl:copy-of select="./tei:head/node()"/>
            </xsl:element>
            <xsl:element name="p">
                <xsl:attribute name="xml:space">
                    <xsl:value-of select="'preserve'"/>
                </xsl:attribute>
                <xsl:copy-of select="./node()[./name()!='head']"/>
            </xsl:element>
        
    </xsl:template>
    
</xsl:stylesheet>
