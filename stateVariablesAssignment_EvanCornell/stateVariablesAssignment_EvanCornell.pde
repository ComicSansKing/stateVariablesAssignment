//State Variables Assignment
//Evan Cornell

//Used startButton code from inclass demo 


//global variables
//images
PImage hotMenuPicA, hotMenuPicB;
float hotMenuPicAScale, hotMenuPicBScale;

//startButton
float startButtonX, startButtonY, startButtonWidth, startButtonHeight;
float startButtonLeft, startButtonRight, startButtonTop, startButtonBottom;

//font
PFont comicSans;
String menuText;

//colour
float rMenu, gMenu, bMenu;

//state
int state;

//position
float menuxA, menuyA, menuxB, menuyB;
float menuTextWidth, menuTextHeight;

//motion
float x, y;
float dx, dy;
boolean leftMotion, rightMotion, upwardMotion, downwardMotion; 

void setup () {
  size (800, 800);
  state = 0;
  comicSans = createFont("Comic Sans MS", 45);
  hotMenuPicA = loadImage("narutoMenuA.png");
  hotMenuPicB = loadImage("narutoMenuB.png");
  menuxA = width/20;
  menuyA = height/3;
  menuxB = width/2;
  menuyB = height/2;
  hotMenuPicAScale = 1.4;
  hotMenuPicBScale = 3;


  //startButton screen position
  startButtonX = width/4;
  startButtonY = height/6;
  startButtonWidth = width/2;
  startButtonHeight = height/8;

  //calculates the sides of the button
  startButtonTop = startButtonY;
  startButtonBottom = startButtonY + startButtonHeight;
  startButtonLeft = startButtonX;
  startButtonRight = startButtonX + startButtonWidth;

  textFont(comicSans);
  menuTextWidth = width/2.5;
  menuTextHeight = height/4;
  menuText = ("Start");
}

void draw () {
  chooseState();
}

void chooseState () {
  if (state == 0) { //startScreen
    setRandoms();
    startScreen();
    displayStartButton();
    displayMenuText();
  } else if (state == 1) {//game
  }
}

void setRandoms() {
  rMenu = random(255);
  gMenu = random(255);
  bMenu = random(255);
}

void startScreen() {
  background (rMenu, gMenu, bMenu);
  image(hotMenuPicA, menuxA, menuyA, hotMenuPicA.width*hotMenuPicAScale, hotMenuPicA.height*hotMenuPicAScale);
  image(hotMenuPicB, menuxB, menuyB, hotMenuPicB.width*hotMenuPicBScale, hotMenuPicB.height*hotMenuPicBScale);
}

boolean mouseOnButton() {
  return((mouseX > startButtonLeft) &&
    (mouseX < startButtonRight) &&
    (mouseY > startButtonTop) &&
    (mouseY < startButtonBottom));
}

void displayStartButton() {
  noStroke();
  if (mouseOnButton()) {
    fill(0);
  } else {
    fill(255);
  }
  rect(startButtonX, startButtonY, startButtonWidth, startButtonHeight);
}

void displayMenuText() {
  if (mouseOnButton()) {
    fill(255);
    text(menuText, menuTextWidth, menuTextHeight);
  } else {
    fill(0);
    text(menuText, menuTextWidth, menuTextHeight);
  }
}

void mousePressed() {
  if (mouseOnButton()) {
    state = 1;
  }
}

void keyPressed () {
  //sets the booleans for motion to true if the key is pressed
  //each key coresponds with a different direction
  if (key == 'd' || key == 'D') {
    rightMotion = true;
  } 
  if (key == 'a' || key == 'A') {
    leftMotion = true;
  }
  if (key == 'w' || key == 'W') {
    upwardMotion = true;
  }
  if (key == 's' || key == 'S') {
    downwardMotion = true;
  }
}

void keyReleased () {
  //sets the booleans for motion back to false if the key is released
  if (key == 'd' || key == 'D') {
    rightMotion = false;
  } 
  if (key == 'a' || key == 'A') {
    leftMotion = false;
  }
  if (key == 'w' || key == 'W') {
    upwardMotion = false;
  }
  if (key == 's' || key == 'S') {
    downwardMotion = false;
  }
}

void moveCharacter () {
  //each if statement states if that boolean == true then set the x or y to the earlier mentioned movement speed, creates character motion 
  if (rightMotion) {
    x += dx;
  }
  if (leftMotion) {
    x -= dx;
  }
  if (upwardMotion) {
    y -= dy;
  }
  if (downwardMotion) {
    y += dy;
  }
}