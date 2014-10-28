package bitsy.lang;

import static bitsy.lang.symbols.BuiltinType.STRING;
import static bitsy.lang.symbols.BuiltinType.NUMBER;
import static bitsy.lang.symbols.BuiltinType.BOOLEAN;
import static bitsy.lang.symbols.BuiltinType.NULL;
import bitsy.lang.symbols.Type;

public enum BinaryOperation {
	POWER(new Type[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	MULTIPLY(new Type[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	DIVIDE(new Type[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	MODULUS(new Type[] {
		//       S, 	N, 		B
		/* S */  NULL,  NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	
		/* B */	 NULL,	NULL,	NULL
	}), 
	ADD(new Type[] {
		//       S, 	 N, 		B
		/* S */  STRING, STRING,	NULL,	
		/* N */  STRING, NUMBER,	NULL,	
		/* B */	 NULL,	 NULL,		NULL
	}),
	SUBTRACT(new Type[] {
		//       S, 	 N, 		B
		/* S */  NUMBER, NUMBER,	NULL,	
		/* N */  NUMBER, NUMBER,	NULL,	
		/* B */	 NULL,	 NULL,		NULL
	}),
	GTE(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	GT(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	LTE(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	LT(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 NULL,		NULL,		NULL
	}),
	EQ(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	}),
	NE(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	}),
	AND(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	}),
	OR(new Type[] {
		//       S,			N, 			B
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN
	});
	public static int COLS = 3;
	Type[] allowed;
	
	private BinaryOperation(Type[] allowed) {
		this.allowed = allowed;
	}
	public Type allowed(int index) {
		return allowed[index];
	}
}
