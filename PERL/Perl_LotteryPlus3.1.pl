#!/usr/bin/perl
#Perl 5.8.8

use Getopt::Long;	
use File::Path;	
use DirHandle;
use Cwd;
use Time::Local;
use POSIX qw(ceil);


#use strict;
#use warnings;

require "Lotto_Struct.ph";	#Read in The Hash Table/Struct for 1-47 + Mega(1-27)

#This program will read in the list downloaded from 'Download All Numbers' from 
#http://www.calottery.com/Games/SuperLottoPlus/WinningNumbers/
#Then will create a Hash Table,for the Super Lotto, 1-47 for first 5 numbers, and 1-27 for Mega.
#For Mega Million it is 1-56 + Mega (1-46)
#For PowerBall as of October 2015,  1-69 + Powerball (1-26)


###########################################################################################

my $App_Name = "PERL POWERBALL, SUPERLOTTO and MEGAMILLION PLUS";
my $Version_String = "Version: 3.1";			#Remember to change this when edit
my $Version_Date 	= "August 20th, 2017";			#Update this too!!!
my $Authored_String = "Developed by: Joseph K. Nguyen, MBA";
my $Copyright_String = "Copyright (C) 2011 STARS-CSI Corp.";

##########################################################################################
#Version History:
#2/27/07: Version 1.0 basically works to read data into hash, sort, and spit out to file
#2/28/07: Version 1.1 Edit Exit code, so that it will display until hit space bar, so that 
#-------  It can be used in batch file.
#3/2/07:  1.2 Provide ability to backup old Sorted file and ability to differentialte _S_ and _M_
#_______  Also, provide datestamp for backup file.
#3/3/07:  1.3 Fixed Path so that it will get relative path and cwd from local computer.
#12/12/10: 1.4 Update for variable of new cutoff values for SuperLotto and Mega in usage instruction
#12/21/10: 1.5 Update for SuperLotto QuickPick
#12/25/10:1.6 Update for QuickPick and Sorting by Value
#12/26/2010: Update, calculating STDEV for each value
#01/04/2011: v2.2 Provided feature to get Quick Pick numbers from Top 10 frequently occurred and least 10 frequently occured.
#01/18/2011: v2.3 Generate Quick Pick of 5 tickets randomly from Top 10 and bottom 10....
#02/07/2011: V2.4 Fixed that bug that intermittently select the same random number.
#02/08/2011: V2.5 Write QuickPick to File & change logic  for True QP to get both from Top and Bottom & Random from that.
#
#
#  1. Calculate Stdev for each drawing numbers including Mega-DONE
# 2.  Then sort and display by both Most Frequently occurred & -DONE
# 3.  Sort and display by largest or smallest STDEV and its drawing number.-DONE
# 4.  Make QuickPick of $5 worth for FF + Mega based on Statistics and random generator, but select only from pool of results. - DONE 1/4/2011
#5.  Return list of top # occurred numbers in array for FF and Mega-Done
# Known bugs:  Fix Standard Deviation and have Unique Sum of Square for each number based on weight and frequency...-???? Need new algorthym
#Fix repeated same random number.- DONE 2/7/2011
#Fix routine to QuickPick Multiple tickets. - DONE 12/31/2010
#Add function to select bottom-most X, opposite of Most Frequency - DONE 1/4/2011
#Add funciton to sort FF  for QuickPick .... DONE 2/8/2011
#Add function to select median X -- MAYBE NOT???
#Add function to write to file for Printer.
#Add function to randomly select from pool of Top 10 and bottom 10 of most and least frequently occured to generate 5 tickets


#8/21/2017 3.0 Add on support for PowerBall: 1-69 for first 5 number and PowerBall = 1-26.
#8/x/xxxx 3.1  - Fix bug on issue 2 of the same #s for FF on quickpick  - WIP _______
# - Fix bug on issuing a Powerball number out of range, > 26    - DATA ISSUE______
# - Fixed bug on providing leading zero to number < 10 randomly. - Fixed 8/22/2017
# - Fixed bug for using Powerball out of range when doinug -T and -B option with -P and -Q -Actual issue was DB downloaded from website include data prior to 10/04/2015.  Rem



###########
#GLOBAL VARIABLES:
my $FF = 5;

my $SUPER_LOTTO_MAX = 47;	
my $SUPER_LOTTO_MEGA_MAX = 27;
my $SUPER_FF ="SuperLotto_First_Five";
my $SUPER_M = "SuperLotto_Mega_Number";

my $MEGA_MIL_LOTTO_MAX = 56;	
my $MEGA_MIL_MEGA_MAX = 46;
my $MEGA_MILLION_FF ="Mega_Million_First_Five";
my $MEGA_M = "Mega_Million_Mega_Number";

my $POW_FF_MAX = 69;
my $POW_POW_MAX = 26;
my $POW_FF ="POW_First_Five";
my $POW_P = "POW_POW_Number";


#CUTOFF FILTERS FOR USAGE
my $SUPER_5_CUTOFF = "130";
my $SUPER_M_CUTOFF = "52";
my $MEGA_5_CUTOFF = "60";
my $MEGA_M_CUTOFF = "18";
my $POW_5_CUTOFF = "20";
my $POW_P_CUTOFF = "10";


my $HFILEOUT = "Sorted_Lottery_Data";                       #Note: WO Extension for now.
my $QUICK_PICK_TICKETS = 5;  #Number of tickets to print for quick pick
my $TOP_FF_X= 10; #number of top FF to get
my $TOP_M_X= 5; # number of top Megas to get
my $BOT_FF_X= 10; #number of bot FF to get
my $BOT_M_X= 5; # number of bot Megas to get

my $outFile1 = "/Users/jknguyen/Downloads/QuickPick.txt";

my @previousRandom=();

#Prototypes
sub display_logo();
sub usage($);
sub calMeanFirstFive(%);
sub calMeanMega(%);

