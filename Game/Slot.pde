class Slot{
  int x,y;
  PImage slotImage;
  boolean occupied;
  // jos slot eturivisisä, boolean on true
  boolean front;
  
  Slot(int x, int y){
    this.x = x;
    this.y = y;
    this.occupied = false;
  }
}
