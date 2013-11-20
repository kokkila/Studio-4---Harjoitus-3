class Menu {
  PImage heart_image;
  Game game;
  int x;
  int y;
  int image_width;
  
  Menu(Game game) {
    this.game = game;
    this.heart_image = loadImage("heart.png");
    this.x = 20;
    this.y = 20;
    this.image_width = 30;
  }
  
  void draw() {
    int i = 0;
    int hearts = this.game.getLives();
    while (i < hearts) {
      image(heart_image, this.x + (i*30), this.y);
      i += 1;
    }
  }
}
