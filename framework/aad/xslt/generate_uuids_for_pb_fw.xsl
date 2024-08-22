<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ko="https://www.kraus.wienbibliothek.at/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:uuid="java:java.util.UUID"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:pb">
        <xsl:element name="pb">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xml:id">
                <xsl:variable name="uid" select="concat('uuid_',uuid:randomUUID())"/>
                <xsl:value-of select="$uid"/>
            </xsl:attribute>
            <xsl:copy-of select="node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:fw">
        <xsl:element name="fw">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xml:id">
                <xsl:variable name="uid" select="concat('uuid_',uuid:randomUUID())"/>
                <xsl:value-of select="$uid"/>
            </xsl:attribute>
            <xsl:copy-of select="node()"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>