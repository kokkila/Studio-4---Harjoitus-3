//jos osuu, peliluokka käskee mennä alas (käytetäänkö jotain osumisanimaatiota?
//kun uusi spawnaa, käsketään nousta ylös


class Creature{
  int x, y, timeUp, moveTime, timeCreated;
  boolean visible, hasThrown; // onko näkyvillä = ylhäällä = true vai piilossa = alhaalla = false
  PImage creatureImage;
  GameEngine gameEngine;

  Creature(int x, int y, int timeUp, int moveTime, int timeCreated, GameEngine gameEngine) {  // x ja y halutut lopulliset paikat
    this.x = x;
    this.y = y;
    this.timeUp = timeUp;
    this.moveTime = moveTime;
    this.timeCreated = timeCreated;
    this.visible = false; // oletusarvo. turha?
    this.hasThrown = false;
    this.gameEngine = gameEngine;
    //this.creatureImage = loadImage("tiedostonnimi.png");
    println("UUSI CREATURE LUOTIIN");
  }

  void display(int timeNow) {
    // käyttää timeCreatedia hyväksi "ukkelin nostamiseen"
    // timeCreated+moveTime on aika, kun ukkeli ylhäällä
    // sen jälkeen timeUp paikallaan
    // timeCreated+moveTime+timeUp jälkeen menee alas
    image(this.creatureImage, this.x, this.y); // eli this.y riippuu ajasta, lasketaan ajan perusteella
  }

  //Atro: Creaturet heittää Santaa
  void throwSnowBall(Santa santa, int timeThrown) {   // luo uuden lumipallo-olion, joka lähtee kohti creaturea
    new SnowBall(x, y, 1, this.gameEngine).throwBallto(x, y, timeThrown); // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuiko?
    this.hasThrown = true;
  }
  
  void riseUp() {
    // pehmeä kuvan liikuttaminen piilosta ylös - huom, pitää olla layereita jonka takaa creature tulee
    this.visible = true;
  }
  
  void goDown() {
    // pehmeä kuvan liikuttaminen ylhäältä piiloon - pitää olla layer jonka alle menee
    this.visible = false;  
  }
  
  boolean checkHit(int x, int y) { // tarkistetaan, osuiko annettulla (x,y)-koordinaattiparilla tähän creaturen. käytännössä, osuiko hitboxiin ja oliko creature ylhäällä
    if (this.isHere(x, y) && this.visible) return true;
    else return false;
  }
  
  boolean isHere(int x, int y) {  // metodi jolla tarkistetaan, kuuluuko annettu (x,y)-koordinaattipari kuva-alueelle (hitbox)
    // boksin koko suurenee/pienenee jos ukkeli liikkuu ylös, toteuta logiikka sen perusteella
    if (x >= this.x && x <= this.x+this.creatureImage.width && y >= this.y && y <= this.y+this.creatureImage.height) return true;
    else return false;
  }
  
  boolean hasThrown(){
    return this.hasThrown;
  }
  
}
