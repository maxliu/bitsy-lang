package bitsy.lang;

import static bitsy.lang.ProcessUtil.run;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.stringtemplate.v4.STGroupFile;

import bitsy.antlr4.BitsyLexer;
import bitsy.antlr4.BitsyParser;

public class Bitsy {
	
    public static void main(String[] args) throws IOException, InterruptedException {
        ANTLRFileStream source = new ANTLRFileStream("src/main/resources/bitsy/test.bit");
        
        BitsyLexer lexer = new BitsyLexer(source);
        BitsyParser parser = new BitsyParser(new CommonTokenStream(lexer));
        parser.setBuildParseTree(true);
        ParseTree tree = parser.parse();
        //System.out.println(tree.toStringTree(parser));
        
        Scope scope = new Scope();
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk(new SymbolListener(scope), tree);
        if (args.length == 0 || args[0].startsWith("-native")) { 
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
    }
}
