import java.util.Iterator;
// Tänne draw() metodi, joka parametrina annetun Game attribuutin avulla piirtää kaikki pallot ja otukset
class GUI {

  GameEngine gameEngine;
  PImage backgroundImage;
  PImage backSnow;
  PImage frontSnow;

  public GUI(GameEngine gameEngine) {
    this.gameEngine = gameEngine;
    this.backgroundImage = loadImage("game_screen.png");
    this.backSnow = loadImage("snow_2.png");
    this.frontSnow = loadImage("snow_1.png");
  }
  public void display() {
    // piirtää taustan, takaCreaturet, takaKinos, etuCreaturet, etuKinos, Lumipallot, Santa sekä menun
    imageMode(CORNER);
    image(backgroundImage, 0, 0);
    /*for (Map.Entry<Slot, Creature> entry : gameEngine.creaturesMap.entrySet()) {
      Slot key = entry.getKey();
      Creature value = entry.getValue();
      if (value != null && !key.front){
        value.display(gameEngine.game.runningTime);
      }
      // ...
    }*/
    for (Creature c : gameEngine.creaturesMap.values()) {
      if (c != null && !c.slot.front) {
        c.display(gameEngine.game.runningTime);// ...
      }
    }
    image(backSnow, 0, -100);
    /*for (gameEngine.creaturesMap.Entry<String, Object> entry : gameEngine.creaturesMap.entrySet()) {
      Slot key = entry.getKey();
      Creature value = entry.getValue();
      if (value != null && key.front){
        value.display(gameEngine.game.runningTime);
      }
      // ...
    }*/
    for (Creature c : gameEngine.creaturesMap.values()) {
      if (c != null && c.slot.front) {
        c.display(gameEngine.game.runningTime);// ...
      }
    }
    image(frontSnow, 0, -100);
    imageMode(CENTER);
    for (SnowBall sb : gameEngine.snowBalls) {
      sb.display(millis());
    }
    gameEngine.santa.display();
  }
}

