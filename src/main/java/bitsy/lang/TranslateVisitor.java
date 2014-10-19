package bitsy.lang;

import java.util.ArrayList;
import java.util.List;

import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;

import bitsy.antlr4.BitsyBaseVisitor;
import bitsy.antlr4.BitsyParser.AndExpressionContext;
import bitsy.antlr4.BitsyParser.AssignmentContext;
import bitsy.antlr4.BitsyParser.BlockContext;
import bitsy.antlr4.BitsyParser.BoolExpressionContext;
import bitsy.antlr4.BitsyParser.ElseIfStatContext;
import bitsy.antlr4.BitsyParser.ElseStatContext;
import bitsy.antlr4.BitsyParser.EqExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.GtEqExpressionContext;
import bitsy.antlr4.BitsyParser.GtExpressionContext;
import bitsy.antlr4.BitsyParser.IdentifierExpressionContext;
import bitsy.antlr4.BitsyParser.IfStatContext;
import bitsy.antlr4.BitsyParser.IfStatementContext;
import bitsy.antlr4.BitsyParser.LtEqExpressionContext;
import bitsy.antlr4.BitsyParser.LtExpressionContext;
import bitsy.antlr4.BitsyParser.NotEqExpressionContext;
import bitsy.antlr4.BitsyParser.NumberExpressionContext;
import bitsy.antlr4.BitsyParser.OrExpressionContext;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;
import bitsy.antlr4.BitsyParser.StatementContext;
import bitsy.antlr4.BitsyParser.StringExpressionContext;
import bitsy.lang.symbols.BuiltinType;
import bitsy.lang.symbols.GlobalScope;
import bitsy.lang.symbols.Register;
import bitsy.lang.symbols.Scope;
import bitsy.lang.symbols.Symbol;
import bitsy.lang.symbols.SymbolTable;
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
        int locals = 1;
        Scope blockScope = symbolTable.scopes.get(ctx.block());
        for(Symbol s: blockScope.getSymbols()) {
        	if (s.type == BuiltinType.NUMBER) locals++;
        	locals++;
        }
        st.add("locals", locals);
        st.add("block", visit(ctx.block()));
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
    	currentScope.assign(id, currentScope.getRegister());
    	st.add("value", val);
    	st.add("scope", currentScope);
    	result.append(st.render());
    	return result.toString();
    }
    
    @Override
    public String visitPrintFunctionCall(PrintFunctionCallContext ctx) {
        ST st = group.getInstanceOf("println");
        ExpressionContext ectx = ctx.expression();
        if ( ectx != null) {
        	visit(ectx);
        	Value val = values.get(ectx);
            st.add("value", val);
            st.add("scope", currentScope);
            if (!val.isReference()) {
            	constantString(val);
            }
        }
        String out = st.render();
        return out;
    }
    
    private String renderBOP(ExpressionContext ctx, ST st, List<ExpressionContext> ecx) {
    	StringBuilder result = new StringBuilder();
    	ExpressionContext lcx = ecx.get(0);
    	ExpressionContext rcx = ecx.get(1);
    	result.append(visit(lcx));
    	result.append(visit(rcx));
    	st.add("lval", values.get(lcx));
    	st.add("rval", values.get(rcx));
    	st.add("scope", currentScope);
    	currentScope.getNextRegister();
    	result.append(st.render());
    	Register ref = new Register(currentScope.getRegister(), BuiltinType.BOOLEAN);
    	values.put(ctx, new Value(ref));
		return result.toString();
    }
    
    @Override
    public String visitGtEqExpression(GtEqExpressionContext ctx) {
    	ST st = group.getInstanceOf("gtEqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitGtExpression(GtExpressionContext ctx) {
    	ST st = group.getInstanceOf("gtExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitLtExpression(LtExpressionContext ctx) {
    	ST st = group.getInstanceOf("ltExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitLtEqExpression(LtEqExpressionContext ctx) {
    	ST st = group.getInstanceOf("ltEqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitEqExpression(EqExpressionContext ctx) {
    	ST st = group.getInstanceOf("eqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitNotEqExpression(NotEqExpressionContext ctx) {
    	ST st = group.getInstanceOf("neqExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitAndExpression(AndExpressionContext ctx) {
    	ST st = group.getInstanceOf("andExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
    }
    
    @Override
    public String visitOrExpression(OrExpressionContext ctx) {
    	ST st = group.getInstanceOf("orExpression");
    	List<ExpressionContext> ecx = ctx.expression();
    	return renderBOP(ctx, st, ecx);
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
    	values.put(ctx, new Value(currentScope.resolve(id)));
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
	
	private Scope getMethodScope() {
		Scope walkScope = currentScope;
		while (!(walkScope.getEnclosingScope() instanceof GlobalScope)) {
			walkScope = walkScope.getEnclosingScope();
		}
		return walkScope;
	}
}
