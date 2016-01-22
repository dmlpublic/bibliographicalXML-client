<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0" name="minimal">

    <p:documentation>
        See discussion in minimal-fail.xpl
    </p:documentation>

    <p:input port="source">
        <p:document href="../xml/minimal.xml"/>
    </p:input>

    <p:validate-with-xml-schema assert-valid="true" mode="strict">
        <p:input port="schema">
            <p:document href="../schemas/minimal.xsd"/>
        </p:input>
    </p:validate-with-xml-schema>

    <p:sink/>

    <p:xslt name="style">
        <p:input port="source">
            <p:pipe port="source" step="minimal"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../xsl/minimal.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>

    <p:store href="../html/minimal.html"/>

</p:declare-step>
