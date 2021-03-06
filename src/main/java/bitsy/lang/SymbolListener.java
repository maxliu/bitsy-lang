package bitsy.lang;

import static bitsy.lang.symbols.BuiltinType.BOOLEAN;
import static bitsy.lang.symbols.BuiltinType.NULL;
import static bitsy.lang.symbols.BuiltinType.NUMBER;
import static bitsy.lang.symbols.BuiltinType.STRING;
import static bitsy.lang.symbols.BuiltinType.LIST;
import static bitsy.lang.symbols.BuiltinType.MAP;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.RuleContext;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeProperty;

import bitsy.antlr4.BitsyBaseListener;
import bitsy.antlr4.BitsyParser.AddExpressionContext;
import bitsy.antlr4.BitsyParser.AndExpressionContext;
import bitsy.antlr4.BitsyParser.ArgumentContext;
import bitsy.antlr4.BitsyParser.AssignmentContext;
import bitsy.antlr4.BitsyParser.BlockContext;
import bitsy.antlr4.BitsyParser.BoolExpressionContext;
import bitsy.antlr4.BitsyParser.DivideExpressionContext;
import bitsy.antlr4.BitsyParser.EqExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionExpressionContext;
import bitsy.antlr4.BitsyParser.ForStatementContext;
import bitsy.antlr4.BitsyParser.FunctionCallExpressionContext;
import bitsy.antlr4.BitsyParser.FunctionDeclContext;
import bitsy.antlr4.BitsyParser.GtEqExpressionContext;
import bitsy.antlr4.BitsyParser.GtExpressionContext;
import bitsy.antlr4.BitsyParser.IdentifierExpressionContext;
import bitsy.antlr4.BitsyParser.IdentifierFunctionCallContext;
import bitsy.antlr4.BitsyParser.ListContext;
import bitsy.antlr4.BitsyParser.ListExpressionContext;
import bitsy.antlr4.BitsyParser.LtEqExpressionContext;
import bitsy.antlr4.BitsyParser.LtExpressionContext;
import bitsy.antlr4.BitsyParser.ModulusExpressionContext;
import bitsy.antlr4.BitsyParser.MultiplyExpressionContext;
import bitsy.antlr4.BitsyParser.NotEqExpressionContext;
import bitsy.antlr4.BitsyParser.NotExpressionContext;
import bitsy.antlr4.BitsyParser.NullExpressionContext;
import bitsy.antlr4.BitsyParser.NumberExpressionContext;
import bitsy.antlr4.BitsyParser.OrExpressionContext;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PowerExpressionContext;
import bitsy.antlr4.BitsyParser.ReturnStatementContext;
import bitsy.antlr4.BitsyParser.StringExpressionContext;
import bitsy.antlr4.BitsyParser.SubtractExpressionContext;
import bitsy.antlr4.BitsyParser.TernaryExpressionContext;
import bitsy.antlr4.BitsyParser.UnaryMinusExpressionContext;
import bitsy.lang.symbols.BuiltinType;
import bitsy.lang.symbols.Function;
import bitsy.lang.symbols.FunctionScope;
import bitsy.lang.symbols.LocalScope;
import bitsy.lang.symbols.Scope;
import bitsy.lang.symbols.Symbol;
import bitsy.lang.symbols.SymbolTable;

public class SymbolListener extends BitsyBaseListener {
	SymbolTable symbolTable;
	String sourceName;
    Scope currentScope;
    public ParseTreeProperty<BuiltinType> resultTypes;
    
	public SymbolListener(SymbolTable symbolTable, String sourceName) {
		this.symbolTable = symbolTable;
		this.sourceName = sourceName;
		this.currentScope = symbolTable.globals;
		this.resultTypes = symbolTable.resultTypes;
	}
	
	private void define(String id, BuiltinType type, ParserRuleContext ctx) {
		currentScope.define(new Symbol(id, type, sourceName, ctx.start.getLine()));
	}
	
	@Override
	public void enterParse(@NotNull ParseContext ctx) {
		define("args", BuiltinType.STRING, ctx);
	}
	
