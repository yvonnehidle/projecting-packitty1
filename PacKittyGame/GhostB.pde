////////////////////////////////////////////////////////
// MOVEMENT INFORMATION FOR GHOST A
// Ghost is randomly generated DoggyGhost class
////////////////////////////////////////////////////////
class GhostB extends Maze
{

  
////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// ints and floats
float ghostBX;
float ghostBY;
float ghostBSpeed = 1;
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
GhostB()
{
  
// take the variables from the maze class
// we need them to make packitty move
super();

// classes
myDoggy = new DoggyGhost();
myKitty = new PacKitty();

// floats
ghostBX = int( random(width) );
ghostBY = int( random(height) );

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
  up_left = collisionMap[int(ghostBX - ghostBSpeed - myDoggy.doggyW/2)][int(ghostBY - myDoggy.doggyH/2)];
  up_right = collisionMap[int(ghostBX - ghostBSpeed + myDoggy.doggyW/2)][int(ghostBY - myDoggy.doggyH/2)];
  down_right = collisionMap[int(ghostBX - ghostBSpeed + myDoggy.doggyW/2)][int(ghostBY + myDoggy.doggyH/2)];
  down_left = collisionMap[int(ghostBX - ghostBSpeed - myDoggy.doggyW/2)][int(ghostBY + myDoggy.doggyH/2)];

  if (up_left==false || up_right==false || down_right==false || down_left==false)
  {
    ghostBX = int( random(0, width) );
    ghostBY = int( random(0, height) );
  }
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// DRAWING AND MOVING GHOST
////////////////////////////////////////////////////////
void play()
{
// draw ghost using doggyghost class
myDoggy.spawn(ghostBX,ghostBY,color(240,193,242),color(199,123,203));


if (ghostBY != kittyRefY && movingY == true)
{
// move ghost up
if (ghostBY > kittyRefY)
{
moveUp();
}
// move ghost down
if (ghostBY < kittyRefY)
{
moveDown();
}
}


else if (ghostBX != kittyRefX && movingX == true)
{
// move ghost right
if (ghostBX < kittyRefX)
{
moveRight();
}
// move ghost left
if (ghostBX > kittyRefX)
{
moveLeft();
}
}


// if ghostX is equal to kittyX switch directions
else if (ghostBX == kittyRefX)
{
  movingX = false;
  movingY = true;
}

// if ghostY is equal to kittyY switch directions
else if (ghostBY == kittyRefY)
{
  movingX = true;
  movingY = false;
}
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
up_left = collisionMap[int(ghostBX - ghostBSpeed - myDoggy.doggyW/2)][int(ghostBY - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostBX - ghostBSpeed + myDoggy.doggyW/2)][int(ghostBY - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostBX - ghostBSpeed + myDoggy.doggyW/2)][int(ghostBY + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostBX - ghostBSpeed - myDoggy.doggyW/2)][int(ghostBY + myDoggy.doggyH/2)];

// corner tracker
//pushStyle();
//strokeWeight(5);
//stroke(255,0,0);
//point(int(ghostBX - ghostBSpeed - myDoggy.doggyW/2),int(ghostBY - myDoggy.doggyH/2));
//point(int(ghostBX + ghostBSpeed + myDoggy.doggyW/2),int(ghostBY - myDoggy.doggyH/2));
//point(int(ghostBX - ghostBSpeed + myDoggy.doggyW/2),int(ghostBY + myDoggy.doggyH/2));
//point(int(ghostBX - ghostBSpeed - myDoggy.doggyW/2),int(ghostBY + myDoggy.doggyH/2));
//popStyle();
        
        // if there is no wall move
        if (up_left && up_right && down_right && down_left) 
        {
        ghostBX = ghostBX - ghostBSpeed;
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
  
up_left = collisionMap[int(ghostBX + ghostBSpeed - myDoggy.doggyW/2)][int(ghostBY - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostBX + ghostBSpeed + myDoggy.doggyW/2)][int(ghostBY - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostBX + ghostBSpeed + myDoggy.doggyW/2)][int(ghostBY + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostBX + ghostBSpeed - myDoggy.doggyW/2)][int(ghostBY + myDoggy.doggyH/2)];

//corner tracker
//pushStyle();
//stroke(0,0,255);
//strokeWeight(5);
//point(int(ghostBX + ghostBSpeed - myDoggy.doggyW/2),int(ghostBY - myDoggy.doggyH/2));
//point(int(ghostBX + ghostBSpeed + myDoggy.doggyW/2),int(ghostBY - myDoggy.doggyH/2));
//point(int(ghostBX + ghostBSpeed + myDoggy.doggyW/2),int(ghostBY + myDoggy.doggyH/2));
//point(int(ghostBX + ghostBSpeed - myDoggy.doggyW/2),int(ghostBY + myDoggy.doggyH/2));
//popStyle();
        
        // if there is no wall move
        if (up_left && up_right && down_right && down_left) 
        {
        ghostBX = ghostBX + ghostBSpeed;
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
up_left = collisionMap[int(ghostBX - myDoggy.doggyW/2)][int(ghostBY + ghostBSpeed - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostBX + myDoggy.doggyW/2)][int(ghostBY + ghostBSpeed - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostBX + myDoggy.doggyW/2)][int(ghostBY + ghostBSpeed + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostBX - myDoggy.doggyW/2)][int(ghostBY + ghostBSpeed + myDoggy.doggyH/2)];

// corner tracker
//pushStyle();
//strokeWeight(5);
//stroke(255,255,0);
//point(int(ghostBX - myDoggy.doggyW/2),int(ghostBY + ghostBSpeed - myDoggy.doggyH/2));
//point(int(ghostBX + myDoggy.doggyW/2),int(ghostBY + ghostBSpeed - myDoggy.doggyH/2));
//point(int(ghostBX + myDoggy.doggyW/2),int(ghostBY + ghostBSpeed + myDoggy.doggyH/2));
//point(int(ghostBX - myDoggy.doggyW/2),int(ghostBY + ghostBSpeed + myDoggy.doggyH/2));
//popStyle();

        // if there is no wall move
        if (up_left && up_right && down_right && down_left)
        {
        ghostBY = ghostBY + ghostBSpeed;
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
up_left = collisionMap[int(ghostBX - myDoggy.doggyW/2)][int(ghostBY - ghostBSpeed - myDoggy.doggyH/2)];
up_right = collisionMap[int(ghostBX + myDoggy.doggyW/2)][int(ghostBY - ghostBSpeed - myDoggy.doggyH/2)];
down_right = collisionMap[int(ghostBX + myDoggy.doggyW/2)][int(ghostBY - ghostBSpeed + myDoggy.doggyH/2)];
down_left = collisionMap[int(ghostBX - myDoggy.doggyW/2)][int(ghostBY - ghostBSpeed + myDoggy.doggyH/2)];

// corner tracker
//pushStyle();
//stroke(0,255,0);
//strokeWeight(5);
//point(int(ghostBX - myDoggy.doggyW/2),int(ghostBY - ghostBSpeed - myDoggy.doggyH/2));
//point(int(ghostBX + myDoggy.doggyW/2),int(ghostBY - ghostBSpeed - myDoggy.doggyH/2));
//point(int(ghostBX + myDoggy.doggyW/2),int(ghostBY - ghostBSpeed + myDoggy.doggyH/2));
//point(int(ghostBX - myDoggy.doggyW/2),int(ghostBY - ghostBSpeed + myDoggy.doggyH/2));
//popStyle();

        // if there is no wall move
        if (up_left && up_right && down_right && down_left) 
        {
        ghostBY = ghostBY - ghostBSpeed;
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
