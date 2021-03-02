"""
@Author: Jospeh K. Nguyen

FibonacciRecursive.py

This program will perform a Fibonacci series on a user input integer and print out all the values
of that Fibonacci series, using recursive routines.

# Python program to display the Fibonacci sequence up to n-th term using recursive functions
# and requesting user to input the n-th term.
"""

def recur_fibo(n):
   """Recursive function to
   print Fibonacci sequence"""
   if n <= 1:
       return n
   else:
       return(recur_fibo(n-1) + recur_fibo(n-2))

# Change this value for a different result
nterms = None

# uncomment to take input from the user
#nterms = int(input("How many terms? "))

# Get input, if nterms is not set
if nterms <= 0 or nterms == None:
   nterms = int(raw_input('Plese enter a positive integer?'))

   print("Fibonacci sequence:")
   for i in range(nterms):
       print(recur_fibo(i))
else:
    exit(1)