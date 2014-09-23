package bitsy.lang;

import java.io.IOException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.stringtemplate.v4.STGroupFile;

import bitsy.antlr4.BitsyLexer;
import bitsy.antlr4.BitsyParser;

public class Bitsy {

    public static void main(String[] args) throws IOException {
        ANTLRFileStream source = new ANTLRFileStream("src/main/resources/bitsy/test.bit");
        
        BitsyLexer lexer = new BitsyLexer(source);
        BitsyParser parser = new BitsyParser(new CommonTokenStream(lexer));
        parser.setBuildParseTree(true);
        ParseTree tree = parser.parse();
        //System.out.println(tree.toStringTree(parser));
        
        Scope scope = new Scope();
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk(new SymbolListener(scope), tree);
        
        STGroupFile stg = new STGroupFile("src/main/resources/stg/llvm.stg");
        
        System.out.println(new TranslateVisitor(stg, scope).visit(tree));
    }

}
