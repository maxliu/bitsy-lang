package bitsy.lang;

public class CString {
    String s;
    public CString(String s) { this.s = s; }

    public int getLengthInBytes() {
    	String simple = s.replaceAll("\\\\(.)", "$1");
    	return simple.length() + 1; 
    }
    
    public String toString() {
        s = s.replaceAll("\\\\n", "\\\\0A");
        s = s.replaceAll("\\\\r", "\\\\0D");
        s = s + "\\00"; // null terminate strings 
        return s;
    }
}
