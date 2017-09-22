#!/usr/bin/perl
my %originalHash = ( "192.168.1.2"  => "Kodak_Photo_Frame",
                              "192.168.1.3"  => "My_Laptop",
                              "192.168.1.4"  => "IP_Cam"
                              );
                              
while (my ($k, $v ) = each %originalHash) {
                            printf("Printing out my original hash, by Key and value: Key is: %s \t Value is: %s\n",  $k, $originalHash{$k});
}

printf("\n\nNOW PRINTING OUT THE REVERSED Hash\n");
my %reversedHash = reverse %originalHash;

while (my ($k, $v ) = each %reversedHash) {
                              printf("Printing out my REVERSED hash, by Key and value: Key is: %s \t Value is: %s\n",  $k, $reversedHash{$k});
}
