class Santa {
  boolean visible;
  boolean moving;
  int x, y, height, width;
  int upY, downY;
  PImage santaImage;
  // time in millis from down to up/up to down
  float risingTime;
  int movingStartTime;
  int fromCenterY;
  int currentY;
  int timeLastMove;


  public Santa (int x, int y, int downY) {
    this.x = x;
    this.y = y;
    this.upY = y;
    this.downY = downY;
    this.timeLastMove = 0;
    this.santaImage = loadImage("santa.png");
    this.width = 150;
    this.height = 301;
  }

  //
  //void followMouse(boolean up, int timeNow) {
  //    this.moving = true;
  //    this.movingStartTime = timeNow;
  //    if (up) {
  //      this.risingTime = this.risingTime * ((this.y - this.upY)/santaImage.height);
  //      this.visible = true;
  //    }
  //    else {
  //      this.risingTime = this.risingTime * (((this.upY+santaImage.height)-this.y)/santaImage.height);
  //      this.visible = false;
  //    }
  //  }

  int getX() {
    return this.x;
  }
  int getY() {
    return this.y;
  }
  boolean isVisible() {
    return visible;
  }

  void setX(int x) {
    this.x = x;
  }

  void setY(int y) {
    this.y = y;
  }

  // mouse start moving
  // tarkistaa kuinka kaukaa kulmasta kuvasta tartuttiin 



  // päivittää koordinaatit tiedot, eli riittää kun kutsuu sitä 
  // siirätää ylöspäin tai alaspäin riippuen onko yli puolen välin
  // jos hiiri alhaalla siirtää hiiren mukaan 
  // mouseDown = true == sormi alhaalle
  // kutsu tätä joka päivityksessä
  void updateCord(int timeNow) {
    //println("upY: " + upY + ", height: " + height/2);
    if (mouseY > y - height/2 && mouseY <= y + height/2
      && mouseX < x + width && mouseX > x - width && this.y >= upY) {
      if (!moving) {
        //println("!moving");
        fromCenterY = mouseY-this.y;
        this.moving = true;
      }
      this.y = mouseY-fromCenterY;
    }
    else {
      if (this.y < upY) {
        this.y = upY;
      }
      if (this.y > downY) {
        this.y = downY;
      }
    }
    // tarkistetaan ollaanko keskirajan ala vai yläpuolella
    this.checkVisibility();
  }

  void moveAutom(int timeNow) {
    if (this.y > upY) {
      if (timeNow-timeLastMove> 100) {
        timeLastMove = timeNow;
        // jos ollaan ylhäällä, liikutaan ylös
        this.y = this.y-1;
      }
      else {
        timeLastMove = timeNow-timeLastMove;
      }
    }
    this.checkVisibility();
  }

  /*void updateCord(int timeNow){
   if (mousePressed){
   if (mouseY > y && mouseY < y + height){
   currentY = mouseY;
   }
   }
   else{
   if (currentY < downY){
   currentY = y;
   }
   else{
   currentY = downY;
   }
   }
   }*/

  void checkVisibility() {
    if (this.y < ((downY-upY)/2)+upY) {
      this.visible = true;
    }
    else {
      this.visible = false;
    }
  }


  //    // kutsu mousePressed
  //    if (moving) {
  //      if (visible) {
  //        timeOnMove = timeNow-movingStartTime;
  //      }
  //      else {
  //        timeOnMove = -(timeNow-movingStartTime);
  //      }
  //      // Jos liike on lopussa
  //      if (abs(timeOnMove)>=1) {
  //        moving = false;
  //      }
  //      else {
  //        this.y = this.y + Math.round((timeOnMove/risingTime)*santaImage.height);
  //      }


  void display() {
    image(santaImage, this.x, this.y, this.width, this.height);
    //image(santaImage, x, currentY+height/2, 200, 200);

    // lauri: updateCord(timeNow);

    //fill(255, 0, 0);
    //rectMode(CORNER);
    //  if (moving) {
    //    //println("drawMoving");
    //    rect(this.x, this.y+50, 40, 100);
    //  }
    //  else if (visible) {
    //    //println("drawVisible");
    //    rect(this.x, this.y, 40, 150);
    //  }
    //  else {
    //    //println("drawHidden");
    //    rect(this.x, this.y+100, 40, 50);
    //  }
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

