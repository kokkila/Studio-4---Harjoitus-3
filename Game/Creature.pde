//logiikka: creaturet luodaan vain kerran jokaiselle paikalle
//jos osuu, peliluokka käskee mennä alas (käytetäänkö jotain osumisanimaatiota?
//kun uusi spawnaa, käsketään nousta ylös
PImage creature;

class Creature{
  int x, y, timeUp, moveTime;
  boolean visible; // onko näkyvillä (ylhäällä) vai piilossa (alhaalla)

  Creature(int x, int y) {
    this.x = x;
    this.y = y;
    kuva = kuvatiedosto kansiosta;
  }

  void display() {
    // piirtää x, y -koordinaatteihin kuvat
  }

  void throwSnowBall(Santa santa / Creature c ?){ //luo uuden lumipallo-olion, joka lähtee kohti santaa (creaturea)
    new SnowBall(x, y, koko, nopeus ???).throwBallto(x, y, distance ???);
    // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuko?
  }
  
  void riseUp(peliaika) {
    // pehmeä kuvan liikuttaminen piilosta ylös - huom, pitää olla layereita jonka takaa creature tulee
    //
  }
  
  void goDown() {
    // pehmeä kuvan liikuttaminen ylhäältä piiloon - pitää olla layer jonka alle menee
  }
  
  // metodi, osuiko creatureen. otetaan huomioon this.x, this.y, hitboxina täsät x+kuvankoko, y+kuvankoko ja oliko ylhäällä
  // dummymetodina, kun hitbox tehty, aluksi vaikka println("sprölölölöö") jotta tietää toimiiko
}
