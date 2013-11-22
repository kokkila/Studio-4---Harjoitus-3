class SnowBall {
  // onko lumipallo liikkeessä
  boolean moving;
  // heitetäänkö pallo santaa kohti
  boolean toSanta;
  // onko pisteet otettu
  boolean pointsTaken;
  // x ja y mihin pallo piirretään
  int x, y;
  //aloitus pisteet
  int orgX, orgY;
  // muutos Dx ja Dy sekä etäisyys aikana distance
  int Dx, Dy, distance;
  // pallon heittoaika
  int startTime;
  // palllon tuhoutumisaika
  int destroyTime;
  // horisontin koordinaatit
  int horizon;
  // koot
  float size, topSize;
  // nopeudet jolla palloa siirretään: pineneminen ja siirtyminen xy
  float sizeSpeed;
  // muutos luku, jolla akselin koordinaateista tehdään aikaa
  float timeConverter;
  // liikkuvan pallon kuva
  PImage ballPic;
  // tuhoutuneen pallon kuva
  PImage ballSplash;
  GameEngine gameEngine;


  // luo uuden lumipallon, atribuutteina startX ja startY sekä pelimoottori gameEngine
  SnowBall(int startX, int startY, GameEngine gameEngine) {
    this.x = startX;
    this.y = startY;
    this.sizeSpeed = 0.1;
    this.horizon = 180;
    // koko määräytyy y-koordinaatin mukaan
    this.size = Math.round(this.sizeSpeed*this.y);
    this.orgX = startX;
    this.orgY = startY;
    this.timeConverter = 3;
    this.gameEngine = gameEngine;
    this.ballPic=loadImage("snowball.png");
    this.ballSplash = loadImage("splat.png");
    this.pointsTaken = false;
  }

  // piirtää pallon tai sen jättämän jäljen, jos pallo heitettiin santaa kohti ei jälkeä piirretä
  void display(int currentTime, boolean santaBall) {
    if (this.ballPic == this.ballSplash) {
      if (currentTime-destroyTime > 50 || !santaBall) {
        this.gameEngine.setSnowBallToBeRemoved(this);
      }
    }
    image(this.ballPic, this.x, this.y, this.size, this.size);
  }



  // annetaan muuttujaksi kuinka paljon aikaa heitosta kulunut ja lasketaan uusi sijainti sekä pallon koko
  void chanceLoc(int currentTime) {
    if (moving) {
      float timePassed = currentTime - startTime;
      this.setX(this.orgX + Math.round(this.Dx*(timePassed/this.distance)));
      this.setY(this.orgY + Math.round(this.Dy*(timePassed/this.distance)));
      this.setSize(Math.round((this.y-this.horizon)*this.sizeSpeed));      
      if (this.y<this.horizon || (timePassed/this.distance)>1.5) {
        this.gameEngine.setSnowBallToBeRemoved(this);
        destroyBall();
      }
    }
  }

  // mihin pallo heitetään, ja lasketaan kuinka kaukana millisekunteina kohde on 
  void throwBallto(int x, int y, int currentTime) {
    this.startTime = currentTime;
    this.Dx = x-this.x;
    this.Dy = y-this.y; 
    this.distance = abs(Math.round(sqrt((this.Dx*this.Dx)+(this.Dy*this.Dy))*this.timeConverter));
    this.moving = true;
  }

  //Tarkistaa osuuko pallo otukseen c, atribuuttina myös aika
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä
  void checkCollision(Creature c, int currentTime) {  
    // jos pallo lentänyt vaadittavan ajan
    if ((currentTime-this.startTime)>= this.distance) {
      if (c.checkHit(this.x, this.y) && !pointsTaken) {
        this.gameEngine.removeCreatures(c.slot);
        this.gameEngine.addPoints(10);
        this.destroyBall();
        this.pointsTaken = true;
        this.gameEngine.game.splatSound.start();
      }
    }
  }

  //Tarkistaa osuuko pallo santaan
  //Tarvittaessa vähentää elämiä 
  void checkCollision(Santa santa, int currentTime) {
    if ((currentTime-this.startTime)>= this.distance) {
      if (santa.visible && this.orgY<santa.upY-110 && !pointsTaken) {
        this.gameEngine.substractLives(1);
        this.pointsTaken = true;
        this.destroyBall();
        this.gameEngine.game.splatSound.start();
      }
    }
  }

// tuhoaa pallon ja muuttaa pallon kuvaksi pallon jäljen
  void destroyBall() {
    this.moving = false;
    this.destroyTime = millis();
    this.Dx = 0;
    this.Dy = 0;
    this.ballPic = this.ballSplash;
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

