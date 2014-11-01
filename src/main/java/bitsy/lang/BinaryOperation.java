package bitsy.lang;

import static bitsy.lang.symbols.BuiltinType.STRING;
import static bitsy.lang.symbols.BuiltinType.NUMBER;
import static bitsy.lang.symbols.BuiltinType.BOOLEAN;
import static bitsy.lang.symbols.BuiltinType.NULL;
import bitsy.lang.symbols.BuiltinType;

public enum BinaryOperation {
	POWER(new BuiltinType[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	MULTIPLY(new BuiltinType[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	DIVIDE(new BuiltinType[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	MODULUS(new BuiltinType[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	ADD(new BuiltinType[] {
		//       S, 	 N, 		B
		/* S */  STRING, STRING,	NULL,	
		/* N */  STRING, NUMBER,	NULL,	
		/* B */	 NULL,	 NULL,		NULL
	}),
	SUBTRACT(new BuiltinType[] {
		//       S, 	 N, 		B
		/* S */  NUMBER, NUMBER,	NULL,	
		/* N */  NUMBER, NUMBER,	NULL,	
		/* B */	 NULL,	 NULL,		NULL
	}),
	GTE(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	GT(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	LTE(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	LT(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	EQ(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	}),
	NE(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	}),
	AND(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	}),
	OR(new BuiltinType[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	});
	public static int COLS = 3;
	BuiltinType[] allowed;
	
	private BinaryOperation(BuiltinType[] allowed) {
		this.allowed = allowed;
	}
	public BuiltinType allowed(int index) {
		return allowed[index];
	}
}
