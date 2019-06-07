class Projectile extends Charge {
    public Projectile(Vector position, Vector velocity, double q){
        super(position, velocity, q);
        radius = 20;
    }
    
    public void display(){
      fill(255,0,255);
      ellipse((float)position.x,(float)position.y,radius,radius);
    }
}
