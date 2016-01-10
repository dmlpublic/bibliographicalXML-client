<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0">

    <p:documentation>
        This Xproc validates minimal.xml against minimal.xsd and applies minimal.xsl to
        create minimal.html.

        Calabash, the xProc engine, seems to be using a different xslt engine than the
        oXygen default, resulting in some interesting and minor changes to minimal.xsl
        (which resides in the service repository).

        Two examples:

        (1) xsl:if test="@signed = 'false'" works in all other XSLT environments I've tested,
            but in Calabash, there was an error noting that it could not compare a boolean (@signed)
            to a string ('false'). I recoded this (and a number of similar examples) as 
            xsl:if test="not (@signed)"

        (2) The element start is a page number and can be either an integer or a string with a roman
            numeral. One xsl:when statement checks for a roman numeral, beginning:
            r(contains(start, 'i'). This failed in Calabash when start was an integer. I recoded this 
            (and a number of similar examples) to contains(string(start), 'i').

        The conclusion is that Calabash will not cast among datatypes as aggressively as other engines. 

        Note that there will be other similar changes required. I've only run a few .xml files through
        the Calabash engine; other files will bring out other similar problems.

    </p:documentation>
    <p:input port="source">
        <p:document href="../xml/minimal.xml"/>
    </p:input>

    <p:output port="result">
        <p:pipe port="result" step="style"/>
    </p:output>

    <p:validate-with-xml-schema assert-valid="true" mode="strict">
        <p:input port="schema">
            <p:document href="../schemas/minimal.xsd"/>
        </p:input>
    </p:validate-with-xml-schema>

    <p:xslt name="style">
        <p:input port="stylesheet">
            <p:document href="../xsl/minimal.xsl"/>
        </p:input>
        <p:input port="parameters" sequence="true">
            <p:empty/>
        </p:input>
    </p:xslt>

    <p:store href="../html/minimal.html"/>

</p:declare-step>
