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
  PImage ballPic;
  GameEngine gameEngine;



  SnowBall(int startX, int startY, GameEngine gameEngine) {
    this.x = startX;
    this.y = startY;
    this.topSize = 50;
    this.sizeSpeed = 0.01;
    this.size = Math.round(this.sizeSpeed*this.y)+this.topSize;
    this.orgX = startX;
    this.orgY = startY;
    this.timeConverter = 3;
    this.gameEngine = gameEngine;
    this.ballPic=loadImage("snowball.png");
    gameEngine.addSnowBalls(this);
    //println("Uusi pallo luotiin");
  }

  void display() {
    image(this.ballPic, this.x, this.y);
    println("snowball x: " + this.x + "  y :" + this.y);
  }

 

  // annetaan muuttujaksi kuinka paljon aikaa heitosta kulunut ja lasketaan uusi sijainti sekä pallon koko
  // Atro: Pallot ei liiku
  void chanceLoc(int currentTime) {
    if (moving) {
      float timePassed = currentTime - startTime;
      if (this.Dx == 0 || this.Dy== 0) {
        println("ERROR: SnowBall Dx or Dy is 0!!");
      }
      this.setX(this.orgX + Math.round(this.Dx*(timePassed/this.distance)));
      this.setY(this.orgY + Math.round(this.Dy*(timePassed/this.distance)));
      this.setSize(Math.round(this.sizeSpeed*this.y)+this.topSize);
      //println("Pallo liikkuu: " + timePassed + "\nX: " + x + " Y: " + y);
    }
  }

  // mihin pallo heitetään, ja lasketaan kuinka kaukana millisekunteina kohde on 
  void throwBallto(int x, int y, int currentTime) {
              println("Heita to    x: " + x + "  y: " +y);
    this.Dx = x-this.x;
    this.Dy = y-this.y;
    println("Dx:" + this.Dx + "  Dy: " + this.Dy);
    this.startTime = currentTime;
    //etäisyys millisekunteina eli kauan lento kestää
    this.distance = abs(Math.round(sqrt((this.Dx*this.Dx)+(this.Dy*this.Dy))*this.timeConverter));
    //println("distance:" + this.distance);
    this.moving = true;
    if (gameEngine.getSanta().isHere(x, y)) {
      this.toSanta = true;
    }
  }

  //Tarkistaa osuuko pallo otukseen c
  //Muista huomioida myös etäisyys Santasta
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä
  void checkCollision(Creature c, int currentTime) {  
    // jos pallo lentänyt vaadittavan ajan
    if ((currentTime-this.startTime)>= this.distance) {
      //Atro: Oli pakko tyyppimuuntaa, noi voi vaihtaa myöhemmin takaisin floateiksi
      if (c.checkHit((int)(this.x+(this.size/2)), (int)(this.y+(this.size)/2))) {
        gameEngine.removeCreatures(c);
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
  void checkCollision(Santa santa, int currentTime) {
    if ((currentTime-this.startTime)>= this.distance) {
      if(santa.visible){
       gameEngine.substractLives(1);
       this.moving = false;
       this.Dx = 0;
       this.Dy = 0;
      }
    }
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

