<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a LaTeX table of contents for an all-in-one PDF proceedings volume; executed by “make toc.tex”

    Please see this rule in Makefile for further explanations.
    
    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    TODO add further documentation
    
    © Christoph Lange and contributors 2012–2015
    
    Licensed under GPLv3 or any later version
-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <xsl:variable name="volume-number" select="9999"/>
  
  <xsl:template match="paper">
      <xsl:variable name="volume-and-page">
          <xsl:value-of select="$volume-number"/>
          <xsl:number format="0001" value="pages/@from"/>
      </xsl:variable>
      <xsl:text>\add{</xsl:text>
      <xsl:value-of select="$volume-and-page"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$volume-and-page"/>
      <xsl:text>}{</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>}{</xsl:text>
      <xsl:for-each select="authors/author">
          <xsl:if test="position() > 1">
              <xsl:choose>
                  <xsl:when test="position() = last()">
                      <xsl:text> and </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:text>, </xsl:text>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:if>
          <xsl:value-of select="."/>
      </xsl:for-each>
      <xsl:text>}</xsl:text>
  </xsl:template>
    
</xsl:stylesheet>

<!--
Local Variables:
mode: nxml
nxml-child-indent: 4
End:
-->
