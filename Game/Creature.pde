class Creature{
  int x, y, timeUp, moveTime, timeCreated, currentY;
  boolean hasThrown, isHit;
  PImage creatureImage;
  GameEngine gameEngine;

  Creature(int x, int y, int timeUp, int moveTime, int timeCreated, GameEngine gameEngine) { // lisää: määrittele kuvan sijainti parametrina
    this.x = x; // haluttu lopullinen kuvan x-koordinaatti, kuvan vasen yläreuna
    this.y = y; // creaturen y-koordinaatti sen ylhäällä ollessa, kuvan vasen yläreuna
    this.currentY = y; // tämänhetkinen y - käytetään creaturen liikkumiseen kummun päälle/taakse
    this.timeUp = timeUp;
    this.moveTime = moveTime;
    this.timeCreated = timeCreated;
    this.hasThrown = false;
    this.isHit = false;
    this.gameEngine = gameEngine;
    this.creatureImage = loadImage("creature.jpg");
    println("UUSI CREATURE LUOTIIN");
  }

  void display(int timeNow) { // draw-metodista kutsutaan kokoajan uudelleen tätä creaturen animaatiometodia, eli timeNow päivittyy kokoajan
  
  // dummy-toteutus, jotta toimii ainakin ylös töksähtäen ja alas töksähtäen 
  // missä suunnassa x ja y suurenee, jotta saa hitboxit toimimaan
  
    // this.y riippuu ajasta. nousee -> timeCreated+moveTime, paikallaan timeCreated+moveTime+timeUp, laskee timeCreated+2*moveTime+timeUp
    // oletus: display-metodia kutsutaan heti, kun creature luotu. eli alussa timeNow = this.timeCreated. muuten pitää muuttaa timeCreated siihen, kun ukkelia aletaan nostaa.
  
    if (timeNow <= this.timeCreated+this.moveTime) this.riseUp(); // tarkistetaan, onko ukkelin aika nousta
    else if (timeNow > this.timeCreated+this.moveTime+this.timeUp && timeNow <= this.timeCreated+(2*this.moveTime)+this.timeUp && !this.isHit) this.goDown(); // tarkistetaan, onko ukkelin aika laskeutua OTA HUOMIOON ETTEI ISHIT
    println("Piirrä Creature: X: " + this.x + ", Y: " + currentY);
    image(this.creatureImage, this.x, this.currentY);
  }

  //Atro: Creaturet heittää Santaa
  void throwSnowBall(Santa santa, int timeThrown) {   // luo uuden lumipallo-olion, joka lähtee kohti creaturea
    new SnowBall(x, y, this.gameEngine).throwBallto(x, y, timeThrown); // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuiko?
    this.hasThrown = true;
  }
  
  void riseUp() {
    // päivitetään currentY:tä jotta pehmeä kuvan liikuttaminen piilosta ylös onnistuu
    this.currentY = this.currentY+this.creatureImage.height-(this.creatureImage.height/this.moveTime).toInt();
  }
  
  void goDown() {
    // päivitetään currentY:tä jotta pehmeä kuvan liikuttaminen ylhäältä piiloon onnistuu
    this.currentY = this.currentY+(this.creatureImage.height/this.moveTime).toInt();
  }
  
  boolean checkHit(int x, int y) {  // tarkistetaan, osuiko annettulla (x,y)-koordinaattiparilla tähän creaturen. = hitbox
    // logiikka hitboxin suurenemisen/pienenemisen kannalta animaation aikana: käytetään kuvan currentY:tä hyväksi
    if (x >= this.x && x <= this.x+this.creatureImage.width && y >= this.currentY && y <= this.y+this.creatureImage.height) {
      this.isHit = true;
      println("osui");
      return true;
    }
    else return false;
  }
  
  boolean hasThrown(){
    return this.hasThrown;
  }
  
}
