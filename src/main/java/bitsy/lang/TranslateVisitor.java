package bitsy.lang;

import java.util.ArrayList;
import java.util.List;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;

import bitsy.antlr4.BitsyBaseVisitor;
import bitsy.antlr4.BitsyParser.BlockContext;
import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;
import bitsy.antlr4.BitsyParser.StatementContext;

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
    	return visit(ctx.block());
    }
    
    // block
    @Override
    public String visitBlock(BlockContext ctx) {
        ST st = group.getInstanceOf("file");
        st.add("fileName", fileName);
        st.add("symbols", scope.getVariables());
        List<String> statements = new ArrayList<String>();
        for (StatementContext pctx: ctx.statement()) {
            statements.add(this.visit(pctx));
        }
        st.add("statements", statements);
        return st.render();
    }
    
    // println expression?
    @Override
    public String visitPrintFunctionCall(PrintFunctionCallContext ctx) {
        ST st = group.getInstanceOf("println");
        ExpressionContext ectx = ctx.expression();
        if ( ectx != null) {
            String text = visit(ectx);
            String symbolKey = scope.getSymbols().get(ectx);
            st.add("symbol", symbolKey);
            BitsyValue val = scope.getVariables().get(symbolKey);
            st.add("value", val.asString());
            st.add("length", val.getLLVMLength());
        }
        String out = st.render();
        return out;
    }
}
