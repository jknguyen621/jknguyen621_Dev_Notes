#!/usr/bin/python

import numpy as np
a = np.array([1,2,3,1,2,1,3,3,3,2,2,1,4,2,3,3])
counts = np.bincount(a)
print np.argmax(counts)
 
