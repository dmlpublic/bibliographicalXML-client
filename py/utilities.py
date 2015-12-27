def getXMLfiles():
    from glob import glob
    return glob("..\\books\\*.xml")

def getRoot(file):
    import xml.etree.ElementTree as ET
    tree = ET.parse(file)
    return tree.getroot()
