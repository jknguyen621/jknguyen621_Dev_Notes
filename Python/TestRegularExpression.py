"""
@Authors: Jospeh K. Nguyen & Renato Maschion
'''
In this program, we are trying to demonstrate the usage of Python's Regular Expression library(re).
We are also traversing a directory, looking in each file within testData subdirectory for email address pattern.
We will then publish report via graph indicating how many occurrences found in each of the files.
NOTE: Some credits go to Renato Maschion for some of the methods defined.
'''
"""

import re
import os
import matplotlib.pyplot as plt
import numpy as np



results = {}
compiled_exp =''

#email_regex1 ='^[A-Z0-9._%+-]+\@[A-Z0-9.-]+\.[A-Z]{2,3}$'

def compile_regular_expression(regular_expression):

    try:
        global compiled_exp
        compiled_exp = re.compile(regular_expression)
    except Exception, e:
        raise Exception("Bad Regular Expression. ERROR: %s" % e.message)


def search_expression(current_dir, files):
    global compiled_exp
    try:
        for f in files:
            print f
            # count how many times regular expression is true in the file
            count = 0
            with open(current_dir+os.sep+f) as file:
                if f[0] in '__ .': continue
                contents = file.read().strip()
                print contents
                print compiled_exp
                count = len(compiled_exp.findall(contents))
                #match = compiled_exp.findall(contents)
                #print match
                #count = len(match)
                yield f, count
    except Exception, e:
        raise Exception("Error detected during Search Expression. ERROR: %s" % e.message)


def walkdir(root_dir):
    try:
        global results
        #loop all childreen directories
        for cur, _dirs, files in os.walk(root_dir):
            #split current diretory in root/tail
            head, tail = os.path.split(cur)
            #iterate files in child
            file_count = search_expression(cur, files)
            print file_count
            [results.update({r"%s/%s" % (head+"/"+tail,filename):count}) for filename, count in file_count]
    except Exception, e:
        raise e

def plot_results():
    try:
        global results
        plt.rcdefaults()

        objects  = results.keys()
        y_values = results.values()
        y_pos    = np.arange(len(objects))

        plt.bar(y_pos, y_values, align='center', alpha=0.5)
        plt.xticks(y_pos, objects)
        plt.xlabel('Email Addresses Found')
        plt.title('Email Addresses Found via RegEx')
        plot_margin = 0.1 
        plt.gcf().subplots_adjust(bottom=0.60)
        x0, x1, y0, y1 = plt.axis()
        plt.axis((x0 - plot_margin,
                  x1 + plot_margin,
                  y0 + plot_margin,
                  y1 + plot_margin))
        plt.xticks(rotation=90)
        plt.show()
    except Exception, e:
        raise e

if __name__ == '__main__':

    email_regex = '[a-zA-Z0-9._%+-]+\@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}'

    test_dir = os.getcwd()
    print("Current WD: %s \n" % test_dir)
    print email_regex
    compile_regular_expression(email_regex)
    walkdir("./testData/")
    plot_results()
