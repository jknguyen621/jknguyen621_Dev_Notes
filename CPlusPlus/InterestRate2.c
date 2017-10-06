///InterestRate.c
#include <stdio.h>
#include <math.h>

/* Joseph K. Nguyen */

////////////////////////////////////////////////////////////////////////////
//Fumction Prototype
float calculate_monthly_payment(float p, int l, float i); 
void print_payment_schedule(float p, int l, float i, float mp); 

////////////////////////////////////////////////////////////////////////////
int main(void)
{
	int  length;
	float interest, principal, monthly_payment;
	
//	while((principal || interest || length) != EOF)
	//{
	
	printf ("Interest Rate Calculator Version 1.2\n");
	printf ("Written By:  Joseph A. Nguyen\n");
	printf("Please enter the amount : ");
	scanf("%f",&principal);

	printf("\nPlease enter interest rate in percentage %, example 12.5 for 12.5 %% : ");
	scanf("%f",&interest);


	printf("\nPlease enter the length in years : ");
	scanf("%d",&length);
	

	printf("Principal\t");
	printf("Interest\t");
	printf("Length\t\t");
	printf("Monthly payment \n");
	printf("%6.2f\t%2.3f%%\t\t%d\t", principal, interest, length);

	//Converts before calculation
	interest /= 12 * 100;			//Converts interest from years to months.
	length *= 12;					//Converts length in years to length in months!!!

	//Go and calculate Monthly payment based on loan amount, interest, and length.
	monthly_payment = calculate_monthly_payment(principal, length, interest);
	printf("\t%4.2f\n", monthly_payment);

	print_payment_schedule(principal, length, interest, monthly_payment);

	//} //end of while loop!
	return 0;
}

////////////////////////////////////////////////////////////////////////////
float calculate_monthly_payment(float p, int l, float i)
{
	double numerator, denominator;
	//Formulate to calculate monthly payment
	// M=[(P*I*(1+I)^L) / ((1+I)^L -1)]
	//pow(double base, double exponent)
	

	//(float)(p*i*pow(((double)((1+i))), ((double) l))/(pow(((double)1+i),((double) l))-1);
	numerator = p * i * pow((double)((1+i)), (double) l);
	denominator = pow((double)(1+i), (double) l) -1;
	return(numerator/denominator); 
}

////////////////////////////////////////////////////////////////////////////
void print_payment_schedule(float pt, int l, float i, float mp)
{   
	static float payment_number, principal_balance, yearly_p, yearly_i,
				 total_principal_paid, interest_paid, interest_pay_monthly,
				 Total_Interest, Total_Principal;

	int k, j;
	static int pmNo= 0;				//Payment #s

	i /= 100;   //convert interest back to decimal not percentage.
	payment_number, interest_paid, yearly_p, yearly_i, Total_Interest, Total_Principal= 0;
	principal_balance = pt;

	for(k = 1; k < (l/12 +1); k++)				//years
	{
		for(j=1; j<13; j++)				//months in year
		{  pmNo++;
		   payment_number++;  
		   interest_pay_monthly = principal_balance * i *100;    //interest paid for the month
		   principal_balance -= (mp - interest_pay_monthly);		//new balance after interest.
		   interest_paid += interest_pay_monthly;			//total interest paid.
		   total_principal_paid = pt - principal_balance;    //Total paid principal
		   printf("Pymt.#%3d: Amnt.=%6.2f  Princ.=%5.2f  Intrst.=%5.2f  Bal.=%7.2f\n",
			     pmNo, mp, mp-interest_pay_monthly, interest_pay_monthly, principal_balance);
		}// for each year

	

		Total_Interest += interest_paid;				//Sum up yearly interest
		Total_Principal += total_principal_paid;  			//Sum up yearly principal paid.
		
		printf("YEAR %d TOTALS\tYearly Interest Paid\tYearly Principal Paid\n", k);
		printf("\t\t%6.2f\t\t\t%6.2f\n", interest_paid, total_principal_paid);

		printf("YEAR %d TOTALS\tCumm. Interest Paid\tCumm. Principal Paid\n", k);
		printf("\t\t%6.2f\t\t\t%6.2f\n", Total_Interest, Total_Principal);

		printf("\n Press any key to Continue \n");
		getche();
          

		interest_paid = total_principal_paid = 0;  			//reset accumulators
		pt = principal_balance;						//Set Principal Total to new principal balance.

		
	}

	printf("Grand Total Interest Paid \t Grand Total Principal Paid\n");
	printf("\t\t%6.2f\t\t\t%6.2f\n", Total_Interest, 	Total_Principal);
}
