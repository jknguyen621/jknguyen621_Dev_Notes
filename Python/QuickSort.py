"""
@Author: Joseph K. Nguyen

QuickSort.py
Using sublists of less, equal and greater.  Starting out with a pivot point, then compare each element of the array to pivot.
If lesser than less.append(), if equals than equal.append(), if its greater than greater.append().
Then concantenate the list and pass it back into a recurcive calling to the sort again.
"""

def sort(array=[12,4,5,6,7,3,1,15]):
    less = []
    equal = []
    greater = []

    if len(array) > 1:
        pivot = array[0]
        for x in array:
            if x < pivot:
                less.append(x)
            if x == pivot:
                equal.append(x)
            if x > pivot:
                greater.append(x)
        # Don't forget to return something!
        return sort(less)+equal+sort(greater)  # Just use the + operator to join lists
    # Note that you want equal ^^^^^ not pivot
    else:  # You need to hande the part at the end of the recursion - when you only have one element in your array, just return the array.
        return array

if __name__ == '__main__':
	testArray = [7,8,9,10,45,23,11,4,2,1,21,16]
	print("inputArray %d\n", testArray)
        results = sort(testArray)
        print results
