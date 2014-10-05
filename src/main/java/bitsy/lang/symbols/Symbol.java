package bitsy.lang.symbols;

public class Symbol {
	public String name;      // All symbols at least have a name
    public Type type;
    public Scope scope;      // All symbols know what scope contains them.
    private int register;
    
    public Symbol(String name) { 
    	this.name = name; 
    }
    
	public Symbol(String name, Type type) {
		this(name);
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public boolean isGlobal() {
		return scope instanceof GlobalScope;
	}

	public String toString() {
		if (type != null) {
			return '<' + getName() + ":" + type + '>';
		}
		return getName();
	}
	
	public void setRegister(int register) {
		this.register = register;
	}
	
	public int getRegister() {
		return register;
	}
}
