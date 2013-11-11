//logiikka: creaturet luodaan vain kerran jokaiselle paikalle
//jos osuu, peliluokka käskee mennä alas (käytetäänkö jotain osumisanimaatiota?
//kun uusi spawnaa, käsketään nousta ylös

class Creature{
  int x, y;
  boolean visible; // onko näkyvillä (ylhäällä) vai piilossa (alhaalla)

  Creature(int x, int y) {
    this.x = x
    this.y = y
    // + etäisyys santasta?
  }


  void throwSnowBall(Santa santa){ //luo uuden lumipallo-olion, joka lähtee kohti santaa
    new SnowBall(x, y, koko, nopeus ???).throwBallto(x, y, distance ???);
    // tallennetaanko johonkin listaan, jotta voidaan tarkistaa osuko?
  }
  
  void riseUp() {
    // pehmeä kuvan liikuttaminen piilosta ylös - huom, pitää olla layereita jonka takaa creature tulee
  }
  
  void goDown() {
    // pehmeä kuvan liikuttaminen ylhäältä piiloon - pitää olla layer jonka alle menee
  }
  
  // metodi, osuiko creatureen. otetaan huomioon this.x, this.y, hitboxina täsät x+kuvankoko, y+kuvankoko ja oliko ylhäällä
  // dummymetodina, kun hitbox tehty, aluksi vaikka println("sprölölölöö") jotta tietää toimiiko
}