sub PrintHashTable (%) ;
sub WriteHashToFile (%) ;
sub UpdateHash(@);
sub calcStdvForDrawing($$$);
sub fillStdevHashFF($$$%);
sub fillStdevHashM($$$%);
sub printStdevHash(%);

display_logo();
#usage(0);

my $do_hDat = $do_Super = $do_Mega =  "";

my $home_dir =  cwd;		#preserve my directory
print "CWD:$home_dir\n";

my $Path = $home_dir;
print "Path: $Path\n";

# $Path =~ s/\//\\/g;     #Replace forward / with backward \  #Commented out, only needed on windows, but now I am running on MacBook Pro!!!
$Path = $Path."\/";   #\/ for MacBook


open(TICKETS,  '>', $outFile1)
		or die "could not open OUTPUT TICKETS File: $Path: $!";  #Write QuickPick To File

		
GetOptions(
		"B|b"	=> \$do_Bottoms,  #Get QuickPick from Bottom Selected X from table, see header
		"D|d"	=> \$do_hDat,
		"S|s"	=> \$do_Super,  # Use SuperLotto.txt input
                "M|m"	=> \$do_Mega,  # Use MegaMillions.txt input
                "P|p"   => \$do_Power, #User PowerBall.txt input
		"Q|q"   => \$do_Quick,    #Get QuickPick from Top selected X from table, seee header
                "T|t"   => \$do_TrueQP,  #Get Quick Pick Randomly from entire table, need to fix to combine Top(Q) and Bottom (B) to randomly select 5-10 QP tickets
                "H|h"   => \$do_Help,  #Help Menu
		"--"
		) or usage(1);

	

if ($do_Help && @ARGV)
{
    usage(1);
}

if ($#ARGV >= 1) { 
	if($do_hDat && @ARGV) {	
		$do_hDat = shift @ARGV;
		$Path .= $do_hDat;
		printf "DAT selected is: $do_hDat \n";
	}
	if($do_Super && @ARGV) {	
		$do_Super = shift @ARGV;
		printf "SuperLotto selected is: $do_Super \n";
		$Frequency_First_Five = $SUPER_FF;
		$Frequency_Mega_Number = $SUPER_M;
		print "*************************SUPERLOTTO!!!********************************\n\n";
	}
	if($do_Mega && @ARGV) {	
		$do_Mega = shift @ARGV;
		printf "MegaMillion selected is: $do_Mega \n";
		$Frequency_First_Five = $MEGA_MILLION_FF; 
		$Frequency_Mega_Number = $MEGA_M;
		print "**************************MEGA MILLION!!!*******************************\n\n";
        }
        if($do_Power && @ARGV) {	
		$do_Power = shift @ARGV;
		printf "Powerball selected is: $do_Power \n";
		$Frequency_First_Five = $POW_FF; 
		$Frequency_Mega_Number = $POW_P;
		print "**************************MEGA MILLION!!!*******************************\n\n";
	}
	if($do_Quick && @ARGV) {	
		$do_Quick = shift @ARGV;
		printf "Top Quick Pick  selected is: $do_Quick \n";
		if($do_Super)
		{
			printf("SUPER TABLE IS BEING USED!\n");
			$Frequency_First_Five = $SUPER_FF;
			$Frequency_Mega_Number = $SUPER_M;
			
		}
		elsif($do_Mega)
		{
			printf("MEGAMILLION TABLE IS BEING USED!\n");
			$Frequency_First_Five = $MEGA_MILLION_FF; 
			$Frequency_Mega_Number = $MEGA_M;
                }
                elsif($do_Power)
                {       printf("POWERBALL TABLE IS BEING USED!\n");
			$Frequency_First_Five = $POW_FF; 
			$Frequency_Mega_Number = $POW_P;
                       
                }
		print "****************************QUICK PICK FROM TOPS!!!*********************************\n\n";
	}
	if($do_Bottoms && @ARGV) {	
		$do_Bottoms = shift @ARGV;
		printf "Bottom Quick Pick  selected is: $do_Bottoms \n";
		if($do_Super)
		{
			printf("SUPER TABLE IS BEING USED!\n");
			$Frequency_First_Five = $SUPER_FF;
			$Frequency_Mega_Number = $SUPER_M;
			
		}
		elsif($do_Mega)
		{
			printf("MEGAMILLION TABLE IS BEING USED!\n");
			$Frequency_First_Five = $MEGA_MILLION_FF; 
			$Frequency_Mega_Number = $MEGA_M;
		}
		elsif($do_Power)
		{     
			printf("POWERBALL  TABLE IS BEING USED!\n");
			$Frequency_First_Five = $POW_FF; 
			$Frequency_Mega_Number = $POW_P;
		}
		print "****************************QUICK PICK FROM BOTTOMS!!!*********************************\n\n";
	}
	if($do_TrueQP && @ARGV) {	
		$do_TrueQP = shift @ARGV;
		printf "TRUE Quick Pick  selected is: $do_TrueQP \n";
		if($do_Super)
		{
			printf("SUPER TABLE IS BEING USED!\n");
			$Frequency_First_Five = $SUPER_FF;
			$Frequency_Mega_Number = $SUPER_M;
			
		}
		elsif($do_Mega)
		{
			printf("MEGAMILLION TABLE IS BEING USED!\n");
			$Frequency_First_Five = $MEGA_MILLION_FF; 
			$Frequency_Mega_Number = $MEGA_M;
		}
		elsif($do_Power)
		{       printf("POWERBALL  TABLE IS BEING USED!\n");
			$Frequency_First_Five = $POW_FF; 
			$Frequency_Mega_Number = $POW_P;
		}
		print "****************************QUICK PICK FROM BOTTOMS!!!*********************************\n\n";
       }
}
else
{
    usage(1);
    exit(1);
}


