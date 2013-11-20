// Tänne draw() metodi, joka piirtää lopetusnäytön ja ilmoittaa pelaajan pisteet, jotka annetaan konstruktorissa
class EndScreen {
  PImage endscreen_image;
  
  EndScreen() {
    this.endscreen_image = loadImage("end_screen.png");
  }
  
  void draw() {
    image(endscreen_image, 0, 0);
  }
}
