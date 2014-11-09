package bitsy.lang.symbols;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class BuiltinTypeList implements Iterable<BuiltinType>{
	List<BuiltinType> types = new ArrayList<BuiltinType>();
	
	public BuiltinTypeList() {
		
	}
	
	public BuiltinTypeList(BuiltinType[] types) {
		for (BuiltinType type: types) {
			add(type);
		}
	}
	
	BuiltinTypeList add(BuiltinType type) {
		types.add(type);
		return this;
	}

	@Override
	public Iterator<BuiltinType> iterator() {
		return types.iterator();
	}
	
}
