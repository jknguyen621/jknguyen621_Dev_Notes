/*
 * MortgagePaymentCalculator.java
 *
 * Created on February 25, 2009, 8:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Joseph K. Nguyen, MBA
 * CIS-043 Java Programming
 * Dr. Kam Verma
 * 03/04/2009
 *
 * This program will use GUI to request client's name, interest rate agreed too, 
 * and loan amount and number of years for loan.
 * It will then calculate yearly, and monthly mortgage payment, the monthly 
 * interest and monthly principal as well as monthly principal balance.
 * The program will stop when the user input a non-true value, something other 
 * than 1.
 *
 * Formula for Interest Payment on Mortgage:
 *  M = P [ i(1 + i)^n ] / [ (1 +  i)^n - 1]
 *  Where M is the monthly payment. i = r/12. The same formula can be expressed 
 * many different way, but this one avoids using negative exponentials which 
 * confuse some calculators.
    For our $100,000 mortgage at 5% compounded monthly for 15 years, we would 
 * first solve for i as
    i = 0.05 / 12 = 0.004167 and n as 12 x 15 = 180 monthly payments
    Next we would solve for (1 + i)^n = (1.004167)^180 using the xy key on the 
 * calculator, which yields 2.11383
    Now our formula reads M = P [ i(2.11383)] / [ 2.11383- 1] which simplifies 
 * to M = P [.004167 x 2.11383] / 1.11383 or M = $100,000 x 0.00791 = $791.81
    All of the rounding down I did makes a 2 cent difference on the monthly 
 * payment, compared with keeping all the digits the calculator can handle. Now,
 * one important feature of the mortgage formula is that it's the principal is 
 * multiplied last, meaning that we can develop a table of mortgage rate 
 * multipliers for any fixed time period that will yield a monthly payment 
 * simply by multiplying the principal borrowed.
    If you're curious to know how much interest you'd pay the bank over the 
 * course of the mortgage,just multiply the amount of the monthly payment 
 * by the number of payments and subtract the principal:
    ($791.81 x 180 ) - $100,000 = $142,525.80 - $100,000 = $42,525.80 
     *
 */

import javax.swing.JOptionPane;         //java lib for GUI

public class MortgagePaymentCalculator 
{
    //Instance Variables
    private String nameOfClient;   //name of Client this record is for
    private double loanAmount;  //Amount of loan
    private float rate;        //interest rate      
    private int years;          //number of years, i.e. 30 yrs = 360 mons.      
    
   //SET  METHODS:    
   public void setName(String name)
   {
       if(name.length() != 0)
       {
            nameOfClient = name;
       }
       else
       {
            //Display errror dialog
            String message = String.format("You have entered an invalid name, " 
                    + "must be greater than \"\" !!!");
            JOptionPane.showMessageDialog(null, message);
            System.exit(1);
       }
   }
   
   public void setAmount(double amount)
   {
        loanAmount = amount;
   }
   
   public void setRate(float interest)
   {
        rate = interest/100;  //Set to actual representation of %
   }
   
   public void setYears(int yrs)
   {
       years = yrs;
   }
   
   //GET METHODS:
   public String getName()
   {
       return nameOfClient;
   }
   
   public double getAmount()
   {
       return loanAmount;
   }
   
   public float getRate()
   {
       return rate;
   }
    
   public int getYears()
   {
       return years;
   }
    
   public String displayWelcomeQuestion()
   {
       String yesNo =  JOptionPane.showInputDialog("Welcome to the Nguyen's "
                + "Mortgage Calculator!!!\n Would you like to enter a new Loan "
                + "Client record?, \"Y/N\" ");
       return yesNo;
   }
     
     
   //Get Inputs Methods:
   public String  inputClientName()
   {
       String client =  JOptionPane.showInputDialog("Please enter the full "
                + "name of the Client for the loan calculation: ");
       return client;
   }
    
   public double inputLoanAmount()
   {
       String message = String.format("Please enter request loan amount for %s:", nameOfClient );    
       double requestedAmount = Double.parseDouble(JOptionPane.showInputDialog(message));
       return requestedAmount;
   }
        
   public int inputYears()
   {
       String message = String.format("Please enter request number of years loan is for:" );    
       int requestedYears = Integer.parseInt(JOptionPane.showInputDialog(message));
       return requestedYears;
   }
    
   public float inputRate()
   {
       String message = String.format("Please enter Interest Rate you want to calculate for:" );    
       float requestedRate = Float.parseFloat(JOptionPane.showInputDialog(message));
       return requestedRate;
   }
        
   public void getClientInfo()
   {
        //Get Client Name
        String client =  inputClientName();
        String message = String.format("New Client Name Is: %s", client);
        JOptionPane.showMessageDialog(null, message);
        setName(client);        
             
       //Get Request Loan Amount
        double requestedAmount = inputLoanAmount();
        String message2 = String.format("Requested Loan Amount Is: %7.2f", requestedAmount);
        JOptionPane.showMessageDialog(null, message2);
        setAmount(requestedAmount);       
        
         //Get Number of Years Loan is for
        int requestedYears = inputYears();
        String message3 = String.format("Requested Number of Years Is: %d", requestedYears);
        JOptionPane.showMessageDialog(null, message3);
        setYears(requestedYears);  
        
         //Get Rate want to use for calculation
        float requestedRate = inputRate();
        String message4 = String.format("Interest Rate Entered Is: %2.3f", requestedRate);
        JOptionPane.showMessageDialog(null, message4);
        setRate(requestedRate); 
        
   }
     
   public void calculateMortgagePayment()
   {
        /* Formula Used:   
           M = P [ i(1 + i)^n ] / [ (1 +  i)^n - 1]
        */
        
       float monthlyInterestRate = getRate()/12;          //rate per month  (i)
       int numberOfMonths = getYears() * 12;              //months per year (n)
       double loanAmount = getAmount();                  //Full loan Amoutn (P)
       //This is (1+ i)^n
       float baseInterest = (float) Math.pow((1 + monthlyInterestRate), numberOfMonths);     
       float monthlyPayment;            //Is What we are trying to calculate (M)
       float monthlyPrincipal;                      //principal for this month.
       float monthlyInterestPayment;                  //interest in this month
       float i, n;
       
       //for ease of viewing the formula.
       i = monthlyInterestRate;
       n = (float) numberOfMonths;
       
       //Let's calcuate:
       //M = P [ i(1 + i)^n ] / [ (1 +  i)^n - 1]
       
       monthlyPayment = (float) loanAmount * ((i * baseInterest) / (baseInterest -1));
       
       //printing output
       String message0 = String.format("Client Name Is: %s\n", getName());
       String message = String.format("Original Loan Amount Is: %7.2f\n", getAmount());
       String message1 = String.format("Original Loan Interest Rate Is: %2.3f\n", 100* getRate());
       String message2 = String.format("Original Number of Years Is: %2d\n", getYears());
       
       String message3 = String.format("Monthly Payment Is: %5.2f\n", monthlyPayment);
       
        //Calculate Total Paid Over the years:
       float cummulativePayment = (monthlyPayment * n);
        String message4 = String.format("Total Paid Over the %d years "
               + "is %7.2f\n", getYears(), cummulativePayment);
        
       //Calculate Interest Paid over the years:
       float cummulativeInterest =  (monthlyPayment * n) - (float) loanAmount;
      
       String message5 = String.format("Total Interest Paid Over the %d years "
               + "is %7.2f\n", getYears(), cummulativeInterest);
       JOptionPane.showMessageDialog(null, message0 + message + message1 + 
                                           message2 + message3 + message4 +
                                           message5);
   }
}
