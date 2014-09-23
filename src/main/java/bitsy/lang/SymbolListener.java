package bitsy.lang;

import org.antlr.v4.runtime.tree.TerminalNode;

import bitsy.antlr4.BitsyBaseListener;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;

public class SymbolListener extends BitsyBaseListener {
    Scope scope;
    int symbolNumber = 0;
    
    public SymbolListener(Scope scope) {
        this.scope = scope;
    }
    
    @Override
    public void enterPrintFunctionCall(PrintFunctionCallContext ctx) {
        TerminalNode string;
        if ( (string = ctx.STRING()) != null) {
            String text = string.getText();
            scope.put(ctx, "s"+symbolNumber, new BitsyValue(text.substring(1, text.length() - 1)));
            symbolNumber++;
        }
    }
}
