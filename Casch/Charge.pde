class Charge {
    static final double epsilon_naught = 8.85e-12;
    
    Vector position;
    Vector velocity;
    boolean isProjectile;
    double magnitude;
    float radius;
    
    public Charge(Vector r, Vector v, double q, boolean b){
        position = r;
        velocity = v;
        magnitude = q;
        isProjectile = b;
        radius = abs((float)magnitude) * 2; //radius is proportional to magnitude
    }
    
    public Vector forceFrom(Charge q){
        Vector r = position.add(q.position.scalarMultiply(-1)); // Difference between position vectors
        double distance = r.magnitude();
        double forceMagnitude = (1 / (4 * Math.PI * epsilon_naught)) * (this.magnitude * q.magnitude / (distance * distance));
        r.normalize();
        return r.scalarMultiply(forceMagnitude*.000000001);
    }
    
    public void display(){
      if (magnitude < 0){ //negative charge is blue
        double blue = magnitude*-1/50 *100 + 100; //(100-200)
        fill(0,0,Math.round(blue));
      }
      else{
        double red = magnitude/50 *100 + 100; //(100-200)
        fill(Math.round(red),0,0);
      }
      ellipse((float)position.x,(float)position.y,radius,radius);
    }
    
    public boolean collision(Charge q){
      if ((this.position.x + this.radius) > (q.position.x - q.radius) && (this.position.x - this.radius) < (q.position.x + q.radius)){
        if((this.position.y + this.radius) > (q.position.y - q.radius) && (this.position.y - this.radius) < (q.position.y + q.radius)){
          return true;
        }
      }
      return false;
    }
}
