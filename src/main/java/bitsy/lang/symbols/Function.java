package bitsy.lang.symbols;

import java.util.ArrayList;
import java.util.List;

import org.antlr.v4.runtime.tree.ParseTreeProperty;

import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.FunctionDeclContext;
import bitsy.antlr4.BitsyParser.IdentifierFunctionCallContext;

public class Function {
	FunctionDeclContext ctx;
	String id;
	List<BuiltinType> params;
	List<IdentifierFunctionCallContext> calls  = new ArrayList<IdentifierFunctionCallContext>();
	
	public Function(String id) {
		this.id = id;
	}
	
	public void setContext(FunctionDeclContext ctx, String sourceName) {
		if (this.ctx != null) {
			throw new RuntimeException("Function "+id+" redefined in "+sourceName+
					" line: "+ctx.start.getLine());
		}
		this.ctx = ctx;
	}

	public void addCall(IdentifierFunctionCallContext callCtx) {
		calls.add(callCtx);
	}
	
	public List<BuiltinType> getParams(ParseTreeProperty<BuiltinType> resultTypes, String sourceName) {
		for (IdentifierFunctionCallContext call: calls) {
			List<BuiltinType> callParams = new ArrayList<BuiltinType>();
			for (ExpressionContext ctx: call.exprList().expression()) {
				callParams.add(resultTypes.get(ctx));
			}
			if (params == null) {
				params = callParams;
			} else if (!params.equals(callParams)) {
				throw new RuntimeException("Inconsistent function calls to "+id+" for noticed in "+
						sourceName+" on line: "+call.start.getLine());
			}
		}
		return params;
	}
}
