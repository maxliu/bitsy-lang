package bitsy.lang;

import org.antlr.v4.runtime.tree.TerminalNode;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;

import bitsy.antlr4.BitsyBaseVisitor;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;

public class TranslateVisitor extends BitsyBaseVisitor<String> {
    STGroup group;
    Scope scope;
    
    public TranslateVisitor(STGroup group, Scope scope) {
        this.group = group;
        this.scope = scope;
    }
    
    @Override
    protected String defaultResult() {
        return "";
    }
    
    @Override
    public String visitParse(ParseContext ctx) {
        ST st = group.getInstanceOf("file");
        st.add("symbols", scope.getVariables());
        StringBuilder body = new StringBuilder();
        for (PrintFunctionCallContext pctx: ctx.printFunctionCall()) {
            body.append(this.visit(pctx));
        }
        st.add("body", body.toString());
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
            st.add("length", scope.getVariables().get(symbolKey).getCString().getLengthInBytes());
        }
        String out = st.render();
        return out;
    }
}
