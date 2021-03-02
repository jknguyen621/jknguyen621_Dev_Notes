"""
@Authpr: Joseph K. Nguyen

ReverseInputString.py
Given: A user input a sentence as a string.  Provide the equivalent of that string word by word, maintaing the words
"""

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

    myStr = "Who Do You Think I am?"
    newString2 = reverseInputString(myStr)
    print ("\'"+newString2+"\'")


'''
Example:
In = "I love Apple"
Out = "Apple love I"

In = "Who Do You Think I am?"
Out = "am? I Think You Do Who"
'''