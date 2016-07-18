<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a CEUR-WS.org compliant index.html page from toc.xml and workshop.xml; executed by “make ceur-ws/index.html”

    Compliance usually holds for the time when this code was last revised.
    
    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    © Christoph Lange and contributors 2012–2015
    
    Licensed under GPLv3 or any later version
-->
<!-- Template: http://ceur-ws.org/Vol-XXX/index.html -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">
  <xsl:output method="html" version="5.0"/><!-- xsl:output/@version is Saxon-specific -->

  <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
  <xsl:variable name="year" select="year-from-date(xs:date(if ($workshop/date/from) then $workshop/date/from else $workshop/date))"/>
  <xsl:variable name="pubyear" select="if ($workshop/pubyear) then $workshop/pubyear else $year"/>
  <xsl:variable name="id" select="concat($workshop/title/id, $year)"/>
  <xsl:variable name="number" select="if ($workshop/number) then $workshop/number else 'XXX'"/>
  <xsl:variable name="volume" select="concat('Vol-', $number)"/>
  <xsl:variable name="volume-url" select="concat('http://ceur-ws.org/', $volume, '/')"/>

  <xsl:variable name="multi-session" select="exists(/toc/session)" as="xs:boolean"/>
  <!-- for performance reasons, the following variable only has a well-defined value when there are multiple sessions, as otherwise we don't need it: -->
  <xsl:variable name="all-papers-across-sessions" select="if ($multi-session) then /toc//paper else ()"/>

  <xsl:template match="/">
    <xsl:comment> CEURVERSION=2015-12-02 </xsl:comment>
    <html
      prefix="bibo: http://purl.org/ontology/bibo/
              event: http://purl.org/NET/c4dm/event.owl#
              time: http://www.w3.org/2006/time#
              swc: http://data.semanticweb.org/ns/swc/ontology#
              xsd: http://www.w3.org/2001/XMLSchema#"
      typeof="bibo:Proceedings">
      <head>
        <meta http-equiv="Content-type" content="text/html;charset=utf-8"/><xsl:comment>Not HTML 5 style; for backwards compatibility</xsl:comment>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="../ceur-ws.css"/>
        <link rel="foaf:page" href="{ $volume-url }"/>
        <title>CEUR-WS.org/<xsl:value-of select="$volume"/> - <xsl:value-of select="$workshop/title/full"/> (<xsl:value-of select="$workshop/title/acronym"/>)</title>
      </head>
    
      <xsl:comment>CEURLANG=<xsl:value-of select="$workshop/language"/></xsl:comment>
      <body>
    
    
        <table style="border: 0; border-spacing: 0; border-collapse: collapse; width: 95%">
          <tbody><tr>
          <td style="text-align: left; vertical-align: middle">
            <a rel="dcterms:partOf" href="http://ceur-ws.org/"><div id="CEURWSLOGO"/></a>
          </td>
          <td style="text-align: right; vertical-align: middle">
    
            <span property="bibo:volume" datatype="xsd:nonNegativeInteger" content="{ $number }" class="CEURVOLNR"><xsl:value-of select="$volume"/></span> <br/>&#xa;
            <span property="bibo:uri dcterms:identifier" class="CEURURN">urn:nbn:de:0074-<xsl:value-of select="$number"/>-C</span>
            <p class="unobtrusive copyright" style="text-align: justify">Copyright © 
            <span class="CEURPUBYEAR"><xsl:value-of select="$pubyear"/></span> for the individual papers
            by the papers' authors. Copying permitted for private and academic purposes.
            This volume is published and copyrighted by its editors.</p>
    
          </td>
        </tr>
      </tbody></table>
    
      <hr/>
    
      <br/><br/><br/>&#xa;
    
      <h1><a rel="foaf:homepage" href="{ $workshop/homepage }"><span about="" property="bibo:shortTitle" class="CEURVOLACRONYM"><xsl:value-of select="$workshop/title/acronym"/><xsl:text> </xsl:text><xsl:value-of select="$year"/></span></a><br/>&#xa;
      <span property="dcterms:alternative" class="CEURVOLTITLE"><xsl:value-of select="$workshop/title/volume"/></span></h1>
    
      <br/>
    
      <h3>
        <span property="dcterms:title" class="CEURFULLTITLE">Proceedings of the <xsl:value-of select="$workshop/title/full"/></span><br/>&#xa;
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
            </xsl:choose><xsl:if test="$workshop/conference/full">)</xsl:if><br/>&#xa;
          </xsl:when>
          <xsl:otherwise>
            <xsl:comment> co-located with &lt;span class="CEURCOLOCATED"&gt;NONE&lt;/span&gt; </xsl:comment>
          </xsl:otherwise>
        </xsl:choose>
        
      </h3>
      <h3><span rel="bibo:presentedAt" typeof="bibo:Workshop" class="CEURLOCTIME"><span rel="event:place" resource="{ replace($workshop/location/@href, 'https?://en\.wikipedia\.org/wiki/', 'http://dbpedia.org/resource/') }"><xsl:value-of select="$workshop/location"/></span>, <xsl:choose>
      <xsl:when test="$workshop/date/from and $workshop/date/to">
        <!--
        Possible output formats:
        different years: (December 31st, 2013) to (January 1st, 2014)
        same year, different months: (November 30th) to (December 1st, 2013)
        same year, same month: (December 30th) to (31st, 2013)
        -->
        <span rel="event:time">
          <xsl:variable name="same-year" select="year-from-date($workshop/date/from) eq year-from-date($workshop/date/to)"/>
          <xsl:variable name="same-year-and-month" select="$same-year and month-from-date($workshop/date/from) eq month-from-date($workshop/date/to)"/>
          <span rel="time:hasBeginning">
            <span property="time:inXSDDateTime" content="{ $workshop/date/from }" datatype="xsd:date"><xsl:value-of select="format-date(xs:date($workshop/date/from), concat('[MNn] [D1o]', if (not($same-year)) then ', [Y]' else ''))"/></span>
          </span>
          to
          <span rel="time:hasEnd">
            <span property="time:inXSDDateTime" content="{ $workshop/date/to }" datatype="xsd:date"><xsl:value-of select="format-date(xs:date($workshop/date/to), concat(if (not($same-year-and-month)) then '[MNn] ' else '', '[D1o], [Y]'))"/></span>
          </span>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span property="dcterms:date" content="{ $workshop/date }" datatype="xsd:date"><xsl:value-of select="format-date(xs:date($workshop/date), '[MNn] [D1o], [Y]')"/></span>
      </xsl:otherwise>
      </xsl:choose></span>.</h3> 
      <br/>&#xa;
      <b> Edited by </b>
      <p>
    
      </p><h3 rel="bibo:editor">
      <xsl:for-each select="$workshop/editors/editor">
        <xsl:choose>
          <xsl:when test="homepage">
            <a href="{ homepage }"><span property="foaf:name" class="CEURVOLEDITOR"><xsl:value-of select="name"/></span></a>
          </xsl:when>
          <xsl:otherwise>
            <span about="_:{ generate-id() }" property="foaf:name" class="CEURVOLEDITOR"><xsl:value-of select="name"/></span>
          </xsl:otherwise>
        </xsl:choose>, <xsl:value-of select="affiliation"/>, <xsl:value-of select="country"/><br/>&#xa;
      </xsl:for-each>
    </h3>
    
    <hr/>
    
    <br/><br/><br/>&#xa;
    
    <div class="CEURTOC">
      <h2> Table of Contents </h2>

      <!-- <toc> is expected to either contain a sequence of <paper> elements or a sequence of <session> elements.  However we also gracefully handle the occurrence of both, in which case we first output all <paper>s without a session, then the <session>s. -->
      <xsl:if test="/toc/paper">
        <ul rel="dcterms:hasPart">
          <xsl:apply-templates select="/toc/paper"/>
        </ul>
      </xsl:if>

      <xsl:apply-templates select="/toc/session"/>
    </div>
    
    <p>
      We offer a <a href="{ $id }.bib">BibTeX file</a> for citing papers of this workshop from LaTeX.
    </p>
    
    <hr/>
    <span class="unobtrusive">
      <xsl:value-of select="format-date(current-date(), (: old format: '[D]-[MNn,*-3]-[Y]' :) '[Y]-[M,2]-[D,2]')"/>: submitted by <xsl:value-of select="$workshop/editors/editor[@submitting='true']/name"/>, metadata incl. bibliographic data published under <a href="http://creativecommons.org/publicdomain/zero/1.0/">Creative Commons CC0</a><br/>&#xa;
    <span property="dcterms:issued" datatype="xsd:date" class="CEURPUBDATE">yyyy-mm-dd</span>: published on CEUR-WS.org
