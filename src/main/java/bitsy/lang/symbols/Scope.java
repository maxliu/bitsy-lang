package bitsy.lang.symbols;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public abstract class Scope {
	Scope enclosingScope;
	Map<String, Symbol> symbols = new LinkedHashMap<String, Symbol>();
	int registerCount = 0;

	public Scope(Scope enclosingScope) {
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
	
	public void assign(String name, int register) {
		resolve(name).setRegister(register);
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
	
	public int getRegister() {
		return registerCount;
	}
	
	public int getNextRegister() {
		return ++registerCount;
	}
	
	public int getNextLocal() {
		int ret = getRegister();
		getNextRegister();
		return ret;
	}
	
	public int getNextLocalWide() {
		int ret = getRegister();  
		getNextRegister();
		getNextRegister();
		return ret;
	}
	
	public void resetRegisters() {
		registerCount = 0;
	}
}
