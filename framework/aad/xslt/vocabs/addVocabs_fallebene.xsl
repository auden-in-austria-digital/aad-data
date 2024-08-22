<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" version="1.0" indent="yes"/>
    
    <xsl:variable name="fallebene" select="document('fallebene_test.xml')"/><!-- define xml file with vocabs data as variable -->
    
    <xsl:variable name="id" select="tei:TEI/@xml:id" as="xs:string"/><!-- define xml:id from collections as variable -->
    
    <!-- copy all -->
    <xsl:template match="@* | node()" name="identity-copy">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy> 
    </xsl:template>
    
    <!-- add various concepts to profileDesc -->
    
    <!-- TO DO: 
        - nur Element erstellen, wenn Info vorhanden -->
    
    <xsl:template match="tei:profileDesc">
                    
        <xsl:element name="textClass" namespace="http://www.tei-c.org/ns/1.0"><!-- add element textClass -->
            
            <!-- diverse Konzepte, Prosa -->
            
            <!-- define variables for various concepts (matching node name with xml:id) -->
            <xsl:variable name="rb_prosa1" select="$fallebene//Info[text() = 'RB_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="rb_prosa2" select="$fallebene//Info[text() = 'RB_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="rb_prosa3" select="$fallebene//Info[text() = 'RB_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="ad_prosa1" select="$fallebene//Info[text() = 'AD_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="ad_prosa2" select="$fallebene//Info[text() = 'AD_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="ad_prosa3" select="$fallebene//Info[text() = 'AD_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="dt_prosa1" select="$fallebene//Info[text() = 'DT_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="dt_prosa2" select="$fallebene//Info[text() = 'DT_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="dt_prosa3" select="$fallebene//Info[text() = 'DT_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="a_prosa1" select="$fallebene//Info[text() = 'A_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="a_prosa2" select="$fallebene//Info[text() = 'A_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="a_prosa3" select="$fallebene//Info[text() = 'A_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="av_prosa1" select="$fallebene//Info[text() = 'AV_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="av_prosa2" select="$fallebene//Info[text() = 'AV_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="av_prosa3" select="$fallebene//Info[text() = 'AV_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="t_prosa1" select="$fallebene//Info[text() = 'T_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="t_prosa2" select="$fallebene//Info[text() = 'T_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="t_prosa3" select="$fallebene//Info[text() = 'T_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:element name="keywords" namespace="http://www.tei-c.org/ns/1.0"><!-- add element keywords -->
                
                <!-- add terms for various concepts, Prosa-Bezeichnungen as strings -->
                
                <xsl:choose>
                    <xsl:when test="$rb_prosa1/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$rb_prosa1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$rb_prosa2/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$rb_prosa2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$rb_prosa3/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$rb_prosa3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$ad_prosa1/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$ad_prosa1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$ad_prosa2/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$ad_prosa2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$ad_prosa3/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$ad_prosa3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$dt_prosa1/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$dt_prosa1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$dt_prosa2/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$dt_prosa2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$dt_prosa3/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$dt_prosa3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$a_prosa1/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$a_prosa1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$a_prosa2/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$a_prosa2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$a_prosa3/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$a_prosa3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$av_prosa1/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$av_prosa1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$av_prosa2/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$av_prosa2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$av_prosa3/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$av_prosa3/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$t_prosa1/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$t_prosa1/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$t_prosa2/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$t_prosa2/text()"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$t_prosa3/text()">
                        <xsl:element name="term" namespace="http://www.tei-c.org/ns/1.0">
                           <xsl:value-of select="$t_prosa3/text()"/>
                       </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
            </xsl:element>
            
            <!-- diverse Konzepte, Kürzel -->
            
            <!-- define variables for various concepts (matching node name with xml:id) -->
            <xsl:variable name="rb_kuerzel1" select="$fallebene//Info[text() = 'RB_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="rb_kuerzel2" select="$fallebene//Info[text() = 'RB_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="rb_kuerzel3" select="$fallebene//Info[text() = 'RB_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="ad_kuerzel1" select="$fallebene//Info[text() = 'AD_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="ad_kuerzel2" select="$fallebene//Info[text() = 'AD_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="ad_kuerzel3" select="$fallebene//Info[text() = 'AD_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="dt_kuerzel1" select="$fallebene//Info[text() = 'DT_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="dt_kuerzel2" select="$fallebene//Info[text() = 'DT_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="dt_kuerzel3" select="$fallebene//Info[text() = 'DT_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="a_kuerzel1" select="$fallebene//Info[text() = 'A_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="a_kuerzel2" select="$fallebene//Info[text() = 'A_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="a_kuerzel3" select="$fallebene//Info[text() = 'A_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="av_kuerzel1" select="$fallebene//Info[text() = 'AV_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="av_kuerzel2" select="$fallebene//Info[text() = 'AV_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="av_kuerzel3" select="$fallebene//Info[text() = 'AV_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="t_kuerzel1" select="$fallebene//Info[text() = 'T_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="t_kuerzel2" select="$fallebene//Info[text() = 'T_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="t_kuerzel3" select="$fallebene//Info[text() = 'T_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <!-- add classCodes for various concepts, vocabs-url in @scheme, Kürzel as string -->
            
            <xsl:choose>
                <xsl:when test="$rb_kuerzel1/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                       <xsl:attribute name="scheme">
                           <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $rb_kuerzel1/text())"/>
                       </xsl:attribute>
                       <xsl:value-of select="$rb_kuerzel1/text()"/>
                   </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$rb_kuerzel2/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $rb_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$rb_kuerzel2/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$rb_kuerzel3/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $rb_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$rb_kuerzel3/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$ad_kuerzel1/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $ad_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$ad_kuerzel1/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$ad_kuerzel2/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $ad_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$ad_kuerzel2/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$ad_kuerzel3/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $ad_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$ad_kuerzel3/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$dt_kuerzel1/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
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
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $dt_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$dt_kuerzel3/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$a_kuerzel1/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $a_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$a_kuerzel1/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$a_kuerzel2/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $a_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$a_kuerzel2/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$a_kuerzel3/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $a_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$a_kuerzel3/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$av_kuerzel1/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $av_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$av_kuerzel1/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$av_kuerzel2/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $av_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$av_kuerzel2/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$av_kuerzel3/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $av_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$av_kuerzel3/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$t_kuerzel1/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $t_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$t_kuerzel1/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$t_kuerzel2/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $t_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$t_kuerzel2/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$t_kuerzel3/text()">
                    <xsl:element name="classCode" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $t_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:value-of select="$t_kuerzel3/text()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
        </xsl:element>
           
    <!-- add persons and institutions to profileDesc -->
            
            <!-- persons -->
            
            <xsl:element name="particDesc" namespace="http://www.tei-c.org/ns/1.0"><!-- add element particDesc -->
            
                <xsl:element name="listPerson" namespace="http://www.tei-c.org/ns/1.0"><!-- add element listPerson -->
                    
                    <!-- define variables for various concepts (matching node name with xml:id) -->
                    <xsl:variable name="p1_name" select="$fallebene//Info[text() = 'P1_Name']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_pmb" select="$fallebene//Info[text() = 'P1_PMB']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_prosa1" select="$fallebene//Info[text() = 'P1_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_kuerzel1" select="$fallebene//Info[text() = 'P1_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_prosa2" select="$fallebene//Info[text() = 'P1_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_kuerzel2" select="$fallebene//Info[text() = 'P1_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_prosa3" select="$fallebene//Info[text() = 'P1_Prosa3']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p1_kuerzel3" select="$fallebene//Info[text() = 'P1_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                    
                    <xsl:variable name="p2_name" select="$fallebene//Info[text() = 'P2_Name']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_pmb" select="$fallebene//Info[text() = 'P2_PMB']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_prosa1" select="$fallebene//Info[text() = 'P2_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_kuerzel1" select="$fallebene//Info[text() = 'P2_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_prosa2" select="$fallebene//Info[text() = 'P2_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_kuerzel2" select="$fallebene//Info[text() = 'P2_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_prosa3" select="$fallebene//Info[text() = 'P2_Prosa3']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p2_kuerzel3" select="$fallebene//Info[text() = 'P2_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                    
                    <xsl:variable name="p3_name" select="$fallebene//Info[text() = 'P3_Name']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_pmb" select="$fallebene//Info[text() = 'P3_PMB']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_prosa1" select="$fallebene//Info[text() = 'P3_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_kuerzel1" select="$fallebene//Info[text() = 'P3_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_prosa2" select="$fallebene//Info[text() = 'P3_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_kuerzel2" select="$fallebene//Info[text() = 'P3_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_prosa3" select="$fallebene//Info[text() = 'P3_Prosa3']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p3_kuerzel3" select="$fallebene//Info[text() = 'P3_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                    
                    <xsl:variable name="p4_name" select="$fallebene//Info[text() = 'P4_Name']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_pmb" select="$fallebene//Info[text() = 'P4_PMB']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_prosa1" select="$fallebene//Info[text() = 'P4_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_kuerzel1" select="$fallebene//Info[text() = 'P4_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_prosa2" select="$fallebene//Info[text() = 'P4_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_kuerzel2" select="$fallebene//Info[text() = 'P4_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_prosa3" select="$fallebene//Info[text() = 'P4_Prosa3']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p4_kuerzel3" select="$fallebene//Info[text() = 'P4_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                    
                    <xsl:variable name="p5_name" select="$fallebene//Info[text() = 'P5_Name']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_pmb" select="$fallebene//Info[text() = 'P5_PMB']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_prosa1" select="$fallebene//Info[text() = 'P5_Prosa1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_kuerzel1" select="$fallebene//Info[text() = 'P5_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_prosa2" select="$fallebene//Info[text() = 'P5_Prosa2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_kuerzel2" select="$fallebene//Info[text() = 'P5_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_prosa3" select="$fallebene//Info[text() = 'P5_Prosa3']/following-sibling::*[name()=current()/$id]"/>
                    <xsl:variable name="p5_kuerzel3" select="$fallebene//Info[text() = 'P5_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
                    
                    <!-- add persons with vocabs-url in @role, pmb-url in @ref, Name as string in persName and Prosa-Bezeichnung as string in ab type keyword -->
                    
                    <!-- p1 -->
                    
                    <xsl:choose>
                        <xsl:when test="$p1_kuerzel1/text()">
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="role">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p1_kuerzel1/text())"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p1_pmb/text())"/>
                                </xsl:attribute>
                                <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:value-of select="$p1_name/text()"/>
                                </xsl:element>
                                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type">
                                        <xsl:value-of select="'keyword'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$p1_prosa1/text()"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$p1_kuerzel2/text()">
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="role">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p1_kuerzel2/text())"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p1_pmb/text())"/>
                                </xsl:attribute>
                                <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:value-of select="$p1_name/text()"/>
                                </xsl:element>
                                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type">
                                        <xsl:value-of select="'keyword'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$p1_prosa2/text()"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="$p1_kuerzel3/text()">
                            <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="role">
                                    <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p1_kuerzel3/text())"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p1_pmb/text())"/>
                                </xsl:attribute>
                                <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:value-of select="$p1_name/text()"/>
                                </xsl:element>
                                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type">
                                        <xsl:value-of select="'keyword'"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="$p1_prosa3/text()"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
            
                <!-- p2 -->
                
                <xsl:choose>
                    <xsl:when test="$p2_kuerzel1/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p2_kuerzel1/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p2_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p2_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p2_prosa1/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p2_kuerzel2/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p2_kuerzel2/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p2_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p2_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p2_prosa2/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p2_kuerzel3/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p2_kuerzel3/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p2_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p2_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p2_prosa3/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <!-- p3 -->
                
                <xsl:choose>
                    <xsl:when test="$p3_kuerzel1/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p3_kuerzel1/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p3_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p3_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p3_prosa1/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p3_kuerzel2/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p3_kuerzel2/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p3_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p3_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p3_prosa2/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p3_kuerzel3/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p3_kuerzel3/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p3_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p3_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p3_prosa3/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <!-- p4 -->
                
                <xsl:choose>
                    <xsl:when test="$p4_kuerzel1/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p4_kuerzel1/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p4_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p4_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p4_prosa1/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p4_kuerzel2/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p4_kuerzel2/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p4_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p4_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p4_prosa2/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p4_kuerzel3/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p4_kuerzel3/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p4_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p4_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p4_prosa3/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <!-- p5 -->
                
                <xsl:choose>
                    <xsl:when test="$p5_kuerzel1/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p5_kuerzel1/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p5_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p5_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p5_prosa1/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p5_kuerzel2/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p5_kuerzel2/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p5_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p5_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p5_prosa2/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="$p5_kuerzel3/text()">
                        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="role">
                                <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $p5_kuerzel3/text())"/>
                            </xsl:attribute>
                            <xsl:attribute name="ref">
                                <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $p5_pmb/text())"/>
                            </xsl:attribute>
                            <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:value-of select="$p5_name/text()"/>
                            </xsl:element>
                            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:value-of select="'keyword'"/>
                                </xsl:attribute>
                                <xsl:value-of select="$p5_prosa3/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            
            </xsl:element>
                
        </xsl:element>
        
        <!-- institutions -->
            
        <xsl:element name="listOrg" namespace="http://www.tei-c.org/ns/1.0"><!-- add element listOrg -->
            
            <!-- define variables for various concepts (matching node name with xml:id) -->
            <xsl:variable name="i1_name" select="$fallebene//Info[text() = 'I1_Name']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_pmb" select="$fallebene//Info[text() = 'I1_PMB']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_prosa1" select="$fallebene//Info[text() = 'I1_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_kuerzel1" select="$fallebene//Info[text() = 'I1_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_prosa2" select="$fallebene//Info[text() = 'I1_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_kuerzel2" select="$fallebene//Info[text() = 'I1_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_prosa3" select="$fallebene//Info[text() = 'I1_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i1_kuerzel3" select="$fallebene//Info[text() = 'I1_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="i2_name" select="$fallebene//Info[text() = 'I2_Name']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_pmb" select="$fallebene//Info[text() = 'I2_PMB']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_prosa1" select="$fallebene//Info[text() = 'I2_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_kuerzel1" select="$fallebene//Info[text() = 'I2_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_prosa2" select="$fallebene//Info[text() = 'I2_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_kuerzel2" select="$fallebene//Info[text() = 'I2_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_prosa3" select="$fallebene//Info[text() = 'I2_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i2_kuerzel3" select="$fallebene//Info[text() = 'I2_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="i3_name" select="$fallebene//Info[text() = 'I3_Name']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_pmb" select="$fallebene//Info[text() = 'I3_PMB']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_prosa1" select="$fallebene//Info[text() = 'I3_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_kuerzel1" select="$fallebene//Info[text() = 'I3_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_prosa2" select="$fallebene//Info[text() = 'I3_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_kuerzel2" select="$fallebene//Info[text() = 'I3_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_prosa3" select="$fallebene//Info[text() = 'I3_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i3_kuerzel3" select="$fallebene//Info[text() = 'I3_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="i4_name" select="$fallebene//Info[text() = 'I4_Name']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_pmb" select="$fallebene//Info[text() = 'I4_PMB']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_prosa1" select="$fallebene//Info[text() = 'I4_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_kuerzel1" select="$fallebene//Info[text() = 'I4_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_prosa2" select="$fallebene//Info[text() = 'I4_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_kuerzel2" select="$fallebene//Info[text() = 'I4_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_prosa3" select="$fallebene//Info[text() = 'I4_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i4_kuerzel3" select="$fallebene//Info[text() = 'I4_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <xsl:variable name="i5_name" select="$fallebene//Info[text() = 'I5_Name']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_pmb" select="$fallebene//Info[text() = 'I5_PMB']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_prosa1" select="$fallebene//Info[text() = 'I5_Prosa1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_kuerzel1" select="$fallebene//Info[text() = 'I5_Kürzel1']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_prosa2" select="$fallebene//Info[text() = 'I5_Prosa2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_kuerzel2" select="$fallebene//Info[text() = 'I5_Kürzel2']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_prosa3" select="$fallebene//Info[text() = 'I5_Prosa3']/following-sibling::*[name()=current()/$id]"/>
            <xsl:variable name="i5_kuerzel3" select="$fallebene//Info[text() = 'I5_Kürzel3']/following-sibling::*[name()=current()/$id]"/>
            
            <!-- add institutions with vocabs-url in @role, pmb-url in @ref, Name as string in orgName and Prosa-Bezeichnung as string in ab type keyword -->
            
            <!-- i1 -->
            
            <xsl:choose>
                <xsl:when test="$i1_kuerzel1/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i1_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i1_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i1_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i1_prosa1/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i1_kuerzel2/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i1_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i1_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i1_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i1_prosa2/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i1_kuerzel3/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i1_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i1_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i1_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i1_prosa3/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
    
            <!-- i2 -->
            
            <xsl:choose>
                <xsl:when test="$i2_kuerzel1/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i2_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i2_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i2_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i2_prosa1/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i2_kuerzel2/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i2_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i2_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i2_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i2_prosa2/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i2_kuerzel3/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i2_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i2_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i2_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i2_prosa3/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <!-- i3 -->
            
            <xsl:choose>
                <xsl:when test="$i3_kuerzel1/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i3_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i3_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i3_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i3_prosa1/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i3_kuerzel2/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i3_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i3_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i3_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i3_prosa2/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i3_kuerzel3/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i3_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i3_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i3_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i3_prosa3/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <!-- i4 -->
            
            <xsl:choose>
                <xsl:when test="$i4_kuerzel1/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i4_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i4_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i4_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i4_prosa1/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i4_kuerzel2/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i4_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i4_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i4_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i4_prosa2/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i4_kuerzel3/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i4_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i4_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i4_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i4_prosa3/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <!-- i5 -->
            
            <xsl:choose>
                <xsl:when test="$i5_kuerzel1/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i5_kuerzel1/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i5_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i5_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i5_prosa1/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i5_kuerzel2/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i5_kuerzel2/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i5_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i5_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i5_prosa2/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="$i5_kuerzel3/text()">
                    <xsl:element name="org" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="role">
                            <xsl:value-of select="concat('https://vocabs.acdh.oeaw.ac.at/legalkraus/v1.0/', $i5_kuerzel3/text())"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">
                            <xsl:value-of select="concat('https://pmb.acdh.oeaw.ac.at/entity/', $i5_pmb/text())"/>
                        </xsl:attribute>
                        <xsl:element name="orgName" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="$i5_name/text()"/>
                        </xsl:element>
                        <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:value-of select="'keyword'"/>
                            </xsl:attribute>
                            <xsl:value-of select="$i5_prosa3/text()"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
    
        </xsl:element>
        
    </xsl:template>
        
</xsl:stylesheet>