class Charge {
    static final double epsilon_naught = 8.85e-12;
    
    Vector position;
    Vector velocity;
    double magnitude;
    float radius;
    
    public Charge(Vector r, Vector v, double q){
        position = r;
        velocity = v;
        magnitude = q;
        radius = abs((float)magnitude)/100 *50 + 10; //radius is proportional to magnitude (10-60 pixels)
    }
    
    public Vector forceFrom(Charge q){
        Vector r = position.add(q.position.scalarMultiply(-1)); // Difference between position vectors
        double distance = r.magnitude();
        double forceMagnitude = (1 / (4 * Math.PI * epsilon_naught)) * (this.magnitude * q.magnitude / (distance * distance));
        r.normalize();
        return r.scalarMultiply(forceMagnitude*8e-10);
    }
    
    public void display(){
      if (magnitude < 0){ //negative charge is blue
        double blue = magnitude*-1/100 *100 + 100; //(100-200)
        fill(0,0,Math.round(blue));
      }
      else{
        double red = magnitude/100 *100 + 100; //(100-200)
        fill(Math.round(red),0,0);
      }
      ellipse((float)position.x,(float)position.y,radius,radius);
    }
    
    public boolean chargeCollision(Charge q){
      if(distance(q) < q.radius - 10){
       return true; 
      }
      return false;
    }
    
    public boolean playerCollision(Player p){
      if(p.distance(this) < this.radius + p.h/Math.sqrt(2)){
       return true; 
      }
      return false;
    }
    
    public double distance(Charge q){
      double x = q.position.x - this.position.x;
      double y = q.position.y - this.position.y;
      return Math.sqrt(x*x + y*y);
    }
}
