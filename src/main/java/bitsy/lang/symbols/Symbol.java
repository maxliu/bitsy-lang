package bitsy.lang.symbols;

public class Symbol extends Register {
	public String name;      // All symbols at least have a name
    public Scope scope;      // All symbols know what scope contains them.
    int local;
    
    public Symbol(String name) { 
    	this(name, null); 
    }
    
	public Symbol(String name, Type type) {
		super(0, type);
		this.name = name;
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
	
	public void setLocal(int local) {
		this.local = local;
	}
	
	public int getLocal() {
		return local;
	}
}
