#!/usr/bin/python

#LongestPalindromicSubstring.py

import sys, os


'''
Input: "babad"

Output: "bab"

Note: "aba" is also a valid answer.
'''
class Solution(object):
    def __init__(self, s):
        self.s = s

    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """

        result = []
        length = len(s)
        j = -1
        for i in range(length):
            if s[i] == s[j]:
                a = ''.join(result) + s[j]
                if result:
                    result.pop()
                result.append(a)
            else:
                pass

            j -= 1


            print result

        return result[0]

if __name__ == '__main__':

    myStr = "babad"   #expect: "bab"  or "aba"
    solve = Solution(myStr)
    sol= solve.longestPalindrome(myStr)
    print "Test case of 'babad'\n"
    print "Longest Palindromic Substring is: \'%s\'\n" % sol