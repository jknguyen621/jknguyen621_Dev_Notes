"""
@Author: Jospeh K. Nguyen
This program will find the max repeated number from a list of number, using numpy data analysis package
"""

import numpy as np
a = np.array([1,5,3,5,2,4,3,4,5,1,2,5,4,7,2,3,5,1])
counts = np.bincount(a)
print np.argmax(counts)



