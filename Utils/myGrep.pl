#!/usr/bin/perl
use FileHandle;
my $input = "76-0.txt";
my $FH = new FileHandle($input,"<");
my @array = ();
my %hash = ();  #Should initialize everything to empty

while($line = <$FH>) {
  #Separate per word on space, newline, carriage return, comma, period, question mark, etc...
  @array = split(/\s+|\,|\.|\?|\r|\n/, $line);     #Can use multiple tokens as array.
  foreach (@array) {
      $hash{$_}++;
  }		
}

while(my($k, $v) = each (%hash)) {
  printf("WORD IS:\"%s\"     \t# of Occurences:\"%d\"\n", $k, $v);	
}
