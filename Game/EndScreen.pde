class EndScreen {
  PImage endscreen_image;
  GameEngine gameEngine;
  PFont font;

  EndScreen(GameEngine gameEngine, PFont font) {
    this.endscreen_image = loadImage("end_screen.png");
    this.gameEngine = gameEngine;
    this.font = font;
  }
  
  void draw() {
    image(endscreen_image, 0, 0);
    textFont(font, 32);
    fill(15, 29, 47);
    stroke(15, 29, 47);
    text(gameEngine.getPoints(), 543, 375);
  }
}
