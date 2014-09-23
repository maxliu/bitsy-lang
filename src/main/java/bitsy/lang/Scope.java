package bitsy.lang;

import java.util.LinkedHashMap;
import java.util.Map;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ParseTreeProperty;

public class Scope {
    Scope parent;
    private Map<String, BitsyValue> variables;
    private ParseTreeProperty<String> symbols = new ParseTreeProperty<String>();

    public Scope() {
        this(null);
    }
    
    public Scope(Scope parent) {
        this.parent = parent;
        this.variables = new LinkedHashMap<String, BitsyValue>();
    }
    
    public void put(ParserRuleContext ctx, String name, BitsyValue value) {
        variables.put(name,  value);
        symbols.put(ctx, name);
    }
    
    public ParseTreeProperty<String> getSymbols() {
        return symbols;
    }

    public Map<String, BitsyValue> getVariables() {
        return variables;
    }
}
