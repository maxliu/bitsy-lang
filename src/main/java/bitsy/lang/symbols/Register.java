package bitsy.lang.symbols;

public class Register {
	public BuiltinType type;
	private int register;
	private int size;
	
	public Register(int register, BuiltinType type) {
		this(register, type, 0);
	}
	
	public Register(int register, BuiltinType type, int size) {
		this.register = register;
		this.type = type;
		this.size = size;
	}
	
	public int getSize() {
		return size;
	}
	
	public void setRegister(int register) {
		this.register = register;
	}
	
	public int getRegister() {
		return register;
	}
	
	public void setType(BuiltinType type) {
		this.type = type;
	}
	
	public boolean isString() {
		return type == BuiltinType.STRING;
	}
	
	public boolean isNumber() {
		return type == BuiltinType.NUMBER;
	}
	
	public boolean isBoolean() {
		return type == BuiltinType.BOOLEAN;
	}
	
	public boolean isList() {
		return type == BuiltinType.LIST;
	}
	
	public boolean isMap() {
		return type == BuiltinType.MAP;
	}

	public boolean isNull() {
		return type == BuiltinType.NULL;
	}
}
