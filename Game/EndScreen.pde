// Tänne draw() metodi, joka piirtää lopetusnäytön ja ilmoittaa pelaajan pisteet, jotka annetaan konstruktorissa
class EndScreen {
  PImage endscreen_image;
  GameEngine gameEngine;
  
  EndScreen(GameEngine gameEngine) {
    this.endscreen_image = loadImage("end_screen.png");
    this.gameEngine = gameEngine;
  }
  
  void draw() {
    image(endscreen_image, 0, 0);
    text(gameEngine.getPoints(), 600, 500);
  }
}
