// Tänne Draw() metodi, jossa piirretään aloitusnäyttö, ohjeet ja aloitusnappi
// Kun aloitusnappia painetaan, game.setStarted(true);

class StartScreen {
   PImage startscreen_image;
   
   StartScreen() {
     this.startscreen_image = loadImage("start_screen.png");
   }
   
   void draw() {
     image(startscreen_image, 0, 0);
   }

}
