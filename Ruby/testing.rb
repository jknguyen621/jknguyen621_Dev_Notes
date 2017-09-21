=begin
###!/usr/bin/local/ruby
##!/C:/ruby\lib\ruby\1.8
###!C:/ruby/bin
=end

#!/usr/bin/ruby

Constants = "JOE NAMATH"

puts Constants

#New Array
myArray = Array.new[4]   #looks like automatic size to string
myArray = ['N', 'a', 'm', 'a', 't', 'h']
puts myArray 
puts "\n"
myArray.each { |e| puts e}

#New Hash
myHash =Hash.new
myHash = { 1 => "Susy", 2 => "Larry"}
myHash.each {|k, v| puts "#{k}, #{v}" } 


#Reading in URLs

require 'open-uri'
#url = "http://www.google.com/search?q=ruby"

=begin
url = "http://www.google.com/search?hl=en&q=ruby&btnG=Search"

open(url) { |page| page_content = page.read()
links = page_content.scan(/<a class=1.*?href=\"(.*?)\"/).flatten
links.each {|link| puts link}
}
=end

#Demo of Attri
class Dog
  attr :bark, true
end

#Dog.instance_methods -  Object.instance_methods
myDog =Dog.new
myDog.bark = "Wolf!"

puts myDog.bark

#Demo of XML reading
require 'rexml/document'
include REXML

#=begin
address = <<XML
<address>
<name><given>Mondo</given><family>Mangrove</family></name>
<street>1234 Main St.</street>
<city>Milpitas</city>
<state>California</state>
<country>USA</country>
</address>
XML
#=end

#myXMLFile = "./Testing.xml"
#ARGV << myXMLFile 

document = Document.new(address)
puts document

require 'tk'

TkRoot.new {title "Ruby is awesome!"}

TkLabel.new {
  font TkFont.new('mistral 42')
  text "Ruby is fun, says Joe!"
  width 30
  height 3
  fg 'blue'
  pack
  }
  
  TkButton.new{
  text 'Quit'
  command 'exit'
  pack
  }
  
  Tk.mainloop
