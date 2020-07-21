import java.io.BufferedWriter;
import java.io.File; // Import the File class
import java.io.FileWriter;
import java.util.Scanner; // Import the Scanner class to read text files


public class Test {

    static double pi =3.14159265359;
    static double[] arcTan = {0.7854, 0.4636, 0.245, 0.1244, 0.0624, 0.0312, 0.0156, 0.0078, 0.0039, 0.002, 0.001 , 0.0005 , 0.0002 };

    public static void main(String[] args)  {
    try {
      File testFile = new File("test_input.txt");
      File modeFile = new File("test_mode.txt");
      FileWriter writer = new FileWriter("test_result_golden_model.txt", false);
      BufferedWriter bufferedWriter = new BufferedWriter(writer);
      Scanner testScanner = new Scanner(testFile);
      Scanner modeScanner = new Scanner(modeFile);
      String x , y , theta , result;
      for (int i = 0; i < 100; i++) {
          x = testScanner.nextLine();
          y = testScanner.nextLine();
          if(modeScanner.nextLine().equals("0")){
            theta = testScanner.nextLine();
            result =  rotate(x, y, theta);
          }else
            result =  phaseDetector(x, y);
          bufferedWriter.write(result);
          bufferedWriter.newLine();
      }
      modeScanner.close();
      testScanner.close();
      bufferedWriter.close();
    } catch (Exception e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }
  }

  static String rotate(String x , String y , String theta){
        double xc = strToDouble(x);
        double yc = strToDouble(y);
        double z = strToDouble(theta);
        z = adjustTheta(z);
        double cos = Math.cos(z);
        double sin = Math.sin(z);
        double resX = xc*cos + yc*sin;
        double resY = -xc*sin + yc*cos;
        String acs = doubleToStr(resX);
        String bcs = doubleToStr(resY);

        return acs + " " +  bcs + " x="+resX+ " y="+resY;
  }

  static String phaseDetector(String x , String y){
        double xc = strToDouble(x);
        double yc = strToDouble(y);
        double z = Math.atan2(yc , xc);
        String zs = doubleToStr(z);
        return zs + " theta="+z;
  }

  static double strToDouble(String x){
        String sign = x.charAt(0) == '1'? "-" : "";
        if(sign.equals("-"))
            x = twoSComp(x.substring(1));
        else
            x = x.substring(1);
        int intVal = Integer.parseInt(sign+x,2);
        double res = intVal;
        for (int i = 0; i < 8; i++) {
            res /= 2;
        }
        return res;
  }

  static String doubleToStr(double f){
        for (int i = 0; i < 8; i++) {
            f *= 2;
        }
        int intVal = (int)f;
        String string = Integer.toBinaryString(intVal);
        while(string.length() < 16){
            string = "0" + string;
        }
        return string.substring(string.length()-16, string.length());
  }

  static String twoSComp(String x){
      StringBuilder stringBuilder = new StringBuilder();
      int index = x.length()-1;
      while(index >= 0 && x.charAt(index) == '0'){
        stringBuilder.append(x.charAt(index));
        index--;  
      }
      if(index >= 0){
        stringBuilder.append(x.charAt(index));
         index--;
     }

      while(index >= 0){
        char c = x.charAt(index) == '0' ? '1' : '0';
        stringBuilder.append(c);
        index--;
      }
      stringBuilder.reverse();
      return stringBuilder.toString();
  }

  static double adjustTheta(double theta){
    double sign = theta > 0 ? 1 : -1;
    while(Math.abs(theta) > 2*pi){
      theta -= sign * 2 * pi;
      sign = theta > 0 ? 1 : -1;
    }
    return theta;
  }
}
