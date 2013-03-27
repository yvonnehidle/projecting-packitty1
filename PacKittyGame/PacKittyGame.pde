////////////////////////////////////////////////////////
// PROJECT 1: PACKITTY
// Processing for the Arts (48-757 @ 11:30AM)
// M. Yvonne Hidle (yvonnehidle@gmail.com)
//
// CREDITS:
// 1. Collision mapping based off code from Laurel Deel
//    http://www.openprocessing.org/sketch/43601
// 2. Pacman sounds
//    http://www.classicgaming.cc/classics/pacman/sounds.php
// 3. Other sounds
//    http://www.sounddogs.com
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// import libraries
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.serial.*;
import processing.video.*;

// classes
PacKitty myKitty;
GhostA myGhostA;
GhostB myGhostB;
GhostC myGhostC;
Food myFood;

// images
PImage visibleMap;
PImage introImage;
PImage deathImage;
PImage levelImage;

// audio stuff
Minim minim;
AudioPlayer intro;
AudioPlayer kibble;
AudioPlayer fish;
AudioPlayer death;
AudioPlayer levelComplete;
AudioPlayer catnip;
AudioPlayer grow;
AudioPlayer shrink;
AudioPlayer eatghost;

// general game variables
int gamePhase;
int startTime;
float kittyStartX;
float kittyStartY;
float ghostStartX;
float ghostStartY;
int levelNum;
int goalKibbles;
int goalFish;
int goalGhosts;

// arduino
Serial myPort;
String inString;