|<a href="https://validator.w3.org/nu/?doc=http%3A%2F%2Fceur-ws.org%2F{ $volume }%2F">valid HTML5</a>|
    </span>
    </body></html>
  </xsl:template>

  <xsl:template match="session">
    <h3><span class="CEURSESSION">Session <xsl:number/><xsl:if test="title">
      <xsl:text>: </xsl:text>
      <xsl:value-of select="title"/>
    </xsl:if></span></h3>

    <ul rel="dcterms:hasPart">
      <xsl:apply-templates select="paper"/>
    </ul>
  </xsl:template>
    
  <xsl:template match="paper">
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="@id != ''">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- determine the number of this <paper> element among all <paper> elements in document order (including those in different <session> branches)-->
          <!-- http://stackoverflow.com/a/3562716/2397768 -->
          <xsl:variable name="position">
            <xsl:choose>
              <xsl:when test="$multi-session">
                <xsl:variable name="prev-papers-in-same-session" select="preceding::paper"/>
                <xsl:variable name="ancestors" select="ancestor::node()"/>
                <!-- $ns1[count(.|$ns2) = count($ns2)] == $ns1 intersect $ns2 -->
                <xsl:variable name="prev-papers-in-other-branches" select="
                  $all-papers-across-sessions
                    [count(.|$prev-papers-in-same-session) = count($prev-papers-in-same-session)
                    or
                    count(.|$ancestors) = count($ancestors)]"/>
                <xsl:value-of select="count($prev-papers-in-other-branches) + 1"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:value-of select="concat('paper-', format-number($position, '00'))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="pdf" select="concat($id, '.pdf')"/>
    <li id="{ $id }" typeof="bibo:Article" about="#{ $id }"><span rel="dcterms:relation"><a typeof="bibo:Document" href="{ $pdf }"><span property="dcterms:format" content="application/pdf"/><span property="bibo:uri" content="{ resolve-uri($pdf, $volume-url) }"/><span about="#{ $id }" property="dcterms:title" class="CEURTITLE"><xsl:value-of select="title"/></span></a></span><xsl:if test="pages"> <span class="CEURPAGES"><span property="bibo:pageStart" datatype="xsd:nonNegativeInteger"><xsl:value-of select="pages/@from"/></span>-<span property="bibo:pageEnd" datatype="xsd:nonNegativeInteger"><xsl:value-of select="pages/@to"/></span></span> </xsl:if><br/>&#xa;
    <xsl:for-each select="authors/author">
        <span rel="dcterms:creator"><span property="foaf:name" class="CEURAUTHOR"><xsl:value-of select="."/></span></span>
        <xsl:if test="position() ne last()">, </xsl:if>
        </xsl:for-each><br/></li>&#xa;
  </xsl:template>
</xsl:stylesheet>

<!--
Local Variables:
mode: nxml
nxml-child-indent: 2
End:
-->
