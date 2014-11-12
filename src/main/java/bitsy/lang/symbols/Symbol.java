package bitsy.lang.symbols;

public class Symbol extends Register {
	public String name;      // All symbols at least have a name
    public Scope scope;      // All symbols know what scope contains them.
    public String sourceName;
    public int line;
    int local;
    
	public Symbol(String name, BuiltinType type, String sourceName, int line) {
		super(0, type);
		this.name = name;
		this.type = type;
		this.sourceName = sourceName;
		this.line = line;
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
