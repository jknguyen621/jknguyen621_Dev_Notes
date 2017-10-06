/**********************************/
/**    Joseph K. Nguyen          **/
/**  Start date: 04/24/96        **/
/** Completion date:  /  /       **/
/**********************************/

// * Complete and tested load structure and Make new Node routines 4/26/96

// * Complete and tested write to output file function 5/6/96

// *Complete and tested frequency of number occurences 5/17/96
//Start to implement option #4 to generat frequency list of
//most occuring sets of combination.  Need to brainstorm about algorithm.
//3/17/99


//Known bugs: Option #2 sometimes generate 0.  Also Option#2 random generator
//is not truly randomized.
//
//
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <dos.h>
#include <general.h>
#include <math.h>
#include <time.h>   //For random() generator
#include <\sys\timeb.h>


#define     SIZE_OF_LONG        6
#define     INPUT_FILE          "lottery.dat"
#define     OUTPUT_FILE         "freqlist.dat"
#define     POSSIBILITY         51

#define EQ(a,b)          ((a) == (b))                    /* numerical sort */
#define NE(a,b)          ((a) != (b))
#define LT(a,b)          ((a) <  (b))
#define GT(a,b)          ((a) >  (b))
#define LE(a,b)          ((a) <= (b))
#define GE(a,b)          ((a) >= (b))

/***************************************************************************/
/*  Structure Definition of our data storage.                              */
/***************************************************************************/
typedef long int Data_type;                                  /* each field */

typedef struct item_tag{                        /* each lottery date entry */
  Data_type entry;
  }Item_type;
typedef struct node_tag{
  Item_type data;
  struct node_tag *next;
  }Node_type;

typedef struct list_tag{                 /* list of all lottery date entry */
  Node_type *head;
  Node_type *tail;
  }List_type;

/************ Structure for count list of numbers of occurrences ***********/
typedef struct count_tag{               /* structure for count for numbers */
  long int candidate[POSSIBILITY];             /* list of 51 possibilities */
  }Count_type;

/***************************************************************************/
/* Prototypes                                                              */
/***************************************************************************/
struct dostime_t *timep;                                /* lib function for time */
struct dosdate_t *datep;                               /*  lib function for date */
List_type *load_structure(char *[]);                     /* read from file */
Node_type *Make_Item(long int);                        /* Create Item node */
void Write_to_outfile(List_type *);             /* save data from structure*/
Count_type *frequency_counter(List_type *);    /*count frequency of numbers */
Count_type struct_sort(Count_type *);/* sort counted structure of occurence*/

/***************************************************************************/
void main(argc, argv)     /* expct cmd. like this: lottery.exe output.dat  */
 int argc;                           /* number of commands on command line */
 char *argv[];              /* array to store each command on command line */

