/*
 * MortgagePaymentCalculatorTest.java
 *
 * Created on February 25, 2009, 8:18 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 *
 * @author Joseph K. Nguyen, MBA
 * CIS-043 Java Programming
 * Dr. Kam Verma
 * 03/04/2009
 */

import javax.swing.JOptionPane;         //java lib for GUI

public class MortgagePaymentCalculatorTest 
{
              
    /** Creates a new instance of MortgagePaymentCalculatorTest */
    public static void main(String args[]) 
    {
       
            
        //Display welcome message and ask if wanted to enter new client info
       String response =  JOptionPane.showInputDialog("Welcome to the Nguyen's Mortgage "
               + "Calculator!!!\n Would you like to enter a new Loan Client record?, \"Y/N\" ");
       
        //check response
        while(response.equals("Y") || response.equals("y"))
        {
           //Create a new instance object of MortgagePaymentCalculator
            MortgagePaymentCalculator clientLoan = new MortgagePaymentCalculator();
           
            clientLoan.getClientInfo();
      
            clientLoan.calculateMortgagePayment();
               
           response = clientLoan.displayWelcomeQuestion();  //Check to see if want to continue
        }
        System.exit(0);   //terminate when no more salesperson
    }     
 
} //class MortgagePaymentCalculatorTest 
