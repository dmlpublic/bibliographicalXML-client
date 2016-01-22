<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0">

    <p:documentation>
        This Xproc runs the $check.py script to validate all collations in the xml directory. Notes: 

        (1) I had to hard-code the full paths to python, $check.py, and cwd in the p:exec step. 

        (2) The pipeline captures python errors to errors.txt and python output to output.text.

    </p:documentation>

    <p:input port="source" sequence="true">
        <p:empty/>
    </p:input>

    <p:exec command="d:\Programs\Python34\python.exe"
        args="e:/documents/programming/Ascher/py/$check.py"
        cwd = "e:/documents/programming/Ascher/py"
        source-is-xml="false"
        result-is-xml="false"
        errors-is-xml="false"
        wrap-result-lines="false"
        wrap-error-lines="false"
        name="check">
    </p:exec>

    <p:store href="output.txt" method="text"/>

    <!-- write the "errors" output port to a text file -->
    <p:store href="errors.txt" method="text">
        <p:input port="source">
            <p:pipe step="check" port="errors"/>
        </p:input>
    </p:store>

</p:declare-step>
