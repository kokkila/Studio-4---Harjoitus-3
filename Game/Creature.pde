//jos osuu, peliluokka käskee mennä alas (käytetäänkö jotain osumisanimaatiota?
//kun uusi spawnaa, käsketään nousta ylös


class Creature{
  int x, y, timeUp, moveTime, timeCreated;
  boolean visible; // onko näkyvillä = ylhäällä = true vai piilossa = alhaalla = false
  PImage creatureImage;

  Creature(int x, int y, int timeUp, int moveTime, int timeCreated) {  // x ja y halutut lopulliset paikat
    this.x = x;
    this.y = y;
    this.visible = false; // oletusarvo. turha?
    this.creatureImage = loadImage("tiedostonnimi.png");
  }

  void display(int timeNow) {
    // käyttää timeCreatedia hyväksi "ukkelin nostamiseen"
    // timeCreated+moveTime on aika, kun ukkeli ylhäällä
    // sen jälkeen timeUp paikallaan
    // timeCreated+moveTime+timeUp jälkeen menee alas
    image(this.creatureImage, this.x, this.y); // eli this.y riippuu ajasta, lasketaan ajan perusteella
  }

  void throwSnowBall(Creature anotherCreature) {   // luo uuden lumipallo-olion, joka lähtee kohti creaturea
    new SnowBall(x, y).throwBallto(x, y); // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuiko?
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
  
}
