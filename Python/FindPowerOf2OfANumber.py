"""
@Author: Jospeh K. Nguyen

FindPowerOf2OfANumber.py
This program will find the base 2 of a number or log2 and return the power quotient.

Write a function that tells me if a given number is power of 2.
eg ( 4, 32, 128 ) => True
( 3, 10, 32 ) => false
"""

import math

def findBaseof2Root(number):
    powerOf2 = False
    print("\nRoot of 2 for number: %d\n" % number)
    if (math.log(number, 2).is_integer()):
        print ("To the " + str(math.log(number, 2)) + "rd/th power\n")
        powerOf2 = True
    else:
        powerOf2 = False

    return powerOf2

flag = findBaseof2Root(8)
print flag