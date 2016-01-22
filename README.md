## bibliographicalXML-client

James Ascher and David Levy are working to extract reusable components from Levy's Hoyle XML bibliography (http://booksongaming.com/hoyle/bibliography) that will be generally useful to biliobraphers. The Hoyle bibliography contains 200 XML bibliographical descriptions, XML schemas to validate the XML, python code to do further testing of the XML in ways that XML schema cannot handle, and XSLT for rendering the XML as HTML and WordML. 

**Collation** is the first component to be extracted. **Collation** resides in https://github.com/cacology/bibliographicalXML.git. 

bibliogrphicalXML-client is a client repository demonostrating how **collation** can be used. It has two complete examples. 

**minimal** has a schema (minimal.xsd) that includes the collation schema, an XML file with a sample collation (minimal.xml), and a style sheet (minimal.xsl, that includes collation.xml from **collation**) to transform it into html. 

**minimalOverride** demonstrates how to override a schema definition from **collation**. It uses a reduced example from Levy's Hoyle work (http://booksongaming.com/hoyle/bibliography/books/whist.2.xml) where a note on the collation formula requires some markup (a superscript chi). **minimalOverride** has a schema that overrides the element **note** from **collation** so that it is a typeld that supports markup rather than a plain text field. There are corresponding XML and XSL files. 

There are also some rudimentary XProc scripts that will validate XML against a schema, run the python checking, and run the XML->HTML transformations. More work is required on these. 

To use this skeleton for your own bibliographical work, fork this repository and clone it.  **bibliographicalXML** will be pulled in as a submodule. We do not want to bring others' bibliographical work into this repository which should remain a skeleton. 
