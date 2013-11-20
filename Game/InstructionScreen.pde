class InstructionScreen {
   PImage instruction_image;
   Game game;
   
   InstructionScreen(Game game) {
     this.instruction_image = loadImage("instruction_screen.png");
     this.game = game;
   }
   
   void draw() {
     image(instruction_image, 0, 0);
   }

}
