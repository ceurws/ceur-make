<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a CEUR-WS.org compliant index.html page from toc.xml and workshop.xml; executed by “make ceur-ws/index.html”

    Compliance usually holds for the time when this code was last revised.
    
    Part of ceur-make (https://github.com/clange/ceur-make/)

    TODO add further documentation
    
    © Christoph Lange 2012–2013
    
    Licensed under GPLv3 or any later version
-->
<!-- Template: http://ceur-ws.org/Vol-XXX/index.html -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">
  <xsl:output method="html" version="5.0"/><!-- xsl:output/@version is Saxon-specific -->

  <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
  <xsl:variable name="year" select="year-from-date(xs:date($workshop/date))"/>
  <xsl:variable name="pubyear" select="if ($workshop/pubyear) then $workshop/pubyear else $year"/>
  <xsl:variable name="id" select="concat($workshop/title/id, $year)"/>
  <xsl:variable name="number" select="if ($workshop/number) then $workshop/number else 'XXX'"/>
  <xsl:variable name="volume" select="concat('Vol-', $number)"/>
  <xsl:variable name="volume-url" select="concat('http://ceur-ws.org/', $volume, '/')"/>

  <xsl:template match="/">
    <xsl:comment> CEURVERSION=2013-12-02 </xsl:comment>
    <html
      prefix="bibo: http://purl.org/ontology/bibo/
              event: http://purl.org/NET/c4dm/event.owl#
              swc: http://data.semanticweb.org/ns/swc/ontology#
              xsd: http://www.w3.org/2001/XMLSchema#"
      typeof="bibo:Proceedings">
      <head>
        <meta http-equiv="Content-type" content="text/html;charset=windows-1252"/><xsl:comment>Not HTML 5 style; for backwards compatibility</xsl:comment>
        <link rel="stylesheet" type="text/css" href="../ceur-ws.css"/>
        <link rel="foaf:page" href="{ $volume-url }"/>
        <title>CEUR-WS.org/<xsl:value-of select="$volume"/> - <xsl:value-of select="$workshop/title/full"/> (<xsl:value-of select="$workshop/title/acronym"/>)</title>
      </head>
    
      <xsl:comment>CEURLANG=<xsl:value-of select="$workshop/language"/></xsl:comment>
      <body>
    
    
        <table style="border: 0; border-spacing: 0; border-collapse: collapse; width: 95%">
          <tbody><tr>
          <td style="text-align: left; vertical-align: middle">
            <a rel="dcterms:partOf" href="http://ceur-ws.org/"><img src="../CEUR-WS-logo.png" alt="[CEUR Workshop Proceedings]" style="border: 0"/></a>
          </td>
          <td style="text-align: right; vertical-align: middle">
    
            <span property="bibo:volume" content="{ $number }" class="CEURVOLNR"><xsl:value-of select="$volume"/></span> <br/>
            <span property="bibo:uri dcterms:identifier" class="CEURURN">urn:nbn:de:0074-<xsl:value-of select="$number"/>-C</span>
            <p class="unobtrusive copyright" style="text-align: justify">Copyright © 
            <span class="CEURPUBYEAR"><xsl:value-of select="$pubyear"/></span> for the individual papers
            by the papers' authors. Copying permitted only for private and academic purposes.
            This volume is published and copyrighted by its editors.</p>
    
          </td>
        </tr>
      </tbody></table>
    
      <hr/>
    
      <br/><br/><br/>
    
      <h1><a rel="foaf:homepage" href="{ $workshop/homepage }"><span about="" property="bibo:shortTitle" class="CEURVOLACRONYM"><xsl:value-of select="$workshop/title/acronym"/><xsl:text> </xsl:text><xsl:value-of select="$year"/></span></a><br/>
      <span property="dcterms:alternative" class="CEURVOLTITLE"><xsl:value-of select="$workshop/title/volume"/></span></h1>
    
      <br/>
    
      <h3>
        <span property="dcterms:title" class="CEURFULLTITLE">Proceedings of the <xsl:value-of select="$workshop/title/full"/></span><br/>
        <xsl:choose>
          <xsl:when test="$workshop/conference">
            co-located with <xsl:if test="$workshop/conference/full"><xsl:value-of select="$workshop/conference/full"/> (</xsl:if>
            <xsl:choose>
              <xsl:when test="$workshop/conference/homepage">
                <a rel="swc:isSubEventOf" href="{ $workshop/conference/homepage }"><span class="CEURCOLOCATED"><xsl:value-of select="$workshop/conference/acronym"/></span></a>
              </xsl:when>
              <xsl:otherwise>
                <span class="CEURCOLOCATED"><xsl:value-of select="$workshop/conference/acronym"/></span>
              </xsl:otherwise>
            </xsl:choose><xsl:if test="$workshop/conference/full">)</xsl:if><br/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:comment> co-located with &lt;span class="CEURCOLOCATED"&gt;NONE&lt;/span&gt; </xsl:comment>
          </xsl:otherwise>
        </xsl:choose>
        
      </h3>
      <h3><span rel="bibo:presentedAt" typeof="bibo:Workshop" class="CEURLOCTIME"><span rel="event:place" resource="{ replace($workshop/location/@href, 'https?://en\.wikipedia\.org/wiki/', 'http://dbpedia.org/resource/') }"><xsl:value-of select="$workshop/location"/></span>, <span property="dcterms:date" content="{ $workshop/date }" datatype="xsd:date"><xsl:value-of select="format-date(xs:date($workshop/date), '[MNn] [D1o], [Y]')"/></span></span>.</h3> 
      <br/>
      <b> Edited by </b>
      <p>
    
      </p><xsl:comment> TODO If your editors have FOAF profiles, please manually add resource="foaf-profile" in addition to href="homepage" for each editor.&#xa;Then remove this comment. </xsl:comment><h3 rel="bibo:editor">
      <xsl:for-each select="$workshop/editors/editor">
          <a href="{ homepage }"><span property="foaf:name" class="CEURVOLEDITOR"><xsl:value-of select="name"/></span></a>, <xsl:value-of select="affiliation"/>, <xsl:value-of select="country"/><br/>
      </xsl:for-each>
    </h3>
    
    <hr/>
    
    <br/><br/><br/>
    
    <div class="CEURTOC">
      <h2> Table of Contents </h2>
    
      <ol rel="dcterms:hasPart">
        <xsl:for-each select="/toc/paper">
          <xsl:variable name="id" select="concat('paper-', format-number(position(), '00'))"/>
          <xsl:variable name="pdf" select="concat($id, '.pdf')"/>
          <li id="{ $id }" typeof="bibo:Article" about="#{ $id }"><span rel="dcterms:relation"><a typeof="bibo:Document" href="{ $pdf }"><span property="dcterms:format" content="application/pdf"/><span property="bibo:uri" content="{ resolve-uri($pdf, $volume-url) }"/><span about="#{ $id }" property="dcterms:title" class="CEURTITLE"><xsl:value-of select="title"/></span></a></span><xsl:if test="pages"> <span class="CEURPAGES"><span property="bibo:pageStart"><xsl:value-of select="pages/@from"/></span>-<span property="bibo:pageEnd"><xsl:value-of select="pages/@to"/></span></span> </xsl:if><br/>
        <xsl:comment> TODO If your authors have FOAF profiles, manually add resource="foaf-profile" to each outer &lt;span rel="dcterms:creator"&gt;; otherwise, if they have homepages and you want to link to them, manually add rel="foaf:homepage" resource="homepage" to each inner &lt;span property="foaf:name"&gt;.&#xa;Then remove this comment. </xsl:comment> 
        <span class="CEURAUTHORS">
            <xsl:for-each select="authors/author">
              <span rel="dcterms:creator"><span property="foaf:name"><xsl:value-of select="."/></span></span>
              <xsl:if test="position() ne last()">, </xsl:if>
            </xsl:for-each></span><br/></li>
        </xsl:for-each>
      </ol>
    
    </div>
    
    <p rel="dcterms:relation">
      <xsl:variable name="pdf" select="concat($id, '-complete.pdf')"/>
      <span about="{ $pdf }" typeof="bibo:Document">
      The whole proceedings can also be downloaded as a single file (<span property="dcterms:format" content="application/pdf"/><a property="bibo:uri" content="{ $volume-url }{ $pdf }" href="{ $pdf }">PDF</a>, including title pages, preface, and table of contents).
    </span></p>
    
    <p>
      We offer a <a href="{ $id }.bib">BibTeX file</a> for citing papers of this workshop from LaTeX.
    </p>
    
    <hr/>
    <span class="unobtrusive">
      <xsl:value-of select="format-date(current-date(), (: old format: '[D]-[MNn,*-3]-[Y]' :) '[Y]-[M,2]-[D,2]')"/>: submitted by <xsl:value-of select="$workshop/editors/editor[@submitting='true']/name"/><br/>
    <span property="dcterms:issued" content="yyyy-mm-dd" class="CEURPUBDATE">yyyy-mm-dd</span>: published on CEUR-WS.org
|<a href="http://validator.w3.org/check?uri=http%3A%2F%2Fceur-ws.org%2F{ $volume }%2F">valid HTML5</a>|
    </span>
    </body></html>
    
  </xsl:template>
</xsl:stylesheet>

<!--
Local Variables:
mode: nxml
nxml-child-indent: 2
End:
-->
