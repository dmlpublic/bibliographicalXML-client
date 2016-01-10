<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="1.0">

    <p:documentation>
        This Xproc tries to run the $check.py script to validate all collations in the xml directory. 
        It is running python and is running the script, but there are several problems.

        (1) It cannot import checkCollation and utilities from the services directory. 
            The python code:

                import sys
                sys.path.insert(0, '..\\..\\bibXML-service\\scripts')

            does not seem to work when python is invoked by Xproc. I've temporary copied the two 
            python files to the bibXML-service\py\

        (2) It cannot run getXMLfiles() in utilties.py. The python code:

            def getXMLfiles():
                from glob import glob
                return glob("..\\xml\\*.xml")

            returns an empty list. I don't know if this is a problem with the current directory
            or whether it is another example like (1) where system functions are not working. 

        (3) I had to hard-code the full paths to python and $check.py in the p:exec step. I was
            unable to make cwd= work, though it appears that python uses py\ as the current directory.

        (4) The pipeline does capture python errors to errors.txt and python output to output.text

    </p:documentation>

    <p:input port="source" sequence="true">
        <p:empty/>
    </p:input>

    <p:exec command="d:\Programs\Python34\python.exe"
        args="e:\Documents\Programming\bibXML-client\py\$check.py"
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
