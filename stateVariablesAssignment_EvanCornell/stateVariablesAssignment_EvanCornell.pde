//State Variables Assignment
//Evan Cornell

//global variables

//images
PImage hotMenuPicA, hotMenuPicB;
float hotMenuPicAScale, hotMenuPicBScale;

//font
PFont comicSans;
String menuText;

//colour
float rMenu, gMenu, bMenu;

int state;

//motion
float menuxA, menuyA, menuxB, menuyB;

void setup () {
  size (800, 800);
  state = 0;
  comicSans = createFont("Comic Sans MS", 20);
  hotMenuPicA = loadImage("narutoMenuA.png");
  hotMenuPicB = loadImage("narutoMenuB.png");
  menuxA = width/20;
  menuyA = height/3;
  menuxB = 
  hotMenuPicAScale = 1.4;
  
}

void draw () {
  setRandoms();
  startScreen();
}

void setRandoms() {
  rMenu = random(255);
  gMenu = random(255);
  bMenu = random(255);
}

void startScreen() {
  background (rMenu, gMenu, bMenu);
  image(hotMenuPicA, menuxA, menuyA, hotMenuPicA.width*hotMenuPicAScale, hotMenuPicA.height*hotMenuPicAScale);
}