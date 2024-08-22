<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="tei:*"/>
    
    <xsl:template match="/">
        <xsl:variable name="pass1">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:apply-templates select="$pass1" mode="pass2"/>
    </xsl:template>
    
    <xsl:template match="tei:TEI | tei:text | tei:p | tei:list | tei:item">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:item[tei:list]/node()[1][self::tei:hi]">
        <label><xsl:apply-templates/></label>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@rend | @style"/>
    
    <xsl:template match="@*">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <front>
            <titlePage>
                <titlePart>
                    <title><xsl:apply-templates select="*[1]"/></title>
                </titlePart>
            </titlePage>
            <div>
                <head><xsl:apply-templates select="*[5]"/></head>
                <xsl:apply-templates select="*[position() = (6,7)]"/>
            </div>
            <div>
                <head><xsl:apply-templates select="*[8]"/></head>
                <xsl:apply-templates select="*[9]"/>
            </div>
            <div>
                <head><xsl:apply-templates select="*[10]"/></head>
                <xsl:apply-templates select="*[11]"/>
            </div>
            <div>
                <head><xsl:apply-templates select="*[12]"/></head>
                <xsl:apply-templates select="*[13]"/>
            </div>
            <div>
                <head><xsl:value-of select="*[14]"/></head>
                <list type="abbreviations">
                    <xsl:for-each select="*[position() gt 14 and position() lt 31]">
                    <item>
                        <label><xsl:value-of select="*[1]"/></label>
                        <expan><xsl:value-of select="normalize-space(*[2])"/></expan>
                    </item>
                    </xsl:for-each>
                </list>
            </div>
        </front>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <head>Bestand</head>
            <xsl:for-each-group select="*[position() ge 31]" group-starting-with="tei:p[starts-with(.,'Foliobox')]">
                <div n="{position()}">
                    <head><xsl:value-of select="."/></head>
                    <xsl:apply-templates select="current-group() except ."/>                </div>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()[not(matches(.,'^\s+$'))][not(preceding-sibling::node()[1]/self::*) or not(following-sibling::node()[1]/self::*)]">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <xsl:template match="node() | @*" mode="pass2">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body//tei:item[not(tei:list)]" mode="pass2">
        <xsl:param name="n" tunnel="yes"/>
        <xsl:variable name="nn" as="xs:string">
            <xsl:number/>
        </xsl:variable>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="n" select="concat($n,'.',$nn)"/>
            <xsl:apply-templates mode="pass2"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:body//tei:item[tei:list]" mode="pass2">
        <xsl:variable name="n" as="xs:integer" select="count(preceding::tei:list[ancestor::tei:body][descendant::tei:list])+1"/>
        
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="n" select="$n"/>
            <xsl:apply-templates mode="#current">
                <xsl:with-param name="n" select="$n" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>