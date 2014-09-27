package bitsy.lang;

public class LLVMStringUtil {

    public static int getLength(String s) {
    	String simple = s.replaceAll("\\\\(.)", "$1");
    	return simple.length() + 1; 
    }
    
    public static String encode(String s) {
        s = s.replaceAll("\\\\n", "\\\\0A");
        s = s.replaceAll("\\\\r", "\\\\0D");
        s = s + "\\00"; // null terminate strings 
        return s;
    }
}