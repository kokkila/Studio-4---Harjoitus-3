// Tänne Draw() metodi, jossa piirretään aloitusnäyttö, ohjeet ja aloitusnappi
// Kun aloitusnappia painetaan, game.setStarted(true);

class StartScreen {
   PImage startscreen_image;
   Game game;
   //int start_x1, start_x2, start_y1, start_y2;
   
   StartScreen(Game game) {
     this.startscreen_image = loadImage("start_screen.png");
     /*this.start_x1 = 480;
     this.start_x2 = 685;
     this.start_y1 = 355;
     this.start_y2 = 475;*/
     this.game = game;
   }
   
   void draw() {
     image(startscreen_image, 0, 0);
   }
   
   /*void mousePressed(){
     if (mouseX > this.start_x1 && mouseX < this.start_x2 && mouseY > this.start_y1 && mouseY < this.start_y2) {
       this.game.setStarted();
       println("menee tanne");
  }
}*/

}
