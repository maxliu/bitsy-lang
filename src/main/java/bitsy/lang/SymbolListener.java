package bitsy.lang;

import org.antlr.v4.runtime.misc.NotNull;

import bitsy.antlr4.BitsyBaseListener;
import bitsy.antlr4.BitsyParser.NumberExpressionContext;
import bitsy.antlr4.BitsyParser.StringExpressionContext;

public class SymbolListener extends BitsyBaseListener {
    Scope scope;
    int symbolNumber = 0;
    
    public SymbolListener(Scope scope) {
        this.scope = scope;
    }
    
    @Override
    public void enterStringExpression(@NotNull StringExpressionContext ctx) {
    	String text = ctx.STRING().getText();
    	scope.put(ctx, "s"+symbolNumber, new BitsyValue(text.substring(1, text.length() - 1)));
    	symbolNumber++;
    }
    
    @Override
    public void enterNumberExpression(@NotNull NumberExpressionContext ctx) {
    	String text = ctx.NUMBER().getText();
    	scope.put(ctx, "s"+symbolNumber, new BitsyValue(Double.parseDouble(text)));
    	symbolNumber++;
    }
}
