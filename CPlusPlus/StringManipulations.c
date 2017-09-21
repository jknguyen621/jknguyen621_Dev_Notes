//StringManipulations.c

//Author: Joseph K. Nguyen
//Aug 9th, 2017

#include <stdio.h>
#include <string.h>
#include <stdlib.h>


int main(void)
{
  
        //Problem 1. Reverse Entire Input String by characters:
        printf ("\n\nProblem 1: Reverse Entire Input String by characters\n");
	
	char inputString1[] = "Don't let the sun go down on me!";
	int len = strlen(inputString1);

	printf ("Input string is: %s\n", inputString1);
	printf ("Len of string1 is: %d\n", len);

	char *begin, *end = NULL;
	char temp = ' ';

	
	begin = &inputString1[0];
	end = &inputString1[len-1];  //So that we don't terminate at 1/2 way, if we reverse the /0 terminating string.

	printf ("My test String Before Reversing is: \"%s\"\n ", inputString1);

	
	for (int c=0; (c <= (len+1)/2); c++)   // (begin != end)
	{
	  //c++;
	        temp = *end;
		*end = *begin;
		*begin = temp;
		
		begin++;
		end--;

		//printf ("My test String After Reversing: %d, %c,  \"%s\"\n ", c, temp,  inputString1);
	}
	
	printf ("My test String After Reversing is: \"%s\" ", inputString1);



  /**********************************************************************************/
	//Problem 2. Reverse Entire Input String by words:
	printf ("\n\nProblem 2: Reverse Entire Input String by words\n");
	       
	//Algo:
	/*
	  a. Find length and create an alternative buffer same size.
	  b. Start at end of buffer of first string, iterate until space, while keeping character count.
	  c. Grab the previous word and write to outstring.  
	  d. Keep count and pointers positions, continue to beginning of buffer.

	 */
	 /*  
            |<----|*p2old-----|<--*p1old\0   
	   
            |*p1new----->|*p2new---->|\0 
        */
	
	char static *p1old, *p2old, *p1new, *p2new, *ptemp = NULL;

	char inputString2[] = "Don't let the sun go down on me Today!";
	int len2 = strlen(inputString2);
	char *outputString2  = malloc((len2+1) * sizeof(char));
	//char outputString2[len2+1];

	printf ("Input string is: %s\n", inputString2);

	p1old = p2old = &inputString2[len2-1]; //last character of input string.
	p1new = p2new  = &outputString2[0];     //first character of output string.
       
	//printf("Copy of inputstring1: \'%s\'\n", p1old);

	char ch;
	int index = 0;
        int wordCount = 0;
	
	for (int c=len2; c > 0; c--)            //start at the length of the buffer and work backward.
	{
	    ch = *p2old;
	    int count =0;

	    //decrement from rear going towards front...
	    /*  if (ch == '\0')
	      ch = ' ';
	    */
	    
	    while (ch != ' ')
	    {
	        printf ("Inside while not space... : \'%c\' \n", ch);
	        count++;
	        p2old = --p1old;
	        ch = *p2old;
	    }
	    wordCount++;
	    
	    //hit word boundary, now grab that last word: 
	    ptemp = p2old; //hold the progress of current position...
      	    printf ("Count is:  %d %s\n",  count, ptemp);

	    int i;
	    for (i=0; i <= count; i++){   //start at 1 to skip whitespace
	      *(p1new + index + i) =(*(++p2old));
	      (++p2new);
	    }

	    index += (count);  //move index up
	    if (wordCount == 1)
	      {
		//index++;
		*(p1new + index) = ' ';  //put back space for last word/first word due to removed '\0'
		//++p2new;
	      }
	    
	    //*(++p2new) = ' ';
	    c -= (count);
	    
	    //p1new = p2new; // + index;

	     /*  
		 |<----|*p2old-----|<--*p1old\0  inputString2  //--
	   
		 |*p1new----->|*p2new---->|\0   outputString2  //++
            */
	    
	    //p1old = ptemp;  //move up pointer of p1 to end of previous word.
	    p2old = ptemp;  //update p2 to new p1
	    p1old = p2old;
	    printf ("Out is:  \'%s\', \'%s\' \n",  p1new, p2new);
	    ch = *(++p2old);
	    c--;
	   
	  }
       
	
	printf ("My String After Reversing by word is: \"%s\" \n", outputString2);

	
}