print "Path is: $Path\n";
##################################################################################################
#Main routine to go through Lottery Historical data and update Hash Table and printout accordingly
MAIN: 
{

        printf("About to open INPUT Lottery DB File: %s \n", $Path);
    
	open(HLDAT, $Path) 
		or die "could not open Lottery Historical Data File: $Path: $!"; #Create a handle to Lottery Historical Data

	while(chomp($line = <HLDAT>))
	{
			##### DEBUGGING #################
	                #print "Line read in is: $line\n";

			@Data = split(/\s+/, $line); #Parse based on white space, all white spaces will be treated as single space under \x+

			#print "Split Line's Contents are: @Data\n";

			#Take care and get rid of header:
			$test = shift(@Data);
			
			if ($test eq "Draw" || $test eq "Download") 
			{ #skip
			#Do nothing with line
				print "Draw Line will be deleted\n";
			}
			elsif ($test eq "------") 
			{
				print "Dashes line will be deleted\n";
			}
			elsif ($test eq "") 
			{	#skip
			#Do nothing with line
				print "Empty line: will ber ignored\n\n";
			}
			else 
			{
			    shift (@Data);		#Get rid of Date aslo  #day of week
			    shift (@Data);              # Month  New format of downloaded data 
			    shift (@Data);              # Day of month
			    shift (@Data);              #year
			    
			    #print "Actual Processing Line: @Data\n";
			    UpdateHash(@Data);		#Load up Hash Structure with Data
			}
	}

	close(HLDAT);
	
	

	
	#Copy over 2 Hashes for STDEV calculations, so that we do not DESTROY original input HASH structures.
	my %stdevFF;
	my %stdevM;
	
	#Hashes to store Sum of Square calculated per drawing number based on their frequencies or occuring.
	my %sumofSqFF;
	my %sumofSqM;
	
	%stdevFF = %Frequency_First_Five;
	%stdevM = %Frequency_Mega_Number;

	%sumofSqFF = %Frequency_First_Five;
	%sumofSqM = %Frequency_Mega_Number;
	#Testing
#	foreach (sort keys %stdevFF)
#	{
#		printf("Key is: %d, value is: %d\n", $_, $stdevFF{$_});
#	}
#	
#	printf("\n\n");
#	
	#Testing
#	foreach (sort keys %stdevM)
#	{
#		printf("Key is: %d, value is: %d\n", $_, $stdevM{$_});
#	}
	
	#Calculate Mean of first 5
	my ($ffMean, $ffItemsCount, $sum, %ffSSQHash) = calMeanFirstFive(%$Frequency_First_Five, \%sumofSqFF);
	printf ("Mean of FirstFive is = %3.2f \t Total Frequency Count for all FirstFive is = %3.2f,".
			" Total Sum is = %d \t SumofSq = %d\n", $ffMean, $ffItemsCount, $sum, %ffSSQHash);
	
	my %printHash1 = fillStdevHashFF($ffMean, $ffItemsCount,  \%stdevFF, \%ffSSQHash );
	
		#foreach (sort keys %printHash1)
		#{
		#	printf("TEST:Key is: %d, value is: %d\n", $_,$printHash1{$_});
		#}
	
	printStdevHash(\%printHash1);
	
	printf("\n\n");
	
	#Calculate Mean of Mega/PowerBall
	my ($megaMean, $megaItemsCount, $msum, %mSSQHash) = calMeanMega(%$Frequency_Mega_Number, \%sumofSqM);
	printf ("Mean of MegaNumber is = %3.2f \t Total Frequency Count for all Mega Numbers is = %3.2f,".
			" Total Sum is = %d \t SumofSq = %d\n", $megaMean, $megaItemsCount, $msum,  %mSSQHash);

	my %printHash2  = fillStdevHashM($megaMean, $megaItemsCount, \%stdevM, \%mSSQHash);
	printStdevHash(\%printHash2);
	
	if($do_Quick)
	{
		printf("\nGet Top %d FF:\n", $TOP_FF_X);
		my @topFFs = returnTopXFFNumbers($TOP_FF_X, \%Frequency_First_Five);
		foreach $v (@topFFs)
		{
			printf("Top %d FF numbers are: %d\n", $TOP_FF_X, $v);
		}
		
		printf("Get Top %d M:\n", $TOP_M_X);
		my @topMs = returnTopXFFNumbers($TOP_M_X, \%Frequency_Mega_Number);
		foreach $v (@topMs)
		{
			printf("Top %d Mega numbers are: %d\n", $TOP_M_X, $v);
		}
		
		 
		
		 @quickPick=();
		 for( $j=1; $j <= $QUICK_PICK_TICKETS; $j++)
		 {
			 @quickPick = makeQuickPick(\@topFFs, \@topMs);
			#Printing out quickpick from tops numbers:
			printf("\nQuickPick Numbers are: \t");
			foreach $v (@quickPick)
			{
				printf(" %d", $v);
				print(TICKETS  $v." ");
			}
		
			printf ("\n");
			print TICKETS "\n";
		
			@quickPick=();  #Reset it.
		}
	}
	
	if($do_Bottoms)
	{
		printf("\nGet Bottom %d FF:\n", $BOT_FF_X);
		my @botFFs = returnBottomXFFNumbers($BOT_FF_X, \%Frequency_First_Five);
		foreach $v (@botFFs)
		{
			printf("Bottom %d FF numbers are: %d\n", $BOT_FF_X, $v);
		}
		
		printf("Get Bot %d M:\n", $BOT_M_X);
		my @botMs = returnBottomXFFNumbers($BOT_M_X, \%Frequency_Mega_Number);
		foreach $v (@botMs)
		{
			printf("Bot %d Mega numbers are: %d\n", $BOT_M_X, $v);
		}
		
	 
		
		@quickPick=();
		for( $j=1; $j <= $QUICK_PICK_TICKETS; $j++)
		{
		    ######DEBUG#######
		    #print @botFFs;
		    #print @botMs;
		    
			@quickPick = makeQuickPick(\@botFFs, \@botMs);
			#Printing out quickpick from tops numbers:
			printf("\nQuickPick Numbers are from Bottom: \t");
			foreach $v (@quickPick)
			{
				printf(" %d", $v);
				print(TICKETS  $v." ");
			}
		
		 	printf ("\n");
			print TICKETS "\n";
			 
			@quickPick=();  #Reset it.
		}
	}
	
	if($do_TrueQP)
	{
		@TopandBottomFF = ();
		@TopandBottomM = ();
		
		#Get Top Most Frequent list of FF and M
		#printf("\nGet Top %d FF:\n", $TOP_FF_X);
		my @topFFs = returnTopXFFNumbers($TOP_FF_X, \%Frequency_First_Five);
		
		push(@TopandBottomFF, @topFFs);
		
		foreach $v (@topFFs)
		{
			#printf("Top %d FF numbers are: %d\n", $TOP_FF_X, $v);
		}
		
		#printf("Get Top %d M:\n", $TOP_M_X);
		my @topMs = returnTopXFFNumbers($TOP_M_X, \%Frequency_Mega_Number);
		
		push(@TopandBottomM, @topMs);
		
		foreach $v (@topMs)
		{
			printf("TESTING: Top %d Mega numbers are: %d\n", $TOP_M_X, $v);
		}
		
		
		
		#Get Bottom Most Frequent list of FF and M 
		printf("\nGet Bottom %d FF:\n", $BOT_FF_X);
		my @botFFs = returnBottomXFFNumbers($BOT_FF_X, \%Frequency_First_Five);
		
		push(@TopandBottomFF, @botFFs);
		
		foreach $v (@botFFs)
		{
			#printf("Bottom %d FF numbers are: %d\n", $BOT_FF_X, $v);
		}
		
		printf("Get Bot %d M:\n", $BOT_M_X);
		my @botMs = returnBottomXFFNumbers($BOT_M_X, \%Frequency_Mega_Number);
		
		push(@TopandBottomM, @botMs);
		
		foreach $v (@botMs)
		{
			printf("TESTING: Bot %d Mega/Power numbers are: %d\n", $BOT_M_X, $v);
		}
		
	 
		#TESTING
		
		foreach (@TopandBottomFF)
			 { printf("Testing: Combined Top and Botooms FFs: %d \n", $_); }
		
		printf("\n\n");
		
		foreach (@TopandBottomM)
			 { printf("Testing: Combined Top and Botooms Ms/Ps: %d \n", $_); }

		
		#ENDOFTESTING
		
		
		
		@quickPick=();
		 for( $j=1; $j <= $QUICK_PICK_TICKETS; $j++)
		{
			 @quickPick = makeQuickPick(\@TopandBottomFF, \@TopandBottomM);
			#Printing out quickpick from tops numbers:
			printf("\nQuickPick Numbers are TRUE QP, from TOPs and BOttoms and Random from Both: \t");
			foreach $v (@quickPick)
			{
				print(TICKETS  $v." ");
			}
		
			printf ("\n");
			print TICKETS "\n";
			 
			@quickPick=();  #Reset it.
		}
		
	}
	
#want to calculate the Stdev of each 
	###################################################################################
	#USAGE INSTRUCTIONS:

	print "Please input Minimum Count for Cutoff to Printout \n";
	print "\n";
	print "Cutoff for first five draws frequency <enter>. Example: $SUPER_5_CUTOFF (SupperLotto) or $MEGA_5_CUTOFF (MegaMillion) or $POW_5_CUTOFF (PowerBall) \n";
	print "Cutoff for Mega number frequency <enter>.  Example: $SUPER_M_CUTOFF (SupperLotto) or $MEGA_M_CUTOFF (MegaMillion) or $POW_P_CUTOFF (PowerBall)\n";
        print "\n";
	print "Exit Input by CTRL-Z <enter> for EOF on Windows! \n\n";
	print "Exit Input by control+D for EOF on MacBook/Linux \n\n";

	###################################################################################

	while (chomp($input = <STDIN>)) 
	{  #get rid of \n from input line, reading until Ctrl-Z
	 push (@line, $input);

	}

	$Cutoff1 = shift @line;
	$Cutoff2 = shift @line;


	print "Cutoff you wish is: $Cutoff1, $Cutoff2\n";

	PrintHashTable (%$Frequency_First_Five, %$Frequency_Mega_Number);  #Printout current Hash Table

	WriteHashToFile(%$Frequency_First_Five, %$Frequency_Mega_Number);  #Write Hash Table to FILE

	print "Please press CTRL-Z then  <enter> for EOF on Windows!,  whenever you are ready to exit!\n";
	print "Please press control+D for EOF on MacBook/Linus,  whenever you are ready to exit!\n";
	while (chomp($line = <STDIN>)) 
	{
	};
	exit(0);
	
	close(TICKETS);
}#End of Main


