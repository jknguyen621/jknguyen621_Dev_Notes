"""
@Author: Jospeh K. Nguyen
This program will write "w+" to file starting at 0.  Rewind to read back and print out.
Then reopen as append "a" to append new text at end of file.
"""
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
print ("Rewind to start of file and read back!\n")
for lines in fileOut:
    print lines
    words = lines.split(' ')
    #print words
print ("This concludes the Reading Test portion!\n")
fileOut.close()

#Append
print ("About to append new text to existing file....\n")
fileOut = open(DirPath+testFile, "a")
fileOut.write("Newly Appended Text!!!\n")
print ("This concludes the Appending Test portion!\n")
fileOut.close()