package teacher;

import java.io.*;
import java.util.ArrayList;
import java.util.regex.Pattern;



/**
 * 按照年份抽取每年的27X27学科引用数据，以便计算影响力系数与感应度系数
 * 输入txt格式 TO,FROM,YEAR,CITE
 *  学科引用矩阵S[i][j] 即学科i被学科j引用 或 学科j引用学科i
 *  i 对应 From , j 对应 To 。 S[i][j] = S[From][To]
 */
public class Extract_Time {
    public void TestRead(String FilePath) {
        try {
            // ！！以下三行全为魔法值，学科领域一共27类 标号从10至36
            int time_limit = 18;
            int flag = time_limit - 1;
            int n = 27;

            // 三维数组，第一维是时间，输出时按照时间分成不同二维数组
            int[][][] matrix = new int[time_limit][n][n];

            BufferedReader reader = new BufferedReader(new FileReader(FilePath));
            // 第一行不读，跳过
            reader.readLine();
            String line = null;
            line = reader.readLine();
            String[] item = new String[4];

            // 正则，匹配数据中以魔法值17开头的计算机科学内部引用，26开头为数学
            String pattern = "^200[0-9]|201[0-7]";
            boolean isMatch = true;


            while ((line = reader.readLine()) != null) {
                item = line.split(",");
                isMatch = Pattern.matches(pattern, item[2]);
                if (isMatch) {
                    matrix[Integer.parseInt(item[2])-2000][Integer.parseInt(item[1]) - 10][Integer.parseInt(item[0]) - 10] += Integer.parseInt(item[3]);
                }
            }

            reader.close();
            while(flag >= 0){
                String filename = "CiteMatrix" + (flag+2000) + ".csv";
                String path = "C:\\Users\\HP\\Desktop\\Data\\Time\\" + filename;
                File StorePath = new File(path);
                BufferedWriter bw = new BufferedWriter(new FileWriter(StorePath, false));

                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < n; i++) {
                    sb = new StringBuilder();
                    for(int j = 0; j < n; j++) {
                        sb.append(matrix[flag][i][j]);
                        sb.append(",");
                    }
                    bw.write(sb.substring(0, sb.length() - 1));
                    if(i != 26){
                        bw.newLine();
                    }

                }
                bw.flush();
                bw.close();
                flag--;
            }

        } catch (FileNotFoundException var18) {
            System.out.println("没有找到指定文件");
        } catch (IOException var19) {
            System.out.println("文件读写出错");
        } catch (Exception var20) {
            var20.printStackTrace();
        }
    }

    public static void main(String[] args) {
        teacher.Extract_Time a = new teacher.Extract_Time();
        a.TestRead("C:\\Users\\HP\\Desktop\\Data\\D2DYC.txt");
        System.out.println("finish");
    }
}
