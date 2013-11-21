class Menu {
  PImage heart_image;
  GameEngine gameEngine;
  int x;
  int y;
  int image_width;
  
  Menu(GameEngine gameEngine) {
    this.gameEngine = gameEngine;
    this.heart_image = loadImage("heart.png");
    this.x = 20;
    this.y = 20;
    this.image_width = 30;
  }
  
  void draw() {
    int i = 0;
    int hearts = this.gameEngine.getLives();
    while (i < hearts) {
      image(heart_image, this.x + (i*30), this.y);
      i += 1;
    }
    stroke(255);
    text("Points: " + this.gameEngine.getPoints(), 800, 20);
  }
}
