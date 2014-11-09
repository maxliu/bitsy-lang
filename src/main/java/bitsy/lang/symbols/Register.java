package bitsy.lang.symbols;

public class Register {
	public Type type;
	private int register;
	
	public Register(int register, Type type) {
		this.register = register;
		this.type = type;
	}
	
	public void setRegister(int register) {
		this.register = register;
	}
	
	public int getRegister() {
		return register;
	}
	
	public void setType(Type type) {
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
}
