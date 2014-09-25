package bitsy.lang;

import static bitsy.lang.ProcessUtil.run;
import jasmin.ClassFile;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.PosixFilePermission;
import java.util.HashSet;
import java.util.Set;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.stringtemplate.v4.STGroupFile;

import bitsy.antlr4.BitsyLexer;
import bitsy.antlr4.BitsyParser;

public class Bitsy {
	static void jvm(Scope scope, ParseTree tree, ANTLRFileStream source) throws IOException, Exception {
	    STGroupFile stg = new STGroupFile("src/main/resources/stg/jvm.stg");
        ClassFile classFile = new ClassFile();
        String jasminString = new TranslateVisitor(stg, scope).visit(tree);
        //System.out.println(jasminString);
        InputStream is = new ByteArrayInputStream(jasminString.getBytes("UTF-8"));
        InputStreamReader ir = new InputStreamReader(is);
        try (BufferedReader inp = new BufferedReader(ir)) {
            classFile.readJasmin(inp, source.getSourceName(), false);
        }
        FileOutputStream outp = new FileOutputStream(new File(classFile.getClassName()+".class"));
        classFile.write(outp);
	}
    static void llvm(Scope scope, ParseTree tree, ANTLRFileStream source) throws IOException {
	    STGroupFile stg = new STGroupFile("src/main/resources/stg/llvm.stg");
        
        String irString = new TranslateVisitor(stg, scope).visit(tree);
        File irFile = new File(source.getSourceName()+".ll");
        Files.write(irFile.toPath(), irString.getBytes());
        
        File sourceFile = new File(source.getSourceName());
        File bcFile = new File(source.getSourceName()+".bc");
        File sFile = new File(source.getSourceName()+".s");
        if (run("llvm-as -f "+irFile) != 0) return;
        irFile.delete();
        if (run("llc  "+bcFile) != 0) return;
        bcFile.delete();
        if (run("clang -o "+sourceFile+".out "+sFile) != 0) return;
        sFile.delete();
	}
	
	static void bash(Scope scope, ParseTree tree, ANTLRFileStream source) throws IOException {
	    STGroupFile stg = new STGroupFile("src/main/resources/stg/bash.stg");
        String bashString = new TranslateVisitor(stg, scope).visit(tree);
        String fileName = FilenameUtil.getFilenameAndExtenion(source.getSourceName())[0];
        Path bashFile = new File(fileName+".sh").toPath();
        Files.write(bashFile, bashString.getBytes());
        
        Set<PosixFilePermission> perms = Files.getPosixFilePermissions(bashFile);
        perms.add(PosixFilePermission.OWNER_EXECUTE);
        perms.add(PosixFilePermission.GROUP_EXECUTE);
        perms.add(PosixFilePermission.OTHERS_EXECUTE);
        Files.setPosixFilePermissions(bashFile, perms);
	}
	
    public static void main(String[] args) throws Exception {
        ANTLRFileStream source = new ANTLRFileStream("src/main/resources/bitsy/test.bit");
        
        BitsyLexer lexer = new BitsyLexer(source);
        BitsyParser parser = new BitsyParser(new CommonTokenStream(lexer));
        parser.setBuildParseTree(true);
        ParseTree tree = parser.parse();
        //System.out.println(tree.toStringTree(parser));
        
        Scope scope = new Scope();
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk(new SymbolListener(scope), tree);
        if (args.length != 1) {
            System.out.println("Parsed successfully. Please specify -native, -bash or -jvm to create output files");
        } else if (args[0].startsWith("-native")) { 
            llvm(scope, tree, source);
        } else if (args[0].equals("-jvm")) {
            jvm(scope, tree, source);
        } else if (args[0].equals("-bash")) {
            bash(scope, tree, source);
        }
    }
}
