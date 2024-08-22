<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs" version="2.0">
  
  <!-- Attention: This stylesheet has not been thoroughly tested or applied. Instead, regex queries were used: https://docs.google.com/document/d/19ENkSmqYwGxD_peqc_k1Np0WCtKVJdH3svHI3C77EaY/edit -->
  
  <xsl:output method="xml" version="1.0" indent="no"/>
  
  <xsl:template match="@* | node()" name="identity-copy">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- lb followed by whitespace -->
  <xsl:variable name="lb-ws" select="//*:lb[@*]/following-sibling::text()[1]"/>
  <xsl:template match="$lb-ws[starts-with(., ' ')]">
    <xsl:value-of select="substring(., 2)"/>
  </xsl:template>
  
  <!-- rs followed by hi (sibling, e. g. <rs/> <hi/>) -->
  <xsl:template
    match="text()[//preceding-sibling::*[1][self::*:rs[@*]]][following-sibling::*[1][self::*:hi[@*]]][string-length(normalize-space()) = 0]"/>
  
  <!-- rs followed by hi / hi as rs' child (e. g. <rs> <hi/> </rs> -->
  <xsl:template
    match='text()[//parent::*[1][self::*:rs[@*] and child::*[1][self::*:hi[@*]]] and normalize-space(.) = ""]'/>
  
  <!-- hi followed by hi (closed/sibling, e. g. <hi/> <hi/>) -->
  <xsl:template
    match="text()[//preceding-sibling::*[1][self::*:hi[@*]]][following-sibling::*[1][self::*:hi[@*]]][string-length(normalize-space()) = 0]"/>
  
  <!-- hi followed by hi (open/child, e. g. <hi> <hi> </hi> </hi>) -->
  <xsl:template
    match='text()[//ancestor::*[1][self::*:hi[@*] and descendant::*[1][self::*:hi[@*]]] and normalize-space(.) = ""]'/>
  
</xsl:stylesheet>
