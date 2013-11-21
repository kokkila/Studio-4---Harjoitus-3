class SnowBall {
  boolean moving;
  boolean toSanta;
  boolean pointsTaken;
  // x ja y mihin pallo piirretään
  int x, y;
  //aloitus pisteet
  int orgX, orgY;
  int Dx, Dy, distance;
  int startTime;
  int destroyTime;
  int horizon;
  float size, topSize;

  // nopeudet jolla palloa siirretään: pineneminen ja siirtyminen xy
  float sizeSpeed;
  float timeConverter;
  PImage ballPic;
  PImage ballSplash;
  GameEngine gameEngine;



  SnowBall(int startX, int startY, GameEngine gameEngine) {
    this.x = startX;
    this.y = startY;
    this.sizeSpeed = 0.1;
    this.horizon = 180;
    this.size = Math.round(this.sizeSpeed*this.y);
    this.orgX = startX;
    this.orgY = startY;
    this.timeConverter = 3;
    this.gameEngine = gameEngine;
    this.ballPic=loadImage("snowball.png");
    this.ballSplash = loadImage("splat.png");
    //this.gameEngine.addSnowBalls(this);
    this.pointsTaken = false;
    //println("Uusi pallo luotiin");
  }

  void display(int currentTime) {
    if (this.ballPic == this.ballSplash) {
      if (currentTime-destroyTime > 50) {
        this.gameEngine.setSnowBallToBeRemoved(this);
      }
    }
    image(this.ballPic, this.x, this.y, this.size, this.size);
    //println("snowball x: " + this.x + "  y :" + this.y);
  }



  // annetaan muuttujaksi kuinka paljon aikaa heitosta kulunut ja lasketaan uusi sijainti sekä pallon koko
  // Atro: Pallot ei liiku
  void chanceLoc(int currentTime) {
    //println("current:  " + currentTime + " start: " + startTime + " == timePassed: "); 
    if (moving) {
      float timePassed = currentTime - startTime;
      //println("prosentteja:" + (timePassed/this.distance) + "   timePassed:  " + timePassed + "  thisdistance:  " + this.distance);
      this.setX(this.orgX + Math.round(this.Dx*(timePassed/this.distance)));
      this.setY(this.orgY + Math.round(this.Dy*(timePassed/this.distance)));
      //println("muutos: " + Math.round(this.sizeSpeed*this.y) + "topSIze:" + this.topSize);
      //println("uusi koko: " + (Math.round(this.sizeSpeed*this.y) + this.topSize));
      this.setSize(Math.round((this.y-this.horizon)*this.sizeSpeed));      
      //println("Pallo liikkuu: " + timePassed + "\nX: " + x + " Y: " + y);
      if (this.y<this.horizon || (timePassed/this.distance)>1) {
        destroyBall();
      }
    }
  }

  // mihin pallo heitetään, ja lasketaan kuinka kaukana millisekunteina kohde on 
  void throwBallto(int x, int y, int currentTime) {
    //println("Heita to    x: " + x + "  y: " +y);
    this.startTime = currentTime;
    this.Dx = x-this.x;
    this.Dy = y-this.y; 
    //println("this.x:  " + this.x + "this.y" + this.y);
    //println("Dx:" + this.Dx + "  Dy: " + this.Dy);
    //etäisyys millisekunteina eli kauan lento kestää
    this.distance = abs(Math.round(sqrt((this.Dx*this.Dx)+(this.Dy*this.Dy))*this.timeConverter));
    //println("distance:" + this.distance);
    this.moving = true;
  }

  //Tarkistaa osuuko pallo otukseen c
  //Muista huomioida myös etäisyys Santasta
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä

  //POISTA ITSESI LISTASTA
  void checkCollision(Creature c, int currentTime) {  
    // jos pallo lentänyt vaadittavan ajan
    //println("CT - sT: " + (currentTime-this.startTime) + ", d: " + this.distance);
    if ((currentTime-this.startTime)>= this.distance) {
      //println("TRUE");

      //Atro: Oli pakko tyyppimuuntaa, noi voi vaihtaa myöhemmin takaisin floateiksi
      if (c.checkHit(this.x, this.y) && !pointsTaken) {
        this.gameEngine.removeCreatures(c.slot);
        this.gameEngine.addPoints(10);
        this.destroyBall();
        this.pointsTaken = true;
      }
      else {
        //println("Ball missed all targets");
      }
    }
  }

  //Tarkistaa osuuko pallo santaan
  //Tarvittaessa vähentää elämiä
  // POISTA ITSESTI LISTASTA
  void checkCollision(Santa santa, int currentTime) {
    if ((currentTime-this.startTime)>= this.distance) {
      println("santa visi: " + santa.visible);
      if (santa.visible && this.orgY<santa.upY-110 && !pointsTaken) {
        this.gameEngine.substractLives(1);
        this.pointsTaken = true;
        destroyBall();
      }
    }
  }

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

