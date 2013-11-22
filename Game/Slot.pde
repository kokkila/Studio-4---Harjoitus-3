class Slot {
  int x,y;
  PImage slotImage;
  boolean occupied;
  boolean front;
  
  Slot(int x, int y, boolean frontOrBack){
    this.x = x;
    this.y = y;
    this.occupied = false;
    this.front = frontOrBack;
  }
}
