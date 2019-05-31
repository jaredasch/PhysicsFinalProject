import java.util.*; 
public class StationaryCharge{
  
  private int charge; //charge in microcololumb 
  private int x;  //x cord
  private int y;  //y cord
  private int radius;
  
  public StationaryCharge(){
    x = Math.random() * 1024;
    y = Math.random() * 1024;
    charge = (Math.random() * 20) - 10;  //from -10 to 10
    radius = abs(charge * 10);
  }
  public int getCharge(){ //accesor for charge
     return charge;
    }

  
}
