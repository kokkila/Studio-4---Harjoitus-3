class Santa {
  boolean visible;
  boolean moving;  
  int x, y;
  int upY;
  PImage santaImage;
  // time in millis from down to up/up to down
  float risingTime;
  int movingStartTime;

  public Santa (int x, int y, PImage santaImage) {
    this.x = x;
    this.y = y;
    this.upY = y;
    this.santaImage = santaImage;
  }

  // display päivittää koordinaatit tiedot, eli riittää kun kutsuu sitä
  display(int timeNow) {
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

  void move(boolean up, int timeNow) {
    this.moving = true;
    this.movingStartTime = timeNow;
    if (up) {
      this.risingTime = this.risingTime * ((this.y - this.upY)/santaImage.height)
        this.visible = true;
    }
    else {
      this.risingTime = this.risingTime * (((this.upY+santaImge.height)-this.y)/santaImage.height)
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
    if (x >= this.x && x <= this.x+this.santaImage.width && y >= this.y && y <= this.y+this.santaImage.height && visible) return true;
    else return false;
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
}

