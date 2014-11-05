package bitsy.lang.symbols;

public class FunctionScope extends Scope {
	public FunctionScope(Scope parent) {
		super(parent);
	}

	public String getScopeName() {
		return "function";
	}
}
