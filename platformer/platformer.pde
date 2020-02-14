import fisica.*;

//COLORS

color black=#000000;

color orange=#FA9B0D;

color green=color(0,255,0);

color red=#FC0000;

color deepBlue=#01198B;

PImage map;

boolean akey, dkey, skey, wkey, spacekey;

int gridSize=50;

float vx=0, vy=0;

ArrayList<FBox> boxes=new ArrayList<FBox>();
FWorld world;

FBox player;

FBomb bomb=null;

void setup() {

  size(800, 600, FX2D);

  Fisica.init(this);

  world=new FWorld();

  world=new FWorld(0, 0, 10000, 10000);

  world.setGravity(0, 900);



  //load the world

  loadWorld();



  player= new FBox(50, 50);

  player.setFillColor(red);

  player.setPosition(1000, 100);

  player.setRotatable(false);

  world.add(player);

}



void draw() {
 

    background(255);

  pushMatrix();

  translate(-player.getX()+width/2,-player.getY()+height/2);

  world.step();

  world.draw();

  popMatrix();

  vx=0;

  if (akey) vx=-500;

  if (dkey) vx=500;

  player.setVelocity(vx, player.getVelocityY());

  ArrayList<FContact> contacts = player.getContacts();

  if (wkey&&contacts.size()>0) player.setVelocity(player.getVelocityX(), -500);

//drop bombs
if (spacekey&&bomb==null){
    bomb = new FBomb(); 
}

if(bomb!=null) bomb.act();
}



void loadWorld() {

  map=loadImage("map.png");

  int x=0;

  int y=0;

  while (y<map.height) {

    color c=map.get(x, y);

    if (c==black) {

      FBox b= new FBox(gridSize, gridSize);

      b.setName("bricks");

      b.setFill(black);

      b.setStroke(5, 109, 177, 18);

      b.setStatic(true);

      b.setPosition(x*gridSize, y*gridSize);

      b.setFriction(0);

      b.setStaticBody(true);

      b.setSensor(false);

      world.add(b);
      boxes.add(b);
      
    }

    if (c == green) {

      FBox g = new FBox(gridSize, gridSize);

      g.setName("ground");

      g.setFillColor(green);

      g.setPosition(x*gridSize, y*gridSize);

      g.setStatic(true);

      world.add(g);
   
    }

   

    x++;

    if (x==map.width) {

      x=0;

      y++;

    }



    /* if(c==red){

     // LavaBox lb= new LavaBox(); 

     // lb.setPosition(x*gridSize,y*gridSize);

     // currentWorld.add(lb);

     // terrain.add(lb);

     }

     if(c==deepBlue){

     FBox b= new FBox(gridSize,gridSize);

     b.setName("water");

     b.setFill(5,109,177,170);

     b.setStroke(5,109,177,18);

     b.setPosition(x*gridSize,y*gridSize);

     b.setFriction(0);

     b.setStaticBody(true);

     b.setSensor(true);

     world.add(b);

     //  terrain.add(b);

     }

     }*/

  }

}





void keyPressed() {

  if (key=='S'||key=='s') skey=true;

  if (key=='W'||key=='w') wkey=true;

  if (key=='A'||key=='a') akey=true;

  if (key=='D'||key=='d') dkey=true;

  if (key==' ') spacekey=true;

}

void keyReleased() {

  if (key=='S'||key=='s') skey=false;

  if (key=='W'||key=='w') wkey=false;

  if (key=='A'||key=='a') akey=false;

  if (key=='D'||key=='d') dkey=false;

  if (key==' ') spacekey=false;

}
