package bitsy.lang.symbols;

public enum BuiltinType implements Type {
	STRING("string"),
	NUMBER("number"),
	BOOLEAN("boolean"),
	NULL("null");
	
	String name;
	private BuiltinType(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	
	public String toString() {
		return name;
	}
}
