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


 <!-- 
<listWit>
                    <witness xml:id="D_000002-003-000-wit01" facs="#D_000002-003-000-facs001"/>
                </listWit>
 -->
 
 
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:p[parent::tei:sourceDesc]">
            <xsl:element name="listWit">
                <xsl:element name="witness">
                    <xsl:attribute name="xml:id">
                        <xsl:variable name="wit-id" select="concat(substring-before(./ancestor::tei:TEI/@xml:id/string(), '.xml'),'-wit01')"/>
                        <xsl:value-of select="$wit-id"/>
                    </xsl:attribute>
                    <xsl:attribute name="facs">
                        <xsl:value-of select="''"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
    </xsl:template>
    
        
</xsl:stylesheet>
