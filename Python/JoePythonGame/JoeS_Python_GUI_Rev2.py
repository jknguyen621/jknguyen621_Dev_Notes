#""Joe's GUI program in Python""
# Developed  on December 4, 2007

#import from livewires graphic package
from livewires import games, color
import random                                            # New for Rev2.0

#################################################
# Revision History:
# Rev 1.0, Basic picture, pizzas flying, and pan, and bouncing, but no catching of pizzas yet
# Rev 2.0, Implemented Catching and destroying of pizza object, and creating new ones.
#             Also keep track of score.
#################################################

Sound = games.load_sound("missile.wav")     #New for Rev 2.0
games.init(screen_width = 640, screen_height = 480, fps =50)  #New for Rev 2.0

#################################################
#Making the pizzas bounce, making a derived class, and overriding the update method
class Pizza(games.Sprite):    #Base class of Sprite
  """A Bouncing Pizza."""
  
  def update(self):
    """Reverse a velocity component if edge of screen reached."""
    if self.right > games.screen.width or self.left < 0:
      self.dx = -self.dx
      
    if self.bottom > games.screen.height or self.top < 0:
      self.dy = -self.dy
      
  def handle_collide(self):                             # New for Rev2.0
    """Move to a random screen location"""
    self.x = random.randrange(games.screen.width)
    self.y = random.randrange(games.screen.height)
    Sound.play()  
      
#################################################      
#Now adding on the Pan class, so that I can use mouse-input to update Pan position
class Pan(games.Sprite):        #base class is games.Sprite object
  """A Pan controlled by the mouse"""
  image = games.load_image("pan.bmp")
  #games.screen.add(image)
  
  def __init__(self, x = 320, y = 450):
      """Init Pan Object and create Text object for score"""    #New for 2.0
      super(Pan, self).__init__(image = Pan.image, x = games.mouse.x, y = games.mouse.y)
      self.score = games.Text(value = 0, size = 50, color = color.red, x = 575, y=20)
      games.screen.add(self.score)
      
  def update(self):
      """Move the Mouse coordiantes"""
      self.x = games.mouse.x
      self.y = games.mouse.y
      self.check_collide()                                        # New for Rev2.0
      
      if self.left <0:
          self.left = 0
          
      if self.right > games.screen.width:
          self.right = games.screen.width
      
      self.check_collide()
      
  def check_collide(self):                                    #New of Rev2.0
      """Check for Collision of Pan and Pizza"""
      for pizza in self.overlapping_sprites:
        self.score.value +=50                     #Incr. score by 50
        pizza.handle_collide()
      
#################################################
################################################# 
# MAIN:
def main():
    # create window
    #games.init(screen_width = 640, screen_height = 480, fps =50)   #Moved to global as a workaround.

    #Load background
    #still has problem if we give absolute path, i.e."C:\lkjlfs\dfdsfs"
    wall_image = games.load_image("CIMG2622.JPG", transparent = False)
    games.screen.background = wall_image

    # Add on 3 pizzas for 3 girls
    p_image = games.load_image("pizza.bmp")
   
        #Now calling derived class Pizza to make them bounce via over-ride update method.
    pizza_x = random.randrange(games.screen.width)      #New for 2.0
    pizza_y = random.randrange(games.screen.height)
    pizza1 = Pizza(image =  p_image, x = pizza_x, y=pizza_y, dx =1, dy =-1)  #New for 2.0
    pizza2 = Pizza(image =  p_image, x = pizza_x, y=pizza_y, dx = -1, dy =-1)
    pizza3 = Pizza(image =  p_image, x = pizza_x, y=pizza_y, dx =-1, dy =1)
    pizza4 = Pizza(image =  p_image, x = pizza_x, y=pizza_y, dx =1, dy =1)
     
    games.screen.add(pizza1)
    games.screen.add(pizza2)
    games.screen.add(pizza3)
    games.screen.add(pizza4)

    #Load music file playing as background
    games.music.load("theme.mid")
    loop = 9999
    games.music.play(loop)
     
    #Create Pan sprite and add to screen.
    pan_image = games.load_image("pan.bmp")
    pan = Pan()                                                  #Mod for Rev 2.0
    
    games.screen.add(pan)
    
     #Display "Dinner Time" as Message demo
    eatMessage = games.Message(value = "Touch Score Board to Quit!",
                                              size = 40,
                                              color = color.red,
                                              x = games.screen.width/2,
                                              y = games.screen.height/2,
                                              lifetime = 50,
                                              #after_death = games.screen.mainloop
                                              )

    #games.screen.add(eatMessage)
    
    
    #Setting mouse pinter not visible
    games.mouse.is_visible = False
    
    #Grab all graphic events
    games.screen.event_grab = True
      
    #Display window on screen
    games.screen.mainloop()
#################################################
#################################################

#Launch Main()
main()

pause 