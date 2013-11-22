class GUI {

  GameEngine gameEngine;
  PImage backgroundImage;
  PImage backSnow;
  PImage frontSnow;
  PImage santaSnow;

  public GUI(GameEngine gameEngine) {
    this.gameEngine = gameEngine;
    this.backgroundImage = loadImage("game_screen.png");
    this.backSnow = loadImage("snow_2.png");
    this.frontSnow = loadImage("snow_1.png");
    this.santaSnow = loadImage("snow_3.png");
  }
  public void display() {
    imageMode(CORNER);
    image(backgroundImage, 0, 0);
    for (Creature c : gameEngine.creaturesMap.values()) {
      if (c != null && !c.slot.front) {
        c.display(gameEngine.game.runningTime);// ...
      }
    }
    image(backSnow, 0, -100);
    for (Creature c : gameEngine.creaturesMap.values()) {
      if (c != null && c.slot.front) {
        c.display(gameEngine.game.runningTime);// ...
      }
    }
    image(frontSnow, 0, -100);
    imageMode(CENTER);
    for (SnowBall sb : gameEngine.santaSnowBalls) {
      sb.display(millis(), true);
    }
    for (SnowBall sb : gameEngine.creatureSnowBalls) {
      sb.display(millis(), false);
    }
    imageMode(CORNER);
    image(this.santaSnow, 0, -30);
    imageMode(CENTER);
    gameEngine.santa.display();
  }
}

