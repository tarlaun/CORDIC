import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

public class TestGenerator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = 1000;
        Random random = new Random();
        scanner.close();
        try {
            FileWriter writer = new FileWriter("test_input.txt", false);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);
            for (int i = 0; i < n; i++) {
                int random_int = random.nextInt()% 16383;
                int random_int2 = random.nextInt() % 16383;
                int random_int3 = random.nextInt() % 800;

                random_int = random_int < 0 ? -random_int : random_int;
                random_int2 = random_int2 < 0 ? -random_int2 : random_int2;
                random_int3 = random_int3 < 0 ? -random_int3 : random_int3;

                if(random.nextInt()%3 == 0)
                    random_int += (int)Math.pow(2,15);
                if(random.nextInt()%3 == 0)
                    random_int2 += (int)Math.pow(2,15);
                if(random.nextInt()%3 == 0)
                    random_int3 += (int)Math.pow(2,15);
                bufferedWriter.write((int)Math.abs(random.nextInt()%2) + "");
                bufferedWriter.newLine();
                bufferedWriter.write(getStringFromInt(random_int));
                bufferedWriter.newLine();
                bufferedWriter.write(getStringFromInt(random_int2));
                bufferedWriter.newLine();
                bufferedWriter.write(getStringFromInt(random_int3));
                bufferedWriter.newLine();
            }
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String getStringFromInt(int random_int) {
        StringBuilder stringBuilder = new StringBuilder();
        for (int j = 0; j < 16; j++) {
            char c = (random_int%2 == 0)? '0' : '1';
            random_int /= 2;
            stringBuilder.append(c);
        }
        return stringBuilder.reverse().toString();
    }
}