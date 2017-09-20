/*
 * GraphicDrawingPractice.java
 *
 * Created on February 20, 2009, 12:30 AM
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

import java.awt.Graphics;   //drawing library
import javax.swing.JPanel;   //drawing canvas
import javax.swing.JOptionPane; //dialogs


public class GraphicDrawingPractice extends JPanel                  //inherited from JPanel
{
    
    /** Creates a new instance of GraphicDrawingPractice */
    public void paintComponent(Graphics g)                  //passed by the OS when things are invalidated. Override base class paintComponent.
    {
        super.paintComponent(g);
        int width = getWidth();
        int height = getHeight();
        
       /* //draw line from upper left to lower right then
        * //draw line from lower left to upper right
        
        g.drawLine(0,0,width, height);   //start x, start y, endx, endy
     
        g.drawLine(0,height, width, 0);
        **/
        
             
        //now do 4 fans one from each corner
        //1st fan, starting from 0,0:
        int y = height;  //dec/increment end points from
        int x = 0;
        double step = 33.33;  //width/15
        while((x <= width) && (y >= 0))
        {
           g.drawLine(0,0,x,y);  //starting 0,0
           x += step;
           y -= step;
        }
        
        //second fan, starting from width, 0:
        y = height; //dec/increment end points from
        x = width;
        while((x >= 0) && (y >= 0))
        {
           g.drawLine(width,0,x,y);   //starting width,0
           x -= step;
           y -= step;
        }
        
        //third fan, starting from width,height:
        y = 0; //dec/increment end points from
        x = width;
        while((x >= 0) && (y <= height))
        {
           g.drawLine(width,height,x,y);  //starting width, height
           x -= step;
           y += step;
        }
        
        //fourth fan, starting from 0, height:
         y = 0; //dec/increment end points from
        x = 0;
        while((x >= 0) && (y <= height))
        {
           g.drawLine(0,height,x,y);  //starting width, height
           x += step;
           y += step;
        }
        
        //drawing rectangles
        x = width/4; y=height/4;  
        for(int i = 0; i<10; i++)
        {
            g.drawRect(x + (10*i), y + (10*i), x + (10*i), y + (10 *i));
        }
        
          //drawing circles
        x = width/100; y=height/100;
        for(int i = 0; i<10; i++)
        {
            g.drawOval(x + (10*i), y + (10*i), x + (10*i), y + (10 *i));
        }
        
          //drawing 3D Rect
        x = width/100; y=height/100;
        for(int i = 0; i<10; i++)
        {
            g.draw3DRect(x + (20*i), y + (20*i), x + (20*i), y + (20 *i), true);
        }
        
    } //end of paint
} //end of class
