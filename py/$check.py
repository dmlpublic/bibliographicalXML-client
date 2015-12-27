
import sys
sys.path.insert(0, '..\\..\\bibXML-service\\scripts')

import checkCollation
from checkBibl import checkBibl
from utilities import getXMLfiles


# files = ['..\\books\\whist.3.xml']
files = getXMLfiles()

for file in files:
	print (file)
	checkCollation.checkCollation(file)
	checkBibl(file)

print ("done")

