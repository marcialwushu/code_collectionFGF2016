<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" indent="yes"/>


<!-- global variables -->
<xsl:variable name="newline"><xsl:text>
</xsl:text></xsl:variable>
<xsl:variable name="tizen_uifw" select="'@tizen_core'"/>
<xsl:variable name="replace_path" select="'%tizen-web-ui-fw-path%'"/>
<xsl:variable name="tizen_uifw_path" select="'tizen-web-ui-fw/latest/js'"/>
<xsl:variable name="path" select="/tizenFile/tizenProject/frameworks/framework[@param=$tizen_uifw]/@path"/>
<xsl:variable name="theme" select="/tizenFile/tizenProject/frameworks/variables/variable[@name='theme']/@value"/>
<xsl:variable name="scale" select="/tizenFile/tizenProject/frameworks/variables/variable[@name='viewportmode']/@value"/>

<xsl:template name="print_script">
    <xsl:param name="path"/>    
    <script><xsl:attribute name="src"><xsl:value-of select="$path"/></xsl:attribute></script>
    <xsl:value-of select="$newline"/>
</xsl:template>

<xsl:template name="print_framework">
    <xsl:param name="framework_name"/>    
    <xsl:variable name="framework" select="/tizenFile/tizenProject/frameworks/framework[@param=$framework_name]/@path"/>
    
    <xsl:variable name="result_path">
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text" select="$framework"/>
            <xsl:with-param name="replace" select="$replace_path"/>
            <xsl:with-param name="by" select="$tizen_uifw_path"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="print_script">
        <xsl:with-param name="path" select="$result_path"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="print_scale">
    <xsl:param name="scale"/>
<!--    
    <xsl:variable name="viewport" select="concat('width=', $scale, ',initial-scale=1,user-scalable=no')"/>
-->     
    <xsl:variable name="viewport" select="concat('width=', $scale, ',user-scalable=no')"/>
    <meta name="viewport"><xsl:attribute name="content"><xsl:value-of select="$viewport"/></xsl:attribute>
    </meta>
</xsl:template>

<xsl:template name="print_theme">
    <xsl:param name="theme"/>
    <xsl:variable name="href" select="concat('tizen-web-ui-fw/latest/themes/', $theme, '/tizen-web-ui-fw-theme.css')"/>
    <link rel="stylesheet"> <xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute> <xsl:attribute name="name">tizen-theme</xsl:attribute>
    </link>
</xsl:template>

<!--
<xsl:template name="print_tizen_web_uifW">
-->
<xsl:template name="print_tizen_web_uifw">
    <xsl:variable name="result_path">
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text" select="$path"/>
            <xsl:with-param name="replace" select="$replace_path"/>
            <xsl:with-param name="by" select="$tizen_uifw_path"/>
        </xsl:call-template>
    </xsl:variable>
    <script>
	<xsl:attribute name="src"><xsl:value-of select="$result_path"/></xsl:attribute>
        <xsl:attribute name="data-framework-theme"><xsl:value-of select="$theme"/></xsl:attribute>
<!--        
        <xsl:attribute name="data-framework-viewport-width"><xsl:value-of select="$scale"/></xsl:attribute>
-->        
    </script>
    <xsl:value-of select="$newline"/>
</xsl:template>


<xsl:template name="print_js_pages">
    <xsl:for-each select="/tizenFile/tizenProject/pages/page">
        <xsl:call-template name="print_script">
            <xsl:with-param name="path" select="@managedJsPath"/>
        </xsl:call-template>
        <xsl:call-template name="print_script">
            <xsl:with-param name="path" select="@jsPath"/>
        </xsl:call-template>
    </xsl:for-each>
</xsl:template>

<xsl:template name="print_link">
    <xsl:param name="css_path"/>
    <link rel="stylesheet" type="text/css">
        <xsl:attribute name="href"><xsl:value-of select="$css_path"/></xsl:attribute>
    </link>
</xsl:template>

<xsl:template name="print_css_pages">
    <xsl:for-each select="/tizenFile/tizenProject/pages/page">
        <xsl:call-template name="print_link">
            <xsl:with-param name="css_path" select="@cssPath"/>
        </xsl:call-template>
    </xsl:for-each>
</xsl:template>

<xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <xsl:value-of select="$newline"/>
<xsl:comment>
This file was generated by Tizen Web UI Builder.
This file will be auto-generated each and everytime you save your project.
Do not hand edit this file.
</xsl:comment>
<xsl:value-of select="$newline"/>

<html>
<xsl:value-of select="$newline"/>
    <head>
    <meta charset="utf-8"/>
    <meta name="description" content="A Tizen Web Application Template"/>
    <xsl:call-template name="print_scale">
      <xsl:with-param name="scale" select="$scale"/>
    </xsl:call-template>

    <xsl:call-template name="print_theme">
      <xsl:with-param name="theme" select="$theme"/>
    </xsl:call-template>
	
    <title></title>
    
    <xsl:value-of select="$newline"/>
    <xsl:value-of select="$newline"/>
	
    <xsl:comment> Javascripts </xsl:comment>
    <xsl:value-of select="$newline"/>
    
    <xsl:apply-templates select="/tizenFile/tizenProject/libraries"/>
    <xsl:value-of select="$newline"/>
    
    <xsl:comment> Style sheets </xsl:comment>
    <xsl:value-of select="$newline"/>
    <xsl:apply-templates select="/tizenFile/tizenProject/stylesheets"/>
    </head>
    <body>
    <div data-role="page"></div>
    </body>
<xsl:value-of select="$newline"/>
</html>

</xsl:template>

<xsl:template match="libraries">
    <xsl:for-each select="library">
        <xsl:variable name="start_with" select="substring(@param, 1, 1)"/>
        <xsl:choose>
            <xsl:when test="@param=$tizen_uifw">
                <xsl:call-template name="print_tizen_web_uifw"/>
            </xsl:when>
	        <xsl:when test="@type='framework' and $start_with='@'">
	           <xsl:call-template name="print_framework">
	               <xsl:with-param name="framework_name" select="@param"/>
	           </xsl:call-template>
	        </xsl:when>
	        <xsl:when test="@type='pages'">
	           <xsl:call-template name="print_js_pages"/>
	        </xsl:when>
	        <xsl:otherwise>
	           <xsl:call-template name="print_script">
	               <xsl:with-param name="path" select="@param"/>
	           </xsl:call-template>
	        </xsl:otherwise>
        </xsl:choose>
        
    </xsl:for-each>
</xsl:template>

<xsl:template match="stylesheets">
    <xsl:for-each select="stylesheet">
        <xsl:choose>
            <xsl:when test="@type='user'">
                <xsl:call-template name="print_link">
                    <xsl:with-param name="css_path" select="@param"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>

<xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
        <xsl:when test="contains($text, $replace)">
            <xsl:value-of select="substring-before($text,$replace)" />
            <xsl:value-of select="$by" />
            <xsl:call-template name="string-replace-all">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
                <xsl:with-param name="by" select="$by" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
