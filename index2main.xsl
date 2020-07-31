<!--
    Auto-generate an entry for the main index at http://ceur-ws.org/index.html from a proceedings volume ToC at http://ceur-ws.org/Vol-###/index.html
    
    This functionality is for the CEUR-WS.org editorial team, not for proceedings editors, but you may use it to get a preview.  Run this via the index2main.sh frontend.
    
    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    © Christoph Lange and contributors 2019–
    
    Licensed under GPLv3 or any later version
-->
<html xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="vol-nr" select="//*[@class='CEURVOLNR'][1]/text()"/>
  <xsl:variable name="urn" select="//*[@class='CEURURN'][1]/text()"/>
  <tr><th colspan="2"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></th></tr>
  <tr>
    <td align="left" bgcolor="#DCDBD7"><b><a name="{ $vol-nr }"><xsl:value-of select="$vol-nr"/></a></b></td>
    <td align="left" bgcolor="#DCDBD7">
      <b><font color="#000000">
        <a href="http://ceur-ws.org/{ $vol-nr }/"><xsl:apply-templates select="//*[@class='CEURVOLTITLE'][1]"/>.</a>
      </font></b></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><font size="-2"><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><br/>
    </font></td>
    <xsl:variable name="ceur-full-title" select="//*[@class='CEURFULLTITLE'][1]"/>
    <xsl:variable name="title-location-time" select="$ceur-full-title/parent::*"/>
    <xsl:variable name="colocated" select="$ceur-full-title/following-sibling[contains(text(), 'co-located with')]"/>
    <td bgcolor="#FFFFFF"><!--
      --><xsl:variable name="title" select="$ceur-full-title/text()"/><!--
      --><xsl:variable name="acronym" select="//*[@class='CEURVOLACRONYM'][1]/text()"/>
      <xsl:value-of select="$title"/><xsl:if test="not(contains(normalize-space(translate($title, '-', ' ')), normalize-space(translate($acronym, '-', ' '))))"> (<xsl:value-of select="$acronym"/>)</xsl:if><xsl:if test="string-length($colocated) &gt; 0">, <xsl:apply-templates select="$colocated"/>
      <xsl:apply-templates select="$title-location-time//*[@class='CEURCOLOCATED'][1]"/>)</xsl:if>,
<xsl:apply-templates select="//*[@class='CEURLOCTIME'][1]"/>.<br/>
Edited by: <xsl:for-each select="//*[@class='CEURVOLEDITOR']"><xsl:apply-templates select="."/><xsl:if test="position() &lt; last()">, </xsl:if></xsl:for-each><br/><!--
--><xsl:variable name="pub-date-span" select="//*[@class='CEURPUBDATE'][last()]"/><!--
--><xsl:variable name="submitted-by-span" select="$pub-date-span/parent::*/text()[contains(., 'submitted by')]"/>
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
