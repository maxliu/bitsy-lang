package bitsy.lang;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;

import bitsy.antlr4.BitsyBaseVisitor;
import bitsy.antlr4.BitsyParser.AddExpressionContext;
import bitsy.antlr4.BitsyParser.AndExpressionContext;
import bitsy.antlr4.BitsyParser.AssertFunctionCallContext;
import bitsy.antlr4.BitsyParser.AssignmentContext;
import bitsy.antlr4.BitsyParser.BlockContext;
import bitsy.antlr4.BitsyParser.BoolExpressionContext;
import bitsy.antlr4.BitsyParser.DivideExpressionContext;
import bitsy.antlr4.BitsyParser.ElseIfStatContext;
import bitsy.antlr4.BitsyParser.ElseStatContext;
import bitsy.antlr4.BitsyParser.EqExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionExpressionContext;
import bitsy.antlr4.BitsyParser.ForStatementContext;
import bitsy.antlr4.BitsyParser.GtEqExpressionContext;
import bitsy.antlr4.BitsyParser.GtExpressionContext;
import bitsy.antlr4.BitsyParser.IdentifierExpressionContext;
import bitsy.antlr4.BitsyParser.IfStatContext;
import bitsy.antlr4.BitsyParser.IfStatementContext;
import bitsy.antlr4.BitsyParser.LtEqExpressionContext;
import bitsy.antlr4.BitsyParser.LtExpressionContext;
import bitsy.antlr4.BitsyParser.ModulusExpressionContext;
import bitsy.antlr4.BitsyParser.MultiplyExpressionContext;
import bitsy.antlr4.BitsyParser.NotEqExpressionContext;
import bitsy.antlr4.BitsyParser.NotExpressionContext;
import bitsy.antlr4.BitsyParser.NumberExpressionContext;
import bitsy.antlr4.BitsyParser.OrExpressionContext;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PowerExpressionContext;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;
import bitsy.antlr4.BitsyParser.StatementContext;
import bitsy.antlr4.BitsyParser.StringExpressionContext;
import bitsy.antlr4.BitsyParser.SubtractExpressionContext;
import bitsy.antlr4.BitsyParser.TernaryExpressionContext;
import bitsy.antlr4.BitsyParser.UnaryMinusExpressionContext;
import bitsy.antlr4.BitsyParser.WhileStatementContext;
import bitsy.lang.symbols.BuiltinType;
import bitsy.lang.symbols.GlobalScope;
import bitsy.lang.symbols.Register;
import bitsy.lang.symbols.Scope;
import bitsy.lang.symbols.Symbol;
import bitsy.lang.symbols.SymbolTable;
import bitsy.lang.symbols.Type;
import bitsy.lang.symbols.Value;

public class TranslateVisitor extends BitsyBaseVisitor<String> {
	public ParseTreeProperty<Value> values = new ParseTreeProperty<Value>();
    STGroup group;
    SymbolTable symbolTable;
    Scope currentScope;
    String fileName;
    List<Value> strings = new ArrayList<Value>();
    
    public TranslateVisitor(STGroup group, SymbolTable symbolTable, String fileName) {
        this.group = group;
        this.symbolTable = symbolTable;
        this.currentScope = symbolTable.globals;
        this.fileName = FilenameUtil.getFilenameAndExtenion(fileName)[0];
    }
    
    public void constantString(Value s) {
    	if (s.getRegister() == 0) {
    		strings.add(s);
    		s.setRegister(strings.size());
    	}
    }
    
    @Override
    protected String defaultResult() {
        return "";
    }
    
    @Override
    public String visitParse(ParseContext ctx) {
    	ST st = group.getInstanceOf("file");
        st.add("fileName", fileName);
        st.add("strings", strings);
        Scope blockScope = symbolTable.scopes.get(ctx.block());
        st.add("block", visit(ctx.block()));
        st.add("scope", blockScope);
    	return st.render();
    }
    
