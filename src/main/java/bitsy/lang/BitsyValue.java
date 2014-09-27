package bitsy.lang;


public class BitsyValue {
	public static final BitsyValue NULL = new BitsyValue();
	public static final BitsyValue VOID = new BitsyValue();

	Object value;
    
    private BitsyValue() {
        value = new Object();
    }
    
    public BitsyValue(Object value) {
        this.value = value;
    }
    
    public boolean isString() {
        return value instanceof String;
    }
    
    public boolean isNumber() {
        return value instanceof Number;
    } 
    
    public String asString() {
    	if (isString()) {
    		return (String) value;
    	} 
    	return value.toString();
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
        return LLVMStringUtil.encode(asString());
    }
    
    public int getLLVMLength() {
    	return LLVMStringUtil.getLength(asString());
    }
}
