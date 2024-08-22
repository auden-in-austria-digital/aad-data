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
    
    <xsl:variable name="fackel" select="$objects//tei:rs[@type='work' and @subtype='fackel']/@ref"/>
    
    <!-- get ref values as distinct values and create an item element for each distinct value with values in num/@issue and biblScope -->
    <xsl:template match="//tei:body">
                
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            
            <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                
                <xsl:for-each select="distinct-values($fackel)">
                    
                    <xsl:choose>
                        
                        <!-- Hefte -->
                        
                        <xsl:when test="matches(., 'https://fackel.oeaw.ac.at/f/[0-9]{3},0u1')">
                        
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type"><xsl:value-of select="'fackel'"/></xsl:attribute>
                                <xsl:attribute name="corresp"><xsl:value-of select="."/></xsl:attribute>
                                <xsl:attribute name="sortKey"></xsl:attribute>
                                <xsl:element name="editor" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="ref"><xsl:value-of select="'#11988'"/></xsl:attribute>
                                    <xsl:text>Karl Kraus</xsl:text>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'b'"/></xsl:attribute>
                                    <xsl:text>Die Fackel</xsl:text>
                                </xsl:element>
                                <xsl:element name="pubPlace" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="ref"><xsl:value-of select="'#50'"/></xsl:attribute>
                                    <xsl:text>Wien</xsl:text>
                                </xsl:element>
                                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="when"></xsl:attribute>
                                </xsl:element>
                                <xsl:element name="num" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'issue'"/></xsl:attribute>
                                    <xsl:sequence select="substring-before(substring-after(., 'https://fackel.oeaw.ac.at/f/'),',0u1')"/>
                                </xsl:element>
                                <xsl:element name="num" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'volume'"/></xsl:attribute>
                                </xsl:element>
                            </xsl:element>
                            
                        </xsl:when>
                                 
                        <!-- Beiträge -->
                        
                        <xsl:otherwise>
                    
                            <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type"><xsl:value-of select="'fackel'"/></xsl:attribute>
                                <xsl:attribute name="corresp"><xsl:value-of select="."/></xsl:attribute>
                                <xsl:attribute name="sortKey"></xsl:attribute>
                                <xsl:element name="author" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="ref"><xsl:value-of select="'#11988'"/></xsl:attribute>
                                    <xsl:text>Karl Kraus</xsl:text>
                                </xsl:element>
                                <xsl:element name="editor" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="ref"><xsl:value-of select="'#11988'"/></xsl:attribute>
                                    <xsl:text>Karl Kraus</xsl:text>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'a'"/></xsl:attribute>
                                    <xsl:attribute name="subtype"><xsl:value-of select="'main'"/></xsl:attribute>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'a'"/></xsl:attribute>
                                    <xsl:attribute name="subtype"><xsl:value-of select="'sub'"/></xsl:attribute>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'b'"/></xsl:attribute>
                                    <xsl:text>Die Fackel</xsl:text>
                                </xsl:element>
                                <xsl:element name="pubPlace" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="ref"><xsl:value-of select="'#50'"/></xsl:attribute>
                                    <xsl:text>Wien</xsl:text>
                                </xsl:element>
                                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="when"></xsl:attribute>
                                </xsl:element>
                                <xsl:element name="num" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'issue'"/></xsl:attribute>
                                    <xsl:sequence select="substring-before(substring-after(., 'https://fackel.oeaw.ac.at/f/'),',')"/>
                                </xsl:element>
                                <xsl:element name="num" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="type"><xsl:value-of select="'volume'"/></xsl:attribute>
                                </xsl:element>
                                <xsl:element name="biblScope" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:text>S. </xsl:text><xsl:sequence select="substring-after(., ',')"/>
                                </xsl:element>
                            </xsl:element>
                    
                        </xsl:otherwise>
                                                
                    </xsl:choose>
                    
                </xsl:for-each>
                                    
            </xsl:element>
            
        </xsl:copy>
        
    </xsl:template>
    
</xsl:stylesheet>