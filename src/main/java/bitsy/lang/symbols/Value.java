package bitsy.lang.symbols;

public class Value {
	public static final Value NULL = new Value();
	public static final Value VOID = new Value();
	private int register;
	Object value;
    
    private Value() {
        value = new Object();
    }
    
    public Value(Object value) {
        this.value = value;
    }
    
    public boolean isReference() {
    	return value instanceof Register;
    }
    
    public boolean isSymbol() {
    	return value instanceof Symbol;
    }
    
    public boolean isLiteral() {
    	return !(value instanceof Register);
    }
    
    public boolean isOnstack() {
    	return (value instanceof Register) && !(value instanceof Symbol);
    }
    
    public Register asReference() {
    	return (Register) value;
    }
    
    
    public boolean isString() {
        return value instanceof String || (isReference() && asReference().isString());
    }
    
    public boolean isNumber() {
        return value instanceof Number || (isReference() && asReference().isNumber());
    }
    
    public boolean isBoolean() {
    	return value instanceof Boolean || (isReference() && asReference().isBoolean());
    }
    
    public boolean isOnTrue() {
    	return asBoolean();
    }
    
    public boolean isOnFalse() {
    	return !asBoolean();
    }
    
    public String asString() {
    	if (isReference()) {
    		if (value instanceof Symbol) {
    			return ((Symbol) value).getName();
    		} else {
    			return ((Register) value).getRegister()+"";
    		}
    	} else if (isString()) {
    		return (String) value;
    	} else if (isBoolean()) {
    		return asBoolean() ? "1" : "0";
    	} else if (value == null) {
    		return "";
    	}
    	return value.toString();
    }
    
    public String toString() {
    	return asString();
    }
    
    public long getLong() {
    	if (isNumber()) {
    		return asLong();
    	} else {
    		return 0;
    	}
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
    
    public int getRegister() {
    	if (isReference()) {
    		return ((Symbol) value).getRegister();
    	} 
    	return register;
    }
    
    public void setRegister(int register) {
    	this.register = register;
    }
    
    public String getToBoolean() {
    	if (isReference()) {
    		throw new RuntimeException("Not to be used for references");
    	}
    	if (isString()) {
    		return asString().length() != 0 ? "1" : "0";
    	} else if (isNumber()) {
    		return asDouble() != 0 ? "1" : "0";
    	} else {
    		return asBoolean() ? "1" : "0";
    	}
    }
    
    public String getType() {
    	if (isNumber()) {
    		return "number";
    	} else if (isBoolean()) {
    		return "boolean";
    	} else {
    		return "string";
    	}
    }
    
    public BuiltinType type() {
    	if (isNumber()) {
    		return BuiltinType.NUMBER;
    	} else if (isBoolean()) {
    		return BuiltinType.BOOLEAN;
    	} else {
    		return BuiltinType.STRING;
    	}
    }
}