	@Override
	public void exitReturnStatement(@NotNull ReturnStatementContext ctx) {
		RuleContext parentCtx = ctx;
		while (parentCtx != null && !(parentCtx instanceof FunctionDeclContext)) {
			parentCtx = parentCtx.getParent();
		}
		if (parentCtx != null && !(ctx.expression() instanceof FunctionCallExpressionContext)) {
			BuiltinType returnType = resultTypes.get(ctx.expression());
			resultTypes.put(parentCtx, returnType);
			String id = ((FunctionDeclContext) parentCtx).IDENTIFIER().getText();
			symbolTable.functions.get(id).checkReturnType(returnType, ctx);
		}
	}
	
	@Override
	public void enterFunctionDecl(@NotNull FunctionDeclContext ctx) {
		currentScope = new FunctionScope(currentScope);
		symbolTable.scopes.put(ctx, currentScope);
		BuiltinType returnType = BuiltinType.VOID;
		String id = ctx.IDENTIFIER().getText();
		if ( ctx.type() != null) {
			returnType = BuiltinType.fromString(ctx.type().getText());
			if (returnType == null) {
				throw new RuntimeException("Invalid return type "+ctx.type().getText()+
						" for function name "+id+" in "+sourceName+
						" on line "+ctx.start.getLine());
			}
		}
		if (symbolTable.functions.containsKey(id)) {
			throw new RuntimeException("Duplicate function name "+id+" in "+sourceName+
					" on line "+ctx.start.getLine());
		}
		Function function = new Function(id, ctx, returnType, sourceName);
		resultTypes.put(ctx, returnType);
		symbolTable.functions.put(id, function);
		if (ctx.argumentList() != null) {
			for (ArgumentContext acx: ctx.argumentList().argument() ) {
				String argument = acx.IDENTIFIER().getText();
				BuiltinType argumentType = BuiltinType.fromString(acx.type().getText());
				if (argumentType == null) {
					throw new RuntimeException("Invalid type "+ acx.type().getText() +
							" for function declaration "+ id +" in "+
	        				sourceName+" on line: "+ctx.start.getLine());
				}
				function.addArgument(argument, argumentType);
				define(argument, argumentType, ctx);
			}
		}
	}
	
	@Override
	public void exitFunctionCallExpression(@NotNull FunctionCallExpressionContext ctx) {
		resultTypes.put(ctx, resultTypes.get(ctx.functionCall()));
	}
	
	@Override
	public void exitIdentifierFunctionCall(@NotNull IdentifierFunctionCallContext ctx) {
		String id = ctx.IDENTIFIER().getText();
		Function function = symbolTable.functions.get(id);
		if (function == null) {
			throw new RuntimeException("Undefined function call to "+id+" in "+
    				sourceName+" on line: "+ctx.start.getLine());
		}
		resultTypes.put(ctx, function.getReturnType());
	}
	
