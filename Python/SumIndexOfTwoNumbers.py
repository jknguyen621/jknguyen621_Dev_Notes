"""
@Author: Joseph K. Nguyen

#SumIndexOfTwoNumbers
Given: an array of numbers, and a separate value, representing the sum of two indexes of that array.
Figure out the two index position that will produce that sum.
NOTE: If no matching pair, return None, None
"""

def SumIndexOfTwoNumbers(testArray, sum):

    for j in range(len(testArray) -1):
        for k in range(len(testArray) -1):
            if (testArray[j] + testArray[k]) == sum:
                return j, k
    print("There were no matching pair of indexes that would produce the provided input sum!")
    return(None, None)

if __name__ == '__main__':
    array1 = [1, 6, 9, 5, 3, 7, 4, 15, 11]
    array2 = [1, 6, 9, 5, 3, 7, 4, 15, 11]
    array3 = [1,6,9,5,3,7,4,15,11]

    (a,b) = SumIndexOfTwoNumbers(array2, 7)

    print("Summary is: %s, %s" % (a, b))


'''
Given an array of integers, return indices of the two numbers such that they add up to a specific target.
#You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example1...:
#input:
#array: [1,6,9,5,3,7,4,15,11]
#sum = 13
#output = 1, 5 

#Explanation (6+7 = 13)
#input:
#array: [1,6,9,5,3,7,4,15,11]
#sum = 16 
#output  = 3, 8 or 0,7

#Explanation (5+11) or (1+15)
#input:
#array: [1,6,9,5,3,7,4,15,11]
#sum = 2

Example2:
    (a,b) = SumIndexOfTwoNumbers(array3, 24)
    Summary is: 2, 7
    
Example3:    
     (a,b) = SumIndexOfTwoNumbers(array2, 1)
     Summary is: None, None
'''