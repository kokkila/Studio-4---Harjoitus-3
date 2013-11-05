class SnowBall {
  int x;
  int y;
  int Dx;
  int Dy;
  int Dsize;
  float size;
  float sizeSpeed;
  float xySpeed;

  SnowBall(int startX, int startY, float size, float speed) {
    this.x = startX;
    this.y = startY;
    this.size = size;
    this.speed = speed;
    Dy = 0;
    Dx = 0;
  }

  void chanceLoc(float timePassed) {
    if (this.Dx == 0 || this.Dy== 0) {
      println("ERROR: SnowBall Dx or Dy is 0!!");
    }
    this.x = this.x + this.Dx*(Math.round(timePassed*this.xyspeed));
    this.y = this.y + this.Dy*(Math.round(timePassed*this.xyspeed));
    this.size= this.size - this.Dsize*Math.round(timePassed*this.sizeSpeed);
  }
  
  void throwBallto(int x, int y, int distance){
    this.Dx = x-this.x;
    this.Dy = y-this.y;
    this.Dsize = distance;
  }
  
}

