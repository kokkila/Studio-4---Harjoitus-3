class SnowBall {
  boolean moving;
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
    this.xySpeed = speed;
    this.sizeSpeed = 0.0005;
    Dy = -1;
    Dx = 1;
    Dsize = 1;
  }

  void chanceLoc(int timePassed) {
    if (this.Dx == 0 || this.Dy== 0) {
      println("ERROR: SnowBall Dx or Dy is 0!!");
    }
    this.x = this.x + this.Dx*(Math.round(timePassed*this.xySpeed));
    this.y = this.y + this.Dy*(Math.round(timePassed*this.xySpeed));
    this.size= this.size - this.Dsize*Math.round(timePassed*this.sizeSpeed);
  }
  
  void throwBallto(int x, int y, int distance){
    this.Dx = x-this.x;
    this.Dy = y-this.y;
    this.Dsize = distance;
    this.moving = true;
  }
  
  //Tarkistaa osuuko pallo otukseen c
  //Muista huomioida myös etäisyys Santasta
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä
  void checkCollision(Creature c){
      
  }
  
  //Tarkistaa osuuko pallo santaan
  //Tarvittaessa vähentää elämiä
  void checkCollision(Santa santa){
      
  }
  
  
  
}

