import sys
sys.path.insert(0, '..\\..\\bibXML-service\\scripts')

import checkCollation
import utilities
from checkBibl import checkBibl


# files = ['..\\books\\whist.3.xml']
files = utilities.getXMLfiles()

for file in files:
	print (file)
	checkCollation.checkCollation(file)
	checkBibl(file)

print ("done")

