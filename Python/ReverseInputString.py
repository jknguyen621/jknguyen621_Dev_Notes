#!/usr/bin/python


def reverseInputString(testString):

    wordList = testString.strip().split(' ')

    reversed = ""

    for word in wordList:
        print word

    print len(wordList)

    for i in range(len(wordList)-1, -1, -1):
       reversed += wordList[i] + " "

    newString = reversed.rstrip()
    return newString

if __name__ == '__main__':

    myStr = "I love Apple"
    newString2 = reverseInputString(myStr)
    print ("\'"+newString2+"\'")