{
  time_t t;
  struct time timep;
   char *inputfile[1], option; /*name of input file user/progrm. specified */
   List_type *database, *p;                 /* pointer to loaded structure */
   Count_type *sorted;
   int ii;
   char c;          //For random number display pausing
   //fflush(stdin);  //Get rid of space character in input stream

	int i;

  // struct time_store {                //Same struct as time or timep
  //   unsigned char  ti_min;
  //   unsigned char  ti_hour;
  //   unsigned char  ti_hund;
  //   unsigned char  ti_sec;
  // };

    if (argc < 0)
       Error("Missing parameters for command"
	      "example: lottery.exe quickpick.out");
    inputfile[0] = INPUT_FILE;


    database = load_structure(inputfile[0]);    /* load database structure */


///* USE FOR DIAGNOSTICS OF VALID DATABASE!!!
//p = database;
//while(p->head->next != NULL)
//{ printf("content of entry is %ld \n", p->head->next->data.entry);
//p->head = p->head->next;
//}

 /*    Write_to_outfile(database);         will destroy database structure */
      printf("database first content is %ld\n",database->head->data.entry);
      clrscr();
	  window(1,1,80,25);
	  textbackground(BLUE);
	  window(5, 2, 75,22);
	  textbackground(BLACK);
	  textcolor(RED);

      while(1)
       {  gotoxy(20, 3);
	  cprintf("\n\n$$$ I'M GLAD YOU'LL HAVE COME TO MAKE MONEY $$$\n\n");
	  textcolor(LIGHTGREEN);
	  gotoxy(15,6);
	  cprintf("\n S/W Engineered by: Joseph, Yaovamaln & Amita Nguyen  6/27/98, Revised 1998\n\n");
	  gotoxy(20,7);
	  cprintf("\n Database Engineer: Thuan (Tony) Tran\n\n");

	  textcolor(WHITE);
	 gotoxy(23,10);cprintf("(1) Search most frequently occurred Nos.\n");
	 gotoxy(23,11);cprintf("    and generate list of top ___ Nos.\n");
	 gotoxy(23,13);cprintf("(2) Generat e random number to index\n ");
	 gotoxy(23,14);cprintf("    from 1 to 51.\n");
	 gotoxy(23,16);cprintf("(3) Start search of frequent Nos. since\n");
	 gotoxy(23,17);cprintf("    date ex: 010190 for jan, 01, 1990.\n");
	 gotoxy(23,19);cprintf("(4) Generates list of most occuring combinations.\n");
	 gotoxy(23,21);cprintf("(5) Exit of Lottery Program.\n");

	_setcursortype(_NOCURSOR);
	fflush(stdin);

	//randomize();
	 option=getche();
	 clrscr();
	 switch (option)
	  { case '1':
	      { sorted = frequency_counter(database);
	       /*	for (ii=1; ii<=POSSIBILITY;ii++)
		 { printf("The number N and its occurences o: N[o]= %d[%ld]\n",
			   ii, sorted->candidate[ii]);
		 }*/

		break;
	      }

	    case '2':
	      {
	       //randomize();
	       //Max is 18009460 combinations for 51 numbers!!!!


		//_dos_gettime(timep);
		//srand((unsigned) time(&t));    //gettimein s and set seed
		//srand(18009460);    //Reinitialized each time
		//randomize();
	       //printf("Random number is %d\n\n",abs(random(18009460)% 52));
		gettime(&timep);
		srand((unsigned)timep.ti_hund);
	       printf("Random number is %d\n\n",abs(random(18009460)% 52));
	       printf("Press any key to continue\n");
	       getch();
	       break;
	      }

	    case '3':
	      { break;
	      }
	    case '4':
	      {
	       //Will add code here to handle and calculate most
	       //occuring list of combinations sets.  Very valuable
	       //I need to figure out a algorithm to do this.
	       //Start on 3/17/99.


	       break;
	      }

	    case '5':
	      return(0);

	    default:
	      { printf("\nYou have just entered a non-existened option, as"
		       " a penalty. you will be ejeculated from this program.\n");
		return(0);
	      }
	  } /* end of switch-case */
       } /* while waiting for user's input option */
  } /* end of main program */

/***************************************************************************/
/* Load database structure with input file of historical lottery numbers   */
/* and dates.                                                              */
/***************************************************************************/
List_type *load_structure(char *inputfile[])
 {
   FILE *fptrin;          		          /* pointer to input file */
   List_type *list;
   Node_type *New_node;
   char ch, entry[SIZE_OF_LONG];
   int counter, char_counter, item ;

   counter =  char_counter = item = 0;              /* initialize counters */

   list->head->next = list->tail->next = NULL;          /* terminate lists */

   if ((fptrin=fopen(inputfile, "r")) == NULL)        /* if does not exist */
      Error("Missing or can't open specified input file");           /*exit*/

/* NOTE: loading structure and checking for spaces, \n, EOF */

    while ((ch=getc(fptrin))!=EOF)                        /* while not EOF */
     { if(ch!='\n')
	 entry[char_counter++]=ch;

      while((ch=getc(fptrin)) != '\n')      /* while not end of item /line */
       { if(ch!=' ')
	    entry[char_counter++] = ch;
	 else
	    { entry[char_counter] = '\0';/* terminate array to make string */
	      char_counter = 0;                 /* reset character counter */
	      break;
	     }
	}  /* end of check end of line or space */

      if(ch=='\n')                  /* if end of line then terminate array */
       { entry[char_counter] ='\0';        /* terminate for line feed case */
	 char_counter =0;                       /* reset character counter */
       }
      New_node = Make_Item((Data_type) atol(entry));  /* long int. to asci */

//printf("New node is %ld\n", New_node->data.entry);

      item++;                                    /* counter for each entry */

/* NOTE: no statements between increment value & checking value */

      if(item <= 1)                                      /* first item     */
	{ list->head = New_node;                         /* in linked list */
	  list->tail  = New_node;
	}
       else
	{ list->tail->next = New_node;              /* add to tail of list */
	  list->tail = New_node;
	}
     }  /* end of while not EOF */
    fclose(fptrin);                           /* close database input file */
    return list;                              /* loaded database structure */
 } /* end of routine */

