<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a BibTeX database for the proceedings volume; executed by “make ceur-ws/temp.bib”

    The BibTeX entries contain some fields only supported by BibLaTeX (http://ctan.org/pkg/biblatex), which is strongly recommended for using this BibTeX database, but it will also be usable with plain BibTeX.
    
    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    © Christoph Lange and contributors 2012–2015
    
    Licensed under GPLv3 or any later version
-->
<xsl:stylesheet version="2.0"
  xmlns:ex="http://example.org"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
  <xsl:variable name="year" select="year-from-date(xs:date(if ($workshop/date/from) then $workshop/date/from else $workshop/date))"/>
  <xsl:variable name="volume-id" select="concat($workshop/title/acronym, $year)"/>
  <xsl:variable name="volume-url" select="concat('http://ceur-ws.org/Vol-', $workshop/number, '/')"/>

  <xsl:template name="entry">
      <xsl:param name="type"/>
      <xsl:param name="id"/>
      <xsl:param name="content"/>
      <xsl:text>@</xsl:text>
      <xsl:value-of select="$type"/>
      <xsl:text>{</xsl:text>
      <xsl:if test="$id">
          <xsl:value-of select="$id"/>
          <xsl:text>,</xsl:text>
      </xsl:if>
      <xsl:if test="$type ne 'comment'">
          <xsl:text>&#xa;</xsl:text>
      </xsl:if>
      <xsl:copy-of select="$content"/>
      <xsl:text>}&#xa;&#xa;</xsl:text>
  </xsl:template>

  <xsl:template name="field">
      <xsl:param name="name"/>
      <xsl:param name="content"/>
      <xsl:param name="type"/>
      <xsl:value-of select="$name"/>
      <xsl:text> = </xsl:text>
      <xsl:if test="$type ne 'number'">
          <xsl:text>{</xsl:text>
      </xsl:if>
      <xsl:value-of select="$content"/>
      <xsl:if test="$type ne 'number'">
          <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>,&#xa;</xsl:text>
  </xsl:template>

  <xsl:function name="ex:familyName">
      <xsl:param name="author"/>
      <xsl:value-of select="tokenize($author, ' ')[last()]"/>
  </xsl:function>

  <xsl:function name="ex:id-from-authors">
      <xsl:param name="authors"/>
      <xsl:value-of select="concat(ex:familyName($authors/author[1]), if (count($authors/author) eq 2) then ex:familyName($authors/author[2]) else if (count($authors/author) gt 2) then 'EtAl' else '')"/>
  </xsl:function>

  <xsl:template match="paper">
      <xsl:variable name="paperurl">
	  <xsl:choose>
	      <xsl:when test="@id != ''">
		  <xsl:value-of select="concat($volume-url, '#', @id)"/>
	      </xsl:when>
	      <xsl:otherwise>
		  <xsl:value-of select="concat($volume-url, '#paper-', format-number(position(), '00'))"/>
	      </xsl:otherwise>
	  </xsl:choose>
      </xsl:variable>
      
      <xsl:call-template name="entry">
          <xsl:with-param name="type">inproceedings</xsl:with-param>
          <xsl:with-param name="id" select="concat(ex:id-from-authors(authors), ':', $volume-id)"/>
          <xsl:with-param name="content">
              <xsl:call-template name="field">
                  <xsl:with-param name="name">title</xsl:with-param>
                  <xsl:with-param name="content" select="title"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">author</xsl:with-param>
                  <xsl:with-param name="content" select="ex:name-list(authors/author)"/>
              </xsl:call-template>
              <xsl:if test="pages">
                  <xsl:call-template name="field">
                      <xsl:with-param name="name">pages</xsl:with-param>
                      <xsl:with-param name="content" select="concat(pages/@from, '--', pages/@to)"/>
                  </xsl:call-template>
              </xsl:if>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">url</xsl:with-param>
                  <xsl:with-param name="content" select="$paperurl"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">crossref</xsl:with-param>
                  <xsl:with-param name="content" select="$volume-id"/>
              </xsl:call-template>
          </xsl:with-param>
      </xsl:call-template>
  </xsl:template>

  <xsl:function name="ex:name-list">
      <xsl:param name="names"/>
      <xsl:for-each select="$names">
          <xsl:value-of select="."/>
          <xsl:if test="position() ne last()">
              <xsl:text> and </xsl:text>
          </xsl:if>
      </xsl:for-each>
  </xsl:function>
  
  <xsl:template match="/toc">
      <xsl:call-template name="entry">
          <xsl:with-param name="type">comment</xsl:with-param>
          <xsl:with-param name="content">It is strongly recommended to use BibLaTeX for these entries</xsl:with-param>
      </xsl:call-template>

      <xsl:apply-templates select="descendant::paper"/>

      <xsl:variable name="title" select="concat($workshop/title/full, ' (', $workshop/title/acronym, ')')"/>
      <xsl:call-template name="entry">
          <xsl:with-param name="type">proceedings</xsl:with-param>
          <xsl:with-param name="id" select="$volume-id"/>
          <xsl:with-param name="content">
              <xsl:call-template name="field">
                  <xsl:with-param name="name">booktitle</xsl:with-param>
                  <xsl:with-param name="content" select="$title"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">title</xsl:with-param>
                  <xsl:with-param name="content" select="concat('Proceedings of the ', $title)"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">year</xsl:with-param>
                  <xsl:with-param name="type">number</xsl:with-param>
                  <xsl:with-param name="content" select="$year"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">editor</xsl:with-param>
                  <xsl:with-param name="content" select="ex:name-list($workshop/editors/editor/name)"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">number</xsl:with-param>
                  <xsl:with-param name="type">number</xsl:with-param>
                  <xsl:with-param name="content" select="$workshop/number"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">series</xsl:with-param>
                  <xsl:with-param name="content">CEUR Workshop Proceedings</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">address</xsl:with-param>
                  <xsl:with-param name="content">Aachen</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">issn</xsl:with-param>
                  <xsl:with-param name="content">1613-0073</xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">url</xsl:with-param>
                  <xsl:with-param name="content" select="$volume-url"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">venue</xsl:with-param>
                  <xsl:with-param name="content" select="$workshop/location"/>
              </xsl:call-template>
              <xsl:call-template name="field">
                  <xsl:with-param name="name">eventdate</xsl:with-param>
                  <xsl:with-param name="content">
                      <xsl:choose>
                        <xsl:when test="$workshop/date/from and $workshop/date/to">
                            <xsl:value-of select="concat($workshop/date/from, '/', $workshop/date/to)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$workshop/date"/>
                        </xsl:otherwise>
                      </xsl:choose>
                  </xsl:with-param>
              </xsl:call-template>
          </xsl:with-param>
      </xsl:call-template>
  </xsl:template>
    
</xsl:stylesheet>

<!--
Local Variables:
mode: nxml
nxml-child-indent: 4
End:
-->
