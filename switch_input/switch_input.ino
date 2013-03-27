const int upSwitch = 2;        // up
const int dnSwitch = 3;        // down
const int lfSwitch = 4;        // left
const int rgSwitch = 5;        // right
const int eatSwitch = 6;       // eat
const int goSwitch = 8;        // go - start - next
const int mapSwitch = 9;       // generate map
const int debounceDelay = 10;


////////////////////////////////////////////////////
boolean debounce(int pin)
{
  boolean state;
  boolean previousState;
  
  previousState = digitalRead(pin);
  for(int counter=0; counter < debounceDelay; counter++)
  {
    delay(1);
    state = digitalRead(pin);
    if(state != previousState)
    {
      counter=0;
      previousState = state;
    }
  }
  
  return state;
}
////////////////////////////////////////////////////


////////////////////////////////////////////////////
void setup() 
{ 
  pinMode(upSwitch,INPUT);      // 2
  pinMode(dnSwitch,INPUT);      // 3
  pinMode(lfSwitch,INPUT);      // 4
  pinMode(rgSwitch,INPUT);      // 5 
  pinMode(eatSwitch, INPUT);    // 6
  pinMode(goSwitch, INPUT);     // 8
  pinMode(mapSwitch, INPUT);    // 9
  Serial.begin(9600);
} 
////////////////////////////////////////////////////


////////////////////////////////////////////////////
void loop() 
{
  int input = Serial.read();
  
  // up switch (2)
  if(debounce(upSwitch))
  {
    Serial.println("UP");
  }
  // dn switch (3)
  if(debounce(dnSwitch))
  {
    Serial.println("DN");
  }
  // left switch (4)
  if(debounce(lfSwitch))
  {
    Serial.println("LF");
  }
  // right switch (5)
  if(debounce(rgSwitch))
  {
    Serial.println("RG");
  }
  // eat switch (6)
  if(debounce(eatSwitch))
  {
    Serial.println("EAT");
  }
  // go switch (8)
  if(debounce(goSwitch))
  {
    Serial.println("GO");
  }
  // map switch (9)
  if(debounce(mapSwitch))
  {
    Serial.println("MAP");
  }
  
}
////////////////////////////////////////////////////
