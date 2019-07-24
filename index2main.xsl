<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="vol-nr" select="//*[@class='CEURVOLNR'][1]/text()"/>
  <xsl:variable name="urn" select="//*[@class='CEURURN'][1]/text()"/>
  <tr><th colspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></th></tr>
  <tr>
    <td align="left" bgcolor="#DCDBD7"><b><a name="{ $vol-nr }"><xsl:value-of select="$vol-nr"/></a></b></td>
    <td align="left" bgcolor="#DCDBD7">
      <b><font color="#000000">
        <a href="http://ceur-ws.org/{ $vol-nr }/"><xsl:value-of select="//*[@class='CEURVOLTITLE'][1]/text()"/>.</a>
      </font></b></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><font size="-2"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><br/>
    </font></td>
    <xsl:variable name="ceur-full-title" select="//*[@class='CEURFULLTITLE'][1]"/>
    <xsl:variable name="title-location-time" select="$ceur-full-title/parent::*"/>
    <xsl:variable name="colocated" select="$ceur-full-title/following-sibling::text()[contains(., 'co-located with')]"/>
    <td bgcolor="#FFFFFF">
      <xsl:value-of select="$ceur-full-title/text()"/> (<xsl:value-of select="//*[@class='CEURVOLACRONYM'][1]/text()"/>),<xsl:if test="string-length($colocated) &gt; 0"><xsl:value-of select="$colocated"/>
        <xsl:value-of select="$title-location-time/*[@class='CEURCOLOCATED'][1]/text()"/>)</xsl:if>
<xsl:value-of select="$title-location-time/*[@class='CEURLOCTIME'][1]/text()"/>.<br/>
Edited by: <xsl:for-each select="//*[@class='CEURVOLEDITOR'][1]/text()"><xsl:value-of select="."/><xsl:if test="position() &lt; last()">, </xsl:if></xsl:for-each><br/><!--
--><xsl:variable name="pub-date-span" select="//*[@class='CEURPUBDATE'][last()]"/><!--
--><xsl:variable name="submitted-by-span" select="$pub-date-span/parent::*/text()[contains(., 'submitted by')]"/>
<xsl:message>XXX<xsl:value-of select="$submitted-by-span/parent::*"/></xsl:message>
Submitted by: <xsl:value-of select="substring-before(substring-after($submitted-by-span, 'submitted by '), ',')"/><br/><!--
--><xsl:variable name="pub-date" select="$pub-date-span/text()"/><!-- assumed to look like YYYY-MM-DD
--><xsl:variable name="pub-month" select="substring($pub-date, 6, 2)"/>
Published on CEUR-WS: <xsl:value-of select="number(substring($pub-date, 9, 2))"/>-<xsl:choose>
  <xsl:when test="$pub-month = 1">Jan</xsl:when>
  <xsl:when test="$pub-month = 2">Feb</xsl:when>
  <xsl:when test="$pub-month = 3">Mar</xsl:when>
  <xsl:when test="$pub-month = 4">Apr</xsl:when>
  <xsl:when test="$pub-month = 5">May</xsl:when>
  <xsl:when test="$pub-month = 6">Jun</xsl:when>
  <xsl:when test="$pub-month = 7">Jul</xsl:when>
  <xsl:when test="$pub-month = 8">Aug</xsl:when>
  <xsl:when test="$pub-month = 9">Sep</xsl:when>
  <xsl:when test="$pub-month = 10">Oct</xsl:when>
  <xsl:when test="$pub-month = 11">Nov</xsl:when>
  <xsl:when test="$pub-month = 12">Dec</xsl:when>
</xsl:choose>-<xsl:value-of select="substring($pub-date, 1, 4)"/><br/>
ONLINE: <a href="http://ceur-ws.org/{ $vol-nr }/">http://ceur-ws.org/<xsl:value-of select="$vol-nr"/>/</a><br/>
URN: <a href="https://nbn-resolving.org/{ $urn }"><xsl:value-of select="$urn"/></a><br/>
ARCHIVE: <a href="ftp://SunSITE.Informatik.RWTH-Aachen.DE/pub/publications/CEUR-WS/{ $vol-nr }.zip">
         ftp://SunSITE.Informatik.RWTH-Aachen.DE/pub/publications/CEUR-WS/<xsl:value-of select="$vol-nr"/>.zip</a>
    </td>
  </tr>
</html>