##################################################################################################
#Sub-routines Starts here.

#Display App's Logo at start.
sub display_logo()
{
	system("cls");
	printf "\n\n\t\t\t$App_Name\n";
	printf "\t\t\t$Version_String\n";	
	printf "\t\t\t$Version_Date\n";		
	printf "\t\t\t$Authored_String\n";
	printf "\n\t\t\t$Copyright_String\n\n\n";
	
	sleep 2;

	#system("cls");
}

################################################################################
sub GetDrive() {	
	my $Path = shift(@_);
	my @Dir = split(/\\/,$Path);
	my $Drive = shift(@Dir);
	$Drive = $Drive."\\";

	return $Drive;
}



################################################################################
#Display syntax usage
sub usage($) 
{
	$exit_code = shift @_;
	print STDERR "\nusage:perl.exe $0 -D|d Datfile.txt -S|s (Superlotto) -M|m (MegaMil) -P|p (PowerBall) \n";
	print STDERR "\nusage:perl Perl_LotteryPlus1.3.pl -D SuperLottoPlus.txt -S SUPER\n";
	print STDERR "\nusage:perl Perl_LotteryPlus1.3.pl -D MegaMillions.txt -M MEGA\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus2.1.pl -D MegaMillions.txt -M MEGA\/-S SUPER -Q 1  For QUICK PICK using TOPs X\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus2.1.pl -D MegaMillions.txt -M MEGA\/-S SUPER -B 1  For QUICK PICK using Bottoms X\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus2.1.pl -D MegaMillions.txt -M MEGA -Q 1 -B 1  For QUICK PICK using both Top & Bottoms X\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus2.1.pl -D MegaMillions.txt -S SUPER -Q 1 -B 1  For QUICK PICK using both Top & Bottoms X\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus2.2.pl -D SuperLottoPlus.txt -S Super -T 1 For TRUE QUICK PICK using entire SUPER TABLE\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus2.2.pl -D SuperLottoPlus.txt -M MEGA -T 1 For TRUE QUICK PICK using entire MEGAMILLION TABLE\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus3.0.pl -D PowerBall.txt -P POWER  -Q 1  For QUICK PICK using TOPs X\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus3.0.pl -D PowerBall.txt -P POWER  -Q 1 -B1  For QUICK PICK using Tops & Bottos  X\n\n";
	print STDERR "\nusage:perl Perl_LotteryPlus3.1.pl -D PowerBall.txt -P POWER -T 1 For True Quick Pick using entire POWERBALL TABLE\n\n";


	
return $exit_code;
}

