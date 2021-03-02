"""
@Author: Joseph K. Nguyen

#LC_BricksFallingWhen.py

A brick will not drop if and only if it is directly connected to the top of the grid, or at
least one of its (4-way) adjacent bricks will not drop.

TODO: Debug and figure this out, when i have more time.
"""

import numpy as np

class Solution(object):

    def __init__(self, G, H):
        self.grid = G
        self.hits = H
        self.output = []
        pass
        
    def hitBricks(self):
        """
        :type grid: List[List[int]]
        :type hits: List[List[int]]
        :rtype: List[int]
        """
        #print self.hits
        self.resetBrick(self.grid, self.hits)
        return self.output
        
        
    def resetBrick(self, grid, hits):
        #print hits
        for e in hits:    #e=[1,1]
            print e
            
            r = e[0]
            c = e[1]
            
            #print "[r,c] = [%d, %d] \n" % (r,c)
            #print self.grid
            self.grid[r][c] = 0
            self.output.append(self.checkOutput(grid))
    
    def checkOutput(self, grid):
        if grid[0][0] == 1:
            grid[0][0] = 0
            
        outBoolean = np.logical_xor(grid[0],grid[1])
        outBinary = outBoolean.astype(int)
        #print outBoolean
        #print outBinary
        
        if outBinary[0] == 1:  #Get rid of 1 that is closes to side wall.
            outBinary[0] = 0
            
        #print outBinary            
        return int(np.sum(outBinary))
                     
#The number of rows and columns in the grid will be in the range [1, 200].        

"""
while True:        
    grid = input("Please input Grid data of your elements in list of array: ") 
    print "Input grid is: %s \n" % (grid)
    hits = input("Please input hit data: ") 
    print "Input hits is: %s \n" % (hits)
    break
"""


"""
import numpy as nm
self.grid = np.arange(1, fullSize+1).reshape(fullSize,fullSize)

#The list of lists 
#1
grid = [[1,0,0,0],[1,1,1,0]]
hits = [[1,0]]

#2
grid = [[1,0,0,0],[1,1,0,0]]
hits = [[1,1],[1,0]]
rtype = []
    
LoadedGrid = Solution(grid, hits)

print LoadedGrid

rtype = LoadedGrid.hitBricks()
out = int(np.sum(rtype))
print out

print('\n'.join('{}: {}'.format(*k) for k in enumerate(rtype)))
"""

###########################################################
def stringToInt2dArray(input):
    return json.loads(input)

def integerListToString(nums, len_of_list=None):
    if not len_of_list:
        len_of_list = len(nums)
    print "length is: %d \n" % len_of_list    
    return json.dumps(nums[:len_of_list])

def main():
    import sys
    def readlines():
        for line in sys.stdin:
            yield line.strip('\n')
    lines = readlines()
    print lines
    while True:
        try:
            #print "yes1"
            line = lines.next()
            #print "yes2"
            grid = stringToInt2dArray(line)
            #print "yes3"
            line = lines.next()
            #print "yes4"
            hits = stringToInt2dArray(line)
            print "yes5"
            print grid
            #print hits
            ret = Solution(grid, hits).hitBricks()
            print "yes6"
            print "RET is: %s \n" % (ret)

            out = integerListToString(ret)
            print out
        except StopIteration:
            break

if __name__ == '__main__':
    main()

