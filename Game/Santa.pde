class Santa{
  boolean visible;
  int x, y;
  
  public Santa (){

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

  void setMoving(boolean visible) {
    this.moving = visible;
  }
}
