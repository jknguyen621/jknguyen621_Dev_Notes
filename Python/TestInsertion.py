#!/user/bin/python/

#Joseph K. Nguyen
#09/05/2017

#Input value to insert,
#output: return tthe index iwhere it should be insertted.


def findIndex(listIn, indexInput):

    #print myDict
    #Handle the boundaries first
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