    @Override
    public String visitBlock(BlockContext ctx) {
    	currentScope = symbolTable.scopes.get(ctx);
        ST st = group.getInstanceOf("block");
        List<String> statements = new ArrayList<String>();
        for (StatementContext pctx: ctx.statement()) {
        	String stmt = this.visit(pctx);
        	if (stmt.trim().length() > 0) {
        		statements.add(stmt);
        	}
        }
        st.add("symbols", currentScope.getSymbols());
        st.add("statements", statements);
        st.add("scope", currentScope);
        String result = st.render();
    	currentScope = currentScope.getEnclosingScope();
        return result;
    }
    
    
    @Override
    public String visitStatement(StatementContext ctx) {
    	return visit(ctx.getChild(0));
    }
    
    @Override
    public String visitAssignment(AssignmentContext ctx) {
    	StringBuilder result = new StringBuilder();
    	ST st = group.getInstanceOf("assignment");
    	String id = ctx.IDENTIFIER().getText();
    	st.add("name", id);
    	result.append(visit(ctx.expression()));
    	Value val = values.get(ctx.expression());
    	Symbol symbol = currentScope.assign(id, currentScope.getRegister());
    	st.add("symbol", symbol);
    	st.add("value", val);
    	st.add("scope", currentScope);
    	result.append(st.render());
    	return result.toString();
    }
    
    @Override
    public String visitPrintFunctionCall(PrintFunctionCallContext ctx) {
    	StringBuilder result = new StringBuilder();
        ST st = group.getInstanceOf("println");
        ExpressionContext ectx = ctx.expression();
        if ( ectx != null) {
        	result.append(visit(ectx));
        	Value val = values.get(ectx);
            st.add("value", val);
            st.add("scope", currentScope);
            if (!val.isReference()) {
            	constantString(val);
            }
        }
        result.append(st.render());
        return result.toString();
    }
    
    @Override
    public String visitAssertFunctionCall(AssertFunctionCallContext ctx) {
    	StringBuilder result = new StringBuilder();
        ST st = group.getInstanceOf("assert");
        ExpressionContext ectx = ctx.expression();
        if ( ectx != null) {
        	result.append(visit(ectx));
        	Value val = values.get(ectx);
        	getMethodScope().getNextRegister();
            st.add("value", val);
            st.add("label", getMethodScope().getNextLabel());
            st.add("scope", getMethodScope());
            st.add("line", ectx.start.getLine());
            if (!val.isReference()) {
            	constantString(val);
            }
            
            // TODO replace the function name here, possibly the brackets message
            Value message = new Value("Assertion failed: (false), function main, file "+
            		fileName+".bit, line "+ectx.start.getLine()+".");
            constantString(message);
            st.add("message", message);
        }
        result.append(st.render());
        return result.toString();
    }
    

    private String renderUOP(ExpressionContext ctx, ST st) {
    	StringBuilder result = new StringBuilder();
    	result.append(visit(ctx));
    	Value value = values.get(ctx);
    	st.add("scope", currentScope);
    	st.add("value", value);
    	currentScope.getNextRegister();
    	result.append(st.render());
    	Register ref = new Register(currentScope.getRegister(), symbolTable.resultTypes.get(ctx.parent));
    	values.put(ctx.parent, new Value(ref));
    	return result.toString();
    }
    
    @Override
    public String visitUnaryMinusExpression(UnaryMinusExpressionContext ctx) {
    	ST st = group.getInstanceOf("unaryMinusExpression");
    	return renderUOP(ctx.expression(), st);
    }
    
    @Override
    public String visitNotExpression(NotExpressionContext ctx) {
    	ST st = group.getInstanceOf("notExpression");
    	return renderUOP(ctx.expression(), st);
    }
    
    private String renderBOP(ExpressionContext ctx, ST st, List<ExpressionContext> ecx, BinaryOperation bop) {
    	StringBuilder result = new StringBuilder();
    	ExpressionContext lcx = ecx.get(0);
    	ExpressionContext rcx = ecx.get(1);
    	result.append(visit(lcx));
    	result.append(visit(rcx));
    	Value lval = values.get(lcx);
    	Value rval = values.get(rcx);
    	st.add("lval", lval);
    	st.add("rval", rval);
    	st.add("scope", currentScope);
    	currentScope.getNextRegister();
    	result.append(st.render());
    	Register ref = new Register(currentScope.getRegister(), symbolTable.resultTypes.get(lcx.parent));
    	values.put(ctx, new Value(ref));
		return result.toString();
    }
    
