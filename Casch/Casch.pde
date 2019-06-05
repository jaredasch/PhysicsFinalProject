ArrayList board;
Charge p0;
Charge p1;
StationaryCharge sc_0;
StationaryCharge sc_1;
StationaryCharge sc_2;
int s = 800; //size of screen sxs
int turn = 0; //0 - Player 0, 1 - Player 1
boolean animation;


void setup(){
  size(800, 800);
  board = new ArrayList();
  p0 = new Charge(new Vector(50,s-100,0), new Vector(0,0,0), 10, true);
  p1 = new Charge(new Vector(s-50,s-100,0), new Vector(0,0,0), 10, true);
  
  Vector v = new Vector(Math.random()*(s-100) + 50, Math.random()*(s-100), 0); //cant be 50 within walls or in the floor
  double q = Math.random() * 100 - 50;
  sc_0 = new StationaryCharge(v,q);
  
  v = new Vector(Math.random()*(s-100) + 50, Math.random()*(s-100), 0);
  q = Math.random() * 100 - 50;
  sc_1 = new StationaryCharge(v,q);
  
  v = new Vector(Math.random()*(s-100) + 50, Math.random()*(s-100), 0);
  q = Math.random() * 100 - 50;
  sc_2 = new StationaryCharge(v,q);
  
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
  
     if (turn == 0 && animation){        
        for (int i=0; i < board.size(); i++){
          Charge c = (Charge) board.get(i); 
          if(c instanceof StationaryCharge){
            p0.velocity = p0.velocity.add(p0.forceFrom(c));
          }
        }
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
         if (c instanceof StationaryCharge && p0.collision(c)){
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
        
        if(p1.position.x > s || p1.position.x < 0 || p1.position.y > (s-100) || p1.position.y < 0){
           animation = false;
           turn = 0;
           p1.position = new Vector(s-50,s-100,0);
           p1.velocity = new Vector(0,0,0);
        }
        
        for (int i=0; i < board.size(); i++){ //loops through charges to check for collision
           Charge c = (Charge) board.get(i);
           if (c instanceof StationaryCharge && p1.collision(c)){
              animation = false;
              turn = 0;
              p1.position = new Vector(s-50,s-100,0);
              p1.velocity = new Vector(0,0,0);        
            }
         }  
     }
}

void mouseClicked(){
  whenClick();
}

void whenClick(){
    Vector v = new Vector(mouseX, mouseY, 0);
    if (turn == 0){
      Vector resultant = v.add(p0.position.scalarMultiply(-1.0));
      double constant = resultant.magnitude();
      //System.out.println(resultant.toString());
      if (resultant.magnitude() > 100){
        constant = 100;
      }
      System.out.println(constant);
      resultant.normalize();
      resultant.scalarMultiply(constant);
      p0.velocity = resultant;
      animation = true;
    }
    if (turn == 1){
      Vector resultant = v.add(p1.position.scalarMultiply(-1.0));
      double constant = resultant.magnitude();
      //System.out.println(resultant.toString());
      if (resultant.magnitude() > 100){
        constant = 100;
      }
      resultant.normalize();
      resultant.scalarMultiply(constant);
      p1.velocity = resultant;
      animation = true;
    }
}
