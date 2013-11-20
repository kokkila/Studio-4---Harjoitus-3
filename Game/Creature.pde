class Creature {
  int x, y, timeUp, moveTime, timeCreated;
  float currentY;
  boolean hasThrown, isHit;
  Slot slot;
  PImage creatureImage;
  GameEngine gameEngine;

  Creature(int x, int y, int timeUp, int moveTime, int timeCreated, PImage creatureImage, Slot slot, GameEngine gameEngine) { // lisää: määrittele kuvan sijainti parametrina
    this.x = x; // haluttu lopullinen kuvan x-koordinaatti, kuvan vasen yläreuna
    this.y = y; // creaturen y-koordinaatti sen ylhäällä ollessa, kuvan vasen yläreuna
    this.currentY = y; // tämänhetkinen y - käytetään creaturen liikkumiseen kummun päälle/taakse
    this.timeUp = timeUp;
    this.moveTime = moveTime;
    this.timeCreated = timeCreated;
    this.hasThrown = false;
    this.isHit = false;
    this.slot = slot;
    this.gameEngine = gameEngine;
    this.creatureImage = creatureImage;

    //println("UUSI CREATURE LUOTIIN");
  }

  void display(int timeNow) { // draw-metodista kutsutaan kokoajan uudelleen tätä creaturen animaatiometodia, eli timeNow päivittyy kokoajan

    // dummy-toteutus, jotta toimii ainakin ylös töksähtäen ja alas töksähtäen 
    // missä suunnassa x ja y suurenee, jotta saa hitboxit toimimaan

    // this.y riippuu ajasta. nousee -> timeCreated+moveTime, paikallaan timeCreated+moveTime+timeUp, laskee timeCreated+2*moveTime+timeUp
    // oletus: display-metodia kutsutaan heti, kun creature luotu. eli alussa timeNow = this.timeCreated. muuten pitää muuttaa timeCreated siihen, kun ukkelia aletaan nostaa.

    if (timeNow <= this.timeCreated+this.moveTime) {
      this.riseUp(timeNow);
    }  // tarkistetaan, onko ukkelin aika nousta

    else if (timeNow > this.timeCreated+this.moveTime+this.timeUp && timeNow <= this.timeCreated+(2*this.moveTime)+this.timeUp && !this.isHit) {
      this.goDown(timeNow);
    }  // tarkistetaan, onko ukkelin aika laskeutua OTA HUOMIOON ETTEI ISHIT
    else if(timeNow-timeCreated >= timeUp+2*moveTime) {
      slot.occupied = false;
      gameEngine.removeCreatures(slot);
    }
    //println("Piirrä Creature: X: " + this.x + ", Y: " + currentY);
    image(this.creatureImage, this.x, (int)this.currentY, this.creatureImage.width, this.creatureImage.height);
  }

  //Atro: Creaturet heittää Santaa
  void throwSnowBall(Santa santa, int timeThrown) {   // luo uuden lumipallo-olion, joka lähtee kohti creaturea
    SnowBall sb = new SnowBall(x, y, this.gameEngine);
    sb.throwBallto(santa.x, santa.upY-100, timeThrown); // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuiko?
    gameEngine.addCreatureSnowBalls(sb);
    this.hasThrown = true;
  }

  void riseUp(int timeNow) {

    // päivitetään currentY:tä jotta pehmeä kuvan liikuttaminen piilosta ylös onnistuu
    //println("RiseUp: ");
    //this.currentY = this.currentY-(((float)this.creatureImage.height)/this.moveTime);
    this.currentY = this.y-(((timeNow-this.timeCreated)*this.creatureImage.height)/this.moveTime);
  }

  void goDown(int timeNow) {
    //println("GoDown");
    // päivitetään currentY:tä jotta pehmeä kuvan liikuttaminen ylhäältä piiloon onnistuu
    //this.currentY = this.currentY+(this.creatureImage.height/this.moveTime);
    this.currentY = this.y-this.creatureImage.height+(((timeNow-this.timeCreated-this.timeUp-this.moveTime)*this.creatureImage.height)/this.moveTime);
  }

  boolean checkHit(int x, int y) {  // tarkistetaan, osuiko annettulla (x,y)-koordinaattiparilla tähän creaturen. = hitbox
    // logiikka hitboxin suurenemisen/pienenemisen kannalta animaation aikana: käytetään kuvan currentY:tä hyväksi
    //println("CheckHit: BallX: " + x + ", BallY: " + y + ", thisX: " + this.x + "-" + (this.x+this.creatureImage.width) + ", thisY: " + this.currentY + "-" + (this.y+this.creatureImage.height));
    if (x >= this.x && x <= this.x+this.creatureImage.width && y >= this.currentY && y <= this.y+this.creatureImage.height) {
      this.isHit = true;
      println("OSUI");
      return true;
    }
    else return false;
  }

  boolean canThrow(int timeNow) {
    if (timeNow - timeCreated > moveTime && timeNow - timeCreated < moveTime + timeUp && !hasThrown){
      hasThrown = true;
      return true;
    }
    return false;
  }
}

