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
import java.util.Set;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupDir;
import org.stringtemplate.v4.STGroupFile;

import bitsy.antlr4.BitsyLexer;
import bitsy.antlr4.BitsyParser;
import bitsy.lang.symbols.SymbolTable;

public class Bitsy {
	
	static void jvm(SymbolTable symbolTable, ParseTree tree, ANTLRFileStream source) throws IOException, Exception {
		symbolTable.resetRegisters();
		STGroup stg = new STGroupDir("src/main/resources/stg/jvm");
	    stg.importTemplates(new STGroupFile("src/main/resources/stg/jvm/common.stg"));
        ClassFile classFile = new ClassFile();
        String jasminString = new TranslateVisitor(stg, symbolTable, source.getSourceName()).visit(tree);
        Path jFile = new File(source.getSourceName()+".j").toPath();
        Files.write(jFile, jasminString.getBytes());
        System.out.println("Wrote j file "+jFile);
        InputStream is = new ByteArrayInputStream(jasminString.getBytes("UTF-8"));
        InputStreamReader ir = new InputStreamReader(is);
        try (BufferedReader inp = new BufferedReader(ir)) {
            classFile.readJasmin(inp, source.getSourceName(), false);
        }
        System.out.println(">>> Created java class "+classFile.getClassName()+".class");
        FileOutputStream outp = new FileOutputStream(new File(classFile.getClassName()+".class"));
        classFile.write(outp);
        
        run("java test");
	}
    
	static void bash(SymbolTable symbolTable, ParseTree tree, ANTLRFileStream source) throws IOException {
		symbolTable.resetRegisters();
		STGroup stg = new STGroupDir("src/main/resources/stg/bash");
	    stg.importTemplates(new STGroupFile("src/main/resources/stg/bash/common.stg"));
        String bashString = new TranslateVisitor(stg, symbolTable, source.getSourceName()).visit(tree);
        String fileName = FilenameUtil.getFilenameAndExtenion(source.getSourceName())[0];
        Path bashFile = new File(fileName+".sh").toPath();
        Files.write(bashFile, bashString.getBytes());
        
        Set<PosixFilePermission> perms = Files.getPosixFilePermissions(bashFile);
        perms.add(PosixFilePermission.OWNER_EXECUTE);
        perms.add(PosixFilePermission.GROUP_EXECUTE);
        perms.add(PosixFilePermission.OTHERS_EXECUTE);
        Files.setPosixFilePermissions(bashFile, perms);
        
        System.out.println(">>> Created bash script "+bashFile);
        run("./test.sh");
	}
	
	static void llvm(SymbolTable symbolTable, ParseTree tree, ANTLRFileStream source) throws IOException {
		symbolTable.resetRegisters();
	    STGroup stg = new STGroupDir("src/main/resources/stg/llvm");
	    stg.importTemplates(new STGroupFile("src/main/resources/stg/llvm/common.stg"));
	    String sourceName = source.getSourceName();
        String irString = new TranslateVisitor(stg, symbolTable, sourceName).visit(tree);
        File irFile = new File(source.getSourceName()+".ll");
        Files.write(irFile.toPath(), irString.getBytes());
        File bcFile = new File(sourceName+".bc");
        File sFile = new File(sourceName+".s");
        if (run("llvm-as -f "+irFile) != 0) return;
        //irFile.delete();
        if (run("llc "+bcFile) != 0) return;
        bcFile.delete();
        String exeFile = FilenameUtil.getFilenameAndExtenion(sourceName)[0];
        if (run("clang -o "+exeFile+" "+sFile) != 0) return;
        sFile.delete();
        System.out.println(">>> Created native file "+exeFile);
        run("./"+exeFile);
	}
	
    public static void main(String[] args) {
    	try {
	        ANTLRFileStream source = new ANTLRFileStream("src/main/resources/bitsy/test.bit");
	        
	        BitsyLexer lexer = new BitsyLexer(source);
	        BitsyParser parser = new BitsyParser(new CommonTokenStream(lexer));
	        parser.setBuildParseTree(true);
	        ParseTree tree = parser.parse();
	        //System.out.println(tree.toStringTree(parser));
	        
	        SymbolTable symbolTable = new SymbolTable();
	        ParseTreeWalker walker = new ParseTreeWalker();
	        walker.walk(new SymbolListener(symbolTable), tree);
	        
	        llvm(symbolTable, tree, source);
	        bash(symbolTable, tree, source);
	        jvm(symbolTable, tree, source);
	        /*
	        if (args.length == 0) {
	            System.out.println("Parsed successfully. Please specify -native, -bash or -jvm to create output files");
	            return;
	        } 
	        for (String arg: args) {
	        	if (arg.equals("-llvm")) { 
	                llvm(scope, tree, source);
	            } else if (arg.equals("-jvm")) {
	                jvm(scope, tree, source);
	            } else if (arg.equals("-bash")) {
	                bash(scope, tree, source);
	            } else {
	            	System.err.println("Invalid argument "+arg+" exiting.");
	            	return;
	            }
	        }
	        */
    	} catch (Exception e) {
    		System.err.println("Exception "+e.getMessage());
    	}
    }
}
