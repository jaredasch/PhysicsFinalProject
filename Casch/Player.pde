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
   rect((float)(position.x - w/2),(float)(position.y - h/2),(float)h,(float)w);
  }
  
  
}
