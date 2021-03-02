"""
@Author: Joseph K. Nguyen
@Date: 09/05/2017

Given a existing array and a value.  Traverse the array and return the index value,
where the single given value should be inserted in order to keep the list sorted.

- Input value to insert, and an existing sorted array.
- output: return the index where it should be insertted.
"""

def findIndex(listIn, indexInput):

    #print myDict
    #See if it is not in list at all
    #Then check for lower and upper boundaries
    if indexInput not in listIn:
        if indexInput < listIn[0]:
            return 0;
        elif indexInput > listIn[-1]:
            return len(listIn)

    #The logic
    for i in range(len(listIn)):
        if indexInput == listIn[i]:
            return i
        elif indexInput > listIn[i] and indexInput < listIn[i+1]:
            return i+1

############################################
#Expected:
#In-out
#5-2
#0-0
#4-2
#8-4
############################################

lst = [1,2,5,7] #Input original list 

Index = findIndex(lst, 5)
print("%d " % Index)

Index = findIndex(lst, 0)
print("%d " % Index)

Index = findIndex(lst, 4)
print("%d " % Index)

Index = findIndex(lst, 8)
print("%d " % Index)
