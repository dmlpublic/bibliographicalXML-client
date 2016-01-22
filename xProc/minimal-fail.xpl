<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0" name="minimal">

    <p:documentation>
        For now, this XProc will not properly do the XSLT transform. There are some
        errors related to data types.

        Example:

            xsl:if test="@signed = 'false'" generates an error that it could not compare a boolean (@signed)
            to a string ('false').

        The problem is that the result of the p:validate-with-xml-schema step does not include the xml header
        ?xml version="1.0" encoding="utf-8"?

        minimal.xpl solves this by eating the output from p:validate-with-xml-schema step and passing the
        original xml document to p:xslt.

        Research continues.

    </p:documentation>

    <p:input port="source">
        <p:document href="../xml/minimal.xml"/>
    </p:input>

    <p:validate-with-xml-schema assert-valid="true" mode="strict">
        <p:input port="schema">
            <p:document href="../schemas/minimal.xsd"/>
        </p:input>
    </p:validate-with-xml-schema>

    <p:xslt name="style">
        <p:input port="stylesheet">
            <p:document href="../xsl/minimal.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>

    <p:store href="../html/minimal.html"/>

</p:declare-step>