################################################################################
sub UpdateHash(@) 
{

#print "Received: @_\n";
	#print "Routines are: $Frequency_First_Five,$Frequency_Mega_Number\n"; 

#Take care of first five
	for ($i=0; $i<$FF; $i++)  
	{
		my $draw = shift (@Data);
		#print "Draw # is: $draw\n";

		#Add on to fix adding leading zero for Mega, or PowerBall   #  8/22/2017
		$draw = convertSingleDigitToTwo($draw);

		$Frequency_First_Five{$draw} +=  1;
	}

#Take care of Mega Number

	my $draw = shift (@Data); 
	print "Draw Mega# is: $draw\n";
	
	#Add on to fix adding leading zero for Mega, or PowerBall   #  8/22/2017
	$draw = convertSingleDigitToTwo($draw);
	
	$Frequency_Mega_Number{$draw} += 1;
}


################################################################################

sub PrintHashTable (%) 
{

	my $Frequency_First_Five = shift @_;
	my $Frequency_Mega_Number = shift @_;

	#Header
	if ($do_Super)  {
		print "\n\nRUNNING SUPERLOTTO HISTORICAL ANALYSIS!!!\n\n";
	}
	elsif ($do_Mega) {
		print "\n\nRUNNING MEGA MILLION HISTORICAL ANALYSIS!!!\n\n";

	}

	#Frequency of First Five
	print "\nFirst Five Numbers Frequency!\n";
	print "Mininum cutoff is: $Cutoff1\n";

	#print "Routines are: $Frequency_First_Five,$Frequency_Mega_Number\n"; 
	#my %reversedFirstFive = reverse %Frequency_First_Five;  #Keys and Values are swapped
	#Example Frequency of 50 for number 1 1=> 50 becomes  50=>1
	#foreach $key (sort keys %reversedFirstFive) {										#Sort Keys by ASCII storage
	#	if (($reversedFirstFive{$key}) &&  ($reversedFirstFive{$key} >= $Cutoff1)) {
	#		print "Number is: $key, Frequency of draw IS: $reversedFirstFive{$key}\n";
	#	}
	#}
	
	#Print Values/Frequency by Desc order:
	printf("Displaying Frequency Count for each drawing by Descending order of Frequency for FF:\n");
	foreach my $key (sort {hashValueDescendingNum (%Frequency_First_Five)} keys %Frequency_First_Five) {
		#print "\t Frequency of: $Frequency_First_Five{$key} \t\t For: $key\n";
	}

	#Header
	if ($do_Super)  {
		print "\n\nRUNNING SUPERLOTTO HISTORICAL ANALYSIS!!!\n\n";
	}
	elsif ($do_Mega) {
		print "\n\nRUNNING MEGA MILLION HISTORICAL ANALYSIS!!!\n\n";

	}


	#Frequency of Mega
	print "\nMega Number Frequency!\n";
	print "Mininum cutoff is: $Cutoff2\n";

	#foreach $key (sort keys %Frequency_Mega_Number) {										#Sort Keys by ASCII storage
	#	if (($Frequency_Mega_Number{$key}) && ($Frequency_Mega_Number{$key} >= $Cutoff2)) {
	#		print "Frequency of draw IS: $Frequency_Mega_Number{$key}, FOR = $key\n";
	#	}
	#}
	#foreach  my $key (sort { hashValueAscendingNum (%grades) } keys %grades) 
	printf("Displaying Frequency Count for each drawing by Descending order of Frequency for MEGA:\n");
	foreach my $key (sort {hashValueDescendingNum(%Frequency_Mega_Number)} keys %Frequency_Mega_Number) {
		#print "\t Frequency of: $Frequency_Mega_Number{$key} \t\t For: $key\n";
	}

} # PrintHashTable () 

