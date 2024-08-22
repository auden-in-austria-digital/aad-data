<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" 
    exclude-result-prefixes="xs tei xhtml"
    version="2.0">
  
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="debug" select="false()"></xsl:param>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="xhtml:span"/>
    
    <xsl:param name="x_wconf_threshold" select="75"/>
    <xsl:param name="filename"/>
    
    <xsl:template match="/">
        <xsl:variable name="prep">
            <xsl:apply-templates mode="prep"/>
        </xsl:variable>
        <xsl:variable name="tei">
            <xsl:apply-templates select="$prep/*" mode="tei"/>
        </xsl:variable>
        <xsl:variable name="ocr_cleaned">
            <xsl:apply-templates select="$tei" mode="clean_ocr"/>
        </xsl:variable>
        <xsl:variable name="ws_cleaned">
            <xsl:apply-templates select="$ocr_cleaned" mode="clean_ws"/>
        </xsl:variable>
        <xsl:if test="$debug">
            <xsl:result-document href="debug_hocr2tei_{$filename}-1.xml">
                <xsl:sequence select="$prep"/>
            </xsl:result-document>
            <xsl:result-document href="debug_hocr2tei_{$filename}-2.xml">
                <xsl:sequence select="$tei"/>
            </xsl:result-document>
            <xsl:result-document href="debug_hocr2tei_{$filename}-3.xml">
                <xsl:sequence select="$ocr_cleaned"/>
            </xsl:result-document>
            <xsl:result-document href="debug_hocr2tei_{$filename}-4.xml">
                <xsl:sequence select="$ws_cleaned"/>
            </xsl:result-document>
        </xsl:if>
        <xsl:sequence select="$ws_cleaned"/>
    </xsl:template>
    
    
    <xsl:variable name="rplStr">
        <strings xmlns="">
            <str pattern="czu">au</str>
            <str pattern="ii">ü</str>
            <str pattern="y’">f</str>
            <str pattern="ﬁi">fü</str>
            <str pattern="Straﬁ">Strafv</str>
            <str pattern="ﬁ">ri</str>
            <str pattern="tennin">termin</str>
            <str pattern="Tennin">Termin</str>
            <str pattern="uhg\s">ung </str>
            <str pattern="uhg$">ung</str>
            <str pattern="^emch">ersch</str>
            <str pattern="\[\. \. \.\]">[…]</str>
        </strings>
    </xsl:variable>
    
    <xsl:template match="text()[normalize-space()!='']" mode="clean_ocr" priority="1">
        <xsl:call-template name="replaceString">
            <xsl:with-param name="string" select="." as="xs:string"/>
            <xsl:with-param name="replacements" select="$rplStr//str" as="element()+"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="replaceString">
        <xsl:param name="string" as="xs:string"/>
        <xsl:param name="replacements" as="element(str)*"/>
        <xsl:choose>
            <xsl:when test="exists($replacements)">
                <xsl:call-template name="replaceString">
                    <xsl:with-param name="string" select="replace($string, $replacements[1]/@pattern, $replacements[1]/text())"/>
                    <xsl:with-param name="replacements" select="subsequence($replacements,2)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="node() | @*" mode="prep clean_ocr clean_ws">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="xhtml:span" mode="prep">
        <xsl:element name="{@class}" xmlns="">
            <xsl:copy-of select="@*"/>
<!--            <xsl:if test="@class = 'ocr_line'">
                <xsl:attribute name="xml:space">preserve</xsl:attribute>
            </xsl:if>-->
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="xhtml:html | xhtml:body | xhtml:div[@class = 'ocr_carea'] | xhtml:span " mode="tei">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="ocrx_word" mode="tei">
        <xsl:choose>
            <xsl:when test="xs:integer(substring-after(tokenize(@title,'; ')[starts-with(.,'x_wconf')],' ')) lt $x_wconf_threshold">
                <xsl:comment> ?? </xsl:comment>
                <xsl:apply-templates mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="#current"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="ocrx_word[not(following-sibling::ocrx_word)]/text()[last()]" mode="tei">
        <xsl:variable name="v">
            <xsl:analyze-string select="." regex="[—-]$">
                <xsl:matching-substring><lb break="no"/></xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:sequence select="$v"/>
        <xsl:if test="not($v/tei:lb)"><lb/></xsl:if>
    </xsl:template>
    
    <xsl:template match="ocr_line/text()[last()]" mode="tei">
        <xsl:value-of select="replace(.,'\s+\n\s*$','')"/>
        <!--<xsl:if test="not(matches(.,'[—-]$')) and ../following-sibling::*">
            <xsl:text> </xsl:text>
        </xsl:if>-->
    </xsl:template>
    
    <xsl:template match="ocr_line" mode="tei">
        <xsl:apply-templates mode="#current"/>
    </xsl:template>
    
    <xsl:template match="xhtml:head" mode="tei"/>
    <xsl:template match="xhtml:div[@class = 'ocr_page']" mode="tei">
        <div type="page" n="{$filename}">
            <xsl:for-each select="*">
                <xsl:sort select="tokenize(@title,' ')[3]" data-type="number" order="ascending"/>
                <xsl:apply-templates select="." mode="#current"/>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    
    <xsl:template match="xhtml:p" mode="tei">
        <p xml:space="preserve"><xsl:apply-templates mode="#current"/></p>
    </xsl:template>
    
    
    
    <xsl:template match="xhtml:p[normalize-space(.) = '']" priority="1" mode="tei"/>
        
    
    
    <xsl:template match="xhtml:strong | xhtml:em" mode="tei">
        <!-- Too much garbage, so we ignore strong and em tags -->
        <!--<hi rendition="#{local-name()}">-->
            <xsl:apply-templates mode="#current"/>
        <!--</hi>-->
    </xsl:template>
</xsl:stylesheet>