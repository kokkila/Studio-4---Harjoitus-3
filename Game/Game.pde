import java.lang.Math;
PImage snowBallPic;
int runningTime;
int windowSizeX, windowSizeY;
int points, lives;
int start_x1, start_x2, start_y1, start_y2;
int instructions_x1, instructions_x2, instructions_y1, instructions_y2;
boolean started, finished, instructions;
SnowBall snowball;
Santa santa;
ArrayList<SnowBall> snowBalls;
ArrayList<Creature> creatures; // Tää varmaan voisi olla sanakirja, tyyliin slot->creature(t)
//HashMap<Slot, Creature> creaturesMap; // EN tiedä yhtään toimiiko tää
/* Iterointi onnistuu näin
for (Object value : map.values()) {
    // ...
}*/
GameEngine gameEngine;
GUI gui;
StartScreen startScreen;
EndScreen endScreen;
InstructionScreen instructionScreen;
Menu menu;

void setup() {
  this.lives = 3;
  this.started = false;
  this.instructions = false;
  this.finished = false;
  this.start_x1 = 480;
  this.start_x2 = 685;
  this.start_y1 = 355;
  this.start_y2 = 475;
  this.instructions_x1 = 740;
  this.instructions_x2 = 925;
  this.instructions_y1 = 275;
  this.instructions_y2 = 400;
  this.windowSizeX = 1024;
  this.windowSizeY = 600;
  size(windowSizeX, windowSizeY);
  this.gameEngine = new GameEngine(3, this);
  //snowBallPic = loadImage("snowball.png");
  //snowball = new SnowBall(100, 600, 50, 0.001);
  this.startScreen = new StartScreen(this);
  this.endScreen = new EndScreen();
  this.instructionScreen = new InstructionScreen(this);
  this.menu = new Menu(this.gameEngine);
}


void draw(){
  if(this.finished){
    imageMode(CORNER);
    this.endScreen.draw();
  }
  else if (this.started) {
    background(0);
    this.runningTime = millis();
    if(!mousePressed){
      //gameEngine.santa.moving = false;
    }
    gameEngine.updateGame(runningTime);
    //Gui.draw()
    this.menu.draw();
  } else if (this.instructions) {
    this.instructionScreen.draw();
  } else {
    this.startScreen.draw();
  }
}

void mousePressed(){
  if (this.started) {
    if (mouseY < gameEngine.santa.y - gameEngine.santa.height/2) {
      new SnowBall(gameEngine.santa.x, gameEngine.santa.y, gameEngine).throwBallto(mouseX, mouseY, runningTime);
    }
  } else {
    if (mouseX > this.start_x1 && mouseX < this.start_x2 && mouseY > this.start_y1 && mouseY < this.start_y2 && this.instructions == false) {
      this.started = true;
    }
    if (mouseX > this.instructions_x1 && mouseX < this.instructions_x2 && mouseY > this.instructions_y1 && mouseY < this.instructions_y2) {
      this.instructions = true;
    }
    if (mouseX > 954 && mouseY < 70 && this.instructions == true) {
      this.instructions = false;
    }
  }
}

void mouseDragged(){
  if(mouseY > gameEngine.santa.y - gameEngine.santa.height/2 && mouseY <= gameEngine.santa.y + gameEngine.santa.height/2
    && mouseX < gameEngine.santa.x + gameEngine.santa.width && mouseX > gameEngine.santa.x - gameEngine.santa.width){
    //println("Drag Santa");
    gameEngine.santa.startMoving();
  }
  
  /*if(mouseY > 500 && mouseY <= 550 && mouseX < 220 && mouseX > 180 && gameEngine.santa.visible && !gameEngine.santa.moving){
    gameEngine.santa.moving = false;
    println("Down0");
    //println("MouseX: " + mouseX + "\nMouseY: " + mouseY);
  }
  else if(mouseY > 550 && mouseY <= 600 && mouseX < 220 && mouseX > 180 && gameEngine.santa.visible && !gameEngine.santa.moving){
    //gameEngine.santa.visible = false;
    gameEngine.santa.moving = true;
    println("Down1");
    //println("MouseX: " + mouseX + "\nMouseY: " + mouseY);
  }
  else if(mouseY > 600 && mouseY <= 650 && mouseX < 220 && mouseX > 180 && gameEngine.santa.visible && gameEngine.santa.moving){
    gameEngine.santa.visible = false;
    gameEngine.santa.moving = false;
    println("Down2");
    //println("MouseX: " + mouseX + "\nMouseY: " + mouseY);
  }
  else if(mouseY >= 600 && mouseY < 650 && mouseX < 220 && mouseX > 180 && !gameEngine.santa.visible && !gameEngine.santa.moving){
    //gameEngine.santa.moving = true;
    println("Up0");
    //println("MouseX: " + mouseX + "\nMouseY: " + mouseY);
  }
  else if(mouseY > 550 && mouseY <= 600 && mouseX < 220 && mouseX > 180 && !gameEngine.santa.visible && !gameEngine.santa.moving){
    //gameEngine.santa.visible = true;
    gameEngine.santa.moving = true;
    println("Up1");
    //println("MouseX: " + mouseX + "\nMouseY: " + mouseY);
  }
  else if(mouseY > 500 && mouseY <= 550 && mouseX < 220 && mouseX > 180 && !gameEngine.santa.visible && gameEngine.santa.moving){
    gameEngine.santa.visible = true;
    gameEngine.santa.moving = false;
    println("Up2");
    //println("MouseX: " + mouseX + "\nMouseY: " + mouseY);
  }
  else if (mouseX < 170 || mouseX > 230){
    println("Ohi");
    gameEngine.santa.moving = false;
  }*/
}

int getLives() {
  return this.lives;
}
