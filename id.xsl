<?xml version="1.0" encoding="utf-8"?>
<!--
    Writes the shorthand identifier for this proceedings volume into a file; executed by “make ID”
    
    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    TODO add further documentation
    
    © Christoph Lange and contributors 2012–2015
    
    Licensed under GPLv3 or any later version
-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:variable name="workshop" select="/workshop"/>
    <xsl:variable name="year" select="year-from-date(xs:date(if ($workshop/date/from) then $workshop/date/from else $workshop/date))"/>
    <xsl:variable name="id" select="concat($workshop/title/id, $year)"/>

    <xsl:value-of select="$id"/>
    
  </xsl:template>
</xsl:stylesheet>


