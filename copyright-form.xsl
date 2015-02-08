<?xml version="1.0" encoding="utf-8"?>
<!--
    Generates a CEUR-WS.org compliant copyright form from workshop.xml; executed by “make copyright-form.txt”
    
    Part of ceur-make (https://github.com/ceurws/ceur-make/)

    TODO add further documentation
    
    © Christoph Lange and contributors 2012–2015
    
    Licensed under GPLv3 or any later version
-->
<xsl:stylesheet version="2.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <xsl:variable name="workshop" select="document('workshop.xml')/workshop"/>
  <xsl:variable name="year" select="year-from-date(xs:date($workshop/date))"/>
  <xsl:variable name="workshop-id" select="concat($workshop/title/acronym, $year)"/>
  <xsl:variable name="workshop-url" select="concat('http://ceur-ws.org/Vol-', $workshop/number, '/')"/>

  <xsl:template match="workshop"><!--
-->AGREEMENT TO GRANT NON-EXCLUSIVE PUBLICATION PERMISSIONS

Original work entitled: ________________________________________________ 
________________________________________________________________________

Authors: _______________________________________________________________
________________________________________________________________________

Prepared for the Workshop:
Proceedings of the <xsl:value-of select="title/acronym"/><xsl:text> </xsl:text><xsl:value-of select="year-from-date(xs:date(date))"/> Workshop
<xsl:if test="conference/acronym"><xsl:value-of select="conference/acronym"/><xsl:text>&#xa;</xsl:text>
</xsl:if>(to be published with CEUR-WS.org)

I hereby grant non-exclusive and non-time limited publication permissions over 
the above-named material (the Material) to the following personals (hereinafter 
the editors/publishers): 

<xsl:for-each select="editors/editor/name">
    <xsl:value-of select="."/><xsl:text>&#xa;</xsl:text>
</xsl:for-each>
In order to include in any and all forms, compile, publish, print, distribute 
and spread such a work with the unique aim of making it as accessible as 
possible for everybody.

However, authors preserve all their copyrights and publication rights.

In the event that any elements used in the Material contain the work of third-
party individuals, I understand that it is my responsibility to secure any 
necessary permissions and/or licences and will provide it in writing to the 
editor/publishers. If the copyright holder requires a citation to a copyrighted 
work, I have obtained the correct wording and have included it in the designated 
space in the text.

I hereby release and discharge the editors/publishers and other publication 
sponsors and organizers from any all liability arising out of my inclusion in 
the publication, or in connection with the performance of any of the activities 
described in this document as permitted herein. This includes, but is not 
limited to, my right of privacy or publicity, copyright, patent rights, trade 
secret rights, moral rights or trademark rights.

I have used third-party material:  ( ) Yes  ( ) No

If the previous answer is yes, I have the necessary permission to use the third-
party material: ( ) Yes  ( ) No  ( ) Not applicable

Print Name: ________________________________________________________

Date: ______________________________________________________________

Please upload this form together with your final version, following the 
instructions that we will provide.
<!--  --></xsl:template>
</xsl:stylesheet>

<!--
Local Variables:
mode: nxml
nxml-child-indent: 4
End:
-->
