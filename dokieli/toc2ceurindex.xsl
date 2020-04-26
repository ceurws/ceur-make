<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a CEUR-WS.org compliant index.html page from toc.xml and workshop.xml; executed by “make ceur-ws/index.html”

    Compliance usually holds for the time when this code was last revised.

    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    © Christoph Lange and contributors 2012–2015
    Sarven Capadisli 2015-2020

    Licensed under GPLv3 or any later version
-->
<!-- Template: http://ceur-ws.org/Vol-XXX/index.html -->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs xsl"
                version="2.0">
    <xsl:output include-content-type="no" method="xhtml" omit-xml-declaration="yes" encoding="utf-8" indent="yes"/>

    <xsl:param name="all-in-one" select="false()" as="xs:boolean"/>

    <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
    <xsl:variable name="year" select="year-from-date(xs:date(if ($workshop/date/from) then $workshop/date/from else $workshop/date))"/>
    <xsl:variable name="pubyear" select="if ($workshop/pubyear) then $workshop/pubyear else $year"/>
    <xsl:variable name="id" select="concat($workshop/title/id, $year)"/>
    <xsl:variable name="number" select="if ($workshop/number) then $workshop/number else 'XXX'"/>
    <xsl:variable name="volume" select="concat('Vol-', $number)"/>
    <xsl:variable name="volume-url" select="concat('http://ceur-ws.org/', $volume, '/')"/>

    <xsl:variable name="multi-session" select="exists(/toc/session)" as="xs:boolean"/>
    <xsl:variable name="all-papers-across-sessions" select="if ($multi-session) then /toc//paper else ()"/>

    <xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
