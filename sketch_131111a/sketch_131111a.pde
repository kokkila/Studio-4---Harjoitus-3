class SnowBall {
  boolean moving;
  int x, y;
  int Dx, Dy;
  int startTime;
  float size;
  
  // nopeudet jolla palloa siirretään: pineneminen ja siirtyminen xy
  float sizeSpeed;
  float xySpeed;


  SnowBall(int startX, int startY, float size) {
    this.x = startX;
    this.y = startY;
    this.size = size;
    this.xySpeed = 0.000015;
    this.sizeSpeed = -0.0000007;
 

  }

  // annetaan muuttujaksi kuinka paljon aikaa heitosta kulunut ja lasketaan uusi sijainti sekä pallon koko
  void chanceLoc(int currentTime) {
    int timePassed = currentTime - startTime;
    if (this.Dx == 0 || this.Dy== 0) {
      println("ERROR: SnowBall Dx or Dy is 0!!");
    }
    this.x = this.x + Math.round(this.Dx*timePassed*this.xySpeed);
    this.y = this.y + Math.round(this.Dy*timePassed*this.xySpeed);
    this.size= this.size - Math.round(this.Dy*timePassed*this.sizeSpeed);
  }
  
  // mihin pallo heitetään, ja kuinka paljon piennetään -> logiikkaa mietittävä, jos lasketaankin y:n arvosta pienentäminen
  void throwBallto(int x, int y, int startTime){
    this.Dx = x-this.x;
    this.Dy = y-this.y;
    this.startTime = startTime;
    this.moving = true;
    
  }
  
  //Tarkistaa osuuko pallo otukseen c
  //Muista huomioida myös etäisyys Santasta
  //Tarvittaessa muuttaa pisteitä ja poistaa creaturen pelistä
//  void checkCollision(Creature c){
//      
//  }
//  
//  //Tarkistaa osuuko pallo santaan
//  //Tarvittaessa vähentää elämiä
//  void checkCollision(Santa santa){
//      
//  }
  
  int getX(){
    return this.x;
  }
  int getY(){
    return this.y;
  }
  boolean isMoving(){
    return moving;
  }
  
  void setX(int x){
    this.x = x;
  }
  
  void setY(int y){
    this.y = y;
  }
  
  void setMoving(boolean moving){
    this.moving = moving;
  }
  
  
  
}

