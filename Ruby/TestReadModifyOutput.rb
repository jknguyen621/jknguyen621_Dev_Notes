#!/ruby/bin/ruby


=begin
Example of Block comment, using "=begin && =end" keywords
	Here is example of TestInput.txt
	Amy|1234 Main St., Milpitas, CA. 95035
	Annika|3456 E. Palo Alto, LA. 95210
	Alisa|6789 Monkey Island, PA. 05693
	Chori|1982 Sumkumvit Bangkok, TH. 012345
	Jessy|38443 Rose Way, SJ. 95127
	Common methods: .has_key?, .key?, .member?, .key, .value, .each, .each-key, .each-value, .each-pair, .abs, .zero?, .eql?, .nan?, .nonzero?, .shift, .unshift, .push, .pop, .flatten, .integer?, .split 

	#{file.lineno}, #{k} hash key, #{v} hash value
=end


_filePath = "./TestInput.txt"

#Method 1 of opening file, iterate, printing out with line #s too
print("\n\nMethod 1 of reading in file...\n\n")
file = File.open(_filePath)
file.each { |line| print "#{file.lineno}. ",line} 
file.close

#Method 2 of opening file into ARGV array, and then reading each line as string
print("\n\nMethod 2 of reading in file...\n\n")
ARGV << _filePath                 #Reading in file directly
print while gets

printf( "Size of array ARGV is: %d\n", ARGV.size)

#Now trying to read in file and load into hash
puts ("\n\nDemoing reading in, splitting into array and loadig into hash\n\n")

#Defining new array of 2 items
#This is not needed, but here how you would define it.
#_myArray = Array.new[2]

#Defining new Hash
_myHash = Hash.new

#Iterate through input file, splitting and loading it into array.
ARGV << _filePath                 #Reading in file directly
while (line = gets)
      #puts ("Here is my line: ", line)
      _myArray = line.split(/\|/)
      _myHash[_myArray[0]] = _myArray[1]
      #_myArray.each {|e| puts "Printing out my array element: " + e}
end

printf( "Size of array _myArray is: %d\n", _myArray.size)

#Lets overwrite one value for one key
_myHash["Jessy"] = "Love my Lady!!!"

#Iterate through hash and printing out each Key and its value
puts "\n\nPrinting out Hash\n\n"
_myHash.each { |k,v| puts "Key is: #{k}, Value is: #{v}" }


