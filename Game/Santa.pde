class Santa {
  // ollaanko näkyvissä vai ei eli voiko santaan osua
  boolean visible;
  // ollaanko liikkeessä
  boolean moving;
  int x, y, height, width;
  // ylä ja ala-asennon koordinaatit
  int upY, downY;
  PImage santaImage;
  // time in millis from down to up/up to down
  float risingTime;
  // milloin liikkuminen aloitettu
  int movingStartTime;
  // kuinka kaukana kosketus oli y koordinaatista
  int fromCenterY;
  // milloin viimeisin siirtyminen tehty
  int timeLastMove;

// luodaan santa jolle annetaan keskipisteen kordinaatit sekä alhaalla olon y-koordinaatti
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

  // päivittää koordinaatit tiedot, eli riittää kun kutsuu sitä 
  // jos hiiri alhaalla siirtää hiiren mukaan 
  // kutsu tätä joka päivityksessä
  void updateCord(int timeNow) {
    if (mouseY > y - height/2 && mouseY <= y + height/2
      && mouseX < x + width && mouseX > x - width && this.y >= upY) {
      if (!moving) {
        fromCenterY = mouseY-this.y;
        this.moving = true;
      }
      this.y = mouseY-fromCenterY;
    }

    if (this.y < upY) {
      this.y = upY;
    }
    else if (this.y > downY) {
      this.y = downY;
    }

    // tarkistetaan ollaanko keskirajan ala vai yläpuolella
    this.checkVisibility();
  }

  // siirätää santaa ylöspäin
  void moveAutom(int timeNow) {
    if (this.y > upY) {
      if (timeNow-timeLastMove> 100) {
        timeLastMove = timeNow;
        // siirtää kolme pikseliä kerralla
        this.y = this.y-3;
      }
      else {
        timeLastMove = timeNow-timeLastMove;
      }
    }
    this.checkVisibility();
  }

// tarkistaa ollaanko näkyvissä eli koordinaattien puolen välin ylä vai alapuolella
  void checkVisibility() {
    if (this.y < ((downY-upY)/2)+upY) {
      this.visible = true;
    }
    else {
      this.visible = false;
    }
  }

// pirtää santan oikeissa koordinaateissa
  void display() {
    image(santaImage, this.x, this.y, this.width, this.height);
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

  void setX(int x) {
    this.x = x;
  }

  void setY(int y) {
    this.y = y;
  }
}

