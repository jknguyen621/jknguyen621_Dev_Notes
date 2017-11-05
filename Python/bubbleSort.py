#!/usr/bin/python

#BubbleSort in Python

def bubbleSort(inList):
    #Starting from end of array for number of pass, then decrement towards 0,
    #while check from front towards back swapping smaller value towards front.
    for passnum in range(len(inList)-1,0,-1):
        for i in range(passnum):
            if inList[i]>inList[i+1]:
                temp = inList[i]
                inList[i] = inList[i+1]
                inList[i+1] = temp
    return inList

if __name__ == '__main__':
	myArray = [54,26,93,17,77,31,44,55,20]
        print("Before Sort: %d\n", myArray)
	sorted = bubbleSort(myArray)
	print("After Sorted: %d\n", sorted)	
