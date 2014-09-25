package bitsy.lang;

import jasmin.ClassFile;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Test {

    public static void main(String[] args) throws IOException, Exception {
        String inputString = new String(Files.readAllBytes(Paths.get("test.j")));
        ClassFile classFile = new ClassFile();
        
        InputStream is = new ByteArrayInputStream(inputString.getBytes("UTF-8"));
        InputStreamReader ir = new InputStreamReader(is);
        try (BufferedReader inp = new BufferedReader(ir)) {
            classFile.readJasmin(inp, "HelloWorld.j", false);
        }
        FileOutputStream outp = new FileOutputStream(new File("HelloWorld.class"));
        classFile.write(outp);
    }

}
