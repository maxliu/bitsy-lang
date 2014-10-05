package bitsy.lang;

import java.util.ArrayList;
import java.util.List;

import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;

import bitsy.antlr4.BitsyBaseVisitor;
import bitsy.antlr4.BitsyParser.AssignmentContext;
import bitsy.antlr4.BitsyParser.BlockContext;
import bitsy.antlr4.BitsyParser.BoolExpressionContext;
import bitsy.antlr4.BitsyParser.ExpressionContext;
import bitsy.antlr4.BitsyParser.IdentifierExpressionContext;
import bitsy.antlr4.BitsyParser.NumberExpressionContext;
import bitsy.antlr4.BitsyParser.ParseContext;
import bitsy.antlr4.BitsyParser.PrintFunctionCallContext;
import bitsy.antlr4.BitsyParser.StatementContext;
import bitsy.antlr4.BitsyParser.StringExpressionContext;
import bitsy.lang.symbols.BuiltinType;
import bitsy.lang.symbols.Scope;
import bitsy.lang.symbols.Symbol;
import bitsy.lang.symbols.Value;

public class TranslateVisitor extends BitsyBaseVisitor<String> {
	public ParseTreeProperty<Value> values = new ParseTreeProperty<Value>();
    STGroup group;
    Scope scope;
    String fileName;
    List<Value> strings = new ArrayList<Value>();
    
    public TranslateVisitor(STGroup group, Scope scope, String fileName) {
        this.group = group;
        this.scope = scope;
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
        for(Symbol s: scope.getSymbols()) {
        	if (s.type == BuiltinType.NUMBER) locals++;
        	locals++;
        }
        st.add("locals", locals);
        st.add("block", visit(ctx.block()));
    	return st.render();
    }
    
    @Override
    public String visitBlock(BlockContext ctx) {
        ST st = group.getInstanceOf("block");
        List<String> statements = new ArrayList<String>();
        for (StatementContext pctx: ctx.statement()) {
        	String stmt = this.visit(pctx);
        	if (stmt.trim().length() > 0) {
        		statements.add(stmt);
        	}
        }
        st.add("symbols", scope.getSymbols());
        st.add("statements", statements);
        return st.render();
    }
    
    
    @Override
    public String visitStatement(StatementContext ctx) {
    	return visit(ctx.getChild(0));
    }
    
    @Override
    public String visitAssignment(AssignmentContext ctx) {
    	ST st = group.getInstanceOf("assignment");
    	String id = ctx.IDENTIFIER().getText();
    	st.add("name", id);
    	visit(ctx.expression());
    	Value val = values.get(ctx.expression());
    	scope.assign(id, scope.getRegister());
    	st.add("value", val);
    	st.add("scope", scope);
    	String result = st.render();
    	return result;
    }
    
    @Override
    public String visitPrintFunctionCall(PrintFunctionCallContext ctx) {
        ST st = group.getInstanceOf("println");
        ExpressionContext ectx = ctx.expression();
        if ( ectx != null) {
        	visit(ectx);
        	Value val = values.get(ectx);
            st.add("value", val);
            st.add("scope", scope);
            if (!val.isReference()) {
            	constantString(val);
            }
        }
        String out = st.render();
        return out;
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
    	values.put(ctx, new Value(scope.resolve(id)));
    	return "";
    }
    
	private String getString(TerminalNode inputString) {
		String text = inputString.getText();
		text = text.substring(1, text.length() - 1);
		return text;
	}
}