/***************************************************************************/
/*  Make New Node which is a linked list of fields on each Item for each   */
/*  date's entry.                                                          */
/***************************************************************************/
Node_type *Make_Item(long int constant)
 { Node_type *new_node;

   if ((new_node =(Node_type *) malloc(sizeof(Node_type))) == NULL)
       Error("Exhausted available memory.");
   else
       { new_node->data.entry = constant;
	 new_node->next = NULL;
       }
    return new_node;
 }

/***************************************************************************/
/* Write to output file for quickpick  numbers.                            */
/***************************************************************************/
void Write_to_outfile(List_type *list)
 { FILE *fptr;
   char *integer[10];
   int counter = 0;
   List_type *p;
   p = list;

   if((fptr=fopen(OUTPUT_FILE, "w")) == NULL)
     Error("Can't open output file, OUTPUT_FILE");

   while((p->head->data.entry != NULL))
     {
      while (counter <7)
      {
	fputs((ltoa(p->head->data.entry,integer,10)), fptr);/*write to file*/
	fputc(32, fptr);                    /* leave space between entries */

//printf("char to out file is %s \n", ltoa(p->head->data.entry, integer,10));
//printf("long value is %ld\n", p->head->data.entry);

	p->head = p->head->next;
	counter++;
      }
	fputs("\n",fptr);                 /* start new line in output file */
	counter = 0;
      }

   fclose(fptr);
 } /* end of write to file */

/***************************************************************************/
/* Count the frequency of occurrence for each numbers from 1 to 51.  Pass  */
/* to this routine is the linked list of loaded structure from database.   */
/***************************************************************************/
Count_type *frequency_counter(List_type *list)
{ FILE *OutputFileStream;
  char *integer[10];
  int counter = 0;
  int ii;
  Count_type counted_list;                           /* initialize ptr to 0*/
  List_type *p;
  p = list;



// printf("new frecounter content of p->head->data.entry is %ld \n",
//	 p->head->data.entry);


/******* Initialize counter to zero before count sequence *********/

   for (ii=0; ii<=POSSIBILITY;ii++) /*initialize frequency counter to zeros*/
    { counted_list.candidate[ii]= 0L;           /* 0-50 = 51 possibilities */

//printf("content of counted_list is %d, %ld\n",ii,counted_list.candidate[ii]);

     }
   // printf("content of p->head->data.entry is %ld \n",p->head->data.entry);

    while((p->head->data.entry != NULL))              /* entry is not zero */
     { if ( p->head->data.entry <= (POSSIBILITY))   /*valid number,not date*/
	 { counted_list.candidate[p->head->data.entry]
	      = (++(counted_list.candidate[p->head->data.entry]));

//printf("content of counted_list for %ld is counted_list[%ld]\n",
//p->head->data.entry,counted_list.candidate[p->head->data.entry] );

	   p->head = p->head->next;             /* point to next candidate */
	 }      /* end of if-body*/
       else p->head = p->head->next;     /* skip date, record only numbers */

     }    /* end of while-loop */

//printf("You are in while-loop\n");

/* print counted_list of Hz for troubleshooting Note: tested out perfect */
 /* for (ii=1; ii<=POSSIBILITY;ii++)
    { printf("The number N and its occurences o: N[%d]= %d[%d]\n",
	      ii,ii, counted_list.candidate[ii]);
    }
 */
 /****************/
 //output counted list to file




   if((OutputFileStream=fopen(OUTPUT_FILE, "w")) == NULL)
     Error("Can't open output file, OUTPUT_FILE");


   //Write Date to Freqlist.dat file
   _dos_getdate(datep);
   _dos_gettime(timep);
   fprintf(OutputFileStream,"This Frequency List is Generated on: %u/%u/%u\n",
			    datep->month, datep->day, datep->year);
   fprintf(OutputFileStream,"Time this list is generated: %u:%u.%u\n",
			    timep->hour, timep->minute, timep->second);

   //Write out frequency list to file
   for (ii=1; ii<=POSSIBILITY;ii++)
    { fprintf(OutputFileStream,"The number N and its"
				" occurences o: N[%d]= %d[%d]\n",
	      ii,ii, counted_list.candidate[ii]);
    }

   fclose(OutputFileStream);

    return &counted_list;
}

/***************************************************************************/
/* This routine will sort the counted structure of occurrences so that we  */
/* can then select the top 6 highest occurences for our quick pick         */
/* selection.  This function at a later time will return the sorted counted*/
/* structure so that we can select the top ?(whatever desired numbers) of  */
/* occurrences.                                                            */
/***************************************************************************/
