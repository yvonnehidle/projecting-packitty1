////////////////////////////////////////////////////////
// DRAWS THE MAZE
// This is where the collison map is set up
// All classes inherit this for movement
////////////////////////////////////////////////////////
class Maze
{
  
////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// maze variables
boolean[][] collisionMap;
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// VARIABLES VALUES (CONSTRUCTOR)
////////////////////////////////////////////////////////
Maze()
{
// the collision map must be black and white
PImage collisionImage = loadImage("map.png");

// generate our collision map as an two-dimensional boolean array
// black is false (blocked)
// white is true (clear)
collisionMap = new boolean[collisionImage.width][collisionImage.height];
color black = color(0);
color white = color(255);

// looks through collision map rows
for (int i = 0; i < collisionImage.width; i++)
{

// looks through collision map columns
for (int j = 0; j < collisionImage.height; j++)
{
color c = collisionImage.get(i, j);
if (c == black) 
{
collisionMap[i][j] = false;
}

else if (c == white) 
{
collisionMap[i][j] = true;
}

}}}
////////////////////////////////////////////////////////
}
