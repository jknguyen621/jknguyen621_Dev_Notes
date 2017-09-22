#!//Python26

inputFileName = "./TestInput.txt";






myDictionary = {}
#line = ()

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
