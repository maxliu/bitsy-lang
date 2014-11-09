package bitsy.lang.symbols;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public abstract class Scope {
	static int registerCount = 1;
	static int labelCount = 0;
	int localCount = 1; // need to start this after args on method
	Scope enclosingScope;
	List<Scope> childScopes = new ArrayList<Scope>();
	Map<String, Symbol> symbols = new LinkedHashMap<String, Symbol>();
	
	

	public Scope(Scope enclosingScope) {
		this.enclosingScope = enclosingScope;
		if (enclosingScope != null) {
			enclosingScope.childScopes.add(this);
		}
	}
	
	public void resetRegisters() {
		registerCount = 1;
		labelCount = 0;
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

	public void define(Symbol symbol) throws SymbolException {
		Symbol prevSymbol = resolve(symbol.name); //symbols.get(symbol.name);
		if (prevSymbol != null && symbol.type != null && symbol.type != prevSymbol.type) {
			throw new SymbolException();
		}
		if (prevSymbol == null) {
			symbols.put(symbol.name, symbol);
			symbol.scope = this;
			
			Scope methodScope = getMethodScope();
			symbol.setLocal(methodScope.localCount);
			methodScope.localCount += symbol.type == BuiltinType.NUMBER ? 2 : 1; 
		} else if (prevSymbol.type == null && symbol.type != null) {
			symbols.put(symbol.name, symbol);
			symbol.scope = this;
		}
	}
	
	public Symbol assign(String name, int register) {
		Symbol symbol = resolve(name);
		symbol.setRegister(register);
		return symbol;
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
	
	public int getLastRegister() {
		return registerCount - 1;
	}
	
	public Scope getMethodScope() {
		Scope methodScope = this;
		while (!(methodScope.getEnclosingScope() instanceof GlobalScope)) {
			methodScope = methodScope.getEnclosingScope();
		}
		return methodScope;
	}
	
	public int getNextLabel() {
		return ++labelCount;
	}
	
	public int getLabel() {
		return labelCount;
	}
	
	public int getLocalCount() {
		return localCount;
	}
}
