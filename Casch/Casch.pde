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
double hitConstant = .2; //multiplies velocity squared
int winner = 3;
boolean winningMessage = false;

boolean electric_field_visible = false;


void setup(){
  size(800, 800);
  board = new ArrayList();
  p0 = new Projectile(new Vector(50,s-100,0), new Vector(0,0,0), 10);
  p1 = new Projectile(new Vector(s-50,s-100,0), new Vector(0,0,0), 10);
    
  //------------------ Randomize board of 3 stationary charges -------------------------------
  int rand = (int)(Math.random()*4);
  int q1 = 0;
  int q2 = 0;
  int q3 = 0;
  Vector a = new Vector(0,0,0);
  Vector b = new Vector(0,0,0);
  Vector c = new Vector(0,0,0);
  
  rand = 3;
  if (rand == 0){
    a = new Vector(400,550,0);
    b = new Vector(400,100,0);
    c = new Vector(100,300,0);
    q1 = -100;
    q2 = 70;
    q3 = 40;
  }
  if (rand == 1){
    a = new Vector(100,500,0);
    b = new Vector(700,500,0);
    c = new Vector(400,300,0);
    q1 = -20;
    q2 = -20;
    q3 = 100;
  }
  if (rand == 2){
    a = new Vector(400,650,0);
    b = new Vector(400,550,0);
    c = new Vector(400,100,0);
    q1 = -20;
    q2 = -40;
    q3 = 100;
  }
  if (rand == 3){
    a = new Vector(400,300,0);
    b = new Vector(450,600,0);
    c = new Vector(350,600,0);
    q1 = 100;
    q2 = -10;       ;
    q3 = -10;
  }
  

  sc_0 = new StationaryCharge(a,q1);
  sc_1 = new StationaryCharge(b,q2);
  sc_2 = new StationaryCharge(c,q3);
  
  //-----------------------------------------------------------------------------------------------------

  Vector d = new Vector(20,680,0);
  player0 = new Player(100,d,35,35);
  Vector e = new Vector(780,680,0);
  player1 = new Player(100,e,35,35);
  
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
  drawElectricFields();
  if (winningMessage){
   System.out.println("one");
   String s;
   if(winner == 0){
     s = "Player 0 wins!";
   }
   else{
     s = "Player 1 wins!";
   }
   System.out.println("two");
   clear();
   textSize(40);
   text(s, 300, 400);
   exit();
  }
  
  for (int i=0; i < board.size(); i++){
    Charge c = (Charge) board.get(i);
      c.display();
  }
  
  player0.display();
  player1.display();
  
  textSize(32);
  fill(128,128,0);
  text("Health: " +player0.toString() + " - " + player1.toString(), 250, 750);   
  
     if (turn == 0 && animation){        
        for (int i=0; i < board.size(); i++){
          Charge c = (Charge) board.get(i); 
          if(c instanceof StationaryCharge){
            p0.velocity = p0.velocity.add(p0.forceFrom(c));
          }
        }
        
        stroke(0,256,0); //green velocity vector
        strokeWeight(4);
        //System.out.println(p0.velocity.toString());
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
       
       if(p0.playerCollision(player1)){
         double mag = p0.velocity.magnitude();
         player1.hp = (int)(player1.hp - mag*mag*hitConstant);
         animation = false;
         turn = 1;
         p0.position = new Vector(50,s-100,0);
         p0.velocity = new Vector(0,0,0);
         
         if(player1.hp <= 0){
            winner = 0;
            winningMessage = true;
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
        //System.out.println(p0.velocity.toString());
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
         
         if(p1.playerCollision(player0)){
           double mag = p1.velocity.magnitude();
           player0.hp = (int)(player0.hp - mag*mag*hitConstant);
           animation = false;
           turn = 0;
           p1.position = new Vector(s-50,s-100,0);
           p1.velocity = new Vector(0,0,0);
           
           if(player0.hp <= 0){
              winner = 1;
              winningMessage = true;
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
    System.out.println(winningMessage);
    System.out.println(winner);
}

void mouseClicked(){
  whenClick();
}

void whenClick(){
    Vector v = new Vector(mouseX, mouseY, 0);
    if (turn == 0 && !animation){
      Vector resultant = v.add(p0.position.scalarMultiply(-1.0));
      double constant = 10 * (resultant.magnitude() / 100);
      if (resultant.magnitude() > 100){
        constant = 10;
      }
      resultant.normalize();
      //System.out.println(resultant.magnitude());
      resultant = resultant.scalarMultiply(constant);
      p0.velocity = resultant;
      //System.out.println(resultant.magnitude());
      animation = true;
    }
    if (turn == 1 && !animation){
      Vector resultant = v.add(p1.position.scalarMultiply(-1.0));
      double constant = 10 * (resultant.magnitude() / 100);
      if (resultant.magnitude() > 100){
        constant = 10;
      }
      resultant.normalize();
      resultant = resultant.scalarMultiply(constant);
      p1.velocity = resultant;
      animation = true;
    }
}

void drawElectricFields(){
    pushStyle();
    strokeWeight(3);
    
    for(int x = 0; x < 800; x += 40){
        for(int y = 0; y < s - 100; y += 40){
            Vector field = new Vector(0, 0, 0);
            Charge testCharge = new Charge(new Vector(x, y, 0), new Vector(0, 0, 0), 1);
            
            for (int i=0; i < board.size(); i++){
              Charge c = (Charge) board.get(i); 
              if(c instanceof StationaryCharge){
                field = field.add( testCharge.forceFrom(c) );
              }
            }
            
            double magnitude = field.magnitude();
            stroke((int) (4000 * magnitude), 0, 0);
            field.normalize();
            field = field.scalarMultiply(20);
            arrow(x, y, (int) (x + field.x), (int) (y + field.y));
        }
    }
    popStyle();
}


// Code to draw an arrow borrowed from https://processing.org/discourse/beta/num_1219607845.html
void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -4, -4);
  line(0, 0, 4, -4);
  popMatrix();
}
