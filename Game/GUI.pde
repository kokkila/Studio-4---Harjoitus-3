// Tänne draw() metodi, joka parametrina annetun Game attribuutin avulla piirtää kaikki pallot ja otukset
class GUI{
  
  GameEngine gameEngine;
  PImage backgroundImage;
  
  public GUI(GameEngine gameEngine){
    this.gameEngine = gameEngine;
    this.backgroundImage = loadImage("pohja3.png");
  }
  public void display(){
  // piirtää taustan, takaCreaturet, takaKinos, etuCreaturet, etuKinos, Lumipallot, Santa sekä menun
        imageMode(CORNER);

    image(backgroundImage, 0, 0);
    for (Creature c : gameEngine.creaturesMap.values()) {
      if (c != null){
        c.display(gameEngine.game.runningTime);// ...
      }
    }
    imageMode(CENTER);
    for (SnowBall sb : gameEngine.snowBalls){
      sb.display();
    }
    gameEngine.santa.display();
  }
}