    @Override
    public String visitGtEqExpression(GtEqExpressionContext ctx) {
    	ST st = group.getInstanceOf("gtEqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.GTE);
    }
    
    @Override
    public String visitGtExpression(GtExpressionContext ctx) {
    	ST st = group.getInstanceOf("gtExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.GT);
    }
    
    @Override
    public String visitLtExpression(LtExpressionContext ctx) {
    	ST st = group.getInstanceOf("ltExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.LT);
    }
    
    @Override
    public String visitLtEqExpression(LtEqExpressionContext ctx) {
    	ST st = group.getInstanceOf("ltEqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.LTE);
    }
    
    @Override
    public String visitEqExpression(EqExpressionContext ctx) {
    	ST st = group.getInstanceOf("eqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.EQ);
    }
    
    @Override
    public String visitNotEqExpression(NotEqExpressionContext ctx) {
    	ST st = group.getInstanceOf("neqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.NE);
    }
    
    @Override
    public String visitPowerExpression(PowerExpressionContext ctx) {
    	ST st = group.getInstanceOf("powerExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.POWER);
    }
    
    @Override
    public String visitMultiplyExpression(MultiplyExpressionContext ctx) {
    	ST st = group.getInstanceOf("multiplyExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.MULTIPLY);
    }
    
    @Override
    public String visitDivideExpression(DivideExpressionContext ctx) {
    	ST st = group.getInstanceOf("divideExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.DIVIDE);
    }
    
    @Override
    public String visitModulusExpression(ModulusExpressionContext ctx) {
    	ST st = group.getInstanceOf("modulusExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.MODULUS);
    }
    
    @Override
    public String visitAddExpression(AddExpressionContext ctx) {
    	ST st = group.getInstanceOf("addExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.ADD);
    }
    
    @Override
    public String visitSubtractExpression(SubtractExpressionContext ctx) {
    	ST st = group.getInstanceOf("subtractExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.SUBTRACT);
    }
    
    @Override
    public String visitAndExpression(AndExpressionContext ctx) {
    	ST st = group.getInstanceOf("andExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.AND);
    }
    
    @Override
    public String visitOrExpression(OrExpressionContext ctx) {
    	ST st = group.getInstanceOf("orExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx, BinaryOperation.OR);
    }
    
    @Override
    public String visitTernaryExpression(TernaryExpressionContext ctx) {
    	ST st = group.getInstanceOf("ternaryExpression");
    	StringBuilder result = new StringBuilder();
    	ExpressionContext conditionCtx = ctx.expression(0);
    	ExpressionContext trueCtx = ctx.expression(1);
    	ExpressionContext falseCtx = ctx.expression(2);
    	result.append(visit(conditionCtx));
    	Value value = values.get(conditionCtx);
    	st.add("value", value);
    	st.add("trueBlock", visit(trueCtx));
    	st.add("trueVal", values.get(trueCtx));
    	st.add("falseBlock", visit(falseCtx));
    	st.add("falseVal", values.get(falseCtx));
    	st.add("scope", currentScope);
    	st.add("label", currentScope.getNextLabel());
    	currentScope.getNextRegister();
    	result.append(st.render());
    	Register ref = new Register(currentScope.getRegister(), values.get(trueCtx).type());
    	values.put(ctx, new Value(ref));
		return result.toString();
    }
    
    @Override
    public String visitExpressionExpression(ExpressionExpressionContext ctx) {
    	String result = visit(ctx.expression());
    	values.put(ctx, values.get(ctx.expression()));
    	return result;
    }
    
    @Override
    public String visitStringExpression(StringExpressionContext ctx) {
    	Value str = new Value(getString(ctx.STRING()));
    	values.put(ctx, str);
    	constantString(str);
    	return "";
    }
    
    @Override
    public String visitNumberExpression(NumberExpressionContext ctx) {
    	try {
    		Double d = Double.parseDouble(ctx.NUMBER().getText());
    		values.put(ctx, new Value(d));
    	} catch (Exception e) {
    	}
    	return "";
    }
    
    @Override
    public String visitBoolExpression(BoolExpressionContext ctx) {
    	values.put(ctx, new Value(Boolean.valueOf(ctx.BOOL().getText())));
    	return "";
    }
    
    @Override
    public String visitIdentifierExpression(IdentifierExpressionContext ctx) {
    	String id = ctx.IDENTIFIER().getText();
    	Symbol s = currentScope.resolve(id);
    	if (s == null) {
    		throw new RuntimeException("Invalid identifier "+id+" in "+fileName+".bit on line:"+ctx.start.getLine());
    	}
    	values.put(ctx, new Value(s));
    	return "";
    }
    
	private String getString(TerminalNode inputString) {
		String text = inputString.getText();
		text = text.substring(1, text.length() - 1);
		return text;
	}
	
	@Override
	public String visitIfStatement(IfStatementContext ctx) {
		StringBuilder ifStat = new StringBuilder();
		int label = getMethodScope().getNextLabel();
		int sublevel = 0;
		ifStat.append(visitIfStat(ctx.ifStat(), label, sublevel++));
		for (ElseIfStatContext ectx :ctx.elseIfStat()) {
			ifStat.append(visitElseIfStat(ectx, label, sublevel++));
		}
		if (ctx.elseStat() != null) {
			ifStat.append(visitElseStat(ctx.elseStat(), label));
		}
		ST st = group.getInstanceOf("endifStat");
		st.add("label", label);
		ifStat.append(st.render());
		return ifStat.toString();
	}
	
	public String visitIfStat(IfStatContext ctx, int label, int sublevel) {
		StringBuilder result = new StringBuilder();
		ST st = group.getInstanceOf("ifStat");
		result.append(visit(ctx.expression()));
		Value val = values.get(ctx.expression());
		st.add("value", val);
		st.add("block", visit(ctx.block()));
		st.add("scope", getMethodScope());
		st.add("label", label);
		st.add("sublevel", sublevel);
		result.append(st.render());
		return result.toString();
	}
	
	public String visitElseIfStat(ElseIfStatContext ctx, int label, int sublevel) {
		StringBuilder result = new StringBuilder();
		ST st = group.getInstanceOf("elseifStat");
		result.append(visit(ctx.expression()));
		Value val = values.get(ctx.expression());
		st.add("value", val);
		st.add("block", visit(ctx.block()));
		st.add("scope", getMethodScope());
		st.add("label", label);
		st.add("sublevel", sublevel);
		result.append(st.render());
		return result.toString();
	}
	
	public String visitElseStat(ElseStatContext ctx, int label) {
		ST st = group.getInstanceOf("elseStat");
		st.add("block", visit(ctx.block()));
		st.add("label", label);
		return st.render();
	}
	
	@Override
	public String visitForStatement(ForStatementContext ctx) {
		StringBuilder result = new StringBuilder();
		result.append(visit(ctx.expression(0)));
		result.append(visit(ctx.expression(1)));
		Value from = values.get(ctx.expression(0));
		Value to = values.get(ctx.expression(1));
		ST st = group.getInstanceOf("forStatement");
		currentScope.getNextRegister();
		String id = ctx.IDENTIFIER().getText();
		currentScope.assign(id, currentScope.getRegister());
		st.add("id", id);
		st.add("symbol", currentScope.resolve(id));
		st.add("fromVal", from);
		st.add("toVal", to);
		st.add("register", currentScope.getRegister());
		st.add("scope", currentScope);
		st.add("label", currentScope.getNextLabel());
		st.add("block", visit(ctx.block()));
		result.append(st.render());
		return result.toString();
	}
	
	@Override
	public String visitWhileStatement(WhileStatementContext ctx) {
		ST st = group.getInstanceOf("whileStatement");
		currentScope.getNextRegister();
		st.add("valBlock", visit(ctx.expression()));
		st.add("register", currentScope.getRegister());
		st.add("value", values.get(ctx.expression()));
		st.add("block", visit(ctx.block()));
		st.add("label", currentScope.getNextLabel());
		st.add("scope", currentScope);
		return st.render();
	}
	
	private Scope getMethodScope() {
		Scope walkScope = currentScope;
		if (walkScope instanceof GlobalScope) {
			return walkScope;
		}
		while (!(walkScope.getEnclosingScope() instanceof GlobalScope)) {
			walkScope = walkScope.getEnclosingScope();
		}
		return walkScope;
	}
}
