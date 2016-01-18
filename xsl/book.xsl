<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="https://github.com/cacology/bibliographicalXML">
	<xsl:include href="util.xsl"/>
	<xsl:include href="../bibliographicalXML/xsl/collation.xsl"/>
	<xsl:output indent="yes" method="html" omit-xml-declaration="yes"/>

	<!--  	<xsl:key name="myTest" match="anomSignature" use="anomType"/>-->

	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<link href="../css/book.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>

				<xsl:apply-templates select="entry/fileDesc/header"/>
				<xsl:apply-templates select="entry/bookDesc/bookKeys"/>

				<table>
					<!-- Display the title page before half- and section-titles -->
					<xsl:apply-templates
						select="entry/text/sections/section/titlePage[@titleType = 'title']"/>
					<xsl:apply-templates
						select="entry/text/sections/section/titlePage[@titleType != 'title']"/>

					<xsl:apply-templates select="entry/text/collation"/>
					<xsl:apply-templates select="/entry/bookDesc/collectedParts"/>
					<xsl:apply-templates select="entry/text/sections"/>
					<xsl:apply-templates select="entry/text/plates"/>
					<xsl:apply-templates select="entry/text/catchwords"/>
					<xsl:apply-templates select="entry/text/pressFigures"/>
					<xsl:apply-templates select="entry/bookDesc/respStmt"/>
					<xsl:apply-templates select="entry/bookDesc/periodicalReferences"/>
					<xsl:apply-templates select="entry/bookDesc/prices"/>
					<xsl:apply-templates select="entry/bookDesc/listBibl"/>
					<xsl:apply-templates select="entry/text/imprimatur"/>
					<xsl:apply-templates select="entry/text/colophon"/>
					<xsl:apply-templates select="entry/bookDesc/holdings"/>
					<xsl:apply-templates select="entry/bookDesc/notes"/>
				</table>

				<xsl:apply-templates select="/entry/fileDesc/footer"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="bookKeys">
		<h2>
			<xsl:value-of select="idno"/>
		</h2>
		<h3>
			<xsl:apply-templates select="shortTitle"/>
			<xsl:apply-templates select="shortImprint"/>
			<xsl:apply-templates select="description"/>
			<xsl:apply-templates select="statedEdition"/>
			<xsl:apply-templates select="pubYear"/>
			<xsl:text>.</xsl:text>
		</h3>
	</xsl:template>

	<xsl:template match="shortTitle">
		<span id="italic">
			<xsl:value-of select="."/>
		</span>
	</xsl:template>

	<xsl:template match="titlePage">
		<tr>
			<xsl:choose>
				<xsl:when test="@titleType = 'halfTitle'">
					<td id="row-label">Half Title:</td>
				</xsl:when>
				<xsl:when test="@titleType = 'cancelandum'">
					<td id="row-label">Cancelandum:</td>
				</xsl:when>
				<xsl:when test="@titleType = 'section'">
					<td id="row-label">
						<xsl:text>Section Title </xsl:text>
						<xsl:value-of select="@sectionID"/>
						<xsl:text>:</xsl:text>
					</td>
				</xsl:when>
				<xsl:when test="@titleType = 'title'">
					<td id="row-label">Title:</td>
				</xsl:when>
			</xsl:choose>
			<td colspan="4">
				<xsl:apply-templates select="titlePart"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="collectedParts">
		<tr>
			<td id="row-label">Parts: </td>
			<td>
				<xsl:apply-templates select="collectedPart/idno"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="respStmt">

		<xsl:if test="respItem/@respType = 'publisher'">
			<tr>
				<td id="row-label">Publisher: </td>
				<td colspan="4">
					<xsl:for-each select="respItem">
						<xsl:if test="@respType = 'publisher'">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="respItem/@respType = 'printer'">
			<tr>
				<td id="row-label">Printer: </td>
				<td colspan="4">
					<xsl:for-each select="respItem">
						<xsl:if test="@respType = 'printer'">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="respItem/@respType = 'translator'">
			<tr>
				<td id="row-label">Translator: </td>
				<td colspan="4">
					<xsl:for-each select="respItem">
						<xsl:if test="@respType = 'translator'">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

	</xsl:template>

	<xsl:template match="respItem">
		<!-- If there is a second respItem of the same type, add a line break -->
		<xsl:if test="@respType = preceding-sibling::respItem/@respType">
			<xsl:text>, </xsl:text>
		</xsl:if>

		<xsl:apply-templates select="persName"/>
		<xsl:value-of select="orgName"/>
		<xsl:if test="evidence">
			<xsl:text> (</xsl:text>
			<xsl:apply-templates select="evidence"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="persName">
		<xsl:value-of select="forename"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="surname"/>
	</xsl:template>

	<xsl:template match="periodicalReferences">

		<xsl:if test="periodicalReference/@periodicalType = 'advertisement'">
			<tr>
				<td id="row-label">Advertisements: </td>
				<td colspan="4">
					<xsl:for-each select="periodicalReference">
						<xsl:if test="@periodicalType = 'advertisement'">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="periodicalReference/@periodicalType = 'notice'">
			<tr>
				<td id="row-label">Notices: </td>
				<td colspan="4">
					<xsl:for-each select="periodicalReference">
						<xsl:if test="@periodicalType = 'notice'">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="periodicalReference/@periodicalType = 'review'">
			<tr>
				<td id="row-label">Reviews: </td>
				<td colspan="4">
					<xsl:for-each select="periodicalReference">
						<xsl:if test="@periodicalType = 'review'">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>

	</xsl:template>

	<!-- COULDN"T MAKE THIS WORK!

	<xsl:template match="periodicalReferences">

		<xsl:for-each select="periodicalReference">
			<xsl:variable name="TYPE" select="@periodicalType"/>
			<xsl:choose>
				<xsl:when
					test="position()=1 or @periodicalType != preceding-sibling::periodicalReference/@periodicalType">
					<tr>
						<td id="row-label">
							<xsl:value-of select="@periodicalType"/>
						</td>
						<td colspan="4">
							<xsl:if test="$TYPE = @periodicalType">
								<xsl:apply-templates select="."/>
							</xsl:if>
						</td>
					</tr>

				</xsl:when>
				<xsl:otherwise>
					<td colspan="4">
						<xsl:if test="$TYPE = @periodicalType">
							<xsl:apply-templates select="."/>
						</xsl:if>
					</td>

				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
-->

	<xsl:template match="periodicalReference">
		<!-- If there is a second periodicalReference of the same type, add a line break -->
		<xsl:if test="@periodicalType = preceding-sibling::periodicalReference/@periodicalType">
			<br/>
		</xsl:if>

		<xsl:value-of select="pubDate"/>
		<xsl:text> </xsl:text>
		<span id="italic">
			<xsl:value-of select="publication"/>
		</span>
		<xsl:if test="notes">
			<xsl:text>: </xsl:text>
			<xsl:apply-templates select="notes"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="prices">
		<tr>
			<td id="row-label">Price: </td>
			<td colspan="4">
				<xsl:apply-templates select="price"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="price">
		<xsl:apply-templates select="priceComponent"/>
		<xsl:if test="note">
			<xsl:text> </xsl:text>
			<xsl:value-of select="note"/>
		</xsl:if>
		<xsl:text> (</xsl:text>
		<xsl:apply-templates select="evidence"/>
		<xsl:text>)</xsl:text>
		<xsl:if test="position() != last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="priceComponent">
		<xsl:choose>
			<xsl:when test="unit = '$'">
				<xsl:value-of select="unit"/>
				<xsl:value-of select="amount"/>
			</xsl:when>
			<xsl:when test="contains(amount, '.5')">
				<xsl:value-of select="translate(amount, '.5', '½')"/>
				<xsl:value-of select="unit"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="amount"/>
				<xsl:value-of select="unit"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="evidence">
		<xsl:value-of select="."/>
		<xsl:if test="position() != last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="listBibl">
		<tr>
			<td id="row-label">References: </td>
			<td colspan="4">
				<xsl:apply-templates select="bibl"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="bibl">
		<xsl:if test="reference != 'Marshall'">
			<xsl:value-of select="reference"/>
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="reference = 'ESTC'">
					<xsl:variable name="ESTC-URL" select="'http://estc.bl.uk/'"/>
					<xsl:variable name="ESTC-NO">
						<xsl:value-of select="idno"/>
					</xsl:variable>
					<xsl:variable name="URL">
						<xsl:value-of select="concat($ESTC-URL, $ESTC-NO)"/>
					</xsl:variable>
					<a href="{$URL}" target="blank_">
						<xsl:value-of select="$ESTC-NO"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="idno"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="imprimatur">
		<tr>
			<td id="row-label">Imprimatur: </td>
			<td colspan="4">
				<xsl:apply-templates select="notes"/>
			</td>
		</tr>

	</xsl:template>

	<xsl:template match="colophon">
		<tr>
			<td id="row-label">Colophon: </td>
			<td colspan="4">
				<xsl:apply-templates select="notes"/>
			</td>
		</tr>

	</xsl:template>

	<xsl:template match="holdings">

		<xsl:if test="count(holding[@isSeen = 'true' and not(@isCollection = 'true')]) > 0">
			<tr>
				<td id="row-label">Copies Seen:</td>
				<td colspan="4">
					<xsl:apply-templates
						select="holding[@isSeen = 'true' and not(@isCollection = 'true')]"/>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="count(holding[@isSeen = 'true' and @isCollection = 'true']) > 0">
			<tr>
				<td id="row-label">Copies Seen in Publisher's Collections:</td>
				<td colspan="4">
					<xsl:apply-templates
						select="holding[@isSeen = 'true' and @isCollection = 'true']"/>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="count(holding[@isSeen = 'false' and not(@isCollection = 'true')]) > 0">
			<tr>
				<td id="row-label">Other Copies:</td>
				<td colspan="4">
					<xsl:apply-templates
						select="holding[@isSeen = 'false' and not(@isCollection = 'true')]"/>
				</td>
			</tr>
		</xsl:if>

		<xsl:if test="count(holding[@isSeen = 'false' and @isCollection = 'true']) > 0">
			<tr>
				<td id="row-label">Other Copies in Publisher's Collections:</td>
				<td colspan="4">
					<xsl:apply-templates
						select="holding[@isSeen = 'false' and @isCollection = 'true']"/>
				</td>
			</tr>
		</xsl:if>

	</xsl:template>

	<xsl:template match="holding">
		<xsl:value-of select="holder"/>
		<xsl:apply-templates select="shelfmark"/>
		<xsl:apply-templates select="copies"/>
		<xsl:apply-templates select="surrogate"/>
		<xsl:apply-templates select="notes"/>
		<xsl:apply-templates select="idno"/>
		<xsl:apply-templates select="holdingParts"/>
		<xsl:choose>
			<xsl:when test="position() = last() or count(holdingParts) > 0"/>
			<xsl:otherwise>
				<xsl:text>; </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="shelfmark">
		<xsl:text> [</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text>]</xsl:text>
	</xsl:template>

	<xsl:template match="copies">
		<xsl:text> [</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text> copies]</xsl:text>
	</xsl:template>

	<xsl:template match="surrogate">
		<xsl:text> (</xsl:text>
		<xsl:choose>
			<xsl:when test="@url">
				<xsl:variable name="URL">
					<xsl:value-of select="@url"/>
				</xsl:variable>
				<a href="{$URL}" target="blank_">
					<xsl:value-of select="."/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<xsl:template match="holdingParts">
		<xsl:text>: </xsl:text>
		<xsl:apply-templates select="holdingPart"/>
		<br/>
	</xsl:template>

	<xsl:template match="holdingPart">
		<xsl:text> </xsl:text>
		<span id="italic">
			<xsl:value-of select="idno"/>
		</span>
		<xsl:apply-templates select="shelfmark"/>
		<xsl:if test="position() != last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="collectedParts/collectedPart/idno">

		<xsl:variable name="URL-SUFF" select="'.xml'"/>
		<xsl:variable name="BOOK">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:variable name="LOWER"
			select="translate($BOOK, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:variable name="URL">
			<xsl:value-of select="concat($LOWER, $URL-SUFF)"/>
		</xsl:variable>
		<a href="{$URL}">
			<xsl:value-of select="$BOOK"/>
		</a>
		<xsl:if test="position() != last()">
			<br/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="entry/bookDesc/holdings/holding/idno">
		<xsl:text> (see </xsl:text>
		<xsl:variable name="URL-SUFF" select="'.xml'"/>
		<xsl:variable name="BOOK">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:variable name="LOWER"
			select="translate($BOOK, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:variable name="URL">
			<xsl:value-of select="concat($LOWER, $URL-SUFF)"/>
		</xsl:variable>
		<a href="{$URL}">
			<xsl:value-of select="$BOOK"/>
		</a>
		<xsl:text>)</xsl:text>
		<xsl:if test="position() != last()">
			<br/>
		</xsl:if>

	</xsl:template>

	<xsl:template match="sections">
		<xsl:variable name="rowCount" select="count(section) + 1"/>
		<tr>
			<td id="row-label" rowspan="{$rowCount}">Contents: </td>
			<td>
				<span id="bold">Signature (Page) Reference</span>
			</td>
			<td>
				<span id="bold">Contents</span>
			</td>
			<td>
				<span id="bold">Signature (Page) Reference</span>
			</td>
			<td>
				<span id="bold">Running Titles</span>
			</td>
		</tr>
		<xsl:apply-templates select="section"/>
	</xsl:template>

	<xsl:template match="section">

		<!--
			When we have exceptional running titles, exceptions are noted with isOn=true.
			I want the exceptions to appear in the same table row as the normal RT.
			I do this by not printing top and bottom borders to the <td>.
			There are three css styles:
				top means no bottom border;
				middle means no top or bottom border;
				bottom means no top border.
			The variable $class calculates which is necessary. The variable is passed to the templates for content or RT.
		-->

		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when
					test="not(RT/@isOn = 'true') and following-sibling::*[1]/RT/@isOn = 'true'"
					>top</xsl:when>
				<xsl:when test="RT/@isOn = 'true' and following-sibling::*[1]/RT/@isOn = 'true'"
					>middle</xsl:when>
				<xsl:when
					test="RT/@isOn = 'true' and not(following-sibling::*[1]/RT/@isOn = 'true')"
					>bottom</xsl:when>
				<xsl:otherwise>default</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr id="continue">
			<xsl:choose>
				<xsl:when test="content">
					<xsl:apply-templates select="content">
						<xsl:with-param name="class" select="$class"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<td class="{$class}"/>
					<td class="{$class}"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="RT">
					<xsl:apply-templates select="RT">
						<xsl:with-param name="class" select="$class"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<td class="{$class}"/>
					<td class="{$class}"/>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="content | RT">
		<xsl:param name="class"/>

		<td class="{$class}">
			<xsl:if test="@isOn = 'true'">
				<xsl:text>on </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="sigFrom"/>
			<xsl:apply-templates select="sigTo"/>
			<xsl:apply-templates select="pageFrom"/>
			<xsl:apply-templates select="addedRange"/>
		</td>
		<td class="{$class}">
			<xsl:choose>
				<xsl:when test="contentPart">
					<xsl:apply-templates select="contentPart"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="RTPart"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>

	<xsl:template match="addedRange">
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="sigFrom"/>
		<xsl:apply-templates select="sigTo"/>
		<xsl:apply-templates select="pageFrom"/>
	</xsl:template>

	<xsl:template match="sigFrom">
		<xsl:apply-templates select="dupSeqSig"/>
		<xsl:value-of select="multSig"/>
		<xsl:apply-templates select="sigRef"/>
	</xsl:template>

	<xsl:template match="sigTo">
		<xsl:text>–</xsl:text>
		<xsl:value-of select="multSig"/>
		<xsl:apply-templates select="sigRef"/>
	</xsl:template>

	<xsl:template match="sigRef">

		<xsl:choose>

			<xsl:when test="contains(., '.')">

				<!-- A numeric signature where signature and page are separated
					with a period. Example: '1.2r'. Parse out the signature ('1'), 
					page ('2r'), leaf ('2'), and side ('r').
					Print signature, leaf (in subscript), side.
				-->

				<xsl:variable name="PAGE">
					<xsl:value-of select="substring-after(., '.')"/>
				</xsl:variable>

				<xsl:variable name="LEAF">
					<xsl:choose>
						<xsl:when test="contains($PAGE, 'r')">
							<xsl:value-of select="substring-before($PAGE, 'r')"/>
						</xsl:when>
						<xsl:when test="contains($PAGE, 'v')">
							<xsl:value-of select="substring-before($PAGE, 'v')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$PAGE"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="SIDE">
					<xsl:choose>
						<xsl:when test="contains($PAGE, 'r')">
							<xsl:value-of select="'r'"/>
						</xsl:when>
						<xsl:when test="contains($PAGE, 'v')">
							<xsl:value-of select="'v'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="''"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:value-of select="substring-before(., '.')"/>
				<span id="sub">
					<xsl:value-of select="$LEAF"/>
				</span>
				<xsl:value-of select="$SIDE"/>
			</xsl:when>

			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

	<xsl:template match="pageFrom">
		<xsl:text> (</xsl:text>
		<xsl:apply-templates select="dupSeqPage"/>
		<xsl:value-of select="pageRef"/>
		<xsl:apply-templates select="../pageTo"/>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<xsl:template match="pageTo">
		<xsl:text>–</xsl:text>
		<!-- The if test handles the rare situation where the page range is  -->
		<!-- 1 through ^chi 10. See Whist.1.2.xml.  -->
		<xsl:if test="not(../pageFrom/dupSeqPage)">
			<xsl:apply-templates select="dupSeqPage"/>
		</xsl:if>
		<xsl:value-of select="pageRef"/>
	</xsl:template>

	<xsl:template match="/entry/text/plates">
		<tr>
			<td id="row-label">Plates:</td>
			<td colspan="4">
				<xsl:apply-templates select="plate"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="plate">
		<xsl:choose>
			<xsl:when test="@plateLocation">
				<xsl:value-of select="@plateLocation"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="plateRelation"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="dupSeqSig"/>
				<xsl:apply-templates select="multSig"/>
				<xsl:apply-templates select="sigRef"/>
				<xsl:if test="pageRef">
					<xsl:text>(</xsl:text>
					<xsl:apply-templates select="dupSeqPage"/>
					<xsl:value-of select="pageRef"/>
					<xsl:text>)</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:value-of select="plateType"/>
		<xsl:text>: </xsl:text>
		<xsl:apply-templates select="notes"/>
		<xsl:if test="position() != last()">
			<br/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="catchwords">
		<tr>
			<td id="row-label">Catchwords:</td>
			<td colspan="4">
				<xsl:apply-templates select="catchword"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="catchword">
		<xsl:apply-templates select="dupSeqSig"/>
		<xsl:apply-templates select="sigRef"/>
		<xsl:if test="pageRef">
			<xsl:text>(</xsl:text>
			<xsl:apply-templates select="dupSeqPage"/>
			<xsl:value-of select="pageRef"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="cwFoot"/>
		<xsl:text> [</xsl:text>
		<xsl:apply-templates select="cwHead"/>
		<xsl:text>]</xsl:text>
		<xsl:if test="position() != last()">
			<xsl:text>; </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="pressFigures">
		<tr>
			<td id="row-label">Press Figures:</td>
			<td colspan="4">
				<xsl:apply-templates select="pressFigure"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="pressFigure">
		<xsl:apply-templates select="dupSeqSig"/>
		<xsl:value-of select="multSig"/>
		<xsl:apply-templates select="sigRef"/>
		<xsl:text>(</xsl:text>
		<xsl:value-of select="forme"/>
		<xsl:text>):</xsl:text>
		<xsl:value-of select="mark"/>
		<xsl:if test="position() != last()">
			<xsl:text>; </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="entry/bookDesc/notes">
		<tr>
			<td id="row-label">Notes:</td>
			<td colspan="4">
				<xsl:apply-templates select="note"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="notes">
		<xsl:apply-templates select="note"/>
	</xsl:template>

	<xsl:template match="titlePart | contentPart | RTPart | cwFoot | cwHead | note">

		<xsl:variable name="style" select="@rend"/>

		<xsl:choose>
			<!-- EXTERNAL LINKS OPEN IN NEW WINDOW -->
			<xsl:when test="@url and starts-with(@url, 'http')">
				<a href="{@url}" target="blank_">
					<xsl:value-of select="."/>
				</a>
			</xsl:when>
			<!-- INTERNAL LINKS OPEN IN SAME WINDOW -->
			<xsl:when test="@url">
				<a href="{@url}">
					<xsl:value-of select="."/>
				</a>
			</xsl:when>
			<xsl:when test="@rend = 'paragraph'">
				<p/>
			</xsl:when>
			<xsl:when test="@rend = 'break'">
				<br/>
			</xsl:when>
			<xsl:when test="not(@rend)">
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

	<xsl:template match="/entry/fileDesc/footer">
		<hr/>
		<p>
			<a href="mailto:trictrac@sbcglobal.net?subject={/entry/bookDesc/bookKeys/fn}"
				>Feedback?</a>
		</p>
		<p>
			<a href="{home}">Home</a>
		</p>
	</xsl:template>

</xsl:stylesheet>
