package bitsy.lang.symbols;

public enum BuiltinType implements Type {
	STRING("string"),
	NUMBER("number"),
	BOOLEAN("boolean"),
	NULL("null"),
	VOID("void");
	
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
	
	public static BuiltinType fromString(String type) {
		for(BuiltinType bt: values()) {
			if (type.equals(bt.name)) {
				return bt;
			}
		}
		return null;
	}
	
	public boolean isNull() {
		return this == NULL;
	}
}
