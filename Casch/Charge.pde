class Charge {
    static final double epsilon_naught = 8.85e-12;
    
    Vector position;
    Vector velocity;
    
    double magnitude;
    
    public Charge(Vector r, Vector v, double q){
        position = r;
        velocity = v;
        magnitude = q;
    }
    
    public Vector forceFrom(Charge q){
        Vector r = position.add(q.position.scalarMultiply(-1)); // Difference between position vectors
        double distance = r.magnitude();
        double forceMagnitude = (1 / (4 * Math.PI * epsilon_naught)) * (this.magnitude * q.magnitude / (distance * distance));
        r.normalize();
        return r.scalarMultiply(forceMagnitude);
    }
}

void setup(){
    Charge q1 = new Charge(new Vector(0, 0, 0), new Vector(0, 0, 0), 1);
    Charge q2 = new Charge(new Vector(1, 1, 1), new Vector(0, 0, 0), 1);
    System.out.println(q1.forceFrom(q2));
}
