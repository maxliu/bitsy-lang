package bitsy.lang;

import bitsy.lang.StringUtil;

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
import bitsy.lang.symbols.Scope;

public class TranslateVisitor extends BitsyBaseVisitor<String> {
	public ParseTreeProperty<BitsyValue> values = new ParseTreeProperty<BitsyValue>();
    STGroup group;
    Scope scope;
    String fileName;
    int reg = 1;
    List<BitsyValue> strings = new ArrayList<BitsyValue>();
    
    public TranslateVisitor(STGroup group, Scope scope, String fileName) {
        this.group = group;
        this.scope = scope;
        this.fileName = FilenameUtil.getFilenameAndExtenion(fileName)[0];
    }
    
    int getReg() {
    	return reg++;
    }
    
    public void constantString(BitsyValue s) {
    	if (s.symbol == 0) {
    		strings.add(s);
    		s.symbol = strings.size();
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
    	BitsyValue val = values.get(ctx.expression());
    	st.add("value", val);
    	st.add("reg", val.isReference() ? getReg() : 0);
    	return st.render();
    }
    
    @Override
    public String visitPrintFunctionCall(PrintFunctionCallContext ctx) {
        ST st = group.getInstanceOf("println");
        ExpressionContext ectx = ctx.expression();
        if ( ectx != null) {
        	visit(ectx);
        	BitsyValue val = values.get(ectx);
        	constantString(val);
            st.add("s", val);
        }
        String out = st.render();
        return out;
    }
    
    @Override
    public String visitStringExpression(StringExpressionContext ctx) {
    	BitsyValue str = new BitsyValue(getString(ctx.STRING()));
    	values.put(ctx, str);
    	constantString(str);
    	return "";
    }
    
    @Override
    public String visitNumberExpression(NumberExpressionContext ctx) {
    	try {
    		Double d = Double.parseDouble(ctx.NUMBER().getText());
    		values.put(ctx, new BitsyValue(d));
    	} catch (Exception e) {
    	}
    	return "";
    }
    
    @Override
    public String visitBoolExpression(BoolExpressionContext ctx) {
    	values.put(ctx, new BitsyValue(Boolean.valueOf(ctx.BOOL().getText())));
    	return "";
    }
    
    @Override
    public String visitIdentifierExpression(IdentifierExpressionContext ctx) {
    	String id = ctx.IDENTIFIER().getText();
    	values.put(ctx, new BitsyValue(scope.resolve(id)));
    	return "";
    }
    
	private String getString(TerminalNode inputString) {
		String text = inputString.getText();
		text = text.substring(1, text.length() - 1);
		return text;
	}
}
