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


    <!-- fasimile mit IDs versehen -->
    <!-- Muster: D_000002-002-000-facs001 -->
    
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:facsimile">
            <xsl:element name="facsimile">
                <xsl:attribute name="xml:id">
                    <xsl:variable name="docID" select="substring-before(./ancestor::tei:TEI/@xml:id/string(), '.xml')"/>
                    <xsl:variable name="facsNo" select="format-number(count(preceding::tei:facsimile) + 1,'000')"/>
                    
                    <xsl:value-of select="concat($docID,'-facs',$facsNo)"/>
                </xsl:attribute>
                <xsl:for-each select="@*[name() != 'xml:id']">
                    <xsl:copy/>
                </xsl:for-each>
                <xsl:apply-templates/>
            </xsl:element>
    </xsl:template>
    
    <!-- surfaceGrp mit IDs versehen -->
    <!-- Muster: D_000002-002-000-facs001-l001 -->
     
        <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:surfaceGrp">
            <xsl:element name="surfaceGrp">
                <xsl:attribute name="xml:id">
                    <xsl:variable name="docID" select="substring-before(./ancestor::tei:TEI/@xml:id/string(), '.xml')"/>
                    <xsl:variable name="facsNo" select="format-number(count(./ancestor::tei:facsimile/preceding::tei:facsimile) + 1,'000')"/>
                    <xsl:variable name="surfaceGrpNo" select="format-number(count(preceding-sibling::tei:surfaceGrp) + 1,'000')"/>
                    <xsl:value-of select="concat($docID,'-facs',$facsNo,'-l',$surfaceGrpNo)"/>
                </xsl:attribute>
                <xsl:for-each select="@*[name() != 'xml:id']">
                    <xsl:copy/>
                </xsl:for-each>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:template>
    
    <!-- surface mit IDs versehen -->
    <!-- Muster: "D_000002-002-000-facs001-l001-p001" -->
    
    <xsl:template xmlns="http://www.tei-c.org/ns/1.0" match="tei:surface">
        <xsl:element name="surface">
            <xsl:attribute name="xml:id">
                <xsl:variable name="docID" select="substring-before(./ancestor::tei:TEI/@xml:id/string(), '.xml')"/>
                <xsl:variable name="facsNo" select="format-number(count(./ancestor::tei:facsimile/preceding::tei:facsimile) + 1,'000')"/>
                <xsl:variable name="surfaceGrpNo" select="format-number(count(./ancestor::tei:surfaceGrp/preceding-sibling::tei:surfaceGrp) + 1,'000')"/>
                <xsl:variable name="surfaceNo" select="format-number(count(./preceding-sibling::tei:surface) + 1,'000')"/>
                <xsl:value-of select="concat($docID,'-facs',$facsNo,'-l',$surfaceGrpNo,'-p', $surfaceNo)"/>
            </xsl:attribute>
            <xsl:for-each select="@*[name() != 'xml:id']">
                <xsl:copy/>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
        

    
</xsl:stylesheet>
