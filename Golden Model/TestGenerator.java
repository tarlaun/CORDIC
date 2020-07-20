import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

public class TestGenerator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = 2000;
        Random random = new Random();
        scanner.close();
        try {
            FileWriter writer = new FileWriter("test_input.txt", false);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);
            for (int i = 0; i < n; i++) {
                int random_int = random.nextInt()% 65536;
                if(random_int < 0)
                    random_int *= -1;
                StringBuilder stringBuilder = new StringBuilder();
                for (int j = 0; j < 16; j++) {
                    char c = (random_int%2 == 0)? '0' : '1';
                    random_int /= 2;
                    stringBuilder.append(c);
                }
                stringBuilder.reverse();
                bufferedWriter.write(stringBuilder.toString());
                bufferedWriter.newLine();
            }
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}