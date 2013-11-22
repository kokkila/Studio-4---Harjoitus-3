//import ddf.minim.*;
import apwidgets.*;
import java.lang.Math;
PFont font;
int runningTime;
int windowSizeX, windowSizeY;
int points, lives;
int start_x1, start_x2, start_y1, start_y2;
int instructions_x1, instructions_x2, instructions_y1, instructions_y2;
boolean started, finished, instructions;
boolean firstStart = true;
GameEngine gameEngine;
GUI gui;
StartScreen startScreen;
EndScreen endScreen;
InstructionScreen instructionScreen;
Menu menu;
APMediaPlayer backgroundMusic;
APMediaPlayer splatSound;
//Minim minim;

void setup() {
  this.lives = 5;
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
  size(1024, 600);
  this.font = loadFont("Noteworthy-Bold-32.vlw");
  orientation(LANDSCAPE);
  this.gameEngine = new GameEngine(this.lives, this);
  this.startScreen = new StartScreen(this);
  this.endScreen = new EndScreen(this.gameEngine, this.font);
  this.instructionScreen = new InstructionScreen(this);
  this.menu = new Menu(this.gameEngine, this.font);
  setupAudio();
  if (this.firstStart) {

    /*minim = new Minim(this);
     player = minim.loadFile("carolbells.mp3", 2048);
     player.loop();*/
    this.firstStart = false;
  }
}

public void setupAudio() {

  backgroundMusic = new APMediaPlayer(this);
  backgroundMusic.setMediaFile("carolbells.mp3");
  backgroundMusic.start();
  backgroundMusic.setLooping(true);
  backgroundMusic.setVolume(1.0, 1.0);

  splatSound = new APMediaPlayer(this);
  splatSound.setMediaFile("147541__benboncan__splat-ish.wav");
  splatSound.setVolume(1.0, 1.0);
}

void draw() {
  if (this.finished) {
    imageMode(CORNER);
    this.endScreen.draw();
  }
  else if (this.started) {
    background(0);
    this.runningTime = millis();
    if (!mousePressed) {
      gameEngine.santa.moveAutom(this.runningTime);
      gameEngine.santa.moving = false;
    }
    gameEngine.updateGame(runningTime);
    this.menu.draw();
  } 
  else if (this.instructions) {
    this.instructionScreen.draw();
  } 
  else {
    this.startScreen.draw();
  }
}

public void onDestroy() {
  super.onDestroy(); //call onDestroy on super class
  if (backgroundMusic!=null) { //must be checked because or else crash when return from landscape mode
    backgroundMusic.release(); //release the player
  }
}

void mousePressed() {
  if (this.finished) {
    if (mouseX > 410 && mouseX < 625 && mouseY > 510 && mouseY < 550) {
      backgroundMusic.seekTo(0);
      setup();
    }
  }
  if (this.started) {
    if (mouseY < gameEngine.santa.y - gameEngine.santa.height/2 || gameEngine.santa.x - (gameEngine.santa.width/2) > mouseX || gameEngine.santa.x + (gameEngine.santa.width/2) < mouseX) { 
      if (gameEngine.santa.visible) {
        SnowBall sb = new SnowBall(gameEngine.santa.x+50, gameEngine.santa.y-110, gameEngine);
        sb.throwBallto(mouseX, mouseY, runningTime);
        gameEngine.addSantaSnowBalls(sb);
      }
    }
  } 
  else {
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

void mouseDragged() {
  if (mouseY > gameEngine.santa.y - gameEngine.santa.height/1.5 && mouseX < gameEngine.santa.x + gameEngine.santa.width*(1.2) && mouseX > gameEngine.santa.x - gameEngine.santa.width*0.8) {
    gameEngine.santa.updateCord(millis());
  }
}

int getLives() {
  return this.lives;
}

