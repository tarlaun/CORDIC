import java.io.BufferedWriter;
import java.io.File; // Import the File class
import java.io.FileNotFoundException; // Import this class to handle errors
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner; // Import the Scanner class to read text files

public class Test {

    static String neg = "111111111111111";
    static String pos = "000000000000000";

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
        float a = strToFloat(x);
        float b = strToFloat(y);
        float t = strToFloat(theta);
        System.out.println(floatToStr(a));
        System.out.println(floatToStr(b));
        System.out.println(floatToStr(t));
        return "";
  }

  static String phaseDetector(String x , String y){
        float a = strToFloat(x);
        float b = strToFloat(y);
        System.out.println(floatToStr(a));
        System.out.println(floatToStr(b));
        
        return "";
  }

  static float strToFloat(String x){
        String sign = x.charAt(0) == '1'? "-" : "";
        if(sign.equals("-"))
            x = twoSComp(x.substring(1));
        else
            x = x.substring(1);
        int intVal = Integer.parseInt(sign+x,2);
        float res = intVal;
        for (int i = 0; i < 8; i++) {
            res /= 2;
        }
        return res;
  }

  static String floatToStr(float f){
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            f *= 2;
        }
        int intVal = (int)f;
        String string = Integer.toBinaryString(intVal);
        while(string.length() < 16){
            string = "0" + string;
        }
        return string.substring(string.length()-16, string.length());
        // boolean neg = intVal < 0;
        // intVal = Math.abs(intVal);
        // for (int i = 0; i < 15; i++) {
        //     stringBuilder.append(intVal % 2 + "");
        //     intVal /= 2;
        // }
        // if(neg){
        //     stringBuilder.replace(0, stringBuilder.capacity()-1, twoSComp(stringBuilder.toString()));
        //     stringBuilder.append("1");
        // }else
        //     stringBuilder.append("0");
        // stringBuilder.reverse();
        // return stringBuilder.toString();
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
}
