#If References and Shelfmarks appear out of order in the .xml files,
#this will show file and proper sort order.

def checkBibl(file):
    references = getReferences(file)
    sortedReferences = sortReferences(references)

    if references != sortedReferences:
        for r in sortedReferences:
            print ("    ", r['id'])

def getReferences(file):
    references = []

    from utilities import getRoot
    root = getRoot(file)

    for e in root.iter('bibl'):
        reference = {}
        for child in e:
            if child.tag=='reference':
                id = child.text
                reference['id']=id
        references.append(reference)
    return references

def sortReferences(references):
    from operator import itemgetter
    return sorted(references, key=itemgetter('id'))
