class FBomb extends FBox {

  int timer;

  FBomb(){

   super(gridSize, gridSize);

   timer=60;

   this.setFill(orange);

   this.setPosition(player.getX()+gridSize,player.getY());

   world.add(this);

  }

  
void act(){
 timer--;
 if(timer==0){
  explode(); 
  world.remove(this);
  bomb=null;
 }
}
  
  void explode(){
   for (int i=0; i<boxes.size(); i++){
    FBox b=boxes.get(i);
    if (dist(this.getX(),this.getY(),b.getX(), b.getY())<200){
      b.setStatic(false);
      float vx=b.getX()-this.getX();
      float vy=b.getY()-this.getY();
      b.setVelocity(vx*4,vy*4);
    }
   }
  }

}
