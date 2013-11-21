class GameEngine {
  // onko tämä sama kuin millis()??
  int runningTime;
  int windowSizeX, windowSizeY;
  int points, lives;
  boolean started, finished;
  SnowBall snowball;
  Game game;
  Santa santa;
  PImage[] creatureImages = { 
      loadImage("creature_bunny.png"), loadImage("creature_chick.png"), loadImage("creature_ghost.png"), loadImage("creature_reindeer.png"), loadImage("creature_snowman.png"), loadImage("creature_witch.png")
    };
  ArrayList<SnowBall> santaSnowBalls;
  ArrayList<SnowBall> creatureSnowBalls;
  ArrayList<SnowBall> snowBallsToRemove;
  //ArrayList<Creature> creatures; // Tää varmaan voisi olla sanakirja, tyyliin slot->creature(t)
  HashMap<Slot, Creature> creaturesMap; // EN tiedä yhtään toimiiko tää
  /* Iterointi onnistuu näin
   for (Object value : map.values()) {
   // ...
   }*/
  GUI gui;
  StartScreen startScreen;
  EndScreen endScreen;

  GameEngine(int lives, Game game) {
    this.lives = lives;
    this.game = game;

    //Santalle annettava myös alhalla olon koordinaatti int downY
    this.santa = new Santa(500, 600, 700);
    santaSnowBalls = new ArrayList<SnowBall>();
    creatureSnowBalls = new ArrayList<SnowBall>();
    snowBallsToRemove = new ArrayList<SnowBall>();
    creaturesMap = new HashMap <Slot, Creature>();
    initializeSlots();
    this.gui = new GUI(this);
    //this.resizeCreatures();
  }
  
  void resizeCreatures(){
      for (PImage p: creatureImages) {
        p.resize(Math.round(p.width*0.1), Math.round(p.height*0.1));
      }
  }

  void initializeSlots() {
    creaturesMap.put(new Slot(50, 400, true), null);
    creaturesMap.put(new Slot(250, 400, true), null);
    creaturesMap.put(new Slot(750, 430, true), null);
    creaturesMap.put(new Slot(650, 290, false), null);
    creaturesMap.put(new Slot(850, 290, false), null);
  }


  void updateGame(int runningTime) {
    //println("UpdateGame: " + runningTime);
    
    // Lauri lisäsi tämän, koska ei päivitetty
    this.runningTime = runningTime;
    moveSnowBalls(runningTime);
    checkCollisions();
    generateCreatures(runningTime);
    generateSnowBalls(runningTime);
    santa.updateCord(runningTime);
    removeSnowBalls();
    gui.display();
    if(this.lives<=0){
     this.game.finished = true; 
    }
    /*for (SnowBall sb: snowBalls){
     sb.display();
     }
     santa.display(mousePressed, mouseY, mouseX);*/
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
    /*Iterator<SnowBall> it = snowBalls.iterator();
    while(it.hasNext()){
      SnowBall sb = it.next();
      for (Creature c : gameEngine.creaturesMap.values()) {
        if (c != null) {
          sb.checkCollision(c, this.runningTime);// ...
        }
      }
      sb.checkCollision(santa, this.runningTime);
    }*/
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

  public void generateCreatures(int runningTime) {
    //Luo satunnaisesti otuksia ennalta määrättyihin slotteihin, mikäli slotissa ei ole vielä otusta
    double tmpTime = 1/Math.pow(runningTime, 0.00125);
    for (Slot slot: creaturesMap.keySet()) {
      double rand = Math.random();
      //println(slot);
      if (creaturesMap.get(slot) == null) {
        if (rand > tmpTime) {
          int randX = (int)(100*Math.random()-50);
          //println("tmpTime: " + tmpTime + ", rand: " + rand);
          creaturesMap.put(slot, new Creature(slot.x + randX, slot.y, 3000, 1500, runningTime, randomCreatureImage(), slot, this));
        }
      }
    }
  }

  public void generateSnowBalls(int runningTime) {
    double tmpTime = 1/Math.pow(runningTime, 0.00125);
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

  public PImage randomCreatureImage() {
    int rand = (int)(6*Math.random());
    return creatureImages[rand];
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

  public void addCreatures(Creature c) {
    creatures.add(c);
  }

  public void setSnowBallToBeRemoved(SnowBall sB) {
    snowBallsToRemove.add(sB);
  }
  
  public void removeSnowBalls(){
    for (SnowBall sb : snowBallsToRemove){
      santaSnowBalls.remove(sb);
      creatureSnowBalls.remove(sb);
    }
    snowBallsToRemove.clear();
  }

  public void removeCreatures(Slot s) {
    // tämän lisättävä myös pisteitä oikean verran, koska snowBall kutsuu tätä kun osuu T. lauri
    creaturesMap.put(s, null);
  }
}

