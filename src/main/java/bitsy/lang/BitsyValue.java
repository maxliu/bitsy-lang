package bitsy.lang;

import bitsy.lang.symbols.BuiltinType;
import bitsy.lang.symbols.Symbol;


public class BitsyValue {
	public static final BitsyValue NULL = new BitsyValue();
	public static final BitsyValue VOID = new BitsyValue();
	
	public int symbol;
	Object value;
    
    private BitsyValue() {
        value = new Object();
    }
    
    public BitsyValue(Object value) {
        this.value = value;
    }
    
    public boolean isReference() {
    	return value instanceof Symbol;
    }
    
    public Symbol asSymbol() {
    	return (Symbol) value;
    }
    
    public boolean isString() {
        return value instanceof String || (isReference() && asSymbol().type == BuiltinType.STRING);
    }
    
    public boolean isNumber() {
        return value instanceof Number || (isReference() && asSymbol().type == BuiltinType.NUMBER);
    }
    
    public boolean isBoolean() {
    	return value instanceof Boolean || (isReference() && asSymbol().type == BuiltinType.BOOL);
    } 
    
    public String asString() {
    	if (isReference()) {
    		return ((Symbol) value).getName();
    	} else if (isString()) {
    		return (String) value;
    	} else if (isBoolean()) {
    		return asBoolean() ? "1" : "0";
    	}
    	return value.toString();
    }
    
    public String toString() {
    	return asString();
    }
    
    public Boolean asBoolean() {
        return (Boolean)value;
    }

    public Double asDouble() {
        return ((Number)value).doubleValue();
    }

    public Long asLong() {
        return ((Number)value).longValue();
    }
    
    @Override
    public int hashCode() {
        return value.hashCode();
    }
    
    public String getLLVMString() {
    	String s = asString().replaceAll("\\\\n", "\\\\0A");
        s = s.replaceAll("\\\\r", "\\\\0D");
        s = s + "\\00"; // null terminate strings 
        return s;
    }
    
    public int getLLVMLength() {
    	String simple = asString().replaceAll("\\\\(.)", "$1");
    	return simple.length() + 1; 
    }
}
