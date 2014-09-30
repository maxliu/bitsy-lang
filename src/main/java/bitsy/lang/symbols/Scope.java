package bitsy.lang.symbols;

import java.util.Collection;

public interface Scope {
    public String getScopeName();

    public Scope getEnclosingScope();

    public void define(Symbol symbol);

    public Symbol resolve(String name);
    
    public Collection<Symbol> getSymbols();
}
