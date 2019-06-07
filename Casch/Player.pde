class Player{
  int hp;
  Vector position;
  int h; //height
  int w; //widgth
  
  public Player(int hit, Vector p, int hei, int wid){
    hp = hit;
    position = p;
    h = hei;
    w = wid;
  }
  
  public void display(){
   fill(0,255,0);
   rect((float)(position.x - w/2),(float)(position.y - h/2),(float)w,(float)h);
  }
  
  public double distance(Charge q){
      double x = q.position.x - this.position.x;
      double y = q.position.y - this.position.y;
      return Math.sqrt(x*x + y*y);
    }
 
  public String toString(){
    return "" + hp;
  }
  
}
