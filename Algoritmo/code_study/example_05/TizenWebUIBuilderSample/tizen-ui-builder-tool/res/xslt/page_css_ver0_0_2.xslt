<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="utf-8" indent="yes"/>

<xsl:variable name="tab"><xsl:text>    </xsl:text></xsl:variable>
<xsl:variable name="newline"><xsl:text>
</xsl:text></xsl:variable>

<xsl:template match="/">
    <xsl:text><![CDATA[/*******************************************************************************
* This file was generated by Tizen Web UI Builder.
* This file will be auto-generated each and everytime you save your project.
* Do not hand edit this file.
********************************************************************************/
]]></xsl:text>

<xsl:apply-templates select="/tizenFile/document/documentData/tizen.css/tizen.selector"/>

</xsl:template>

<xsl:template match="tizen.selector">
    <xsl:value-of select="concat(@name, ' {', $newline)"/>
    
    <xsl:for-each select="tizen.style">
        <xsl:value-of select="concat($tab, @name, ' : ', @value, ';', $newline)"/>
    </xsl:for-each> 
    
    <xsl:value-of select="concat('}', $newline, $newline)"/>
    

</xsl:template>

</xsl:stylesheet>
