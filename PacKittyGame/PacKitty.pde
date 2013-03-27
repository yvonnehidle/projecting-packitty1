////////////////////////////////////////////////////////
// DRAWS AND MOVES PACKITTY
// Inherits maze class for movement parameters
////////////////////////////////////////////////////////


class PacKitty extends Maze
{
////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// shapes
PShape packitty = loadShape("packitty.svg");

// floats and ints
float kittyW=50;                         
float kittyH=kittyW;                      
float kittyX=int( random(0, width) );    
float kittyY=int( random(0, height) );   
float kittySpeed=8;        
float lipBottom=radians(30); 
float lipTop=radians(330);     

// booleans
boolean lipBottomClosed=true;   // is packitty's bottom lip closed?
boolean lipTopClosed=true;      // is packitty's top lip closed?
boolean kittyState1 = false;     // is packitty looking up?
boolean kittyState2 = false;     // is packitty looking down?
boolean kittyState3 = false;     // is packitty looking left?
boolean kittyState4 = true;      // is packitty looking right?
boolean isCatHighRef;

// arduino
String inString;
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// VARIABLES VALUES (CONSTRUCTOR)
////////////////////////////////////////////////////////
PacKitty()
{
// take the variables from the maze class
// we need them to make packitty move
super();

// define style
noStroke();
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// INTIALIZE STARTING POSITION
////////////////////////////////////////////////////////
void setup()
{
  // booleans
  boolean up_left = false;
  boolean up_right = false;
  boolean down_right = false;
  boolean down_left = false;
 
  // if any of these come back true there is a wall
  up_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY - kittySpeed - kittyW/2)];
  up_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY - kittySpeed - kittyW/2)];
  down_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY - kittySpeed + kittyW/2)];
  down_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY - kittySpeed + kittyW/2)];

  if (up_left==false || up_right==false || down_right==false || down_left==false)
  {
    kittyX = int( random(0, width) );
    kittyY = int( random(0, height) );
  }
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// DRAWING PACKITTY
////////////////////////////////////////////////////////
void spawn(float kittyX, float kittyY)
{
  // open and close packitty's mouth smoothly
  // bottom lip
  if (lipBottom > radians(0) && lipBottomClosed == false)
  {
    lipBottom=lipBottom-radians(1);
  }
  
  if (lipBottom < radians(0))
  {
    lipBottomClosed=true;
  }
  
  if (lipBottomClosed == true)
  {
    lipBottom=lipBottom+radians(1);
  }
  
  if (lipBottom > radians(30))
  {
    lipBottomClosed=false;
  }
  
  // top lip
  if (lipTop < radians(360) && lipTopClosed == false)
  {
    lipTop=lipTop+radians(1);
  }
  
  if (lipTop > radians(360))
  {
    lipTopClosed=true;
  }
  
  if (lipTopClosed == true)
  {
    lipTop=lipTop-radians(1);
  }
  
  if (lipTop < radians(330))
  {
    lipTopClosed=false;
  }

  // IS THE CAT HIGGGHHHHHS
  if (isCatHighRef == true)
  {
    // make the cat grow!
    grow.play();
    float grow = 1.25;
    
    // packitty's body & mouth
    fill(137, 172, 191);
    arc(kittyX, kittyY, kittyW*grow, kittyH*grow, lipBottom, lipTop);
    
    // packitty's accessories!
    shapeMode(CENTER);
    shape(packitty, kittyX-6, kittyY-4, 100*grow, 100*grow);
  }
  else 
  {
    // packitty's body & mouth
    fill(137, 172, 191);
    arc(kittyX, kittyY, kittyW, kittyH, lipBottom, lipTop);
    
    // packitty's accessories!
    shapeMode(CENTER);
    shape(packitty, kittyX-6, kittyY-4, 100, 100);
  }
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// MOVE PACKITTY
////////////////////////////////////////////////////////
void play()
{
  // booleans
  boolean up_left = false;
  boolean up_right = false;
  boolean down_right = false;
  boolean down_left = false;
  // booleans for movement
  boolean goingUp = false;
  boolean goingDn = false;
  boolean goingRg = false;
  boolean goingLf = false; 
  inString = myPort.readStringUntil('\n');
  
  if (inString != null) 
  {
      inString = trim(inString);
      //println(inString);
     
      // move packitty up
      // check for walls
      if(inString.equals("UP") == true)
      {
        kittyState1=true;
        kittyState2=false;
        kittyState3=false;
        kittyState4=false;
      
        // this checks for walls
        if (kittyY >= kittyW/2 + kittySpeed)
        {
        up_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY - kittySpeed - kittyW/2)];
        up_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY - kittySpeed - kittyW/2)];
        down_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY - kittySpeed + kittyW/2)];
        down_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY - kittySpeed + kittyW/2)];
        
        // if there are no walls move
          if (up_left && up_right && down_right && down_left) 
          {
            goingUp = true;
            goingDn = false;
            goingRg = false;
            goingLf = false;
          }
        }
      } 
        
        
      // move packitty down
      // check for walls
      else if(inString.equals("DN") == true)
      {
        kittyState2=true;
        kittyState3=false;
        kittyState4=false;
        kittyState1=false;
        
        // this checks for walls
        if (kittyY <= height - kittyW/2 - kittySpeed)
        {
          up_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY + kittySpeed - kittyW/2)];
          up_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY + kittySpeed - kittyW/2)];
          down_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY + kittySpeed + kittyW/2)];
          down_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY + kittySpeed + kittyW/2)];
          
          // if there are no walls you may move
          if (up_left && up_right && down_right && down_left)
          {
            goingUp = false;
            goingDn = true;
            goingRg = false;
            goingLf = false;
          }
        }
      }
      
      
      // move packitty left
      // check for walls
      else if(inString.equals("LF") == true)
      {
        kittyState3=true;
        kittyState4=false;
        kittyState1=false;
        kittyState2=false;
        
        // this checks for walls
        if (kittyX >= kittyW/2 + kittySpeed)
        {
          up_left = collisionMap[int(kittyX - kittySpeed - kittyW/2)][int(kittyY - kittyW/2)];
          up_right = collisionMap[int(kittyX + kittySpeed - kittyW/2)][int(kittyY - kittyW/2)];
          down_right = collisionMap[int(kittyX - kittySpeed + kittyW/2)][int(kittyY + kittyW/2)];
          down_left = collisionMap[int(kittyX - kittySpeed - kittyW/2)][int(kittyY + kittyW/2)];
          
          // if there are no walls move
          if (up_left && up_right && down_right && down_left) 
          {
            goingUp = false;
            goingDn = false;
            goingRg = false;
            goingLf = true;
          }
        }
      }
        
      
      // move packitty right
      // check for walls
      else if(inString.equals("RG") == true)
      {
        kittyState4=true;
        kittyState1=false;
        kittyState2=false;
        kittyState3=false;
        
        // this checks for walls
        if (kittyX <= width - kittyW/2 - kittySpeed)
        {
          up_left = collisionMap[int(kittyX + kittySpeed - kittyW/2)][int(kittyY - kittyW/2)];
          up_right = collisionMap[int(kittyX + kittySpeed + kittyW/2)][int(kittyY - kittyW/2)];
          down_right = collisionMap[int(kittyX + kittySpeed + kittyW/2)][int(kittyY + kittyW/2)];
          down_left = collisionMap[int(kittyX + kittySpeed - kittyW/2)][int(kittyY + kittyW/2)];
          
          // if there are no walls move
          if (up_left && up_right && down_right && down_left) 
          {
            goingUp = false;
            goingDn = false;
            goingRg = true;
            goingLf = false;
          }
        }
      }
  }
  
  // controlling movement here
  if(goingUp == true)
  {
    kittyY -= kittySpeed;
  }
  else if(goingDn == true)
  {
    kittyY += kittySpeed;
  }
  else if(goingRg == true)
  {
    kittyX += kittySpeed;
  }
  else if(goingLf == true)
  {
    kittyX -= kittySpeed;
  }
  
  //println("goingUp: "+goingUp);
  //println("goingDn: "+goingDn);
  //println("goingRg: "+goingRg);
  //println("goingLf: "+goingLf);
  
  
  // this is where the actual rotation of packitty happens
  // rotate packitty UP
  if (kittyState1==true)
  {
  pushMatrix();
    translate(kittyX, kittyY);
    rotate(radians(-90));
    spawn(0, 0);
  popMatrix();
  }
  
  // rotate packitty DOWN
  else if (kittyState2==true)
  {
  pushMatrix();
    translate(kittyX, kittyY);
    rotate(radians(90));
    spawn(0, 0);
  popMatrix();
  }
  
  // rotate packitty LEFT
  else if (kittyState3==true)
  {
  pushMatrix();
    scale(-1, 1);
    spawn(-kittyX, kittyY);
  popMatrix();
  }
  
  // rotate packitty RIGHT
  else if(kittyState4==true)
  {
  pushMatrix();
    spawn(kittyX, kittyY);
  popMatrix();
  }
  // check for problems
  //println("X: "+kittyX+" Y: "+kittyY);

}
////////////////////////////////////////////////////////

}

