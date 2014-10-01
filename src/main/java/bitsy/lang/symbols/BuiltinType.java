package bitsy.lang.symbols;

public class BuiltinType implements Type {
	public static Type STRING = new BuiltinType("string");
	public static Type NUMBER = new BuiltinType("number");
	public static Type BOOLEAN = new BuiltinType("boolean");
	public static Type NULL = new BuiltinType("null");
	String name;
	
	private BuiltinType(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
}
