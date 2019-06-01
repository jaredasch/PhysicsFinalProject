class Vector {
    public double x;
    public double y;
    public double z;
    
    public Vector(double x, double y, double z){
        this.x = x;
        this.y = y;
        this.z = z;
    }
    
    public Vector scalarMultiply(double d){
        return new Vector(x * d, y * d, z * d);
    }
    
    public double magnitude(){
        return Math.sqrt(x * x + y * y + z * z);
    }
    
    public double dot(Vector v){
        return this.x * v.x + this.y * v.y + this.z * v.z;
    }
    
    public Vector cross(Vector v){
        return new Vector(
            this.y * v.z - this.z * v.y, 
            this.z * v.x - this.x * v.z,
            this.x * v.y - this.y * v.x
        );
    }
    
    public Vector add(Vector v){
        return new Vector(x + v.x, y + v.y, z + v.z);
    }
    
    public void normalize(){
        double magnitude = magnitude();
        x /= magnitude;
        y /= magnitude;
        z /= magnitude;
    }
    
    public String toString(){
        return "Vector<" + x + ", " + y + ", " + z + ">";  
    }
}
