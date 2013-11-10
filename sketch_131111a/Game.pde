import java.lang.Math;
PImage snowBallPic;
SnowBall snowball;
int runningTime;
int windowSizeX, windowSizeY;

void setup(){
  windowSizeX = 400;
  windowSizeY = 700;
  size(windowSizeX, windowSizeY);
  snowBallPic = loadImage("snowball.png");
  snowball = new SnowBall(100, 600, 50);
  snowball.throwBallto(50, 50, this.runningTime);
}

void draw() {
    rect(0,0,windowSizeX, windowSizeY);

  this.runningTime = millis();
  snowball.chanceLoc(this.runningTime);
  image(snowBallPic,snowball.x-(snowball.size/2), snowball.y-(snowball.size/2), snowball.size, snowball.size);
}
