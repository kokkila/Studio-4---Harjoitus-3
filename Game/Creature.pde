// 17.11. poistettu visible-ominaisuus turhana, samoin isHere-metodi koska checkHit ajaa saman asian ja loogisempi nimi


class Creature{
  int x, y, timeUp, moveTime, timeCreated, currentY;
  boolean hasThrown;
  PImage creatureImage;
  GameEngine gameEngine;

  Creature(int x, int y, int timeUp, int moveTime, int timeCreated, GameEngine gameEngine) {
    this.x = x; // haluttu lopullinen kuvan x-koordinaatti
    this.y = y; // creaturen y-koordinaatti sen ylhäällä ollessa
    this.currentY = y; // tämänhetkinen y - käytetään creaturen liikkumiseen kummun päälle/taakse
    this.timeUp = timeUp;
    this.moveTime = moveTime;
    this.timeCreated = timeCreated;
    this.hasThrown = false;
    this.gameEngine = gameEngine;
    this.creatureImage = loadImage("creature.jpg");
    this.creatureImage.resize(100,100);
    //println("UUSI CREATURE LUOTIIN");
  }

  void display(int timeNow) { // draw-metodista kutsutaan kokoajan uudelleen tätä creaturen animaatiometodia, eli timeNow päivittyy kokoajan
    // this.y riippuu ajasta. nousee -> timeCreated+moveTime, paikallaan timeCreated+moveTime+timeUp, laskee timeCreated+2*moveTime+timeUp
    // oletus: display-metodia kutsutaan heti, kun creature luotu. eli alussa timeNow = this.timeCreated. muuten pitää muuttaa timeCreated siihen, kun ukkelia aletaan nostaa.
  
    if (timeNow <= this.timeCreated+this.moveTime) this.riseUp(); // tarkistetaan, onko ukkelin aika nousta
    else if (timeNow > this.timeCreated+this.moveTime+this.timeUp && timeNow <= this.timeCreated+(2*this.moveTime)+this.timeUp) this.goDown(); // tarkistetaan, onko ukkelin aika laskeutua
    //Atro: Tää itse piirto oli unohtunut, joten lisäsin sen
    //println("Piirrä Creature: X: " + this.x + ", Y: " + currentY);
    image(this.creatureImage, this.x, this.currentY);
  }

  //Atro: Creaturet heittää Santaa
  void throwSnowBall(Santa santa, int timeThrown) {   // luo uuden lumipallo-olion, joka lähtee kohti creaturea
    new SnowBall(x, y, this.gameEngine).throwBallto(santa.x, santa.y, timeThrown); // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuiko?
    this.hasThrown = true;
  }
  
  void riseUp() {
    // pehmeä kuvan liikuttaminen piilosta ylös - huom, pitää olla layereita jonka takaa creature tulee
    this.currentY = this.currentY+this.creatureImage.height-(this.creatureImage.height/this.moveTime);
    image(this.creatureImage, this.x, this.currentY); // piirtää ukkelin ajasta riippuvaan paikkaan. HUOM: pitää piirtää taustat vanhan kuvan päälle uusiks. HUOM2: pitääkö pyöristää jakolasku
  }
  
  void goDown() {
    // pehmeä kuvan liikuttaminen ylhäältä piiloon - pitää olla layer jonka alle menee
    this.currentY = this.currentY+this.creatureImage.height/this.moveTime;
    image(this.creatureImage, this.x, this.currentY);
  }
  
  boolean checkHit(int x, int y) {  // tarkistetaan, osuiko annettulla (x,y)-koordinaattiparilla tähän creaturen. = hitbox
    // logiikka hitboxin suurenemisen/pienenemisen kannalta animaation aikana: käytetään kuvan currentY:tä hyväksi
    if (x >= this.x && x <= this.x+this.creatureImage.width && y >= this.currentY && y <= this.y+this.creatureImage.height) return true;
    else return false;
  }
  
  boolean hasThrown(){
    return this.hasThrown;
  }
  
}
