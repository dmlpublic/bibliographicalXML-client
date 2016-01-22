<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="https://github.com/cacology/bibliographicalXML"
	xmlns:b="https://github.com/cacology/bibliographicalXML">

	<xsl:include href="../bibliographicalXML/xsl/collation.xsl"/>
	<xsl:output indent="yes" method="html" omit-xml-declaration="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<link href="../css/minimal.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<xsl:apply-templates select="book/collation"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="note" priority="2">

		<xsl:variable name="style" select="@b:rend"/>

		<xsl:choose>
			<xsl:when test="@b:rend = 'paragraph'">
				<p/>
			</xsl:when>
			<xsl:when test="@b:rend = 'break'">
				<br/>
			</xsl:when>
			<xsl:when test="not(@b:rend)">
				<span id="roman">
					<xsl:value-of select="."/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span id="{$style}">
					<xsl:value-of select="."/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
