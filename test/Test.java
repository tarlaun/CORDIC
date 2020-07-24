import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

public class Test {
    public static void main(String[] args) {
        try{
            File goldenModelFile = new File("golden_model_data.txt");
            File verilogFile = new File("verilog_data.txt");
            FileWriter resultFile = new FileWriter("test_result.txt", false);
            BufferedWriter resultWriter = new BufferedWriter(resultFile);
            Scanner goldenModelScanner = new Scanner(goldenModelFile);
            Scanner verilogScanner = new Scanner(verilogFile);
            int counter = 0;
            double precision = 0.1;
            for (int i = 0; i < 100; i++) {
                String[] strings = goldenModelScanner.nextLine().split(" ");
                String[] strings2 = verilogScanner.nextLine().split(" ");
                
                int x1 = Integer.parseInt(strings[0].substring(1),2);
                int y1 = Integer.parseInt(strings[1].substring(1),2);
                
                int x2 = Integer.parseInt(strings2[0].substring(1),2);
                int y2 = Integer.parseInt(strings2[1].substring(1),2);

                x1 = strings[0].charAt(0) == '0' ? x1 : -x1;
                y1 = strings[1].charAt(0) == '0' ? y1 : -y1;

                x2 = strings2[0].charAt(0) == '0' ? x2 : -x2;
                y2 = strings2[1].charAt(0) == '0' ? y2 : -y2;
                
                double deltaX = Math.abs(x1 - x2);
                double deltaY = Math.abs(y1 - y2);

                double xp = Math.abs(x1);
                double yp = Math.abs(y1);

                double error = strings[2].contains("theta") ? deltaX/xp :( deltaX/xp + deltaY/yp)/2.0;
                String res = error < precision ? "pass"  : "fail " ;
                if( error < precision)
                    counter++;
                resultWriter.write(error + " " + res );
                resultWriter.newLine();
            }
            resultWriter.write(counter + " percent of tests passed");
            resultWriter.newLine();
            resultWriter.close();
            goldenModelScanner.close();
            verilogScanner.close();
        }catch( Exception e){
            e.printStackTrace();
        }
    }
}