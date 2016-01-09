<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="https://github.com/cacology/bibliographicalXML">
	<xsl:include href="util.xsl"/>
	<xsl:include href="../../bibXML-service/xsl/collation.xsl"/>
	<xsl:output indent="yes" method="html" omit-xml-declaration="yes"/>

	<!--  	<xsl:key name="myTest" match="anomSignature" use="anomType"/>-->

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

</xsl:stylesheet>
