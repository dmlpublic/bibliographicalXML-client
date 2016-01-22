import sys
sys.path.insert(0, '..\\bibliographicalXML\\scripts')

import checkCollation
import utilities
from checkBibl import checkBibl


# files = ['..\\xml\\minimal.xml']
files = utilities.getXMLfiles()

for file in files:
	print (file)
	checkCollation.checkCollation(file)

print ("done")
