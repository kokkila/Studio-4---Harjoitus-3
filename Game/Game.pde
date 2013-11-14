import java.lang.Math;
PImage snowBallPic;
int runningTime;
int windowSizeX, windowSizeY;
int points, lives;
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
  windowSizeX = 400;
  windowSizeY = 700;
  size(windowSizeX, windowSizeY);
  this.gameEngine = new GameEngine(3, this);
  //snowBallPic = loadImage("snowball.png");
  //snowball = new SnowBall(100, 600, 50, 0.001);
  //Luodaan startScreen
  //startScreen.draw();
}


void draw(){
  background(0);
  this.runningTime = millis();
  gameEngine.updateGame(runningTime);
  //Gui.draw()
}
void mousePressed(){
  if(mouseY < 500){
    new SnowBall(200, 200, 1, gameEngine).throwBallto(mouseX, mouseY, runningTime);
  }
}
