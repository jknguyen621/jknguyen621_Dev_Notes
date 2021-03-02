"""
@Author: Joseph K. Nguyen

NewReadFile.py
This is the latest way to open a file versus old open method, such as:
	FileHandle = open(filePath, mode) or textFile = open(inputFileName, "r")

Now, we are able to open file, such as:
	with open(filePath) as fileHandle or with open("../Utils/76-0.txt") as inputFile:

NOTE:  This input text file is huge, 627K, so will take about 2 minutes or so to parse and load up to a dictionary.
Be Patient!!!
"""

myDict = {}

def openFile():
	with open("../Utils/76-0.txt", "r") as inputFile:
	   for line in inputFile:
		listWords = line.split(" ")
		for item in listWords:
			if item in myDict.keys():
				myDict.update({item:myDict[item] +1})
			else:
				myDict.update({item:1})
	#inputFile.close()  #DO NOT NEED CLOSE with open...
	return myDict

for key in sorted(myDict):
	print"%s : %d\n" %  (key, myDict[key])

if __name__ == "__main__":
	localDict = openFile()
	for key in sorted(localDict):
		print"%s : %d\n" % (key, localDict[key])