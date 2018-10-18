import numpy as np

class Solution(object):
# A brick will not drop if and only if it is directly connected to the top of the grid, or at      #least one of its (4-way) adjacent bricks will not drop.
           

    def __init__(self, G, H, R):
        self.grid = G
        self.hits = H
        self.output = R
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
        
    #Clear the grid position based on hit's [R,C] values    
    def resetBrick(self, grid, hits):
        #print hits
        for e in hits:    #e=[1,1]
            print e
            
            r = e[0]
            c = e[1]
            
            print "[r,c] = [%d, %d] \n" % (r,c)
            print self.grid
            self.grid[r][c] = 0
            self.output.append(self.checkOutput(grid))
    
    def checkOutput(self, grid):
        if grid[0][0] == 1:
            grid[0][0] = 0
            
        outBoolean = np.logical_xor(grid[0],grid[1])
        outBinary = outBoolean.astype(int)
        print outBoolean
        print outBinary
        
        if outBinary[0] == 1:  #Get rid of 1 that is closes to side wall.
            outBinary[0] = 0
            
        print outBinary            
        return int(np.sum(outBinary))
                     

#The list of lists 
#1
grid = [[1,0,0,0],[1,1,1,0]]
hits = [[1,0]]

#2
#grid = [[1,0,0,0],[1,1,0,0]]
#hits = [[1,1],[1,0]]
rtype = []
    
LoadedGrid = Solution(grid,hits, rtype)
print LoadedGrid

rtype  = LoadedGrid.hitBricks()

print('\n'.join('{}: {}'.format(*k) for k in enumerate(rtype)))
