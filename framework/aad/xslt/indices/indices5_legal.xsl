<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" version="1.0" indent="yes"/>
    
    <!-- copy all -->
    <xsl:template match="@* | node()" name="identity-copy">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy> 
    </xsl:template>
    
    <!-- define variables -->
    <xsl:variable name="objects" select="collection('../../../../data/objects/?select=*.xml')"/>
    <xsl:variable name="legal" select="$objects//tei:rs[@type='law']/@ref"/>
    
    <!-- get ref values as distinct values and create an item element for each distinct value -->
    <xsl:template match="//tei:body">
        
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            
            <xsl:element name="list" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type"><xsl:value-of select="'law'"/></xsl:attribute>
                    <xsl:for-each select="distinct-values($legal)">
                        <xsl:element name="item" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="corresp"><xsl:value-of select="."/></xsl:attribute>
                            <xsl:attribute name="sortKey"></xsl:attribute>
                            <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type"><xsl:value-of select="'j'"/></xsl:attribute>
                                <xsl:attribute name="subtype"><xsl:value-of select="'main'"/></xsl:attribute>
                            </xsl:element>
                            <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type"><xsl:value-of select="'j'"/></xsl:attribute>
                                <xsl:attribute name="subtype"><xsl:value-of select="'sub'"/></xsl:attribute>
                            </xsl:element>
                            <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="when-iso"></xsl:attribute>
                                <xsl:attribute name="resp"><xsl:value-of select="'#'"/></xsl:attribute>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
            </xsl:element>
            
        </xsl:copy>
        
    </xsl:template>
    
</xsl:stylesheet>