<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" version="1.0" indent="yes"/>
    
    <xsl:variable name="dokumentebene" select="document('dokumentebene_test.xml')"/><!-- define xml file with vocabs data as variable -->
    
    <xsl:variable name="id" select="tei:TEI/@xml:id" as="xs:string"/><!-- define xml:id from objects as variable -->
    
    <xsl:variable name="id-without-xml" select="substring-before(tei:TEI/@xml:id, '.xml')" as="xs:string"/><!-- define xml:id without ".xml" suffix as variable -->
    
    <!-- copy all -->
    <xsl:template match="@* | node()" name="identity-copy">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy> 
    </xsl:template>
    
    <!-- add Dokumenttyp to profileDesc -->
    
    <xsl:template match="tei:profileDesc">
        
        <xsl:copy><!-- copy existing nodes -->
            <xsl:apply-templates select="@* | node()"/>
            
            <xsl:element name="textClass" namespace="http://www.tei-c.org/ns/1.0"><!-- add element textClass -->
            
                <!-- Dokumenttyp, Prosa -->
                
                <!-- define variables for Dokumenttypen, Prosa-Bezeichnungen | witness 1 (matching node name with xml:id) -->
                <xsl:variable name="dt_prosa1" select="$dokumentebene//Info[text() = 'DT_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="dt_prosa2" select="$dokumentebene//Info[text() = 'DT_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="dt_prosa3" select="$dokumentebene//Info[text() = 'DT_Prosa3']/following-sibling::*[name()=current()/$id]"/>
                
                <!-- define variables for Dokumenttypen, Prosa-Bezeichnungen | witness 2 (matching node name with xml:id) -->
                <xsl:variable name="w2_dt_prosa1" select="$dokumentebene//Info[text() = 'W2_DT_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="w2_dt_prosa2" select="$dokumentebene//Info[text() = 'W2_DT_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="w2_dt_prosa3" select="$dokumentebene//Info[text() = 'W2_DT_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
                <xsl:element name="keywords" namespace="http://www.tei-c.org/ns/1.0"><!-- add element keywords -->
                    
                    <!-- add terms with witness-id as source and Posa-Bezeichnung as string | witness 1 -->
                    
                    <xsl:choose>
                        <xsl:when test="$dt_prosa1/text()">
                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit01')"/></xsl:attribute>
                                <xsl:value-of select="$dt_prosa1/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$dt_prosa2/text()">
                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit01')"/></xsl:attribute>
                                <xsl:value-of select="$dt_prosa2/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$dt_prosa3/text()">
                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit01')"/></xsl:attribute>
                                <xsl:value-of select="$dt_prosa3/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <!-- add terms with witness-id as source and Posa-Bezeichnung as string | witness 2 -->
                    
                    <xsl:choose>
                        <xsl:when test="$w2_dt_prosa1/text()">
                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit02')"/></xsl:attribute>
                                <xsl:value-of select="$w2_dt_prosa1/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$w2_dt_prosa2/text()">
                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                               <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit02')"/></xsl:attribute>
                               <xsl:value-of select="$w2_dt_prosa2/text()"/>
                           </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$w2_dt_prosa3/text()">
                            <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit02')"/></xsl:attribute>
                                <xsl:value-of select="$w2_dt_prosa3/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                </xsl:element>
                
                <!-- Dokumenttyp, Kürzel -->
                
                <!-- define variables for Dokumenttypen, Kürzel | witness 1 (matching node name with xml:id) -->
                <xsl:variable name="dt_kuerzel1" select="$dokumentebene//Info[text() = 'DT_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="dt_kuerzel2" select="$dokumentebene//Info[text() = 'DT_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="dt_kuerzel3" select="$dokumentebene//Info[text() = 'DT_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                
                <!-- define variables for Dokumenttypen, Kürzel | witness 2 (matching node name with xml:id) -->
                <xsl:variable name="w2_dt_kuerzel1" select="$dokumentebene//Info[text() = 'W2_DT_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="w2_dt_kuerzel2" select="$dokumentebene//Info[text() = 'W2_DT_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="w2_dt_kuerzel3" select="$dokumentebene//Info[text() = 'W2_DT_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                
                <!-- add classCodes for Dokumenttypen, Kürzel with witness-id and Kürzel as string | witness 1 -->
                
                <xsl:choose>
                    <xsl:when test="$dt_kuerzel1/text()">
                        <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit01')"/></xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $dt_kuerzel1/text())"/>
                            </xsl:attribute>
                            <xsl:value-of select="$dt_kuerzel1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$dt_kuerzel2/text()">
                        <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit01')"/></xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $dt_kuerzel2/text())"/>
                            </xsl:attribute>
                            <xsl:value-of select="$dt_kuerzel2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$dt_kuerzel3/text()">
                        <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit01')"/></xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $dt_kuerzel3/text())"/>
                            </xsl:attribute>
                            <xsl:value-of select="$dt_kuerzel3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <!-- add classCodes for Dokumenttypen, Kürzel with witness-id and Kürzel as string | witness 2 -->
                
                <xsl:choose>
                    <xsl:when test="$w2_dt_kuerzel1/text()">
                        <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit02')"/></xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $w2_dt_kuerzel1/text())"/>
                            </xsl:attribute>
                            <xsl:value-of select="$w2_dt_kuerzel1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$w2_dt_kuerzel2/text()">
                        <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit02')"/></xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $w2_dt_kuerzel2/text())"/>
                            </xsl:attribute>
                            <xsl:value-of select="$w2_dt_kuerzel2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$w2_dt_kuerzel3/text()">
                        <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="source"><xsl:value-of select="concat($id-without-xml, '-wit02')"/></xsl:attribute>
                            <xsl:attribute name="scheme">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $w2_dt_kuerzel3/text())"/>
                            </xsl:attribute>
                            <xsl:value-of select="$w2_dt_kuerzel3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            
        </xsl:element>
            
        </xsl:copy>
        
    </xsl:template>
    
    <!-- add Materialitätstyp to physDesc -->
    
    <xsl:template match="tei:physDesc">
        
        <xsl:copy><!-- copy existing nodes -->
            <xsl:apply-templates select="@* | node()"/>
        
            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0"><!-- add element ab with type materiality -->
                <xsl:attribute name="type"><xsl:value-of select="'materiality'"/></xsl:attribute>
                
                <!-- define variables for Materialitätstypen, Prosa-Bezeichnungen | witness 1 (matching node name with xml:id) -->
                <xsl:variable name="mt_prosa1" select="$dokumentebene//Info[text() = 'MT_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="mt_prosa2" select="$dokumentebene//Info[text() = 'MT_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                
                <!-- define variables for Materialitätstypen, Prosa-Bezeichnungen | witness 2 (matching node name with xml:id) -->
                <xsl:variable name="w2_mt_prosa1" select="$dokumentebene//Info[text() = 'W2_MT_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="w2_mt_prosa2" select="$dokumentebene//Info[text() = 'W2_MT_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                
                <!-- define variables for Materialitätstypen, Kürzel | witness 1 (matching node name with xml:id) -->
                <xsl:variable name="mt_kuerzel1" select="$dokumentebene//Info[text() = 'MT_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="mt_kuerzel2" select="$dokumentebene//Info[text() = 'MT_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                
                <!-- define variables for Materialitätstypen, Kürzel | witness 2 (matching node name with xml:id) -->
                <xsl:variable name="w2_mt_kuerzel1" select="$dokumentebene//Info[text() = 'W2_MT_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                <xsl:variable name="w2_mt_kuerzel2" select="$dokumentebene//Info[text() = 'W2_MT_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                
                    <!-- add Materialitätstypen to objectTypes with wid-id in @source, Vocabs-URL in @ref and Prosa-Bezeichnung as string | witness 1 -->
                    
                    <xsl:choose>
                        <xsl:when test="$mt_prosa1/text()">
                            <xsl:element name="objectType" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source">
                                    <xsl:value-of select="concat($id-without-xml, '-wit01')"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $mt_kuerzel1/text())"/>
                                </xsl:attribute>
                                <xsl:value-of select="$mt_prosa1/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$mt_prosa2/text()">
                            <xsl:element name="objectType" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source">
                                    <xsl:value-of select="concat($id-without-xml, '-wit01')"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $mt_kuerzel2/text())"/>
                                </xsl:attribute>
                                <xsl:value-of select="$mt_prosa2/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <!-- add Materialitätstypen to objectTypes with wid-id in @source, Vocabs-URL in @ref and Prosa-Bezeichnung as string | witness 2 -->
                    
                    <xsl:choose>
                        <xsl:when test="$w2_mt_prosa1/text()">
                            <xsl:element name="objectType" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source">
                                    <xsl:value-of select="concat($id-without-xml, '-wit02')"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $w2_mt_kuerzel1/text())"/>
                                </xsl:attribute>
                                <xsl:value-of select="$w2_mt_prosa1/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                
                    <xsl:choose>
                        <xsl:when test="$w2_mt_prosa2/text()">
                            <xsl:element name="objectType" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="source">
                                    <xsl:value-of select="concat($id-without-xml, '-wit02')"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $w2_mt_kuerzel2/text())"/>
                                </xsl:attribute>
                                <xsl:value-of select="$w2_mt_prosa2/text()"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>

            </xsl:element>
            
        </xsl:copy>
            
    </xsl:template>
    
</xsl:stylesheet>