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
GUI gui;
StartScreen startScreen;
EndScreen endScreen;


void setup(){
  lives = 3;
  windowSizeX = 400;
  windowSizeY = 700;
  size(windowSizeX, windowSizeY);
  snowBallPic = loadImage("snowball.png");
  snowball = new SnowBall(100, 600, 50, 0.001);
  //Luodaan startScreen
  startScreen.draw();
}

void startGame(){
  while (!started){
    
  }
  while (lives > 0){
    moveSnowballs();
    checkCollisions();
    generateCreatures();
    generateSnowBalls();
    gui.draw();
  }
  //ENDSCREEN sopivilla arvoilla
}

public void moveSnowBalls(){
  for (SnowBall sb: snowBalls){
    sb.chanceLoc(this.runningTime);
  }
}

public void checkCollisions(){
  for (SnowBall sb: snowBalls){
     for (Creature c: creatures){
       sb.checkCollision(c);
       sb.checkCollision(santa);
     }
  }
}

public void generateCreatures(){
  //Luo satunnaisesti otuksia ennalta määrättyihin slotteihin, mikäli slotissa ei ole vielä otusta
}

public void generateSnowballs(){
  for (Creature c: creatures){
    //throwSnowBall(this.santa) satunnaisesti
  }
}



//Draw pitäisi olla GUI:ssa, Lauri: voidaan mun puolesta ottaa pois, se oli vaan alun testaukseen
void draw() {
  this.runningTime = millis();
  image(snowBallPic,snowball.x, snowball.y, snowball.size, snowball.size);
  snowball.chanceLoc(this.runningTime);
}

public void setStarted(Boolean started){
  this.started = started;
}

public void setEnded(Boolean ended){
  this.ended = ended;
}

public int getLives(){
  return lives;
}

public int getPoints(){
  return points;
}

public Santa getSanta(){
  return this.santa;
}

public void substractLives(int i){
  this.lives = this.lives - i;
}

public void addPoints(int i){
  this.points = this.points + i;
}

public void addSnowBalls(SnowBall sB){
  snowballs.add(sB);
}

public void addCreatures(Creature c){
  creatures.add(c);
}

public void removeSnowBalls(SnowBall sB){
  snowBalls.remove(sB);
}

public void removeCreatures(Creature c){
  // tämän lisättävä myös pisteitä oikean verran, koska snowBall kutsuu tätä kun osuu T. lauri
  creatures.remove(c);
}
