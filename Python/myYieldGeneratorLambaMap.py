#!/usr/bin/python

def search(keyword, filename):
    print('generator started')
    with open(filename, 'r') as f:
        # Looping through the file line by line
        for line in f:
            if keyword in line:
                # If keyword found, return it
                yield line



def search2(keyword, filename):
    result = []
    [result.append(x) for x in [y for y in open(filename) if keyword in y]]
    return result

#Executing search via generator
print "\nWill be calling search with generator and yield, uses less  memory...."
for x in search('Python', "largeText.txt"):
    print x

#Executing it via a lists, not using generator
print "\nWill be calling search2 with return list, uses more memory...."
the_generator = search2('Python', "largeText.txt")
print the_generator

print "Number of iterms found: %d" % len(the_generator)


#Review of Lamba and map(iterator):
print "\nDefining Lambda and using map "
greater = lambda x,y: x > y
results = map(greater, [6,1,2,3,7,5], [2,3,4,5,5,6])
print results
