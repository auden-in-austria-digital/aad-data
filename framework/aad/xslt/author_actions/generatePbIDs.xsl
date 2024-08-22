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


    <!-- pb mit IDs versehen -->
    <!-- Muster: D_000002-002-000_p-001 -->
    
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:pb">
            <xsl:element name="pb">
                <xsl:attribute name="xml:id">
                    <xsl:variable name="docID" select="substring-before(./ancestor::tei:TEI/@xml:id/string(), '.xml')"/>
                    <xsl:variable name="pbNo" select="format-number(count(preceding::tei:pb[ancestor::tei:body]) + 1,'000')"/>
                    <xsl:value-of select="concat($docID,'_p',$pbNo)"/>
                </xsl:attribute>
                <xsl:for-each select="@*[name() != 'xml:id']">
                    <xsl:copy/>
                </xsl:for-each>
                <xsl:apply-templates/>
            </xsl:element>
    </xsl:template>
    
        
    
</xsl:stylesheet>