	@Override
	public void exitFunctionDecl(@NotNull FunctionDeclContext ctx) {
		currentScope = currentScope.getEnclosingScope();
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
	public void exitUnaryMinusExpression(
			@NotNull UnaryMinusExpressionContext ctx) {
		if (resultTypes.get(ctx.expression()) != NUMBER) {
			throw new RuntimeException("Invalid expression ["+ctx.getText()
					+"] a number is expected in "+sourceName+" line:"+ctx.start.getLine());
		}
		resultTypes.put(ctx, NUMBER);
	}
	
	@Override
	public void exitNotExpression(@NotNull NotExpressionContext ctx) {
		resultTypes.put(ctx, BOOLEAN);
	}
	
	private BuiltinType getBOPType(ExpressionContext ctx, BinaryOperation bop, BuiltinType left, BuiltinType right) {
		BuiltinType resultType = bop.allowed(left.ordinal() * BinaryOperation.COLS + right.ordinal());
		if (resultType == BuiltinType.NULL) {
			throw new RuntimeException("Invalid arguments types "+left+
				" and "+right+" for "+bop.name()+" operation ["+
				ctx.getText()+"] in "+sourceName+" on line:"+ctx.start.getLine());
		}
		return resultType;
	}
	
	@Override
	public void exitPowerExpression(@NotNull PowerExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.POWER, leftType, rightType));
	}
	
	@Override
	public void exitMultiplyExpression(@NotNull MultiplyExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.MULTIPLY, leftType, rightType));
	}
	
	@Override
	public void exitDivideExpression(@NotNull DivideExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.DIVIDE, leftType, rightType));
	}
	
	@Override
	public void exitModulusExpression(@NotNull ModulusExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.MODULUS, leftType, rightType));
	}
	
	@Override
	public void exitAddExpression(@NotNull AddExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.ADD, leftType, rightType));
	}
	
	@Override
	public void exitSubtractExpression(@NotNull SubtractExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.SUBTRACT, leftType, rightType));
	}
	
	@Override
	public void exitGtEqExpression(@NotNull GtEqExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.GTE, leftType, rightType));
	}
	
	@Override
	public void exitGtExpression(@NotNull GtExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.GT, leftType, rightType));
	}
	
	@Override
	public void exitLtEqExpression(@NotNull LtEqExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.LTE, leftType, rightType));
	}
	
	@Override
	public void exitLtExpression(@NotNull LtExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.LT, leftType, rightType));
	}
	
	@Override
	public void exitEqExpression(@NotNull EqExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.EQ, leftType, rightType));
	}
	
	@Override
	public void exitNotEqExpression(@NotNull NotEqExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.NE, leftType, rightType));
	}
	
	@Override
	public void exitAndExpression(@NotNull AndExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.AND, leftType, rightType));
	}
	
	@Override
	public void exitOrExpression(@NotNull OrExpressionContext ctx) {
		BuiltinType leftType = resultTypes.get(ctx.expression(0));
		BuiltinType rightType = resultTypes.get(ctx.expression(1));
		resultTypes.put(ctx, getBOPType(ctx, BinaryOperation.OR, leftType, rightType));
	}
	
	@Override
	public void exitTernaryExpression(@NotNull TernaryExpressionContext ctx) {
		BuiltinType conditionType = resultTypes.get(ctx.expression(0));
		BuiltinType trueType = resultTypes.get(ctx.expression(1));
		BuiltinType falseType = resultTypes.get(ctx.expression(2));
		if (conditionType != BOOLEAN) {
			throw new RuntimeException("Invalid condition expression "+
				conditionType+" ["+ctx.getText()+
				"] for ternary operationin "+sourceName+" on line:"+
				ctx.start.getLine());
		} else if (trueType != falseType) {
			throw new RuntimeException("Result types for ternary need to be the same "+
					conditionType+" ["+ctx.getText()+
					"] "+sourceName+" on line:"+
					ctx.start.getLine());
		}
		resultTypes.put(ctx, trueType);
	}
	
	@Override
	public void exitNumberExpression(@NotNull NumberExpressionContext ctx) {
		resultTypes.put(ctx, NUMBER);
	}
	
	@Override
	public void exitBoolExpression(@NotNull BoolExpressionContext ctx) {
		resultTypes.put(ctx, BOOLEAN);
	}
	
	@Override
	public void exitNullExpression(@NotNull NullExpressionContext ctx) {
		resultTypes.put(ctx, NULL);
	}
	
	
	
	@Override
	public void exitIdentifierExpression(@NotNull IdentifierExpressionContext ctx) {
		String id = ctx.IDENTIFIER().getText();
		Symbol rhs = currentScope.resolve(id);
		if (rhs == null) {
			throw new RuntimeException("Attempt to reference variable "+id+
					" that does not exist in "+sourceName+" line:"+ctx.start.getLine());
		}
		resultTypes.put(ctx, (BuiltinType) rhs.type);
	}
	
	@Override
	public void exitStringExpression(@NotNull StringExpressionContext ctx) {
		resultTypes.put(ctx, STRING);
	}
	
	@Override
	public void exitListExpression(@NotNull ListExpressionContext ctx) {
		resultTypes.put(ctx, LIST);
	}
	
	@Override
	public void exitExpressionExpression(
			@NotNull ExpressionExpressionContext ctx) {
		resultTypes.put(ctx, resultTypes.get(ctx.expression()));
	}
	
	@Override
	public void exitAssignment(@NotNull AssignmentContext ctx) {
		String id = ctx.IDENTIFIER().getText();
		ExpressionContext ex = ctx.expression();
		define(id, resultTypes.get(ex), ctx);
	}
	
	@Override
	public void enterForStatement(@NotNull ForStatementContext ctx) {
		String id = ctx.IDENTIFIER().getText();
		define(id, BuiltinType.NUMBER, ctx);
	}
}
