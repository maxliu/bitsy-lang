package bitsy.lang;

import java.util.ArrayList;
import java.util.List;

import org.antlr.v4.runtime.tree.TerminalNode;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;

import bitsy.antlr4.BitsyBaseVisitor;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;

public class TranslateVisitor extends BitsyBaseVisitor<String> {
    STGroup group;
    Scope scope;
    String fileName;
    
    public TranslateVisitor(STGroup group, Scope scope, String fileName) {
        this.group = group;
        this.scope = scope;
        this.fileName = FilenameUtil.getFilenameAndExtenion(fileName)[0];
    }
    
    @Override
    protected String defaultResult() {
        return "";
    }
    
    @Override
    public String visitParse(ParseContext ctx) {
        ST st = group.getInstanceOf("file");
        st.add("fileName", fileName);
        st.add("symbols", scope.getVariables());
        List<String> statements = new ArrayList<String>();
        for (PrintFunctionCallContext pctx: ctx.printFunctionCall()) {
            statements.add(this.visit(pctx));
        }
        st.add("statements", statements);
        return st.render();
    }
    
    // println STRING?
    @Override
    public String visitPrintFunctionCall(PrintFunctionCallContext ctx) {
        ST st = group.getInstanceOf("println");
        TerminalNode string;
        if ( (string = ctx.STRING()) != null) {
            String text = string.getText();
            String symbolKey = scope.getSymbols().get(ctx);
            st.add("symbol", symbolKey);
            BitsyValue val = scope.getVariables().get(symbolKey);
            st.add("value", text);
            st.add("length", val.getCString().getLengthInBytes());
        }
        String out = st.render();
        return out;
    }
}