################################################################################
sub WriteHashToFile(%) 
{

	my $Frequency_First_Five = shift @_;
	my $Frequency_Mega_Number = shift @_;


	#my $date = `date`;		#Call system to get date, hunged for some weird unknown reasons.
	my $date = localtime;           #Get current Date-Timestamp
	$date =~ s/\s+//g;                #Get rid of spaces in timestamp, to make it as one string.
	$date =~ s/\:+//g;                 #Get rid of ::
	printf "\nDatestamp now is: $date\n";


        

	if ($do_Super)  {
	    $HFILEOUT .= "_S_";
	    rename $HFILEOUT."/.txt" , $HFILEOUT.$date."/.txt";            #Make a copy of old sorted SUPER data file
	}
	elsif ($do_Mega) {
	    $HFILEOUT .= "_M_";
            rename $HFILEOUT."/.txt" , $HFILEOUT.$date."/.txt";            #Make a copy of old sorted MEGA data file
	}
        open(SUMMARY_FILE, ">$HFILEOUT.txt")  or die "The summary file can't be opened: $!";  #Open new everytime, overwrite, not append ">>"
	#$^I = "$HFILEOUT.$date";		#backup existing sorted data file, according to book, but does not work
	#printf "\nBackup filename is: $^I\n";

	#Header
	if ($do_Super)  {
		print SUMMARY_FILE "\n\nRUNNING SUPERLOTTO HISTORICAL ANALYSIS!!!\n";
	}
	elsif ($do_Mega) {
		print SUMMARY_FILE "\n\nRUNNING MEGA MILLION HISTORICAL ANALYSIS!!!\n";
	}


	#Take care of first 5 draw numbers
	print SUMMARY_FILE "\nFirst Five Numbers Frequency!\n";
	print SUMMARY_FILE "Mininum cutoff is: $Cutoff1\n";
	#print SUMMARY_FILE "Sorted by keys or indexes!\n";

	#Sort by keys
	foreach $key (sort keys %Frequency_First_Five) {										#Sort Keys by ASCII storage
		if (($Frequency_First_Five{$key}) &&  ($Frequency_First_Five{$key} >= $Cutoff1)) {
			print SUMMARY_FILE "Frequency of draw IS: $Frequency_First_Five{$key}, FOR  = $key\n";
		}
	}
	
	#Sort by Values
	#print SUMMARY_FILE "Sorted by Frequency or Values!\n";
	#foreach $key (sort values %Frequency_First_Five) {										#Sort by Values
	#	if (($Frequency_First_Five{$key}) &&  ($Frequency_First_Five{$key} >= $Cutoff1)) {
	#		print SUMMARY_FILE "Frequency of draw IS: $Frequency_First_Five{$key}, FOR  = $key\n";
	#	}
	#}

	#Header
	if ($do_Super)  {
		print SUMMARY_FILE "\n\nRUNNING SUPERLOTTO HISTORICAL ANALYSIS!!!\n";
	}
	elsif ($do_Mega) {
		print SUMMARY_FILE "\n\nRUNNING MEGA MILLION HISTORICAL ANALYSIS!!!\n";
	}

	#Take care of MEGA number
	#Frequency of Mega
	print SUMMARY_FILE "\nMega Number Frequency!\n";
	print SUMMARY_FILE "Mininum cutoff is: $Cutoff2\n";
	#print SUMMARY_FILE "Sorted by keys or indexes!\n";

	#Sort by keys
	foreach $key (sort keys %Frequency_Mega_Number) {	  #Sort Keys by ASCII storage
		if (($Frequency_Mega_Number{$key}) && ($Frequency_Mega_Number{$key} >= $Cutoff2)) {
		  print SUMMARY_FILE "Frequency of draw IS: $Frequency_Mega_Number{$key}, FOR = $key\n";
		}
	}

	#Sort by values
	#print SUMMARY_FILE "Sorted by Frequency or Values!\n";
	#foreach $key (sort values %Frequency_Mega_Number) {										#Sort by Values
	#	if (($Frequency_Mega_Number{$key}) && ($Frequency_Mega_Number{$key} >= $Cutoff2)) {
	#	      print SUMMARY_FILE "Frequency of draw IS: $Frequency_Mega_Number{$key}, FOR = $key\n";
	#	}
	#}
	
	close (SUMMARY_FILE);
} #WriteHashToFile()
##########################################################################

#TODO: Fix so lower than half round down...
sub roundoff
{
  my $num = shift;
  my $roundto = shift || 1;

  return int(ceil($num/$roundto-0.5))*$roundto;
}

##################################################################################
sub returnTopXFFNumbers
{
	my $xRequested = shift @_;
	my $refHash = shift @_;
	#printf("Returning top X numbers requested for FF or Mega:\n");
	my $i = 0;
	@topXNumbers = ();

	my $local_Max_MP = 0;
	if ($do_Super)
	{
	    $local_Max_MP = 47;
	}
	elsif($do_Mega)
	{
	    $local_Max_MP = 56;
	}
	elsif($do_Power)
	{
	    $local_Max_MP = 26;
	}
	
	foreach $key (sort {hashValueDescendingNum(%$refHash)} keys %$refHash) {
		print "\t Frequency of: $$refHash{$key} \t\t For: $key\n";
		if($xRequested >=1) 
		{
			push(@topXNumbers, $key);     
			$xRequested--;
		}
		else
		{
			break;
		}
		
	}
	return @topXNumbers;
}

##################################################################################
sub returnBottomXFFNumbers
{
	my $xRequested = shift @_;
	my $refHash = shift @_;
	#printf("Returning Bottom X numbers requested for FF or Mega:\n");
	my $i = 0;
	@botXNumbers = ();
	foreach $key (sort {hashKeyAscendingNum(%$refHash)} keys %$refHash) {
		#print "\t Frequency of: $$refHash{$key} \t\t For: $key\n";
		if($xRequested >=1) 
		{
			push(@botXNumbers, $key);     
			$xRequested--;
		}
		else
		{
			break;
		}
		
	}
	return @botXNumbers;
}
################################################################################
sub pickRandomNumberFromArray
{
	#my $refTestArray= ();  #Need to reinit here...
	 my ($refTestArray, $previousRandom) = @_;
	
	my $range = scalar @$refTestArray; 
	#printf "My range is %d\n", $range;
	
	my $random_number = int(rand($range));
	#push(@$previousRandom, $random_number);
	#printf("My random number OUTSIDE LOOP is: %d\n", $random_number);
	foreach (@$previousRandom)
	{
		#If Currently created Random Number matches
		#one of previous random numbers, make 
		#another selection, until get different number
		while($_  == $random_number )
		{
			$random_number = int(rand($range));
		}
		
	}
	push(@$previousRandom, $random_number);
	return @$refTestArray[$random_number];
}
################################################################################

