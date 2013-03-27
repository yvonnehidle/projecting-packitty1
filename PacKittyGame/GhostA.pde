////////////////////////////////////////////////////////
// MOVEMENT INFORMATION FOR GHOST A
// Ghost is randomly generated DoggyGhost class
////////////////////////////////////////////////////////
class GhostA extends Maze
{

  
////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// ints and floats
float ghostAX;
float ghostAY;
float ghostASpeed = 1;
float kittyRefX, kittyRefY;

// booleans
boolean movingX = false;
boolean movingY = true;

// classes
DoggyGhost myDoggy;
PacKitty myKitty;
////////////////////////////////////////////////////////

  
////////////////////////////////////////////////////////
// VARIABLES VALUES (CONSTRUCTOR)
////////////////////////////////////////////////////////
GhostA()
{
  
// take the variables from the maze class
// we need them to make packitty move
super();

// classes
myDoggy = new DoggyGhost();
myKitty = new PacKitty();

// floats
ghostAX = int( random(width) );
ghostAY = int( random(height) );

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
  up_left = collisionMap[int(ghostAX - ghostASpeed - myDoggy.doggyW/2)][int(ghostAY - myDoggy.doggyH/2)];
  up_right = collisionMap[int(ghostAX - ghostASpeed + myDoggy.doggyW/2)][int(ghostAY - myDoggy.doggyH/2)];
  down_right = collisionMap[int(ghostAX - ghostASpeed + myDoggy.doggyW/2)][int(ghostAY + myDoggy.doggyH/2)];
  down_left = collisionMap[int(ghostAX - ghostASpeed - myDoggy.doggyW/2)][int(ghostAY + myDoggy.doggyH/2)];

  if (up_left==false || up_right==false || down_right==false || down_left==false)
  {
    ghostAX = int( random(0, width) );
    ghostAY = int( random(0, height) );
  }
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// DRAWING AND MOVING GHOST
////////////////////////////////////////////////////////
void play()
{
// draw ghost using doggyghost class
myDoggy.spawn(ghostAX,ghostAY,color(255,0,0),color(108,37,37));


if (ghostAY != kittyRefY && movingY == true)
{
// move ghost up
if (ghostAY > kittyRefY)
{
moveUp();
}
// move ghost down
if (ghostAY < kittyRefY)
{
moveDown();
}
}


else if (ghostAX != kittyRefX && movingX == true)
{
// move ghost right
if (ghostAX < kittyRefX)
{
moveRight();
}
// move ghost left
if (ghostAX > kittyRefX)
{
moveLeft();
}
}


// if ghostX is equal to kittyX switch directions
else if (ghostAX == kittyRefX)
{
  movingX = false;
  movingY = true;
}

// if ghostY is equal to kittyY switch directions
else if (ghostAY == kittyRefY)
{
  movingX = true;
  movingY = false;
}


//println("ghostAY: "+ghostAY+" || kittyY: "+kittyRefY);
//println("ghostAX: "+ghostAX+" || kittyX: "+kittyRefX);
//println("movingY: "+movingY+" || movingX: "+movingX);
//println(ghostXold);
//println(ghostYold);
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// MOVE GHOST LEFT
////////////////////////////////////////////////////////
void moveLeft()
{
  
// booleans
boolean up_left = false;
boolean up_right = false;
boolean down_right = false;
boolean down_left = false;
 
// if any of these come back true there is a wall
up_left = collisionMap[int(ghostAX - ghostASpeed - myDoggy.doggyW/2)][int(ghostAY - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostAX - ghostASpeed + myDoggy.doggyW/2)][int(ghostAY - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostAX - ghostASpeed + myDoggy.doggyW/2)][int(ghostAY + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostAX - ghostASpeed - myDoggy.doggyW/2)][int(ghostAY + myDoggy.doggyH/2)];

// corner tracker
//pushStyle();
//strokeWeight(5);
//stroke(255,0,0);
//point(int(ghostAX - ghostASpeed - myDoggy.doggyW/2),int(ghostAY - myDoggy.doggyH/2));
//point(int(ghostAX + ghostASpeed + myDoggy.doggyW/2),int(ghostAY - myDoggy.doggyH/2));
//point(int(ghostAX - ghostASpeed + myDoggy.doggyW/2),int(ghostAY + myDoggy.doggyH/2));
//point(int(ghostAX - ghostASpeed - myDoggy.doggyW/2),int(ghostAY + myDoggy.doggyH/2));
//popStyle();
        
        // if there is no wall move
        if (up_left && up_right && down_right && down_left) 
        {
        ghostAX = ghostAX - ghostASpeed;
        movingX = true;
        }
        
        // if ghost is stuck do this
        else if (up_left == false || up_right == false || down_right == false || down_left == false)
        {
        movingY = true;
        movingX = false;
        }
        
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// MOVE GHOST RIGHT
////////////////////////////////////////////////////////
void moveRight()
{

// booleans
boolean up_left = false;
boolean up_right = false;
boolean down_right = false;
boolean down_left = false;
  
up_left = collisionMap[int(ghostAX + ghostASpeed - myDoggy.doggyW/2)][int(ghostAY - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostAX + ghostASpeed + myDoggy.doggyW/2)][int(ghostAY - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostAX + ghostASpeed + myDoggy.doggyW/2)][int(ghostAY + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostAX + ghostASpeed - myDoggy.doggyW/2)][int(ghostAY + myDoggy.doggyH/2)];

//corner tracker
//pushStyle();
//stroke(0,0,255);
//strokeWeight(5);
//point(int(ghostAX + ghostASpeed - myDoggy.doggyW/2),int(ghostAY - myDoggy.doggyH/2));
//point(int(ghostAX + ghostASpeed + myDoggy.doggyW/2),int(ghostAY - myDoggy.doggyH/2));
//point(int(ghostAX + ghostASpeed + myDoggy.doggyW/2),int(ghostAY + myDoggy.doggyH/2));
//point(int(ghostAX + ghostASpeed - myDoggy.doggyW/2),int(ghostAY + myDoggy.doggyH/2));
//popStyle();
        
        // if there is no wall move
        if (up_left && up_right && down_right && down_left) 
        {
        ghostAX = ghostAX + ghostASpeed;
        movingX = true;
        }

        // if ghost is stuck do this
        else if (up_left == false || up_right == false || down_right == false || down_left == false)
        {
        movingY = true;
        movingX = false;
        }
  
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// MOVE GHOST DOWN
////////////////////////////////////////////////////////
void moveDown()
{
  
// booleans
boolean up_left = false;
boolean up_right = false;
boolean down_right = false;
boolean down_left = false;

// if any of these come back true there is a wall
up_left = collisionMap[int(ghostAX - myDoggy.doggyW/2)][int(ghostAY + ghostASpeed - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostAX + myDoggy.doggyW/2)][int(ghostAY + ghostASpeed - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostAX + myDoggy.doggyW/2)][int(ghostAY + ghostASpeed + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostAX - myDoggy.doggyW/2)][int(ghostAY + ghostASpeed + myDoggy.doggyH/2)];

// corner tracker
//pushStyle();
//strokeWeight(5);
//stroke(255,255,0);
//point(int(ghostAX - myDoggy.doggyW/2),int(ghostAY + ghostASpeed - myDoggy.doggyH/2));
//point(int(ghostAX + myDoggy.doggyW/2),int(ghostAY + ghostASpeed - myDoggy.doggyH/2));
//point(int(ghostAX + myDoggy.doggyW/2),int(ghostAY + ghostASpeed + myDoggy.doggyH/2));
//point(int(ghostAX - myDoggy.doggyW/2),int(ghostAY + ghostASpeed + myDoggy.doggyH/2));
//popStyle();

        // if there is no wall move
        if (up_left && up_right && down_right && down_left)
        {
        ghostAY = ghostAY + ghostASpeed;
        movingY = true;
        }
        
        // if ghost is stuck do this
        else if (up_left == false || up_right == false || down_right == false || down_left == false)
        {
        movingX = true;
        movingY = false;
        }

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// MOVE GHOST UP
////////////////////////////////////////////////////////
void moveUp()
{

// booleans
boolean up_left = false;
boolean up_right = false;
boolean down_right = false;
boolean down_left = false;

// if any of these come back true there is a wall
up_left = collisionMap[int(ghostAX - myDoggy.doggyW/2)][int(ghostAY - ghostASpeed - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostAX + myDoggy.doggyW/2)][int(ghostAY - ghostASpeed - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostAX + myDoggy.doggyW/2)][int(ghostAY - ghostASpeed + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostAX - myDoggy.doggyW/2)][int(ghostAY - ghostASpeed + myDoggy.doggyH/2)];

// corner tracker
//pushStyle();
//stroke(0,255,0);
//strokeWeight(5);
//point(int(ghostAX - myDoggy.doggyW/2),int(ghostAY - ghostASpeed - myDoggy.doggyH/2));
//point(int(ghostAX + myDoggy.doggyW/2),int(ghostAY - ghostASpeed - myDoggy.doggyH/2));
//point(int(ghostAX + myDoggy.doggyW/2),int(ghostAY - ghostASpeed + myDoggy.doggyH/2));
//point(int(ghostAX - myDoggy.doggyW/2),int(ghostAY - ghostASpeed + myDoggy.doggyH/2));
//popStyle();

        // if there is no wall move
        if (up_left && up_right && down_right && down_left) 
        {
        ghostAY = ghostAY - ghostASpeed;
        movingY = true;
        }
        
        // if ghost is stuck do this
        else if (up_left == false || up_right == false || down_right == false || down_left == false)
        {
        movingX = true;
        movingY = false;
        }

}
////////////////////////////////////////////////////////

}
