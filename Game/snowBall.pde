class SnowBall {
  boolean moving;
  boolean toSanta;
  // x ja y mihin pallo piirretään
  int x, y;
  //aloitus pisteet
  int orgX, orgY;
  int Dx, Dy, distance;
  int startTime;
  float size, topSize;

  // nopeudet jolla palloa siirretään: pineneminen ja siirtyminen xy
  float sizeSpeed;
  float timeConverter;

  PImage ballImage;
  Game game;

  SnowBall(int startX, int startY, float size, PImage ballImage Game game) {
    this.x = startX;
    this.y = startY;
    this.topSize = size;
    this.sizeSpeed = 0.01;
    this.size = Math.round(this.sizeSpeed*this.y)+this.topSize;
    this.orgX = startX;
    this.orgY = startY;
    this.timeConverter = 3;
    this.game = game;
    this.ballImage = ballImage;
  }

  void display() {
    img(this.ballImage, this.x, this.y);
  }

 

  // annetaan muuttujaksi kuinka paljon aikaa heitosta kulunut ja lasketaan uusi sijainti sekä pallon koko
  void chanceLoc(int currentTime) {
    if (moving) {
      float timePassed = currentTime - startTime;
      if (this.Dx == 0 || this.Dy== 0) {
        println("ERROR: SnowBall Dx or Dy is 0!!");
      }
      this.setX(this.orgX + Math.round(this.Dx*(timePassed/this.distance)));
      this.setY(this.orgY + Math.round(this.Dy*(timePassed/this.distance)));
      this.setSize(Math.round(this.sizeSpeed*this.y)+this.topSize);
    }
  }

  // mihin pallo heitetään, ja lasketaan kuinka kaukana millisekunteina kohde on 
  void throwBallto(int x, int y, int currentTime) {
    this.Dx = x-this.x;
    this.Dy = y-this.y;
    this.startTime = currentTime;
    //etäisyys millisekunteina eli kauan lento kestää
    this.distance = Math.round(sqrt((this.Dx*this.Dx)+(this.Dy*this.Dy))*this.timeConverter);
    println("distance:" + this.distance);
    this.moving = true;
    if (game.getSanta().isHere(x, y)) {
      this.toSanta = true;
    }
  }

  //Tarkistaa osuuko pallo otukseen c
  //Muista huomioida myös etäisyys Santasta
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä
  void checkCollision(Creature c, int currentTime) {  
    // jos pallo lentänyt vaadittavan ajan
    if ((currentTime-this.startTime)>= this.distance) {
      if (c.isHere(this.x+(this.size/2), this.y+(this.size)/2)) {
        game.removeCreatures(c);
        this.moving = false;
        this.Dx = 0;
        this.Dy = 0;
      }
      else {
        println("Ball missed all targets");
      }
    }
  }

  //Tarkistaa osuuko pallo santaan
  //Tarvittaessa vähentää elämiä
  void checkCollision(Santa santa) {
    
  }

  int getX() {
    return this.x;
  }
  int getY() {
    return this.y;
  }
  float getSize() {
    return this.size;
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

  void setSize(float size) {
    this.size = size;
  }

  void setMoving(boolean moving) {
    this.moving = moving;
  }
}

