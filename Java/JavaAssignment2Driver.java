/*
 * JavaAssignment2Driver.java
 *
 * Created on February 19, 2009, 9:11 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 *
 * @author Joseph K. Nguyen, MBA
 * 02-19-2009
 * Java Programming Course CIS-43
 * Assigment #2
 *
 *
 *Statement of Problem:
 * A large company pays its salespeople on a commission basis.  The salepeople receive $200 per week plus 9% of their gross sales
 * for that week.  For example, a salesperson who sells $5000 worth of merchandise in a week receives $200 plus 9% of $5000, or a total
 * of $650.  You have been supplied with a list of the items sold by each salesperson.  The values of these items are as follows:
 *
 *      Item        Value
 *      1           239.99
 *      2           129.75
 *      3            99.95
 *      4           350.89
 *
 *
 *  Develop a Java application that inputs one salesperson's itmes sold for last week and calculates and displays that salesperon's earnings.
 *  There is not limit to the number of items that can be sold by a salesperson
 */

import javax.swing.JOptionPane;         //java lib for GUI

public class JavaAssignment2Driver 
{
    
    /** Creates a new instance of JavaAssignment2Driver */
    public static void main(String args[]) 
    {
        String yesNo =  JOptionPane.showInputDialog("Would you like to enter a new salesPerson record?, \"Y/N\" ");
        
        while(yesNo.equals("Y") || yesNo.equals("y"))
        {
            String salesPersonName =  JOptionPane.showInputDialog("Please input the name of the sales person to create a new sales record for: ");
            
            if(salesPersonName.length() >= 1)   //Check for valid name
            {   
                //New instance of JavaAssignment2 to create new sales person record.
                JavaAssignment2 salesGuy = new JavaAssignment2(salesPersonName);         
            
                String message = String.format("SalesPerson is: %s", salesPersonName);
                
                int i = 0;
                int items [];       items =  new int [4];  //declare and instantiate array to hold 4 items, meaning 0-3 
             
                //store to array
                for (i=1; i<=4; i++)
                {
                    String message2 = String.format("Please enter quantity sold for item # %d :", i );    
                    items[ i-1] = Integer.parseInt(JOptionPane.showInputDialog(message2));
                }
               
           //Testing array storage code
           /*    for (i=1; i<=4; i++)
                {
                    String message3 = String.format("Value of %d is: %d ", i, items [i-1]);
                    JOptionPane.showMessageDialog(null, message3);
                }
            */  
                //now setting items sold 
                salesGuy.setItems(items[0], items[1], items[2], items[3]);
                
                //calculate weekly commission for this guy.
                double weeklyCommission = salesGuy.calculateWeeklyCommission();
                
                //Display Result for this guy
                String salesMan = salesGuy.getSalesMan();
                String message4 = String.format("Salesman Name is: %s \nWeekly Commision is: %.2f", salesMan, weeklyCommission);
                JOptionPane.showMessageDialog(null, message4);
                
            }
            
            //Determine to continue or exit:
            yesNo =  JOptionPane.showInputDialog("Would you like to enter a new salesPerson record?, \"Y/N\" ");
        }   
        System.exit(0);   //terminate when no more salesperson
    }
 }
