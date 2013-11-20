import java.lang.Math;
PImage snowBallPic;
int runningTime;
int windowSizeX, windowSizeY;
int points, lives;
int start_x1, start_x2, start_y1, start_y2;
boolean started, finished;
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

void setup(){
  lives = 3;
  this.started = false;
  this.start_x1 = 480;
  this.start_x2 = 685;
  this.start_y1 = 355;
  this.start_y2 = 475;
  windowSizeX = 1024;
  windowSizeY = 600;
  size(windowSizeX, windowSizeY);
  this.gameEngine = new GameEngine(3, this);
  //snowBallPic = loadImage("snowball.png");
  //snowball = new SnowBall(100, 600, 50, 0.001);
  this.startScreen = new StartScreen(this);
  startScreen.draw();
}


void draw(){
  if (this.started) {
    background(0);
    this.runningTime = millis();
    if(!mousePressed){
      //gameEngine.santa.moving = false;
    }
    gameEngine.updateGame(runningTime);
    //Gui.draw()
  }
}
void mousePressed(){
  if (this.started) {
    if (mouseY < gameEngine.santa.y - gameEngine.santa.height) {
      new SnowBall(gameEngine.santa.x, gameEngine.santa.y, gameEngine).throwBallto(mouseX, mouseY, runningTime);
    }
  } else {
    if (mouseX > this.start_x1 && mouseX < this.start_x2 && mouseY > this.start_y1 && mouseY < this.start_y2) {
      this.started = true;
      println("menee tanne");
    }
  }
}
void mouseDragged(){
  if(mouseY > gameEngine.santa.y - gameEngine.santa.height && mouseY <= gameEngine.santa.y + gameEngine.santa.height
    && mouseX < gameEngine.santa.x + gameEngine.santa.width && mouseX > gameEngine.santa.x - gameEngine.santa.width){
    println("Drag Santa");
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
