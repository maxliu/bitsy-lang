package bitsy.lang.symbols;

public class GlobalScope extends Scope {
	public GlobalScope() {
		super(null);
	}

	public String getScopeName() {
		return "global";
	}
}
