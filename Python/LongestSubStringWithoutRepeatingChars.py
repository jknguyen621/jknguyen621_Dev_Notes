"""
@Author: Joseph K. Nguyen

#LongestSubStringWithoutRepeatingChars.py
Given "abcabcbb", the answer is "abc", which the length is 3.

Given "bbbbb", the answer is "b", with the length of 1.

Given "pwwkew", the answer is "wke", with the length of 3.
Note that the answer must be a substring,
"pwke" is a subsequence and not a substring.
"""

import sys, os

class Solution(object):
    def __init__(self, s):
        self.s = s

    def lengthOfLongestSubstring(self,s):
        """
        :type s: str
        :rtype: int
        """
        sol = []
        length = len(s)
        ch = ''
        for i in range(length):
            #ch = s[i]
            if(''.join(sol) == s[i]):
                next
            else:
                ch = ''.join(sol) + s[i]
            #print ch
            if ch in s[i+1:length]:
                sol = ch
            else:
                pass
        print sol
        return len(sol)

if __name__ == '__main__':
    myStr = "abcabcbb"   #expect: "abc"  => 3
    solve = Solution(myStr)
    sol= solve.lengthOfLongestSubstring(myStr)
    print "Test case of 'abcabcbb'\n"
    print "Longest Substring Without Repeating Characters is: \'%d\'\n" % sol

    myStr = "bbbbb"  # expect: "b"  => 1
    sol1 = solve.lengthOfLongestSubstring(myStr)
    print "Test case of 'bbbbb'\n"
    print "Longest Substring Without Repeating Characters is: \'%d\'\n" % sol1

    myStr = "pwwkew"  # expect: "wke"  => 3
    sol2 = solve.lengthOfLongestSubstring(myStr)
    print "Test case of 'pwwkew'\n"
    print "Longest Substring Without Repeating Characters is: \'%d\'\n" % sol2

