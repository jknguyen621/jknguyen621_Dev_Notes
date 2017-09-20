//GUI
import javax.swing.JOptionPane;         //java lib for GUI
import java.awt.Color;
import java.awt.Graphics;
import javax.swing.JPanel;
import javax.swing.JOptionPane;         //java lib for GUI
import java.util.Random;                //For Random number generation
import java.math.*;
import javax.swing.JFrame;              //For smiley and sad faces
import java.awt.List;               //For Summary Report 
import java.awt.Graphics;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

import java.util.Scanner;            //Scanner Class to read input


//Class Definition
public class JavaAssignment2Driver 
{
    
    /** Creates a new instance of JavaAssignment2Driver */
    private int myName;
	
    public static void main(String args[]) 
    {
    }
    public void setItem(int one, int two)
    {
    }
}

//String comparisions
 while(yesNo.equals("Y") || yesNo.equals("y"))
   
 //Scanner Input
Scanner input = new Scanner (System.in); //read from main I/O in (keyboard)
System.out.print("Please input Your Name : ");
userName = input.nextLine();  //read in line of text for name.
 
 
 //Input Dialog
String salesPersonName =  JOptionPane.showInputDialog("Please input the name? ");
String answer = JOptionPane.showInputDialog(null,myString,"SUBTRACTION", JOptionPane.PLAIN_MESSAGE);
//parsing input
double mydouble = Double.parseDouble(answer);
int myInt = Integer.parseInt(answer);
 
 
 
 //Message Dialog
   JOptionPane.showMessageDialog(null, message4);
 or 
 JOptionPane pane = new JOptionPane("FAILED!!!", JOptionPane.INFORMATION_MESSAGE);
        JDialog dialog = pane.createDialog(null, "Sorry Charley!");
 
 //List Reporting
{
  List reportListBox = new List(4,false);  //List for Problems report
JFrame reportFrame = new JFrame();       //Frame/application to hold the list
  reportFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        int width = reportFrame.getWidth();
        int height = reportFrame.getHeight();
        int startx = width/4;
        int starty = height/4;
        reportFrame.setLocation(startx, starty);
        reportFrame.setTitle("Well, How did you do?...");
        reportFrame.setSize(500,500);
        reportListBox.add("================================================\n");
        reportListBox.add("Problem\t Your Answer\t /-right, X-wrong\n");
        reportListBox.add("================================================\n");
        //skipping 5 at a time, since we index it inside the loop already 
  frmtString = String.format("%5.0f   %s %5.0f   =%5.0f    %s\n", 
                    q1, symbol, q2, userAnswer, solution);
    reportListBox.add(frmtString);
    
  }
 //Arrays:
 int items [];       items =  new int [4];  //declare and instantiate array t
 items [0] = one; 
 
 //String Formatting
 String message2 = String.format("Please enter quantity sold for item # %d :", i );    
 
 //Exiting
 System.exit(0);
 
 //Graphic
 public class DrawSad extends JPanel 
{
    
    /** Creates a new instance of DrawSmiley */
    public DrawSad() {
    }
    public void paintComponent(Graphics g)
    {
        super.paintComponent(g);
        //draw the face
        int width = getWidth();
        int height = getHeight();
        int startx = width/4;
        int starty = height/4;
        
        
        g.setColor(Color.YELLOW);
        g.fillOval(startx,starty,200,200);
        
        //draw the eyes
        g.setColor(Color.BLACK);
        g.fillOval(startx + 45,starty + 55,30,30);
        g.fillOval(startx + 125,starty + 55,30,30);
        
        //draw the mouth
        g.fillOval(startx + 40,starty + 120,120,60);
       
        //Touch up for smiley
        g.setColor(Color.YELLOW);
        g.fillRect(startx + 40,starty + 150,120,30);
        g.fillOval(startx + 40,starty + 130,120,40);
    }  
}

//Rouding Half-Up
public double myRound(double x, int decimalPlace)
    {
        BigDecimal bd = new BigDecimal(x);
        bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP);
        x = bd.doubleValue();
        return x;
    }
    
    
//Sleeper function
 public void mySleep(int x)
    {        
        try
        {
            Thread.sleep(x);    //display for 5 seconds before exiting
        }
        catch (InterruptedException exception)
        {
            System.out.printf("%s \n", "terminated prematurely");
        }
    }    
    
    //My Random Generator:
     public int randomGenerator(int type)
    {
        Random randomNumbers =  new Random();
        int randomInt = 0;
        switch (type)
        {
            case 1:  //addition, subtraction, 
                randomInt = 1 + randomNumbers.nextInt(99);  //1-99
                break;
            case 2:
                randomInt = 1 + randomNumbers.nextInt(12); //1-12
                break;
            case 3:
                randomInt = 1 + randomNumbers.nextInt(999); //1-999
                break;
            default:
                 randomInt = 1 + randomNumbers.nextInt(99);  //1-99
                break;
        }
        return randomInt;
    }