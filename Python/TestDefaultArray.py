#!usr/bin/python

def f(x, L=[]):
    for i in range(x):
        L.append(i*i)
    print (L)



f(2)