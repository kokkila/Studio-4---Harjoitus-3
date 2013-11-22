
//GameEngine-luokan tehtävä on pyörittää peliä
class GameEngine {
  int runningTime;
  //int windowSizeX, windowSizeY;
  int points, lives;
  boolean started, finished;
  Game game;
  Santa santa;
  
  //Eri kuvat takana ja edessä oleville vihollisille
  PImage[] frontCreatureImages = { 
    loadImage("creature_bunny_100.png"), loadImage("creature_chick_100.png"), loadImage("creature_ghost_100.png"), loadImage("creature_reindeer_100.png"), loadImage("creature_snowman_100.png"), loadImage("creature_witch_100.png")
  };
  PImage[] backCreatureImages = { 
    loadImage("creature_bunny.png"), loadImage("creature_chick.png"), loadImage("creature_ghost.png"), loadImage("creature_reindeer.png"), loadImage("creature_snowman.png"), loadImage("creature_witch.png")
  };
  
  //Pukin ja otusten heittämät pallot eroteltu, jotta pukki ei voisi heittää itseään
  ArrayList<SnowBall> santaSnowBalls;
  ArrayList<SnowBall> creatureSnowBalls;
  
  //Lista, joka pitää kirjaa poistettavista lumipalloista.
  ArrayList<SnowBall> snowBallsToRemove;
  HashMap<Slot, Creature> creaturesMap;
  GUI gui;
  StartScreen startScreen;
  EndScreen endScreen;

  GameEngine(int lives, Game game) {
    this.lives = lives;
    this.game = game;
    this.santa = new Santa(500, 550, 650);
    santaSnowBalls = new ArrayList<SnowBall>();
    creatureSnowBalls = new ArrayList<SnowBall>();
    snowBallsToRemove = new ArrayList<SnowBall>();
    creaturesMap = new HashMap <Slot, Creature>();
    initializeSlots();
    this.gui = new GUI(this);
  }

  //Metodi
  void initializeSlots() {
    creaturesMap.put(new Slot(60, 400, true), null);
    creaturesMap.put(new Slot(250, 400, true), null);
    creaturesMap.put(new Slot(750, 440, true), null);
    creaturesMap.put(new Slot(650, 290, false), null);
    creaturesMap.put(new Slot(850, 280, false), null);
  }


  void updateGame(int runningTime) {

    this.runningTime = runningTime;
    moveSnowBalls(runningTime);
    checkCollisions();
    generateCreatures(runningTime);
    generateSnowBalls(runningTime);
    santa.updateCord(runningTime);
    removeSnowBalls();
    gui.display();
    if (this.lives<=0) {
      this.game.finished = true;
    }
  }

  public void moveSnowBalls(int runningTime) {
    for (SnowBall sb: santaSnowBalls) {
      sb.chanceLoc(runningTime);
    }
    for (SnowBall sb: creatureSnowBalls) {
      sb.chanceLoc(runningTime);
    }
  }

  public void checkCollisions() {

    for (SnowBall sb: santaSnowBalls) {
      for (Creature c : gameEngine.creaturesMap.values()) {
        if (c != null) {
          sb.checkCollision(c, this.runningTime);// ...
        }
      }
    }
    for (SnowBall sb: creatureSnowBalls) {
      sb.checkCollision(santa, this.runningTime);
    }
  }

  //Luo uusia olioita vapaisiin paikkoihin
  //Olioiden luomisnopeus ja muut ominaisuudet muuttuvat ajan myötä, jotta peli vaikeutuisi koko ajan
  public void generateCreatures(int runningTime) {

    double tmpTime = 1/Math.pow(runningTime+2000, 0.0003);
    for (Slot slot: creaturesMap.keySet()) {
      double rand = Math.random();
      if (creaturesMap.get(slot) == null) {
        if (rand > tmpTime) {
          int randX = (int)(100*Math.random()-50);
          int maxThrows = (int)Math.round(Math.random() * (6-6.5/Math.pow(runningTime, 0.04)));
          int upTime = (int)(3000*Math.pow(tmpTime, 10));
          int moveTime = (int)(700*Math.pow(tmpTime, 10));
          PImage creatureImage = randomCreatureImage(slot.front);
          creaturesMap.put(slot, new Creature(slot.x + randX, slot.y, upTime, moveTime, runningTime, maxThrows, creatureImage, slot, this));
        }
      }
    }
  }

  //Pistää oliot heittämään lumipalloja pukkia päin
  public void generateSnowBalls(int runningTime) {
    double tmpTime = 1/Math.pow(runningTime, 0.001);
    for (Object value : creaturesMap.values()) {
      if (value != null) {
        Creature creature = (Creature)value;
        double rand = Math.random();
        if (rand > tmpTime && creature.canThrow(runningTime)) {
          creature.throwSnowBall(this.santa, this.runningTime);
        }
      }
    }
  }

  //Palauttaa satunnaisen oliokuvan
  public PImage randomCreatureImage(boolean frontOrBack) {
    int rand = (int)(6*Math.random());
    if (frontOrBack) {
      return frontCreatureImages[rand];
    }
    return backCreatureImages[rand];
  }
  
  public void setStarted(Boolean started) {
    this.started = started;
  }

  public void setFinished(Boolean finished) {
    this.finished = finished;
  }

  public int getLives() {
    return lives;
  }

  public int getPoints() {
    return points;
  }

  public Santa getSanta() {
    return this.santa;
  }

  public void substractLives(int i) {
    this.lives = this.lives - i;
  }

  public void addPoints(int i) {
    this.points = this.points + i;
  }

  public void addSantaSnowBalls(SnowBall sB) {
    santaSnowBalls.add(sB);
  }

  public void addCreatureSnowBalls(SnowBall sB) {
    creatureSnowBalls.add(sB);
  }

  public void setSnowBallToBeRemoved(SnowBall sB) {
    snowBallsToRemove.add(sB);
  }

  //Poistaa pelistä pallot, jotka ovat jo osuneet tai karanneet liian kauaksi ja tyhjentää listan
  public void removeSnowBalls() {
    for (SnowBall sb : snowBallsToRemove) {
      santaSnowBalls.remove(sb);
      creatureSnowBalls.remove(sb);
    }
    snowBallsToRemove.clear();
  }

  public void removeCreatures(Slot s) {
    creaturesMap.put(s, null);
  }
}

