class Creature {
  int x, y, timeUp, moveTime, timeCreated, maxThrows, throwedBalls;
  float currentY;
  boolean isHit;
  Slot slot;
  PImage creatureImage;
  GameEngine gameEngine;

  Creature(int x, int y, int timeUp, int moveTime, int timeCreated, int maxThrows, PImage creatureImage, Slot slot, GameEngine gameEngine) {
    this.x = x; // haluttu lopullinen kuvan x-koordinaatti, kuvan vasen yläreuna
    this.y = y; // creaturen y-koordinaatti sen ylhäällä ollessa, kuvan vasen yläreuna
    this.currentY = y; // tämänhetkinen y - käytetään creaturen liikkumiseen kummun päälle/taakse
    this.timeUp = timeUp; // kuinka kauan creature on ylhäällä
    this.moveTime = moveTime; // kuinka kauan creaturen nouseminen ja laskeminen kestää
    this.timeCreated = timeCreated;
    this.throwedBalls = 0;
    this.maxThrows = maxThrows;
    this.isHit = false;
    this.slot = slot;
    this.gameEngine = gameEngine;
    this.creatureImage = creatureImage;
  }

  void display(int timeNow) { // draw-metodista kutsutaan kokoajan uudelleen tätä creaturen animaatiometodia, eli timeNow päivittyy kokoajan
    // nousee: timeCreated+moveTime, paikallaan: timeCreated+moveTime+timeUp, laskee: timeCreated+2*moveTime+timeUp
    if (timeNow <= this.timeCreated+this.moveTime) {
      this.riseUp(timeNow);
    }  // tarkistetaan, onko ukkelin aika nousta
    else if (timeNow > this.timeCreated+this.moveTime+this.timeUp && timeNow <= this.timeCreated+(2*this.moveTime)+this.timeUp && !this.isHit) {
      this.goDown(timeNow);
    }  // tarkistetaan, onko ukkelin aika laskeutua
    else if(timeNow-timeCreated >= timeUp+2*moveTime) {
      slot.occupied = false;
      gameEngine.removeCreatures(slot);
    }
    image(this.creatureImage, this.x, (int)this.currentY, this.creatureImage.width, this.creatureImage.height); // piirretään creature nykyiseen paikkaan
  }

  void throwSnowBall(Santa santa, int timeThrown) {   // luo uuden lumipallo-olion, joka lähtee kohti creaturea
    SnowBall sb = new SnowBall(x, y, this.gameEngine);
    sb.throwBallto(santa.x, santa.upY-100, timeThrown);
    gameEngine.addCreatureSnowBalls(sb);
    this.throwedBalls++;
  }

  void riseUp(int timeNow) {
    // päivitetään currentY:tä jotta pehmeä kuvan liikuttaminen piilosta ylös onnistuu
    this.currentY = this.y-(((timeNow-this.timeCreated)*this.creatureImage.height)/this.moveTime);
  }

  void goDown(int timeNow) {
    // päivitetään currentY:tä jotta pehmeä kuvan liikuttaminen ylhäältä piiloon onnistuu
    this.currentY = this.y-this.creatureImage.height+(((timeNow-this.timeCreated-this.timeUp-this.moveTime)*this.creatureImage.height)/this.moveTime);
  }

  boolean checkHit(int x, int y) {  // tarkistetaan, osuiko annettulla (x,y)-koordinaattiparilla tähän creaturen. = hitbox
    // käytetään kuvan currentY:tä hyväksi, jotta pystytään laskemaan oikean kokoinen hitbox silloinkin kun creature nousee tai laskee
    if (x >= this.x && x <= this.x+this.creatureImage.width && y >= this.currentY && y <= this.y+this.creatureImage.height) {
      this.isHit = true;
      return true;
    }
    else return false;
  }

  boolean canThrow(int timeNow) {
    if (timeNow - timeCreated > moveTime && timeNow - timeCreated < moveTime + timeUp && throwedBalls < maxThrows) {
      return true;
    }
    return false;
  }
}

