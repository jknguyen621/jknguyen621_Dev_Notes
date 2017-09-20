#!/usr/bin/python


"""Please solve:

Take two numbers, second number greater than the first, as input say 3 and 7
and print the sequence as follows using recursion: 3 4 5 6 7 6 5 4 3
Recursion involves calling the same function recursively until some condition is met.

@Author: Joseph Nguyen
@Date: 08-29-17

"""

#Note: Assumming the first input is lower than the second

import sys


myStaticCount = 0
countUp = 1
tobeReversed = []

def reCursive(in1, in2):

    #Preserve first input to count down later
    global myStaticCount
    if myStaticCount == 0:
        global myStartEnd
        myStartEnd = in1

    myStaticCount +=1

    global countUp
    if countUp:
        for x in range(in1, in2+1):
            print '{:d}'.format(x).strip()
            res = reCursive(x + 1, in2)
            return res


    in1 = myStartEnd
    #print("Start to count down to: %d\n", in1)

    #Set CountDown flag
    countUp = 0

    global tobeReversed
    if not countUp:
        #Create a dynamic list for countdown:
        for i in range(in1, in2):
            tobeReversed.append(i)

    #Do CountDown:
    if not countUp:
        #Traverse countdown list in reversed
        for value in reversed(tobeReversed):
            if value == in1:
                print '{:d}'.format(value).strip()
                sys.exit(0)
            print("%d " % value)
            res = reCursive(in1, value)
            return res

#Main Driver
reCursive(3, 7)