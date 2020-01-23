errors = ['cat', 'dog']
lines = ['abc cat dog', 'bat tab dog']

errDict = {}


def errsFind(errDict, errors, lines):
    for err in errors:
        errDict[err] = 0

    for items in lines:
        wordList = items.split(' ')

        # get error counts
        countErrorsInLogLine(errDict, wordList)


def countErrorsInLogLine(errDict, wordList):
    for err in errDict:
        for word in wordList:
            if err == word:
                errDict[err] = errDict[err] + 1




errsFind(errDict, errors, lines)
for err in errDict:
    print("Error %s count is%d \n", err, errDict[err])
