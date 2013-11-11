class SnowBall {
  boolean moving;
  boolean toSanta;
  int x, y;
  int Dx, Dy, distance;
  int startTime;
  float size;

  // nopeudet jolla palloa siirretään: pineneminen ja siirtyminen xy
  float sizeSpeed;
  float xySpeed;

  Game game;
  
  SnowBall(int startX, int startY, float size, Game game) {
    this.x = startX;
    this.y = startY;
    this.size = size;
    this.xySpeed = 0.000015;
    this.sizeSpeed = -0.0000007;
    this.game = game;
  }

  // annetaan muuttujaksi kuinka paljon aikaa heitosta kulunut ja lasketaan uusi sijainti sekä pallon koko
  void chanceLoc(int currentTime) {
    int timePassed = currentTime - startTime;
    if (this.Dx == 0 || this.Dy== 0) {
      println("ERROR: SnowBall Dx or Dy is 0!!");
    }
    this.x = this.x + Math.round(this.Dx*timePassed*this.xySpeed);
    this.y = this.y + Math.round(this.Dy*timePassed*this.xySpeed);
    this.size= this.size - Math.round(timePassed*this.sizeSpeed);
  }

  // mihin pallo heitetään, ja lasketaan kuinka kaukana millisekunteina kohde on 
  void throwBallto(int x, int y) {
    this.Dx = x-this.x;
    this.Dy = y-this.y;
    //etäisyys millisekunteina eli kauan lento kestää
    this.distance = (int) sqrt((this.Dx*this.Dx)+(this.Dy*this.Dy))*this.sizeSpeed; 
    this.moving = true;
    if(game.getSanta().isHere(x,y)){
        this.toSanta == true;
    }
  }

  //Tarkistaa osuuko pallo otukseen c
  //Muista huomioida myös etäisyys Santasta
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä
  void checkCollision(Creature c, int currentTime) {  
    // jos pallo lentänyt vaadittavan ajan
    if((currentTime-this.startTime)>= this.distance){
      if(c.isHere(this.x, this.y)){
        game.removeCreatures(c);
      }
      else{
        println("Ball missed all targets");
      }
    }
  }

  //Tarkistaa osuuko pallo santaan
  //Tarvittaessa vähentää elämiä
  void checkCollision(Santa santa) {
    if((
  }

  int getX() {
    return this.x;
  }
  int getY() {
    return this.y;
  }
  boolean isMoving() {
    return moving;
  }

  void setX(int x) {
    this.x = x;
  }

  void setY(int y) {
    this.y = y;
  }

  void setMoving(boolean moving) {
    this.moving = moving;
  }
}

