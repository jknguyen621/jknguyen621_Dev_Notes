# Write a function that tells me if a given number is power of 2.
# eg ( 4, 32, 128 ) => True
# ( 3, 10, 32 ) => false

import math


def findBaseof2Root(number):
    powerOf2 = False
    if (math.log(number, 2).is_integer()):
        powerOf2 = True
    else:
        powerOf2 = False

    return powerOf2


flag = findBaseof2Root(8)
print flag