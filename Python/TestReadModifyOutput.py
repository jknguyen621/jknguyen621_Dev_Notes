"""
@Author: Joseph Nguyen
@Date: 08-29-17
Read in a pipe separated file of key value, load up a dictionary, add on additioinal key and value.
Iterate and print out dictionary.

"""

inputFileName = "./TestInput.txt";


myDictionary = {}

textFile = open(inputFileName, "r")  #Open file for Read
for line in textFile: 
    list = line.split("|")      #Split based on Pipe

    for each in list:
        #print each
        myDictionary [list[0]] = list[1]
        
textFile.close()

#Sub one value in key
myDictionary["Jose"] = "Hallaluha Hallaluha"

for each in myDictionary:
    print("key is: " + each + "\t Value is: " + myDictionary[each] + "\n")
