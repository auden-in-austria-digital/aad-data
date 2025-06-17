<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
        xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        queryBinding="xslt2">
    
    <sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>

    <sch:pattern id="language-validation">
        <sch:title>Language Element Requirements</sch:title>
        
        <sch:rule context="tei:profileDesc">
            <sch:assert test="tei:langUsage">
                profileDesc must contain langUsage element
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="tei:langUsage">
            <sch:assert test="tei:language">
                langUsage must contain at least one language element
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="tei:language">
            <sch:assert test="@ident">
                language must carry ident attribute
            </sch:assert>
            <sch:assert test="@ident = ('de', 'en', 'no', 'sv', 'is', 'fr', 'it', 'hu', 'ru', 'el', 'la')">
                ident attribute must have a permitted value; found: '<sch:value-of select="@ident"/>'
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="change-validation">
        <sch:title>Change Element Requirements</sch:title>
        
        <sch:rule context="tei:revisionDesc">
            <sch:assert test="count(tei:change) >= 2">
                revisionDesc must contain at least two change elements; found: <sch:value-of select="count(tei:change)"/>
            </sch:assert>
            
            <sch:assert test="tei:change[contains(., 'physDesc')]">
                at least one change element must contain string "physDesc"
            </sch:assert>
            
            <sch:assert test="tei:change[contains(., 'transcribed')]">
                at least one change element must contain string "transcribed"
            </sch:assert>
            
            <sch:assert test="tei:change[contains(., 'entities')]">
                at least one change element must contain string "entities"
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="corresp-validation">
        <sch:title>CorrespDesc Requirements</sch:title>
        
        <sch:rule context="tei:titleStmt/tei:title[@level='a']">
            <sch:assert test="not(contains(., ' to ')) or (//tei:correspDesc and count(//tei:correspDesc/tei:correspAction) > 1)">
                documents with titles containing " to " must have correspDesc element with more than one correspAction element
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
</sch:schema>