<xsl:comment>CEURVERSION=2020-04-03</xsl:comment>
<xsl:text>
</xsl:text>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <meta charset="utf-8"/>
        <title>CEUR-WS.org/<xsl:value-of select="$volume"/> - <xsl:value-of select="$workshop/title/full"/> (<xsl:value-of select="$workshop/title/acronym"/>)</title>
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <link rel="stylesheet" media="all" title="CEUR-WS" href="../ceur-ws.css" />
        <link rel="stylesheet" media="all" title="CEUR-WS" href="../ceur-ws-semantic.css" />
    </head>

    <body about="" prefix="schema: https://schema.org/ bibo: http://purl.org/ontology/bibo/">
        <header>
            <address>
              <a href="http://ceur-ws.org/"><img alt="CEUR-WS" height="100" src="http://ceur-ws.org/CEUR-WS-logo.png" width="390" /></a>
            </address>

            <dl id="document-identifier">
                <dt>Identifier</dt>
                <dd><a href="{$volume-url}" rel="owl:sameAs"><xsl:value-of select="$volume-url"/></a></dd>
                <dt>Volume</dt>
                <dd class="CEURVOLNR" lang="" property="bibo:volume" xml:lang=""><xsl:value-of select="$volume"/></dd>
                <dt>URN</dt>
                <dd class="CEURURN" lang="" property="bibo:uri" xml:lang="">urn:nbn:de:0074-<xsl:value-of select="$number"/>-C</dd>
            </dl>

            <dl id="document-language">
                <dt>Language</dt>
                <dd class="CEURLANG" lang="" property="schema:inLanguage" xml:lang=""><xsl:value-of select="$workshop/language"/></dd>
            </dl>

            <dl id="document-license">
                <dt>License</dt>
                <dd><img alt="CC BY" height="35" src="http://ceur-ws.org/cc-by_100x35.png" width="100" /> <span>Copyright © <span class="CEURPUBYEAR"><xsl:value-of select="$pubyear"/></span> for the individual papers by the papers' authors. Copyright © <span class="CEURPUBYEAR"><xsl:value-of select="$pubyear"/></span> for the volume as a collection by its editors. This volume and its papers are published under the Creative Commons License Attribution 4.0 International <a href="https://creativecommons.org/licenses/by/4.0/">(<span class="CEURLIC">CC BY 4.0</span>)</a>.</span></dd>
            </dl>
        </header>

        <main>
            <article about="" lang="" typeof="schema:Article bibo:Proceedings" xml:lang="">
                <h1><a class="CEURVOLACRONYM" rel="schema:url" href="{ $workshop/homepage }" property="bibo:shortTitle schema:alternateName"><xsl:value-of select="$workshop/title/acronym"/><xsl:text> </xsl:text><xsl:value-of select="$year"/></a><xsl:text> </xsl:text><span class="CEURVOLTITLE" property="schema:name"><xsl:value-of select="$workshop/title/volume"/></span></h1>

                <dl id="document-event" rel="bibo:presentedAt" resource="#event">
                    <dt resource="#event" typeof="schema:Event">Event</dt>
                    <dd property="schema:description">
                        <span class="CEURFULLTITLE" property="schema:name"><xsl:value-of select="$workshop/title/full"/></span>
                        <xsl:choose>
                            <xsl:when test="$workshop/conference">
                                <xsl:text> co-located with </xsl:text>
                                <xsl:if test="$workshop/conference/full"><xsl:value-of select="$workshop/conference/full"/> (</xsl:if>
                                <span class="CEURCOLOCATED">
                                <xsl:choose>
                                    <xsl:when test="$workshop/conference/homepage">
                                        <a href="{ $workshop/conference/homepage }" rel="schema:isPartOf"><xsl:value-of select="$workshop/conference/acronym"/></a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$workshop/conference/acronym"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                </span>
                                <xsl:if test="$workshop/conference/full">)</xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:comment> co-located with &lt;span class="CEURCOLOCATED"&gt;NONE&lt;/span&gt; </xsl:comment>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dd>
                    <dt>Location</dt>
                    <dd class="CEURLOCATION" rel="schema:location" resource="{ replace($workshop/location/@href, 'https?://en\.wikipedia\.org/wiki/', 'http://dbpedia.org/resource/') }"><xsl:value-of select="$workshop/location"/></dd>
                    <dt>Date</dt>
                    <dd class="CEURTIME">
                        <xsl:choose>
                            <xsl:when test="$workshop/date/from and $workshop/date/to">
                                <!--
                                Possible output formats:
                                different years: (December 31st, 2013) to (January 1st, 2014)
                                same year, different months: (November 30th) to (December 1st, 2013)
                                same year, same month: (December 30th) to (31st, 2013)
                                -->
                                <xsl:variable name="same-year" select="year-from-date($workshop/date/from) eq year-from-date($workshop/date/to)"/>
                                <xsl:variable name="same-year-and-month" select="$same-year and month-from-date($workshop/date/from) eq month-from-date($workshop/date/to)"/>
                                <time datetime="{ $workshop/date/from }" datatype="xsd:dateTime" property="schema:startDate"><xsl:value-of select="format-date(xs:date($workshop/date/from), concat('[MNn] [D1o]', if (not($same-year)) then ', [Y]' else ''))"/></time>
                                <xsl:text> to </xsl:text>
                                <time datetime="{ $workshop/date/to }" datatype="xsd:dateTime" property="schema:endDate"><xsl:value-of select="format-date(xs:date($workshop/date/to), concat(if (not($same-year-and-month)) then '[MNn] ' else '', '[D1o], [Y]'))"/></time>
                            </xsl:when>
                            <xsl:otherwise>
                                <time datetime="{ $workshop/date }" datatype="xsd:date" property="schema:startDate schema:endDate"><xsl:value-of select="format-date(xs:date($workshop/date), '[MNn] [D1o], [Y]')"/></time>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dd>
                </dl>

                <div id="authors">
                    <dl id="author-name">
                        <dt>Edited by</dt>
                        <xsl:for-each select="$workshop/editors/editor">
                            <xsl:variable name="editorIRI">
                                <xsl:text>#</xsl:text>
                                <xsl:value-of select="replace(normalize-space(name), '\s+', '-')"/>
                            </xsl:variable>
                            <dd id="author-{position()}" rel="bibo:editor" resource="{$editorIRI}"><span about="" rel="schema:editor{if (@submitting='true') then ' schema:creator' else ''}">
                            <xsl:choose>
                                <xsl:when test="homepage">
                                    <a about="{$editorIRI}" class="CEURVOLEDITOR" href="{homepage}" property="schema:name" rel="schema:url" typeof="schema:Person"><xsl:value-of select="name"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="CEURVOLEDITOR"><xsl:value-of select="name"/></span>
                                </xsl:otherwise>
                            </xsl:choose>
                            </span><sup><a about="{$editorIRI}" href="#author-org-{position()}" rel="schema:memberOf" resource="#{replace(normalize-space(affiliation), '\s+', '-')}"><xsl:value-of select="position()"/></a></sup></dd>
                        </xsl:for-each>
                    </dl>

                    <ul id="author-org">
                        <xsl:for-each select="$workshop/editors/editor">
                            <li id="author-org-{position()}"><sup><xsl:value-of select="position()"/></sup>
                            <xsl:choose>
                                <xsl:when test="affiliationHomepage">
                                    <a about="#{replace(normalize-space(affiliation), '\s+', '-')}" href="{replace(normalize-space(affiliationHomepage), '\s+', '')}" property="schema:name" rel="schema:url" typeof="schema:Organization"><xsl:value-of select="affiliation"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span about="#{replace(normalize-space(affiliation), '\s+', '-')}" property="schema:name" typeof="schema:Organization"><xsl:value-of select="affiliation"/></span>
                                </xsl:otherwise>
                            </xsl:choose>, <xsl:value-of select="country"/></li>
                        </xsl:for-each>
                    </ul>
                </div>

                <div id="content">
                    <section class="CEURTOC" id="table-of-contents" rel="schema:hasPart" resource="#table-of-contents">
                        <h2 property="schema:name">Table of Contents</h2>
                        <div datatype="rdf:HTML" property="schema:description">
                            <!--
                            XXX: Preface
                            <ol rel="schema:hasPart">
                                <li id=""><a href="">Preface</a></li>
                            </ol>
                            -->

                            <!-- <toc> is expected to either contain a sequence of <paper> elements or a sequence of <session> elements.  However we also gracefully handle the occurrence of both, in which case we first output all <paper>s without a session, then the <session>s. -->
                            <xsl:if test="/toc/paper">
                                <ol rel="schema:hasPart">
                                    <xsl:apply-templates select="/toc/paper"/>
                                </ol>
                            </xsl:if>

                            <xsl:apply-templates select="/toc/session"/>
                        </div>
                    </section>

                    <xsl:if test="$all-in-one">
                    <p>The whole proceedings can also be downloaded as a single file (<a rel="rdfs:seeAlso" href="{concat($id, '-complete.pdf')}">PDF</a>, including title pages, preface, and table of contents).</p>
                    </xsl:if>
                    <p>We offer a <a href="{$id}.bib">BibTeX file</a> for citing papers of this workshop from LaTeX.</p>
                </div>
            </article>
        </main>

        <footer>
            <xsl:variable name="dateCreated" select="format-date(current-date(), (: old format: '[D]-[MNn,*-3]-[Y]' :) '[Y]-[M,2]-[D,2]')"/>
            <p><time datetime="{$dateCreated}" datatype="xsd:date" property="schema:dateCreated"><xsl:value-of select="$dateCreated"/></time>: submitted by <xsl:value-of select="$workshop/editors/editor[@submitting='true']/name"/>, metadata incl. bibliographic data published under <a href="https://creativecommons.org/publicdomain/zero/1.0/">Creative Commons CC0</a></p>
            <p><time class="CEURPUBDATE" datetime="YYYY-MM-DD" datatype="xsd:date" property="schema:datePublished">YYYY-MM-DD</time>: published on CEUR Workshop Proceedings (CEUR-WS.org, ISSN 1613-0073) |<a href="https://validator.w3.org/nu/?doc=http%3A%2F%2Fceur-ws.org%2FVol-{$number}%2F">valid HTML5</a>|</p>
        </footer>
    </body>
