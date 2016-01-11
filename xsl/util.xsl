<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="https://github.com/cacology/bibliographicalXML">
	
	<xsl:template match="header">
		<hr/>
		<h2 class="center">A Descriptive Bibliography of Edmond Hoyle</h2>
		<p>Copyright &#169; 2014-6 by David Levy</p>

		<xsl:variable name="DATE">
			<xsl:value-of select="dateUpdate"/>
		</xsl:variable>

		<xsl:variable name="DATESTR">
			<xsl:value-of select="concat('(page updated ', $DATE, ')')"/>
		</xsl:variable>

		<p>
			<xsl:value-of select="$DATESTR"/>
		</p>
		<hr/>

	</xsl:template>

	<xsl:template match="footer">
		<hr/>
		<p>
			<a href="mailto:trictrac@sbcglobal.net?subject={fn}">Feedback?</a>
		</p>
		<p>
			<a href="{home}">Home</a>
		</p>
	</xsl:template>

	<xsl:template match="book">
		<li>
			<a href="{fn}">
				<xsl:value-of select="idno"/>
			</a>
			<xsl:text>: </xsl:text>
			<i>
				<xsl:value-of select="shortTitle"/>
			</i>
			<xsl:apply-templates select="shortImprint"/>
			<xsl:apply-templates select="description"/>
			<xsl:apply-templates select="statedEdition"/>
			<xsl:apply-templates select="pubYear"/>
		</li>
	</xsl:template>

	<xsl:template match="shortImprint | description | statedEdition | pubYear">
		<xsl:text>, </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>

</xsl:stylesheet>
