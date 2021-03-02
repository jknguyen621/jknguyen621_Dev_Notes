"""
@Author: Joseph K. Nguyen

Mod3and5.py
For a given input:
 - if the number is divisible by 3 and 5, print "FizzBuzz"
 - if the number is divisible by 3 only, print "Fizz"
 - if the number is divisible by 5 only, print "Buzz"
 - if the number is not divisible by either 3 or 5, print "NONE!!!"
"""

def fizzBuzz(n):

    if (n % 3 == 0) and (n % 5 == 0):
        print("FizzBuzz")
        return
    elif (n % 3 == 0) and (n % 5 != 0):
        print("Fizz")
        return
    elif (n % 5 ==0):
        print("Buzz")
        return
    else:
        print("NONE!!!\n")
        pass

if __name__ == '__main__':

    n = int(input()) #.strip())

    fizzBuzz(n)

"""
Examples:
n=3 => Fizz
n=6 => Fizz
n=9 => Fizz
n=10 => NONE!!!
n=12 => Fizz
n=15 => FizzBuzz
n=45 => FizzBuzz
"""