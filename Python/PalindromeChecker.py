"""
@Author: Joseph K. Nguyen

PalindromeChecker.py

Palindrome program determines if a string has an oppostive(mirror)
Start off by finding the length and the half way point.
Set Palindrome flag as False to start.
Compare the front to the back, stepping up positive in the front and negative in the back.
While comparing if they are equal.  As long as they are equal til the end, than it must be Palindrome.
Then set the Palindrome flag to True.  When the front indexed value does not equal the badck indexed value,
set Palindrome flag to False and break-out.

"""

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
            break

    return palindrome

if __name__ == '__main__':
    print "%sisPalindrome for 'racecar'%s" % ("*" * 30,"*" * 30)
    print isPalindrome("racecar")
    print "%sisPalindrome for 'madam'%s" % ("*" * 30,"*" * 30)
    print isPalindrome("madam")
    print "%sisPalindrome for 'disneyland'%s" % ("*" * 30,"*" * 30)
    print isPalindrome("disneyland")
