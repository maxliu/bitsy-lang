package bitsy.lang.symbols;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public abstract class Scope {
	static int registerCount = 1;
	static int labelCount = 0;
	int localCount = 0; // need to start this after args on method
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

	public void define(Symbol symbol)  {
		Symbol existingSymbol = resolve(symbol.name);
		Scope methodScope = getMethodScope();
		
		// Ignore if in different scope
		if (existingSymbol != null && existingSymbol.scope != methodScope) {
			existingSymbol = null;
		}
		
		// Attempting to change type of symbol in same scope
		if (existingSymbol != null && symbol.type != null && symbol.type != existingSymbol.type) {
			throw new RuntimeException("Attempt to define or redfine the type" +
					"of a variable in "+
    				symbol.sourceName+" on line: "+symbol.line);
		}
		
		// New symbol
		if (existingSymbol == null) {
			symbols.put(symbol.name, symbol);
			symbol.scope = methodScope;
			symbol.setLocal(methodScope.localCount);
			methodScope.localCount += symbol.type == BuiltinType.NUMBER ? 2 : 1; 
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
		while (
			!(methodScope instanceof FunctionScope) &&
			!(methodScope instanceof GlobalScope)) {
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
