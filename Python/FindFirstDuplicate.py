"""
@Author: Jospeh K. Nguyen

FindFirstDuplicate.py

This program will find the duplicates for each of the charactes in a string and return that character along with the number
of counts on that duplicate.
"""

def findDup(str):

    str = str.lower()
    myDict = dict.fromkeys(['a', 'b', 'c', 'd', 'e', 'f', 'g','h', 'i', 'j', 'k','l', 'm', 'n', 'o', 'p', 'q', 'r', 's', \
                            't','u', 'v', 'w', 'x', 'y','z'], 0)

    #Test before
    for k in myDict:
        print("Key is: %s \t Value is: %d\n", k, myDict[k])

    #Update Dictionary with counts.
    for c in str:
        myDict[c] += 1

    #Check results:
    for keys in myDict:
        if myDict[keys] > 1:  #Greater than 1 means repeated
            print("Duplicate Character is %s, with count as %d: " % (keys, myDict[keys]))

findDup("todayisnotmybirthdaybutitsgoingalright")

def shorterFindDup(a):
    adict = {}
    for i in a:
        if i in adict:
            return i
        else:
            adict[i] = 1