sub makeQuickPick
{
	my ($topFFs, $topMs) = @_;
	my @quickPick = ();
	
	@previousRandom=();  #To ensure we do not get the same previous Random number again.
	
	foreach (@$topFFs)
	{
		#printf ("Testing FFs %d\n", $_);
	}
	
	foreach (@$topMs)
	{
		#printf ("Testing Ms %d\n", $_);
	}
	
	#printf("Getting Random for First Five...\n");
	for($i=1; $i<=5; $i++)
	{
		push(@quickPick, pickRandomNumberFromArray($topFFs, \@previousRandom));
	}
	#Add leading zero for lesser than 9
	@newQuickPick = addLeadingZero(@quickPick);
	
	#Sort only first Five
	@sortedQuickPick = sort @newQuickPick;
	
	@previousRandom=();  #init for Mega
	#Then pick Mega Number:
	#printf("Getting Random for Mega...\n");
	push(@sortedQuickPick, pickRandomNumberFromArray($topMs, \@previousRandom));
	@returnList = @sortedQuickPick;
printf("Returning from makeQuickPick(), Array value is: \'%s\' \n", @returnList);
	return @returnList;
}

##############################################################################

sub addLeadingZero
{
    ######DEBUG######
    #printf ("INTO ADDING LEADING ZERO, %s \n", @_);
    
	my(@noLeadingZero) = @_;
	my $size = scalar @noLeadingZero;
	my $add = "0";
	
	for($i=0; $i<$size-1;$i++)
	{
		if($$noLeadingZero[$i] < 10)
		{
		        $noLeadingZero[$i] = convertSingleDigitToTwo($noLeadingZero[$i]);   #New method to fix leading zero and make it reusable. #  8/22/2017
     		}
	}
    @withLeadingZero = @noLeadingZero;
    
    ######DEBUG######
    #printf ("EXITING ADDING LEADING ZERO, %s \n", @withLeadingZero_);
    
	return @withLeadingZero;
}

#############################################################################
#  8/22/2017
sub convertSingleDigitToTwo
{
    my ($input) = @_;
    my $add = "0";
    my $output = "";

    if ($input < 10)
    {
		####### DEBUG #############
	        #printf("Found2 # lesser than 10 \'%d\'\n", $input);
	
		$test = sprintf("%02d", $input);
		$output =  $test;

		######## DEBUG ###########
		#printf("New Value # lesser than 10 \'%02d\'\n", $output);
    }
    else
    {
	$output = $input;
    }

    return $output;
}

##############################################################################
sub getXQuickPickTickets
{
	#my $X = shift @_;
	my ($X, $topFFs, $topMs) = @_;
	@quickPick = ();
	
	#$i=1;

	#do{	
		 @quickPick = makeQuickPick($topFFs, $topMs);
		#Printing out quickpick from tops numbers:
		
	
		printf("QuickPick Numbers %d are: \t", $i);
		foreach ( @quickPick)
		{
			printf(" %d", $_);
		}
	
		printf ("\n");
		@quickPick = ();
		#$i++;
	#}while ($i<=$X);		
}

###########################################################################

############################################################################
# Input: Refernce to an input array containing data. i.e. : \@userData;
#  Synosis: 
#  my @userData = (3.4, 8, 7, 35, 90, 112, 34, 46, 78, 23);
#  my ($mean, $stdv_value) = calcStdv(\@userData); 
#  printf ("STDV of Population for @$userData is: \"$stdv_value\" , and mean is:\"$mean\" \n");
#
# Output: $mean, $stdev
################################################################################

sub calcStdv
{
  	my $ar = shift;
  	my $elements = scalar @$ar;
  	my $sum = 0;
  	my $sumsq = 0;

  	foreach (@$ar) 
	{
    		$sum += $_;
	    	$sumsq += ($_ **2);
  	}

	my $mean = $sum/$elements;
	
  	return ($mean, sqrt( $sumsq/$elements - ($mean ** 2)));
}


################################################################################
sub calcStdvForDrawing($$$)
{
  	my ($mean, $itemCount,  $sumSq) = @_;
	#printf("Inside calcStdvForDrawing: count=%d, meansq=%d, quotient=%6.2f\n", $itemCount,  ($mean ** 2), abs( $sumSq/($itemCount - ($mean ** 2))));
  	return (sqrt(abs( $sumSq/($itemCount - ($mean ** 2)))));
}


################################################################################
sub fillStdevHashFF($$$%)
{
	my ($ffMean, $ffItemsCount,  $stdevFF, $refFFSSQHash )= @_;
	
	printf ("Inside fillStdevHashFF: %d, %d, %d, \"%d\"\n", $ffMean, $ffItemsCount,  $stdevFF, $refFFSSQHash );
	
	foreach $key (sort keys %$stdevFF)
	{
		#printf("FF: Key value is: %d, value is: %d\n", $key, $$stdevFF{$key} );
		$$stdevFF{$key} =  roundoff(calcStdvForDrawing($key, $ffItemsCount,  $$refFFSSQHash{$key}));
		#printf("Calculated STDEV is: %5.4f\n", calcStdvForDrawing($key, $ffItemsCount,  $sumSq));
		#printf("FF: Key value is: %d, STDEV = %5.4f\n",  $key,$$stdevFF{$key});
	}
	%returnHash = %$stdevFF;
	return %returnHash;
}

