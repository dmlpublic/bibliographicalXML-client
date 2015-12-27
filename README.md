## bibliographicalXML-client

James Ascher and David Levy are working to extract reusable components from Levy's Hoyle XML bibliography (http://booksongaming.com/hoyle/bibliography) that will be generally useful to biliobraphers. The Hoyle bibliography contains 200 XML bibliographical descriptions, XML schemas to validate the XML, python code to do further testing of the XML in ways that XML schema cannot handle, and XSLT for rendering the XML as HTML and WordML. 

<collation> is the first component to be extracted. <collation> resides in https://github.com/cacology/bibliographicalXML.git. 

bibliogrphicalXML-client is a client repository demonostrating how the <collation> can be used. It has a schema (book.xsd) that includes <collation>. Whist.3.xml is a sample description unchanaged from Levy's Hoyle bibliography that validates with book.xsd and <collation>.

To make things work, this repository should be cloned to a directory called bibXML-client and the other repostory to a sibling directory called bibXML-service. Later we can find a more robust way for the client code to find the reusable code. 

Next steps are:

(1) to separate the python code into the parts that work with <collation> and the broader parts that work only with book.xsd
(2) to separte the XSLT in the same way
(3) to identify other bibliograpahical components that can be extracted from book.xsd as reusable components. 