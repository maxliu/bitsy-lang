package bitsy.lang;

import java.nio.file.Paths;

public class FilenameUtil {
    public static String[] getFilenameAndExtenion(String fileName) {
        fileName = Paths.get(fileName).getFileName().toString();
        String[] items = new String[] { "", "" };
        String[] split = fileName.split("\\.(?=[^\\.]+$)");
        if (split.length > 0) {
           items[0] = split[0]; 
        }
        if (split.length > 1) {
           items[1] = split[1];
        }
        return items;
    }
}
