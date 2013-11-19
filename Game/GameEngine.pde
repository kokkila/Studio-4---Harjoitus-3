class GameEngine{
  int runningTime;
  int windowSizeX, windowSizeY;
  int points, lives;
  boolean started, finished;
  SnowBall snowball;
  Game game;
  Santa santa;
  ArrayList<SnowBall> snowBalls;
  //ArrayList<Creature> creatures; // Tää varmaan voisi olla sanakirja, tyyliin slot->creature(t)
  HashMap<Slot, Creature> creaturesMap; // EN tiedä yhtään toimiiko tää
  /* Iterointi onnistuu näin
  for (Object value : map.values()) {
      // ...
  }*/
  GUI gui;
  StartScreen startScreen;
  EndScreen endScreen;
  
  GameEngine(int lives, Game game){
    this.lives = lives;
    this.game = game;
    
    //Santalle annettava myös alhalla olon koordinaatti int downY
    this.santa = new Santa(180, 500, 550);
    snowBalls = new ArrayList<SnowBall>();
    creaturesMap = new HashMap <Slot, Creature>();
    initializeSlots();
    this.gui = new GUI(this);
  }
  
  void initializeSlots(){
    creaturesMap.put(new Slot(50, 200), null);
    //creaturesMap.put(new Slot(250, 200), null);
    //creaturesMap.put(new Slot(450, 200), null);
    //creaturesMap.put(new Slot(150, 400), null);
    //creaturesMap.put(new Slot(350, 400), null);
  }
    
  
  void updateGame(int runningTime){
    //println("UpdateGame: " + runningTime);
    moveSnowBalls(runningTime);
    //checkCollisions();
    generateCreatures(runningTime);
    generateSnowBalls(runningTime);
    santa.updateCord(runningTime);
    gui.display();
    /*for (SnowBall sb: snowBalls){
      sb.display();
    }
    santa.display(mousePressed, mouseY, mouseX);*/
  }
  
  public void moveSnowBalls(int runningTime){
    for (SnowBall sb: snowBalls){
      sb.chanceLoc(runningTime);
    }
  }
  
  public void checkCollisions(){
    for (SnowBall sb: snowBalls){
       for (Creature c: creatures){
         sb.checkCollision(c, this.runningTime);
         //sb.checkCollision(santa);
       }
    }
  }
  
  public void generateCreatures(int runningTime){
    //Luo satunnaisesti otuksia ennalta määrättyihin slotteihin, mikäli slotissa ei ole vielä otusta
    double rand = Math.random();
    double tmpTime = 1/Math.pow(runningTime, 0.00125);
    for (Slot slot: creaturesMap.keySet()){
      //println(slot);
      if (creaturesMap.get(slot) == null){
        if (rand > tmpTime){
          creaturesMap.put(slot, new Creature(slot.x, slot.y, 3000, 1500, runningTime, this));
        }
      }
    }
  }
  
  public void generateSnowBalls(int runningTime){
    double rand = Math.random();
    double tmpTime = 1/Math.pow(runningTime, 0.00125);
    for (Object value : creaturesMap.values()) {
      if (value != null){
        Creature creature = (Creature)value;
        if (rand > tmpTime && !creature.hasThrown()){
          creature.throwSnowBall(this.santa, this.runningTime);
        }
      }  
    }
  }
  
  public void setStarted(Boolean started){
    this.started = started;
  }
  
  public void setFinished(Boolean finished){
    this.finished = finished;
  }
  
  public int getLives(){
    return lives;
  }
  
  public int getPoints(){
    return points;
  }
  
  public Santa getSanta(){
    return this.santa;
  }
  
  public void substractLives(int i){
    this.lives = this.lives - i;
  }
  
  public void addPoints(int i){
    this.points = this.points + i;
  }
  
  public void addSnowBalls(SnowBall sB){
    snowBalls.add(sB);
  }
  
  public void addCreatures(Creature c){
    creatures.add(c);
  }
  
  public void removeSnowBalls(SnowBall sB){
    snowBalls.remove(sB);
  }
  
  public void removeCreatures(Creature c){
    // tämän lisättävä myös pisteitä oikean verran, koska snowBall kutsuu tätä kun osuu T. lauri
    creatures.remove(c);
  }
  
}
