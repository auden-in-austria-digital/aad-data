<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:legalkraus="http://legalkraus.acdh.oeaw.ac.at" exclude-result-prefixes="xs" version="2.0"
    xmlns:uuid="java:java.util.UUID">
    
    
    
    
    
    <!-- Alles kopieren -->
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- stamp mit IDs versehen -->
    
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="//tei:stamp">
        <xsl:element name="stamp">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xml:id">
                <xsl:variable name="uid" select="concat('uuid_',uuid:randomUUID())"/>
                <xsl:value-of select="$uid"/>
            </xsl:attribute>
            <xsl:copy-of select="node()"/>
        </xsl:element>
    </xsl:template>
    
    
    
</xsl:stylesheet>