// camera
Capture cam;
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// LOAD OUR CLASSES AND SETUP THE GAME
////////////////////////////////////////////////////////
void setup()
{
size(1024,768);
imageMode(CENTER);
smooth();
  
// classes
myKitty = new PacKitty();
myGhostA = new GhostA();
myGhostB = new GhostB();
myGhostC = new GhostC();
myFood = new Food();

// images
visibleMap = loadImage("map.png");
introImage = loadImage("intro-screen.png");
deathImage = loadImage("death-screen.png");
levelImage = loadImage("levelup-screen.png");

// audio stuff
minim = new Minim(this);
intro = minim.loadFile("pacman_beginning.wav");
kibble = minim.loadFile("chomp_kibble.mp3");
fish = minim.loadFile("chomp_fish.mp3");
death = minim.loadFile("pacman_death.wav");
levelComplete = minim.loadFile("pacman_levelcomplete.wav");
catnip = minim.loadFile("catnip.wav");
grow = minim.loadFile("catnip-grow.wav");
shrink = minim.loadFile("catnip-shrink.wav");
eatghost = minim.loadFile("eatghost.mp3");

// general game variables
gamePhase=0;
startTime=0;
kittyStartX = 950;
kittyStartY = 550;
ghostStartX = width/2;
ghostStartY = 50;
levelNum = 1;
goalKibbles = 10;
goalFish = 1;
goalGhosts = 0;

// arduino
//println(Serial.list());
myPort = new Serial(this, Serial.list()[1], 9600);
myPort.buffer(1);

// camera things
cam = new Capture(this, 640, 480);
cam.start();

// because the music is being annoying!
if (gamePhase == 0)
{
  intro.play();
  intro.rewind();
}
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GAME TABLE OF CONTENTS
////////////////////////////////////////////////////////
void draw()
{ 
  // intro screen
  if(gamePhase == 0)
  {
    showIntro();
  }
  
  // goals for level
  else if(gamePhase == 1)
  {
    showLevel();
  }
  
  // play game
  else if(gamePhase == 2)
  {
    playGame();
  }

  // level up
  else if(gamePhase == 3)
  {
    upLevel();
  }
  
  // show score
  else if(gamePhase == 4)
  {
    score();
  }

  // make a collison map
  else if(gamePhase == 5)
  {
    generateMap();
  }

// check framerate
//println(frameRate);
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// INTRO SCREEN
////////////////////////////////////////////////////////
void showIntro()
{

// show intro image!
background(introImage);

// switches and stuff
inString = myPort.readStringUntil('\n');
if (inString != null) 
{
    inString = trim(inString);
    // if GO is pressed, show level goals
    if(inString.equals("GO") == true)
    {
      gamePhase=1;
      startTime=millis();
    }
    
    // if MAP is pressed, show map generation screen
    if(inString.equals("MAP") == true)
    {
      gamePhase=5;
    }
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// SHOW WHAT LEVEL YOU ARE ON
////////////////////////////////////////////////////////
void showLevel()
{
int countDown = 3000; // three seconds
  
// show intro image!
background(visibleMap);

// make transparent
pushStyle();
fill(255,100);
rect(0,0,width,height);
popStyle();

// show the goals
pushStyle();
fill(0);
textSize(20);
text("L E V E L . " + levelNum, 404, 250);

textSize(15);
text("Eat " + goalKibbles + " Kibbles", 404, 265);
text("Eat " + goalFish + " Tasty Fish", 404, 280);
text("Eat " + goalGhosts + " Ghosts", 404, 295);
popStyle();

// if countdown passes, start the game
pushStyle();
fill(255);
textSize(30);
text((countDown/1000 - ((millis()-startTime))/1000), width/2, 200);
popStyle();

if ((millis()-startTime) > countDown)
{
  gamePhase=2;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// PLAY GAME
////////////////////////////////////////////////////////
void playGame()
{
  // draw maze
  background(visibleMap);
  
  // spawn food
  myFood.spawn();
  
  // spawn characters and move them
  myKitty.play();
  myGhostA.play();
  myGhostB.play();
  myGhostC.play();
  
  // win lose and all that
  death();
  win();
  
  // special things!
  eatGhosts();
  
  // transfer variables from one class to another
  // to ghostA class
  myGhostA.kittyRefX = myKitty.kittyX;
  myGhostA.kittyRefY = myKitty.kittyY;
  // to ghostB class
  myGhostB.kittyRefX = myKitty.kittyX*2;
  myGhostB.kittyRefY = myKitty.kittyY*2;
  // to the food class
  myFood.kittyRefX = myKitty.kittyX;
  myFood.kittyRefY = myKitty.kittyY;
  myFood.kittyRefS = myKitty.kittyW;
  // to packitty class
  myKitty.isCatHighRef = myFood.isCatHigh;
  
  // is the cat high? transfer these variables
  if (myFood.isCatHigh == true)
  {
      // to ghostA class
      myGhostA.kittyRefX = myKitty.kittyX-50;
      myGhostA.kittyRefY = myKitty.kittyY-50;
      // to ghostB class
      myGhostB.kittyRefX = myKitty.kittyX-100;
      myGhostB.kittyRefY = myKitty.kittyY-100;
  }
  // is the cat not high? transfer these variables
  else
  {
      // to ghostA class
      myGhostA.kittyRefX = myKitty.kittyX;
      myGhostA.kittyRefY = myKitty.kittyY;
      // to ghostB class
      myGhostB.kittyRefX = myKitty.kittyX*2;
      myGhostB.kittyRefY = myKitty.kittyY*2;
  }

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// DEATH!!!
////////////////////////////////////////////////////////
void death()
{
  
float deathA = dist(myKitty.kittyX, myKitty.kittyY, myGhostA.ghostAX, myGhostA.ghostAY);
float deathB = dist(myKitty.kittyX, myKitty.kittyY, myGhostB.ghostBX, myGhostB.ghostBY);
float deathC = dist(myKitty.kittyX, myKitty.kittyY, myGhostC.ghostCX, myGhostC.ghostCY);

if (deathA < myKitty.kittyW && myFood.isCatHigh == false || deathB < myKitty.kittyW && myFood.isCatHigh == false || deathC < myKitty.kittyW && myFood.isCatHigh == false)
{
  // pacKitty dies! 
  catnip.pause();
  catnip.rewind();
  death.play();
  death.rewind();
  gamePhase=4;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// EAT GHOSTS!!!
////////////////////////////////////////////////////////
void eatGhosts()
{
  
float yumGhostA = dist(myKitty.kittyX, myKitty.kittyY, myGhostA.ghostAX, myGhostA.ghostAY);
float yumGhostB = dist(myKitty.kittyX, myKitty.kittyY, myGhostB.ghostBX, myGhostB.ghostBY);
float yumGhostC = dist(myKitty.kittyX, myKitty.kittyY, myGhostC.ghostCX, myGhostC.ghostCY);

if (yumGhostA < myKitty.kittyW && myFood.isCatHigh == true)
{
  // pacKitty eats a ghost!
  eatghost.play();
  eatghost.rewind();
  myGhostA.setup();
  myFood.ghostsEaten++;
}

else if (yumGhostB < myKitty.kittyW && myFood.isCatHigh == true)
{
  // pacKitty eats a ghost!
  eatghost.play();
  eatghost.rewind();
  myGhostA.setup();
  myFood.ghostsEaten++;
}

else if (yumGhostC < myKitty.kittyW && myFood.isCatHigh == true)
{
  // pacKitty eats a ghost!
  eatghost.play();
  eatghost.rewind();
  myGhostC.setup();
  myFood.ghostsEaten++;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// WIN!!!!!!!
////////////////////////////////////////////////////////
void win()
{

if (myFood.kibbleEaten >= goalKibbles && myFood.fishEaten >= goalFish && myFood.ghostsEaten >= goalGhosts)
{ 
  // new level
  levelNum++;
  
  // up the goals!
  goalKibbles = goalKibbles+5;
  goalFish++;
  goalGhosts++;
  
  // make the ghosts faster!
  myGhostA.ghostASpeed = myGhostA.ghostASpeed + 0.5;
  myGhostB.ghostBSpeed = myGhostB.ghostBSpeed + 0.5;
  myGhostC.ghostCSpeed = myGhostC.ghostCSpeed + 0.5;
  
  // reset the character values!
  myKitty.setup();
  myGhostA.setup();
  myGhostB.setup();
  myGhostC.setup();
  
  // reset the food placement
  myFood.foodX = myFood.makeFoodX(myFood.foodMax);
  myFood.foodY = myFood.makeFoodY(myFood.foodMax);
  myFood.tastyFishX = int( random(0, width) );
  myFood.tastyFishY = int( random(0, height) );
  
  // reset the score
  myFood.kibbleEaten = 0;
  myFood.fishEaten = 0;
  myFood.ghostsEaten = 0;
  
  // make the cat un-high
  myFood.isCatHigh = false;
  
  // pacKitty wins this level!
  catnip.pause();
  catnip.rewind();
  levelComplete.play();
  levelComplete.rewind();
  gamePhase=3;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// LEVEL UP!
////////////////////////////////////////////////////////
void upLevel()
{

// level up screen image
background(levelImage);

// if GO is pressed, next level!
inString = myPort.readStringUntil('\n');
if (inString != null) 
{
    inString = trim(inString);
    if(inString.equals("GO") == true)
    {
      gamePhase=1;
      startTime=millis();
    }
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// SCORE
////////////////////////////////////////////////////////
void score()
{

// death screen image
background(deathImage);

// reset the character values!
myKitty.setup();
myGhostA.setup();
myGhostB.setup();
myGhostC.setup();

// reset the food placement
myFood.foodX = myFood.makeFoodX(myFood.foodMax);
myFood.foodY = myFood.makeFoodY(myFood.foodMax);
myFood.tastyFishX = int( random(0, width) );
myFood.tastyFishY = int( random(0, height) );

// reset the score
myFood.kibbleEaten = 0;
myFood.fishEaten = 0;
myFood.ghostsEaten = 0;

// reset the goals
levelNum = 1;
goalKibbles = 10;
goalFish = 1;
goalGhosts = 0;

// reset the ghost speeds
myGhostA.ghostASpeed = 1;
myGhostB.ghostBSpeed = 1;
myGhostC.ghostCSpeed = 1;

// if GO is pressed, show level 1 goals
inString = myPort.readStringUntil('\n');
if (inString != null) 
{
    inString = trim(inString);
    if(inString.equals("GO") == true)
    {
      gamePhase=0;
      catnip.pause();
      catnip.rewind();
      intro.play();
      intro.rewind();
    }
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GENERATE A MAP HERE
////////////////////////////////////////////////////////
void generateMap()
{
  
  // camera stuff!
  if (cam.available() == true) 
  {
    cam.read();
  }
  cam.filter(THRESHOLD,.4);
  image(cam, width/2, height/2, width, height);
  
  
  inString = myPort.readStringUntil('\n');
  if (inString != null) 
  {
    inString = trim(inString);
    // if GO is pressed, show level goals
    if(inString.equals("GO") == true)
    {
      gamePhase=1;
      startTime=millis();
    }
    
    // if MAP is pressed, show map generation screen
    if(inString.equals("UP") == true)
    {
      cam.stop();
      saveFrame("data/map.png");
      visibleMap = loadImage("map.png");
    }
  }
  
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// CLOSE THE AUDIO DOWN
////////////////////////////////////////////////////////
void stop()
{
intro.close();
kibble.close();
fish.close();
death.close();
levelComplete.close();
catnip.close();
grow.close();
shrink.close();
eatghost.close();

minim.stop();
super.stop();
}
////////////////////////////////////////////////////////
