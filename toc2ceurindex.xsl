<!--
    Generates a CEUR-WS.org compliant index.html page from toc.xml and workshop.xml; executed by “make ceur-ws/index.html”

    Compliance usually holds for the time when this code was last revised.
    
    Part of ceur-make (https://github.com/clange/ceur-make/)

    TODO add further documentation
    
    © Christoph Lange 2012
    
    Licensed under GPLv3 or any later version
-->
<!-- Template: http://ceur-ws.org/Vol-XXX/index.html -->
<html
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xsl:version="2.0">
  <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
  <xsl:variable name="year" select="year-from-date(xs:date($workshop/date))"/>
  <xsl:variable name="id" select="concat($workshop/title/id, $year)"/>
  <head>
    <link rel="stylesheet" type="text/css" href="../ceur-ws.css"/>
    <title>CEUR-WS.org/Vol-XXX - <xsl:value-of select="$workshop/title/full"/> (<xsl:value-of select="$workshop/title/acronym"/>)</title>
  </head>

  <!--CEURLANG=eng -->
  <body>


    <table border="0" cellpadding="0" cellspacing="5" width="95%">
      <tbody><tr>
      <td align="left" valign="middle">
        <a href="http://ceur-ws.org/"><img src="../CEUR-WS-logo.png" alt="[CEUR Workshop Proceedings]" border="0"/></a>
      </td>
      <td align="right" valign="middle">

        <span class="CEURVOLNR">Vol-XXX</span> <br/>
        <span class="CEURURN">urn:nbn:de:0074-XXX-C</span>
        <p align="justify"><font color="#777777" size="-2">Copyright © 
        <span class="CEURPUBYEAR"><xsl:value-of select="$year"/></span> for the individual papers
        by the papers' authors. Copying permitted only for private and academic purposes.
        This volume is published and copyrighted by its editors.</font></p>

      </td>
    </tr>
  </tbody></table>

  <hr/>

  <br/><br/><br/>

  <h1><a href="{ $workshop/homepage }"><span class="CEURVOLACRONYM"><xsl:value-of select="$workshop/title/acronym"/> <xsl:value-of select="$year"/></span></a><br/>
  <span class="CEURVOLTITLE"><xsl:value-of select="$workshop/title/volume"/></span></h1>

  <br/>

  <h3>
    <span class="CEURFULLTITLE">Proceedings of the <xsl:value-of select="$workshop/title/full"/></span><br/>
  </h3>
  <h3><span class="CEURLOCTIME"><xsl:value-of select="$workshop/location"/>, <xsl:value-of select="format-date(xs:date($workshop/date), '[MNn] [D1o], [Y]')"/></span>.</h3> 
  <br/>
  <b> Edited by </b>
  <p>

  </p><h3>
  <xsl:for-each select="$workshop/editors/editor">
      <a href="{ homepage }"><span class="CEURVOLEDITOR"><xsl:value-of select="name"/></span></a>, <xsl:value-of select="affiliation"/>, <xsl:value-of select="country"/><br/>
  </xsl:for-each>
</h3>

<hr/>

<br/><br/><br/>

<div class="CEURTOC">
  <h2> Table of Contents </h2>

  <ol>
    <xsl:for-each select="/toc/paper">
        <li><a href="paper-{ format-number(position(), '00') }.pdf"><span class="CEURTITLE"><xsl:value-of select="title"/></span></a> <span class="CEURPAGES"><xsl:value-of select="pages/@from"/>-<xsl:value-of select="pages/@to"/></span> <br/>
    <span class="CEURAUTHORS">
        <xsl:for-each select="authors/author">
            <xsl:value-of select="."/>
            <xsl:if test="position() ne last()">, </xsl:if>
        </xsl:for-each></span><br/></li>
    </xsl:for-each>
  </ol>

</div>

<p>
  The whole proceedings can also be downloaded as a single file (<a href="{ $id }-complete.pdf">PDF</a>, including title pages, preface, and table of contents).
</p>

<p>
  We offer a <a href="{ $id }.bib">BibTeX file</a> for citing papers of this workshop from LaTeX.
</p>

<hr/>
<font color="#777777" size="-1">
  <xsl:value-of select="format-date(current-date(), '[D]-[MNn,*-3]-[Y]')"/>: submitted by <xsl:value-of select="$workshop/editors/editor[@submitting='true']/name"/><br/>
<span class="CEURPUBDATE">dd-mmm-jjjj</span>: published on CEUR-WS.org
</font>
</body></html>


