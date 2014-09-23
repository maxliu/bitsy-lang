package bitsy.lang;

public class BitsyValue {
    Object value;
    
    public BitsyValue(String value) {
        this.value = new CString(value);
    }
    
    public boolean isString() {
        return value instanceof String;
    }
    
    public String asString() {
        return (String) value;
    }
    
    public CString asCString() {
        return new CString(asString());
    }
    
    @Override
    public int hashCode() {
        return value.hashCode();
    }
}
