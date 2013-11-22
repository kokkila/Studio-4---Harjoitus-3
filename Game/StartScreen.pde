class StartScreen {
   PImage startscreen_image;
   Game game;
   
   StartScreen(Game game) {
     this.startscreen_image = loadImage("start_screen.png");
     this.game = game;
   }
   
   void draw() {
     image(startscreen_image, 0, 0);
   }

}
