#!/usr/bin/python
import os


DirPath = "/Users/jknguyen/temp/"
testFile = "writeMe.txt"

fileOut = open(DirPath+testFile, "w+")

#Write
fileOut.seek(0, os.SEEK_END)
fileOut.writelines("This is only a test, of the Emergency System2!!!\n")
print ("This concludes the Writing Test portion!\n")


#Read
fileOut.seek(0, os.SEEK_SET)   #Rewind file
for lines in fileOut:
    print lines
    words = lines.split(' ')
    print words
print ("This concludes the Reading Test portion!\n")
fileOut.close()

#Append
fileOut = open(DirPath+testFile, "a")
fileOut.write("Newly Appended Text!!!\n")
print ("This concludes the Appending Test portion!\n")
fileOut.close()