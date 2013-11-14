class Santa{
  boolean visible;
  //Atro: lisäsin tän, kun oli unohtunu
  boolean moving;
  int x, y;
  int size;
  
  public Santa (int x, int y){
    this.x = x;
    this.y = y;
    visible = true;
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
  
  //Atro: Lisäsin ton returnin, jotta saisin tän pyörimään
  boolean isHere(int x, int y){
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
  
  void display(boolean wasPressed, int y, int x){
    
    //Atro: tää on java modelle
    fill(255,0,0);
    rectMode(CORNER);
    if (wasPressed && x > this.x && x < this.x + 40 && y > this.y){
      println("Santaa siirretään");
      rect(this.x, y, 40, -y+this.y+150);
    }
    else{
      rect(this.x, this.y, 40, 150);
    }
    
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
