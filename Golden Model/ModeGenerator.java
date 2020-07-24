import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;
class ModeGenerator{
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = 1000; 
        Random random = new Random();
        scanner.close();
        try {
            FileWriter writer = new FileWriter("test_mode.txt", false);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);
            for (int i = 0; i < n; i++) {
                int random_int = random.nextInt()% 2;
                if(random_int < 0)
                    random_int *= -1;
                bufferedWriter.write(0+ "");
                bufferedWriter.newLine();
            }
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}