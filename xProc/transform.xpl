<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="10.0">
    <p:input port="source">
        <p:document href="../xml/minimal.xml"/>
    </p:input>
    <p:output port="result">
        <p:pipe step="xslt" port="result"/>        
    </p:output>
    <p:xslt>
        <p:input port="stylesheet">
            <p:document href="../xsl/minimal.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    <p:store href="../html/minimal.html" name="xslt"/>
</p:declare-step>