################################################################################
sub fillStdevHashM($$$%)
{
	my ($megaMean, $megaItemsCount,$stdevM, $refMegaSSQHash)= @_;
	
	printf ("Inside fillStdevHashM: %d, %d, %d, \"%d\"\n", $megaMean, $megaItemsCount,$stdevM, $refMegaSSQHash);
	
	foreach $key (sort keys %$stdevM)
	{
		#printf("MEGA: Key value is: %d, value is: %d\n", $key, $$stdevM{$key} );
		$$stdevM{$key} =  roundoff(calcStdvForDrawing($key, $megaItemsCount, $$refMegaSSQHash{$key}));
		#printf("Calculated STDEV is: %5.4f\n", calcStdvForDrawing($key, $megaItemsCount, $msumSq));
		#printf("MEGA: Key value is: %d, STDEV = %5.4f\n",  $key, $$stdevM{$key});
	}
	%returnHash = %$stdevM;
	return %returnHash;
}

################################################################################
sub printStdevHash(%)
{
	my ($stdevHash) = @_;
	
	printf ("Inside printStdevHash\n");
	
	#foreach $key (sort keys %$stdevHash )
	#{
	#	printf("STDEV for %d is = %d\n", $key, $$stdevHash{$key}); 
	#}
	#foreach  my $key (sort { hashValueAscendingNum (%grades) } keys %grades) 
	printf("Displaying STDEV by Descending order of Sigma values:\n");
	foreach my $key (sort {hashValueDescendingNum (%$stdevHash)} keys %$stdevHash) {
		#print "\t STDEV of: $$stdevHash{$key}\t\t For: $key\n";
	}
}

################################################################################
# Input: Refernce to an input array containing data. i.e. :%hashValues
#  Synosis: 
#  my  
#  my ($mean, $items) = calMeanFirstFive(%hash);
#  p
#
# Output: $mean, $stdev
################################################################################

sub calMeanFirstFive(%)
{
	my $Frequency_First_Five = shift @_;
	my $sumSqHash = shift @_;
	
	my ($mean, $itemCount, $sum, $sumSq) = 0;
	
	foreach $key (%Frequency_First_Five)
	{
		$itemCount += $Frequency_First_Five{$key};  #Get value of the location, which is the frequency count.
		$sum += ($Frequency_First_Five{$key} * $key) ;  #Calculate value of frequency * by location
	
		#Calculate Sum of Square for that drawing based on frequency, then save it to sumofSqHash.
		$$sumSqHash{$key} =  (($Frequency_First_Five{$key} * $key) **2);
	}
	%ffSSQHash = %$sumSqHash;

	if($itemCount >= 1)
	{
	    return ($sum/$itemCount, $itemCount, $sum, %ffSSQHash);
	}
	else
	{
	    return 1;
	}
}



################################################################################
# Input: Refernce to an input array containing data. i.e. :%hashValues
#  Synosis: 
#  my  
#  p
#
# Output: $mean, $stdev
################################################################################

sub calMeanMega(%)
{
	my $Frequency_Mega_Number = shift @_;
	my $sumSqHash = shift @_;
	
	my ($mean, $itemCount, $sum, $sumSq) = 0;
	
	foreach $key (%Frequency_Mega_Number)
	{
		$itemCount += $Frequency_Mega_Number{$key};  #Get value of the location, which is the frequency count.
		$sum += ($Frequency_Mega_Number{$key} * $key) ;  #Calculate value of frequency * by location
	
		#Calculate Sum of Square for that drawing based on frequency, then save it to sumofSqHash.
		$$sumSqHash{$key} =  (($Frequency_First_Five{$key} * $key) **2);
	}
	%megaSSQHash = %$sumSqHash;
	if ($itemCount >= 1)
	{
	    return ($sum/$itemCount, $itemCount, $sum, %megaSSQHash);
	}
	else
	{
	    return 1;
	}
}

################################################################################
#----------------------------------------------------------------------#
#  FUNCTION:  hashValueAscendingNum                                    #
#                                                                      #
#  PURPOSE:   Help sort a hash by the hash 'value', not the 'key'.     #
#             Values are returned in ascending numeric order (lowest   #
#             to highest).                                             #
#----------------------------------------------------------------------#

sub hashValueAscendingNum {
    my (%hash) = @_;
   return $hash{$a} <=> $hash{$b};

}

################################################################################
#----------------------------------------------------------------------#
#  FUNCTION:  hashKeyAscendingNum                                    #
#                                                                      #
#  PURPOSE:   Help sort a hash by the hash 'key', not the 'value'.     #
#             Keys are returned in ascending numeric order (lowest   #
#             to highest).                                             #
#----------------------------------------------------------------------#

sub hashKeyAscendingNum {
    my (%hash) = @_;
   return {$a <=> $b};  #UNTESTED!

}

################################################################################
#----------------------------------------------------------------------#
#  FUNCTION:  hashValueDescendingNum                                   #
#                                                                      #
#  PURPOSE:   Help sort a hash by the hash 'value', not the 'key'.     #
#             Values are returned in descending numeric order          #
#             (highest to lowest).                                     #
#----------------------------------------------------------------------#

sub hashValueDescendingNum {
    my (%hash) = @_;
   return $hash{$b} <=> $hash{$a};

}

################################################################################
#----------------------------------------------------------------------#
#  FUNCTION:  hashKeyDescendingNum                                   #
#                                                                      #
#  PURPOSE:   Help sort a hash by the hash 'key', not the 'value'.     #
#             Values are returned in descending numeric order          #
#             (highest to lowest).                                     #
#----------------------------------------------------------------------#

sub hashKeyDescendingNum {
    my (%hash) = @_;
   return {$b <=> $a};  #UNTESTED!
   #foreach $key (sort {$b <=> $a} keys %hash);

}
