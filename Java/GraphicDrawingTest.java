/*
 * GraphicDrawingTest.java
 *
 * Created on February 20, 2009, 12:38 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Joseph K. Nguyen, MBA
 * 02-19-2009
 * Graphic drawing practices
 */

import javax.swing.JFrame;

public class GraphicDrawingTest {
    
    /** Creates a new instance of GraphicDrawingTest */
    public static void main(String args[])
    {
        //create a panel/canvas that contains our drawing
        GraphicDrawingPractice panel = new GraphicDrawingPractice();   //calling constructor of our graphic drawingTest
        
        //create a new frame to hold our panel/canvas
        JFrame application = new JFrame();
        
        //set the frame to exit when it is closed
        application.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        application.add(panel);  //add panel to frame
        application.setSize(500,500); //set size of visible frame
        application.setVisible(true);
        
    }
    
}
