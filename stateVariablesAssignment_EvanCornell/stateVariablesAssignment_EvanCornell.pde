//State Variables Assignment
//Evan Cornell

//Used startButton code from inclass demo 

import ddf.minim.*; 

//global variables
//images
PImage hotMenuPicA, hotMenuPicB, gameBackground, playableSauceyke;
float hotMenuPicAScale, hotMenuPicBScale, playableSauceykeScale;

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
float characterX, characterY;
float characterDX, characterDY;
boolean leftMotion, rightMotion, upwardMotion, downwardMotion; 

//audio
Minim minim; 
AudioPlayer menuPlayer, gamePlayer, endPlayer;

void setup () {
  size (800, 800);
  state = 0;
  comicSans = createFont("Comic Sans MS", 45);
  hotMenuPicA = loadImage("narutoMenuA.png");
  hotMenuPicB = loadImage("narutoMenuB.png");
  gameBackground = loadImage("narutoGameBackground.jpg");
  playableSauceyke = loadImage("sauceykeGameCharacter.png");
  gameBackground.resize(width, height);
  menuxA = width/20;
  menuyA = height/3;
  menuxB = width/2;
  menuyB = height/2;
  hotMenuPicAScale = 1.4;
  hotMenuPicBScale = 3;
  playableSauceykeScale = 0.3;

  //sets starting position for character
  characterX = width/2;
  characterY = height/2;

  //sets the speed for the character
  characterDX = 6;
  characterDY = 6;

  //all booleans are false for motion, they change when movement is implimented later on
  leftMotion = false;
  rightMotion = false;
  upwardMotion = false;
  downwardMotion = false;


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

  minim = new Minim (this);
  menuPlayer = minim.loadFile("narutoMenu.mp3");
  gamePlayer = minim.loadFile("narutoGame.mp3");
  endPlayer = minim.loadFile("narutoEnd.mp3");
}

void draw () {
  chooseState();
}

void chooseState () {
  if (state == 0) { //startScreen
    setRandoms();
    startScreen();
    playMenuMusic();
    displayStartButton();
    displayMenuText();
  } else if (state == 1) {//game
    stopMenuMusic();
    loadGameBackground();
    playGameMusic();
    moveCharacter();
    displayCharacter();
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

void playMenuMusic() {
  menuPlayer.setGain(20);
  if (state == 0) {
    menuPlayer.play();
  }
}

void stopMenuMusic() {
  if (state == 1 || state == 2) {
    menuPlayer.pause();
  }
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
    characterX += characterDX;
  }
  if (leftMotion) {
    characterX -= characterDX;
  }
  if (upwardMotion) {
    characterY -= characterDY;
  }
  if (downwardMotion) {
    characterY += characterDY;
  }
  if (characterX > width) {
   characterX = width;
  }
  if (characterY > height) {
    characterY = height;
  }
  if (characterX < 0) {
    characterX = 0;
  }
  if (characterY < 0) {
    characterY = 0;
  }
}

void loadGameBackground () {
  background(gameBackground);
}

void playGameMusic() {
  gamePlayer.setGain(20);
  if (state == 1) {
    gamePlayer.play();
  }
}

void stopGameMusic() {
  if (state == 2 || state == 0) {
    gamePlayer.pause();
  }
}

void displayCharacter() {
  imageMode(CENTER);
  image (playableSauceyke, characterX, characterY, playableSauceyke.width*playableSauceykeScale, playableSauceyke.height*playableSauceykeScale);
}