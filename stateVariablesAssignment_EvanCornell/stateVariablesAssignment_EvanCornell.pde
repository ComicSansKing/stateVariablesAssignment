//State Variables Assignment
//Evan Cornell

//Used startButton code from inclass demo 

//I deserve full marks for:
//interactive
//aesthetically pleasing ;)
//uses a state variable to switch between menu and game, as well as end screen. The end screen currently has no function but will be built upon in next iteration

//I deserve extra for experts for:
//PIamge used throughout as well as music and music timing.
//the use of states to call functions in an if/else loop
//character movement boundaries 
//lots of hard work

//Not all functions have a purpose yet, and the game is not finished. Hoping to build upon it for the next project.

import ddf.minim.*; 

//global variables
//images
PImage hotMenuPicA, hotMenuPicB, gameBackground, playableSauceyke, computerNaruto;
float hotMenuPicAScale, hotMenuPicBScale, playableSauceykeScale, computerNarutoScale;

//startButton
float startButtonX, startButtonY, startButtonWidth, startButtonHeight;
float startButtonLeft, startButtonRight, startButtonTop, startButtonBottom;

//font
PFont comicSans;
String menuText, endText;

//colour
float rMenu, gMenu, bMenu;

//state
int state;

//position
float menuxA, menuyA, menuxB, menuyB;
float menuTextWidth, menuTextHeight, endTextWidth, endTextHeight;

//motion
float characterX, characterY;
float characterDX, characterDY;
boolean leftMotion, rightMotion, upwardMotion, downwardMotion; 

//time
float timeToWait;

//audio
Minim minim; 
AudioPlayer menuPlayer, gamePlayer, endPlayer;

void setup () {
  //declares screen size and sets state to 0 which will change as the game goes on
  size (800, 800);
  state = 0;
  
  //loads all images and creates the Comic Sans font used throughout ;)
  comicSans = createFont("Comic Sans MS", 45);
  hotMenuPicA = loadImage("narutoMenuA.png");
  hotMenuPicB = loadImage("narutoMenuB.png");
  gameBackground = loadImage("narutoGameBackground.jpg");
  playableSauceyke = loadImage("sauceykeGameCharacter.png");
  computerNaruto = loadImage("narutoGameCharacter.png");
  
  //resizes the background image to whatever the width and height of the background is
  gameBackground.resize(width, height);
  
  //declares where on the screen certain images will appear
  menuxA = width/20;
  menuyA = height/3;
  menuxB = width/2;
  menuyB = height/2;
  
  //scales pictures to the sizes that are desirable
  hotMenuPicAScale = 1.4;
  hotMenuPicBScale = 3;
  playableSauceykeScale = 0.3;
  computerNarutoScale = 0.17;

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


//declares the font type and tells where to put these strings of text
  textFont(comicSans);
  menuTextWidth = width/2.5;
  menuTextHeight = height/4;
  menuText = ("Start");
  endTextWidth = width/2;
  endTextHeight = height/2;
  endText = ("Game Over");

  //timeToWait = 1500;

//launches minim and then assigns each variable a song that will be used later on in the code
  minim = new Minim (this);
  menuPlayer = minim.loadFile("narutoMenu.mp3");
  gamePlayer = minim.loadFile("narutoGame.mp3");
  endPlayer = minim.loadFile("narutoEnd.mp3");
}

void draw () {
  //calls only this function, this chooses what will be displayed in each state
  chooseState();
}

void chooseState () {
  if (state == 0) { //startScreen
  //if the state is 0 then call upon all these functions
    setRandoms();
    startScreen();
    playMenuMusic();
    displayStartButton();
    displayMenuText();
  } else if (state == 1) {//game
  //if the state is 1 then call upon these functions
    stopMenuMusic();
    loadGameBackground();
    playGameMusic();
    moveCharacter();
    displayCharacter();
    displayComputer();
  } else { //endScreen
  //if the state is 2 then call upon these functions 
    stopGameMusic();
    setRandoms();
    endingScreen();
  }
}

  void setRandoms() {
    //sets the rgb values for the menu to all random
    rMenu = random(255);
    gMenu = random(255);
    bMenu = random(255);
  }

  void startScreen() {
    //makes the  background the random values, refreshes them so they constantly change
    background (rMenu, gMenu, bMenu);
    
    //puts the images in the earlier declared x and y postions while also changing the scale
    image(hotMenuPicA, menuxA, menuyA, hotMenuPicA.width*hotMenuPicAScale, hotMenuPicA.height*hotMenuPicAScale);
    image(hotMenuPicB, menuxB, menuyB, hotMenuPicB.width*hotMenuPicBScale, hotMenuPicB.height*hotMenuPicBScale);
  }

  void playMenuMusic() {
    //sets the gain to the desired value
    menuPlayer.setGain(20);
    if (state == 0) {
      //if the state is 0 then the first song is played
      menuPlayer.play();
    }
  }

  void stopMenuMusic() {
    if (state != 0) {
      //if the state is not 0 then the first song is paused
      menuPlayer.pause();
    }
  }

  boolean mouseOnButton() {
    //calculates whether the mouse is on the button or not then returns the value
    return((mouseX > startButtonLeft) &&
      (mouseX < startButtonRight) &&
      (mouseY > startButtonTop) &&
      (mouseY < startButtonBottom));
  }

  void displayStartButton() {
    noStroke();
    //if the mouse is on the button it is black, else it is white
    if (mouseOnButton()) {
      fill(0);
    } else {
      fill(255);
    }
    //draws the button which is the same either way
    rect(startButtonX, startButtonY, startButtonWidth, startButtonHeight);
  }

  void displayMenuText() {
    //much like the previous function, it inverts the text colour while displaying, starts as black and turns white
    if (mouseOnButton()) {
      fill(255);
      text(menuText, menuTextWidth, menuTextHeight);
    } else {
      fill(0);
      text(menuText, menuTextWidth, menuTextHeight);
    }
  }

  void mousePressed() {
    //if the mouse is pressed on the button switch to state 1
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
    //each if statement states if that boolean == true then set the characterX or characterY to the earlier mentioned movement speed, creates character motion 
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
    
    //these four if statements force the player to stay within the bounds of the screen
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
    //loads the game background
    background(gameBackground);
  }

  void playGameMusic() {
    //sets the gain volume then if in state 1 plays music
    gamePlayer.setGain(20);
    if (state == 1) {
      gamePlayer.play();
    }
  }

  void stopGameMusic() {
    //if the state is not 1 pause the music
    if (state != 1) {
      gamePlayer.pause();
    }
  }

  void displayCharacter() {
    //displays Sasuke the playable character model 
    imageMode(CENTER);
    image (playableSauceyke, characterX, characterY, playableSauceyke.width*playableSauceykeScale, playableSauceyke.height*playableSauceykeScale);
  }

  void displayComputer() {
    //imageMode(CENTER);
    //image(computerNaruto, , computerNaruto.width*computerNarutoScale, computerNaruto.height*computerNarutoScale);
  }

  void endingScreen() {
    background(rMenu, gMenu, bMenu);
    textAlign(CENTER);
    fill(255);
    text(endText, endTextWidth, endTextHeight);
  }