package bitsy.lang.symbols;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public abstract class BaseScope implements Scope {
	Scope enclosingScope;
	Map<String, Symbol> symbols = new LinkedHashMap<String, Symbol>();

	public BaseScope(Scope enclosingScope) {
		this.enclosingScope = enclosingScope;
	}

	public Symbol resolve(String name) {
		Symbol s = symbols.get(name);
		if (s != null) {
			return s;
		}

		// if not here, check any enclosing scope
		if (enclosingScope != null) {
			return enclosingScope.resolve(name);
		}
		return null;
	}

	public void define(Symbol symbol) {
		symbols.put(symbol.name, symbol);
		symbol.scope = this;
	}

	public Scope getEnclosingScope() {
		return enclosingScope;
	}

	public String toString() {
		return symbols.keySet().toString();
	}
	
	public Collection<Symbol> getSymbols() {
		return symbols.values();
	}
}
