package bitsy.lang.symbols;

import java.util.LinkedHashMap;
import java.util.Map;

import org.antlr.v4.runtime.tree.ParseTreeProperty;

public class SymbolTable {
	public ParseTreeProperty<Scope> scopes = new ParseTreeProperty<Scope>();
	public ParseTreeProperty<BuiltinType> resultTypes = new ParseTreeProperty<BuiltinType>();
	public Map<String, Function> functions = new LinkedHashMap<String, Function>();
	public GlobalScope globals = new GlobalScope();

	public String toString() {
		return globals.toString();
	}
	
	public void resetRegisters() {
		globals.resetRegisters();
	}
}