</html>
    </xsl:template>

    <xsl:template match="session">
        <xsl:variable name="sessionNumber"><xsl:number/></xsl:variable>

        <xsl:variable name="sessionId">
            <xsl:text>Session-</xsl:text>
            <xsl:value-of select="$sessionNumber"/>
            <xsl:if test="title">
                <xsl:text>-</xsl:text>
                <xsl:value-of select="replace(normalize-space(title), '\s+', '-')"/>
            </xsl:if>
        </xsl:variable>

        <section id="{$sessionId}" rel="schema:hasPart" resource="#{$sessionId}">
            <h3 property="schema:name">Session <xsl:value-of select="$sessionNumber"/>
              <xsl:if test="title">
                <xsl:text>: </xsl:text>
                <xsl:choose>
                  <xsl:when test="title and url">
                    <a class="CEURSESSION" href="{url}" property="schema:url"><xsl:value-of select="title"/></a>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="CEURSESSION"><xsl:value-of select="title"/></span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </h3>
            <div datatype="rdf:HTML" property="schema:description">
                <ol rel="schema:hasPart">
                    <xsl:apply-templates select="paper"/>
                </ol>
            </div>
        </section>
    </xsl:template>

    <xsl:template match="paper">
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

        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="@id != ''">
                    <xsl:value-of select="@id"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- determine the number of this <paper> element among all <paper> elements in document order (including those in different <session> branches)-->
                    <!-- http://stackoverflow.com/a/3562716/2397768 -->
                    <xsl:value-of select="concat('article-', format-number($position, '00'))"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="pdf" select="concat($id, '.pdf')"/>

        <li id="{$id}" resource="#{$id}" typeof="schema:ScholarlyArticle" value="{$position}">
            <a class="CEURTITLE" href="{$pdf}" property="schema:name" rel="schema:url"><xsl:value-of select="title"/></a>
            <xsl:if test="url"><xsl:text> </xsl:text>[<a rel="owl:sameAs" href="{url}">canonical URL</a>]</xsl:if>
            <xsl:if test="pages">
            <dl class="pages">
                <dt>Pages</dt>
                <dd class="CEURPAGES"><span datatype="xsd:nonNegativeInteger" property="schema:pageStart"><xsl:value-of select="pages/@from"/></span>–<span datatype="xsd:nonNegativeInteger" property="schema:pageEnd"><xsl:value-of select="pages/@to"/></span></dd>
            </dl>
            </xsl:if>
            <dl class="authors">
                <dt>Authors</dt>
                <xsl:for-each select="authors/author">
                    <xsl:variable name="authorIRI" select="replace(normalize-space(.), '\s+', '-')"/>
                <dd class="CEURAUTHOR" id="{$id}-{$authorIRI}" inlist="" rel="bibo:authorList" resource="#{$id}-{$authorIRI}"><span about="#{$id}" rel="schema:author"><span about="#{$id}-{$authorIRI}" property="schema:name" typeof="schema:Person"><xsl:value-of select="normalize-space(.)"/></span></span></dd>
                </xsl:for-each>
            </dl>
        </li>
    </xsl:template>
</xsl:stylesheet>
