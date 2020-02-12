class FBomb extends FBox {
  int timer;
  FBomb(){
   super(gridSize, gridSize);
   timer=60;
   this.setFill(orange);
   this.setPosition(player.getX()+gridSize,player.getY());
   world.add(this);
  }
  
  
}
