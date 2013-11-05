import java.lang.Math;
PImage snowBallPic;
int runningTime;
int windowSizeX, windowSizeY;
SnowBall snowball;


void setup(){
  windowSizeX = 400;
  windowSizeY = 700;
  size(windowSizeX, windowSizeY);
  snowBallPic = loadImage("snowball.png");
  snowball = new SnowBall(100, 600, 50, 0.001);
}

void draw() {
  this.runningTime = millis();
  //image(snowBallPic,snowball.x, snowball.y, snowball.size, snowball.size);
  snowball.chanceLoc(this.runningTime);
}
