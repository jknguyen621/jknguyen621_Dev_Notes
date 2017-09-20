#!/usr/bin/python

#Palindrome program determines if a string has an oppostive
def isPalindrome(text):
    palindrome = False
    if text == None:
        return -1

    length = len(text)

    for x in range(length/2):
        if text[x] == text[length - 1 - x]:
            print ("Matched first and last: %s\n", text[x])
            palindrome = True
        else:
            print ("No longer a Palindrome \n")
            palindrome = False

    return palindrome





print isPalindrome("racecar")

#madam is true