<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0">

    <p:input port="source">
        <p:document href="../xml/minimal.xml"/>
    </p:input>

    <p:output port="result"/>

    <p:validate-with-xml-schema assert-valid="true" mode="strict" name="myValidate">
        <p:input port="schema">
            <p:document href="../schemas/minimal.xsd"/>
        </p:input>
    </p:validate-with-xml-schema>

</p:declare-step>
