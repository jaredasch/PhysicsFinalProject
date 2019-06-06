ArrayList board;
Charge p0;
Charge p1;
StationaryCharge sc_0;
StationaryCharge sc_1;
StationaryCharge sc_2;
int s = 800; //size of screen sxs
int turn = 0; //0 - Player 0, 1 - Player 1
boolean animation;
Player player0;
Player player1;


void setup(){
  size(800, 800);
  board = new ArrayList();
  p0 = new Projectile(new Vector(50,s-100,0), new Vector(0,0,0), 10);
  p1 = new Projectile(new Vector(s-50,s-100,0), new Vector(0,0,0), 10);
    
  /*Vector v = new Vector(Math.random()*(s-100) + 50, Math.random()*(s-100), 0); //cant be 50 within walls or in the floor
  double q = Math.random() * 200 - 100; //charge between -100 and 100
  sc_0 = new StationaryCharge(v,q);
  
  v = new Vector(Math.random()*(s-100) + 50, Math.random()*(s-100), 0);
  q = Math.random() * 200 - 100;
  sc_1 = new StationaryCharge(v,q);
  
  v = new Vector(Math.random()*(s-100) + 50, Math.random()*(s-100), 0);
  q = Math.random() * 200 - 100;
  sc_2 = new StationaryCharge(v,q);*/
  
  Vector a = new Vector(400,600,0);
  Vector b = new Vector(400,100,0);
  Vector c = new Vector(100,300,0);

  sc_0 = new StationaryCharge(a,-100);
  sc_1 = new StationaryCharge(b,50);
  sc_2 = new StationaryCharge(c,20);
  
  Vector d = new Vector(40,700,0);
  player0 = new Player(100,d,20,10);
  Vector e = new Vector(860,700,0);
  player1 = new Player(100,e,20,10);
  
  board.add(sc_0);
  board.add(sc_1);
  board.add(sc_2);
  board.add(p0);
  board.add(p1);
}

void draw(){
  clear();
  fill(210,180,140);
  rect(0,s-100,s,100);
  
  for (int i=0; i < board.size(); i++){
    Charge c = (Charge) board.get(i); 
      c.display();
  }
  
  player0.display();
  player1.display();
  
     if (turn == 0 && animation){        
        for (int i=0; i < board.size(); i++){
          Charge c = (Charge) board.get(i); 
          if(c instanceof StationaryCharge){
            p0.velocity = p0.velocity.add(p0.forceFrom(c));
          }
        }
        
        stroke(0,256,0); //green velocity vector
        strokeWeight(4);
        System.out.println(p0.velocity.toString());
        line((float)p0.position.x,(float)p0.position.y,((float)p0.position.x + (float)p0.velocity.x),((float)p0.position.y + (float)p0.velocity.y));
        stroke(0,0,0);
        strokeWeight(1);
        
        Vector increment = p0.position.add(p0.velocity);
        p0.position =  increment;
        
        if(p0.position.x > s || p0.position.x < 0 || p0.position.y > (s-100) || p0.position.y < 0){
           animation = false;
           turn = 1;
           p0.position = new Vector(50,s-100,0);
           p0.velocity = new Vector(0,0,0);
        }
        
       for (int i=0; i < board.size(); i++){ //loops through charges to check for collision
         Charge c = (Charge) board.get(i);
         if (c instanceof StationaryCharge && p0.chargeCollision(c)){
          animation = false;
          turn = 1;
          p0.position = new Vector(50,s-100,0);
          p0.velocity = new Vector(0,0,0);
         }
       }  
     }
     
     if (turn == 1 && animation){
        for (int i=0; i < board.size(); i++){
          Charge c = (Charge) board.get(i); 
          if(c instanceof StationaryCharge){
            p1.velocity = p1.velocity.add(p1.forceFrom(c));
          }
        }
        Vector increment = p1.position.add(p1.velocity);
        p1.position =  increment;
        
        
        stroke(0,256,0);
        strokeWeight(4);
        System.out.println(p0.velocity.toString());
        line((float)p1.position.x,(float)p1.position.y,(float)p1.position.x + (float)p1.velocity.x,(float)p1.position.y + (float)p1.velocity.y);
        stroke(0,0,0);
        strokeWeight(1);
        
        if(p1.position.x > s || p1.position.x < 0 || p1.position.y > (s-100) || p1.position.y < 0){
           animation = false;
           turn = 0;
           p1.position = new Vector(s-50,s-100,0);
           p1.velocity = new Vector(0,0,0);
        }
        
        for (int i=0; i < board.size(); i++){ //loops through charges to check for collision
           Charge c = (Charge) board.get(i);
           if (c instanceof StationaryCharge && p1.chargeCollision(c)){
              animation = false;
              turn = 0;
              p1.position = new Vector(s-50,s-100,0);
              p1.velocity = new Vector(0,0,0);        
            }
         }  
     }
     
     if (turn == 0 && !animation){ //shows the mouse thingy
       Vector v = new Vector(mouseX,mouseY,0);
       v = v.add(p0.position.scalarMultiply(-1));
       if (v.magnitude() > 100){
         v.normalize();
         v = v.scalarMultiply(100);
       }
               
       stroke(256,256,0);
       strokeWeight(4);
       line((float)p0.position.x,(float)p0.position.y,(float)p0.position.x+(float)v.x,(float)p0.position.y+(float)v.y);
       stroke(0,0,0);
       strokeWeight(1);
     }
     if (turn == 1 && !animation){ //shows the mouse thingy
       Vector v = new Vector(mouseX,mouseY,0);
       v = v.add(p1.position.scalarMultiply(-1));
       if (v.magnitude() > 100){
         v.normalize();
         v = v.scalarMultiply(100);
       }
             
       stroke(256,256,0);
       strokeWeight(4);
       line((float)p1.position.x,(float)p1.position.y,(float)p1.position.x+(float)v.x,(float)p1.position.y+(float)v.y);
       stroke(0,0,0);
       strokeWeight(1);
     }
}

void mouseClicked(){
  whenClick();
}

void whenClick(){
    Vector v = new Vector(mouseX, mouseY, 0);
    if (turn == 0 && !animation){
      Vector resultant = v.add(p0.position.scalarMultiply(-1.0));
      double constant = 8 * (resultant.magnitude() / 100);
      if (resultant.magnitude() > 100){
        constant = 8;
      }
      resultant.normalize();
      System.out.println(resultant.magnitude());
      resultant = resultant.scalarMultiply(constant);
      p0.velocity = resultant;
      System.out.println(resultant.magnitude());
      animation = true;
    }
    if (turn == 1 && !animation){
      Vector resultant = v.add(p1.position.scalarMultiply(-1.0));
      double constant = 8 * (resultant.magnitude() / 100);
      if (resultant.magnitude() > 100){
        constant = 8;
      }
      resultant.normalize();
      resultant = resultant.scalarMultiply(constant);
      p1.velocity = resultant;
      animation = true;
    }
}
