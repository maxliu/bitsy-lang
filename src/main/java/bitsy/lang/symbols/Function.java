package bitsy.lang.symbols;

import java.util.LinkedHashMap;
import java.util.Map;

import bitsy.antlr4.BitsyParser.FunctionDeclContext;
import bitsy.antlr4.BitsyParser.ReturnStatementContext;

public class Function {
	FunctionDeclContext ctx;
	BuiltinType returnType;
	String id;
	String sourceName;
	Map<String, BuiltinType> arguments = new LinkedHashMap<String, BuiltinType>();
	
	public Function(String id, FunctionDeclContext ctx, BuiltinType returnType, String sourceName) {
		this.id = id;
		this.ctx = ctx;
		this.returnType = returnType;
		this.sourceName = sourceName;
	}
	public void addArgument(String argument, BuiltinType argumentType) {
		arguments.put(argument, argumentType);
	}
	
	public Map<String, BuiltinType> getArguments() {
		return arguments;
	}
	
	public BuiltinType getReturnType() {
		if (returnType == null) {
			return BuiltinType.NULL;
		}
		return returnType;
	}
	
	public void checkReturnType(BuiltinType returnType, ReturnStatementContext ctx) {
		if ( (returnType == null && this.returnType != null) ||
			 (this.returnType != null && !returnType.equals(this.returnType)) ) 
		{
			throw new RuntimeException("Inconsistent return type for function "+
					id+ " expected "+getReturnType()+" but got "+returnType+
					" in "+sourceName+" on line: "+ctx.start.getLine());
		}
	}
}
