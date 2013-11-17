class Santa {
  boolean visible;
   boolean moving;  
  int x, y;
  int upY;
  PImage santaImage;
  // time in millis from down to up/up to down
  float risingTime;
  int movingStartTime;

  public Santa (int x, int y) {
    this.x = x;
    this.y = y;
    this.upY = y;
    //this.santaImage = loadImage("santa.png");
  }


  void move(boolean up, int timeNow) {
    this.moving = true;
    this.movingStartTime = timeNow;
    if (up) {
      this.risingTime = this.risingTime * ((this.y - this.upY)/santaImage.height);
        this.visible = true;
    }
    else {
      this.risingTime = this.risingTime * (((this.upY+santaImage.height)-this.y)/santaImage.height);
        this.visible = false;
    }
  }


  int getX() {
    return this.x;
  }
  int getY() {
    return this.y;
  }
  boolean isVisible() {
    return visible;
  }

  boolean isHere(int x, int y) {
    return true;
  }

  void setX(int x) {
    this.x = x;
  }

  void setY(int y) {
    this.y = y;
  }

  void setMoving(boolean visible) {
    this.moving = visible;
  }
  
   //päivittää koordinaatit tiedot, eli riittää kun kutsuu sitä
 void updateCord(int timeNow) {
    int timeOnMove;
    if (moving) {
      if (visible) {
        timeOnMove = timeNow-movingStartTime;
      }
      else {
        timeOnMove = -(timeNow-movingStartTime);
      }
      // Jos liike on lopussa
      if (abs(timeOnMove)>=1) {
        moving = false;
      }
      else {
        this.y = this.y + Math.round((timeOnMove/risingTime)*santaImage.height);
      }
    }
  }

  void display(boolean wasPressed, int y, int x) {
    // lauri: updateCord(timeNow);

    fill(255, 0, 0);
    rectMode(CORNER);
    if (moving) {
      //println("drawMoving");
      rect(this.x, this.y+50, 40, 100);
    }
    else if (visible) {
      //println("drawVisible");
      rect(this.x, this.y, 40, 150);
    }
    else {
      //println("drawHidden");
      rect(this.x, this.y+100, 40, 50);
    }
    /*//Atro: tää on java modelle
     fill(255,0,0);
     rectMode(CORNER);
     if (wasPressed && x > this.x && x < this.x + 40 && y > this.y){
     println("Santaa siirretään");
     rect(this.x, y, 40, -y+this.y+150);
     }
     else{
     rect(this.x, this.y, 40, 150);
     }*/

    //Atro: tän pitäisi toimia Android Modessa. Siinä menee toi koordinaatisto ihan sekaisin
    /*fill(255,0,0);
     rectMode(CORNER);
     if (mousePressed && x > game.width*0.45 && x < game.width*0.55 && y < game.height*0.30){
     rect(game.height*0.10, game.width*0.45, y-game.height*0.10, game.width*0.10);
     }
     else{
     rect(game.height*0.10, game.width*0.45, game.height*0.20, game.width*0.10);
     }*/
  }
  
 
}

