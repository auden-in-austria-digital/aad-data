<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:ko="https://www.kraus.wienbibliothek.at/"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei ko"
    version="2.0">
    <xsl:output indent="yes"/>
    <xsl:param name="imgno-offset" as="xs:integer" select="-18"/>
    <xsl:variable name="pagenum" select="xs:integer(substring-before(//tei:div[1]/@n,'.'))+$imgno-offset"/>
    <xsl:param name="path-to-objects">file:/home/dschopper/data/R_Kraus-Samek_11789/101_derived/objects.xml</xsl:param>
    <xsl:variable name="objects" select="doc($path-to-objects)"/>
    <xsl:key name="object-by-n" match="object" use="@n"/>
    <xsl:param name="debug" select="false()" as="xs:boolean"/>
    
    <xsl:template match="node() | @*" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:variable name="pass1">
            <xsl:apply-templates/>
        </xsl:variable>
        <xsl:if test="$debug">
            <xsl:result-document href="debug_{tei:div/@n}.xml">
                <xsl:sequence select="$pass1"/>
            </xsl:result-document>
        </xsl:if>
        <xsl:apply-templates select="$pass1" mode="pass2"/>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:namespace name="ko">https://www.kraus.wienbibliothek.at/</xsl:namespace>
            <pb n="{@n}"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="tei:p[matches(.,'^\d+\s*\.\)')]" priority="4">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="tei:p[matches(.,'^\d+\.\s*\d+')]">
        <xsl:variable name="pattern" select="concat('(',string-join($objects//object[exists(@n)]/replace(@n,'\.','\\.'),'|'),')')"/>
        <xsl:variable name="number">
            <xsl:analyze-string select="." regex="{concat('^(',$pattern,')')}">
                <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="exists($number)">
                <xsl:variable name="ko-object" select="key('object-by-n', $number , $objects)"/>
                <xsl:choose>
                    <xsl:when test="count($ko-object) ge 1">
                        <xsl:if test="count($ko-object) gt 1">
                            <xsl:message terminate="no"><xsl:value-of select="count($ko-object)"/> objects found for <xsl:value-of select="$number"/> in <xsl:value-of select="root()/tei:div/@n"/></xsl:message>
                        </xsl:if>
                        <head level="2" n="{string-join(distinct-values($ko-object/concat(Hauptnummer,'.',Nebennummer)),' ')}" ko:ids="{string-join($ko-object/ID,' ')}" ko:titles="{string-join($ko-object/Titel,' / ')}"><xsl:apply-templates/></head>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:next-match/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- integer-only paragraphs at the end of the page > pageNum -->
    <xsl:template match="tei:p[not(following-sibling::*) and normalize-space(.) = xs:string($pagenum)]">
        <fw type="pageNum"><xsl:value-of select="."/></fw>
    </xsl:template>
    
    <xsl:template match="tei:p[matches(.,'^\d+[\s$]')][normalize-space(.) != xs:string($pagenum)][replace(.,'^(\d+)\s*.+$', '$1') = following-sibling::tei:head[@level = '2']/substring-before(@n,'.')]" priority="1" mode="pass2">
        <head level="1" n="{replace(.,'^(\d+)\s*.+$', '$1')}"><xsl:apply-templates select="@*|node()" mode="pass2"/></head>
    </xsl:template>
    
</xsl:stylesheet>