#!/usr/bin/python

listWorsd = []
myDict = {}

with open("../Utils/76-0.txt") as inputFile:
   for line in inputFile:
	listWords = line.split(" ")
	for item in listWords:
		if item in myDict.keys():
			myDict.update({item:myDict[item] +1})
		else:
			myDict.update({item:1})
inputFile.close()

for key in sorted(myDict):
	print"%s : %d\n" %  (key, myDict[key])
	
