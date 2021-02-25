"""
@Author: Joseph K. Nguyen
@Date: 02/22/2021

#Anagram Checker Program
Anagram is defined as: when two strings are the same length and have same counts of all characters.
NOTE: This version doesn't do multiple same characters count.
"""

array1= ["cat", "tac"]
array2 = ["bad", "dab"]
array3 = ["test", "tset"]
array4= ["dog", "dogg"]

def isAnagram(word1,word2):

    anagram = False
    if len(word1) == len(word2):
        for x in word1:
            if x in word2:
                anagram = True
            else:
                anagram = False
        return anagram
    else:
        return anagram

def main():
    (word1, word2) = array1
    print(word1)
    print(word2)

    flag = isAnagram(word1, word2)
    print(flag)

if __name__ == "__main__":
    main()