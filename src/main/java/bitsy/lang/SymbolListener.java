package bitsy.lang;

import org.antlr.v4.runtime.misc.NotNull;

import bitsy.antlr4.BitsyBaseListener;
import bitsy.antlr4.BitsyParser.AssignmentContext;
import bitsy.antlr4.BitsyParser.BlockContext;
import bitsy.antlr4.BitsyParser.BoolExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.NullExpressionContext;
import bitsy.antlr4.BitsyParser.NumberExpressionContext;
import bitsy.antlr4.BitsyParser.StringExpressionContext;
import bitsy.lang.symbols.BuiltinType;
import bitsy.lang.symbols.LocalScope;
import bitsy.lang.symbols.Scope;
import bitsy.lang.symbols.Symbol;
import bitsy.lang.symbols.SymbolTable;
import bitsy.lang.symbols.Type;

public class SymbolListener extends BitsyBaseListener {
	SymbolTable symbolTable;
    Scope currentScope;
    
	public SymbolListener(SymbolTable symbolTable) {
		this.symbolTable = symbolTable;
		this.currentScope = symbolTable.globals;
	}
	
	private void define(String id, Type type) {
		currentScope.define(new Symbol(id, type));
	}
	
	@Override
	public void enterBlock(@NotNull BlockContext ctx) {
		currentScope = new LocalScope(currentScope);
		symbolTable.scopes.put(ctx, currentScope);
	}
	
	@Override
	public void exitBlock(@NotNull BlockContext ctx) {
		currentScope = currentScope.getEnclosingScope();
	}
	
	@Override
	public void exitAssignment(@NotNull AssignmentContext ctx) {
		String id = ctx.IDENTIFIER().getText();
		ExpressionContext ex = ctx.expression();
		if (ex instanceof StringExpressionContext) {
			define(id, BuiltinType.STRING);
		} else if (ex instanceof NumberExpressionContext) {
			define(id, BuiltinType.NUMBER);
		} else if (ex instanceof BoolExpressionContext) {
			define(id, BuiltinType.BOOLEAN);
		} else if (ex instanceof NullExpressionContext) {
			define(id, BuiltinType.NULL);
		} else {
			// reference
			String rhsId = ex.getText();
			Symbol rhs = currentScope.resolve(rhsId);
			if (rhs == null) {
				throw new RuntimeException("Attempt to reference variable "+rhsId+" that does not exist : line "+ctx.start.getLine());
			}
			define(id, rhs.type);
		}
	}
}
