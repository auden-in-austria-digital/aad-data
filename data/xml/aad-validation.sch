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
            <sch:assert test="@ident = ('de', 'en')">
                ident attribute must be either 'de' or 'en'; found: '<value-of select="@ident"/>'
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
</sch:schema>