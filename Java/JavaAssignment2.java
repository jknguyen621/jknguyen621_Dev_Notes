/*
 * JavaAssignment2.java
 *
 * Created on February 19, 2009, 9:03 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
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
 *
 */
public class JavaAssignment2 
{
    private String salesPerson;             //instance variables.
    private int items[];            //items = new int [4];               //create 4 items array, going from 0-3
    
    private double prices[];        //prices = new double [4];             //To hold price per item  per type
    
    /** Creates a new instance of JavaAssignment2 */
    public JavaAssignment2(String salesName) //Constructor
    {
         if(salesName.length() != 0)
         {
             salesPerson = salesName;
             items = new int [4];               //create 4 items array, going from 0-3
             prices = new double [4];             //To hold price per item  per type
             //items [] = {0, 0, 0, 0};                           //only works in driver class
             items[0]=0;  items[1]=0;     items[2]=0;     items[3]=0;
             //prices[] = {239.99, 129.75, 99.95, 350.89};       //base price per item  type
             prices[0]=239.99;  prices[1]=129.75;   prices[2]=99.95;    prices[3]=350.89;
         }
    }
    
    public void setItems(int one, int two, int three, int four)
    {
        items [0] = one; 
        items [1] = two;
        items [2] = three;
        items [3] = four;
    }
    
    public int getItem(int itemNumber)
    {
        if(itemNumber > 0 && itemNumber < 5)
        {
            int item = items[itemNumber -1];
            return item;    //-1 for 0-indexing
        }
        
        //System.exit(-1);
        return -1;
    }
    
    public String getSalesMan()
    {
        return salesPerson;
    }
    
    public double calculateWeeklyCommission()
    {
        double baseCommission = 200;        //base commission is $200
        double commissionPercentage = 0.09;  //9%
        double valueSold, weeklyPay;
        
        valueSold = (items [0] * prices [0]) + (items [1] * prices[1]) + (items[2] * prices[2]) + (items[3] * prices[3]);
        weeklyPay = (valueSold * commissionPercentage) + baseCommission;
        return weeklyPay;
    }
}
