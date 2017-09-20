#""Joe's GUI program in Python""

#import from livewires graphic package
from livewires import games, color


#Making the pizzas bounce, making a derived class, and overriding the update method
class Pizza(games.Sprite):  #Base class of Sprite
  """A Bouncing Pizza."""
  
  def update(self):
    """Reverse a velocity component if edge of screen reached."""
    if self.right > games.screen.width or self.left < 0:
      self.dx = -self.dx
      
    if self.bottom > games.screen.height or self.top < 0:
      self.dy = -self.dy


#Now adding on the Pan class, so that I can use mouse-input to update Pan position
class Pan(games.Sprite):
  """A Pan controlled by the mouse"""
  
  def update(self):
      """Move the Mouse coordiantes"""
      self.x = games.mouse.x
      self.y = games.mouse.y
      
      
# MAIN:
def main():
    # create window
    games.init(screen_width = 640, screen_height = 480, fps =50)

    #Load background
    #still has problem if we give absolute path, i.e."C:\lkjlfs\dfdsfs"
    wall_image = games.load_image("CIMG2622.JPG", transparent = False)
    games.screen.background = wall_image

    # Add on additional sprite, animation object
    #~ cxtree_image = games.load_image("cxmastree.bmp")
    #~ xtree = games.Sprite(image =  cxtree_image, x = 320, y=240)
    #~ games.screen.add(xtree)

    # Add on 3 pizzas for 3 girls
    p_image = games.load_image("pizza.bmp")
    #~ pizza1 = games.Sprite(image =  p_image, x = 470, y=280, dx =1, dy =-1)
    #~ pizza2 = games.Sprite(image =  p_image, x = 240, y=280, dx = -1, dy =-1)
    #~ pizza3 = games.Sprite(image =  p_image, x = 320, y=280, dx =-1, dy =1)
    
    #Now calling derived class Pizza to make them bounce via over-ride update method.
    pizza1 = Pizza(image =  p_image, x = 470, y=280, dx =1, dy =-1)
    pizza2 = Pizza(image =  p_image, x = 240, y=280, dx = -1, dy =-1)
    pizza3 = Pizza(image =  p_image, x = 320, y=280, dx =-1, dy =1)
    games.screen.add(pizza1)
    games.screen.add(pizza2)
    games.screen.add(pizza3)

    # Display the girls' names as Text and Color demo
    amita = games.Text(value = "Amita",
                                size = 20,
                                color = color.blue,
                                x= 240,
                                y= 310)
                                
                                
    anika = games.Text(value = "Anika",
                                size = 20,
                                color = color.pink,
                                x= 470,
                                y= 310)
                                

    alina = games.Text(value = "Alina",
                                size = 20,
                                color = color.yellow,
                                x= 320,
                                y= 310)
                                
                                
    games.screen.add(amita)
    games.screen.add(anika)
    games.screen.add(alina)

    #Display "Dinner Time" as Message demo
    eatMessage = games.Message(value = "Dinner Time!!!",
                                              size = 40,
                                              color = color.red,
                                              x = games.screen.width/2,
                                              y = games.screen.height/2,
                                              lifetime = 250,
                                              after_death = games.screen.mainloop)

    games.screen.add(eatMessage)

    #Create Pan sprite and add to screen.
    pan_image = games.load_image("pan.bmp")
    pan = Pan(image = pan_image, 
                    x = games.mouse.x,
                    y = games.mouse.y)
                
    games.screen.add(pan)
    
    #Setting mouse pinter not visible
    games.mouse.is_visible = False
    
    #Grab all graphic events
    games.screen.event_grab = True
    
    #Load music file playing as background
    games.music.load("theme.mid")
    games.music.play()
    
    #Load a sound file for use in case of collision, etc...
    missile_sound = games.load_sound("missile.wav")
    loop = 9999
    #missile_sound.play(loop) #continuous
    
    
    #Display window on screen
    games.screen.mainloop()


#Launch Main()
main()
pause 