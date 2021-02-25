'''
@Author: Jospeh K. Nguyen
This program will find the error counts per line(example from textfile or logfile),
and return the proper count for each of the error type.
'''

errors = ['cat', 'dog']
lines = ['abc cat dog', 'bat tab dog']

errDict = {}


def errsFind(errDict, errors, lines):
    # Load up a dictionary
    for err in errors:
        errDict[err] = 0

    # Get list from each items in lines
    for items in lines:
        wordList = items.split(' ')

        # get 'error' word counts present in lines
        countErrorsInLogLine(errDict, wordList)

#counting errors present in each word list from each line.
def countErrorsInLogLine(errDict, wordList):
    for err in errDict:
        for word in wordList:
            if err == word:
                errDict[err] = errDict[err] + 1


errsFind(errDict, errors, lines)
for err in errDict:
    print("Error \'%s\' count is \'%d\' \n" % (err, errDict[err]))
