package bitsy.lang;

import static bitsy.lang.symbols.BuiltinType.STRING;
import static bitsy.lang.symbols.BuiltinType.NUMBER;
import static bitsy.lang.symbols.BuiltinType.BOOLEAN;
import static bitsy.lang.symbols.BuiltinType.NULL;
import static bitsy.lang.symbols.BuiltinType.LIST;
import static bitsy.lang.symbols.BuiltinType.MAP;
import bitsy.lang.symbols.BuiltinType;

public enum BinaryOperation {
	POWER(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,	NULL,	NULL,
		/* B */	 NULL,	NULL,	NULL,	NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	MULTIPLY(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,   NULL,	NULL,	
		/* B */	 NULL,	NULL,	NULL,   NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	DIVIDE(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,   NULL,	NULL,	
		/* B */	 NULL,	NULL,	NULL,   NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	MODULUS(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,   NULL,	NULL,	
		/* B */	 NULL,	NULL,	NULL,   NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	ADD(new BuiltinType[] {
		//       S, 	 N, 		B,		L,		M
		/* S */  STRING, STRING,	NULL,   LIST,	NULL,	
		/* N */  STRING, NUMBER,	NULL,   LIST,	NULL,	
		/* B */	 NULL,	 NULL,		NULL,   LIST,	NULL,
		/* L */	 LIST,	 LIST,		LIST,	LIST,	NULL,
		/* M */	 NULL,	 NULL,		NULL,	NULL,	MAP
	}),
	SUBTRACT(new BuiltinType[] {
		//       S, 	 N, 		B,		L,		M
		/* S */  NUMBER, NUMBER,	NULL,   NULL,	NULL,	
		/* N */  NUMBER, NUMBER,	NULL,   NULL,	NULL,	
		/* B */	 NULL,	 NULL,		NULL,   NULL,	NULL,
		/* L */	 NULL,	 NULL,		NULL,	LIST,	NULL,
		/* M */	 NULL,	 NULL,		NULL,	NULL,	MAP
	}),
	GTE(new BuiltinType[] {
		//       S,			N, 			B,		L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL
	}),
	GT(new BuiltinType[] {
		//       S,			N, 			B,		L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL
	}),
	LTE(new BuiltinType[] {
		//       S,			N, 			B,		L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL
	}),
	LT(new BuiltinType[] {
		//       S,			N, 			B,		L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL
	}),
	EQ(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,   NULL,	NULL,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,
		/* L */	 NULL,		NULL,		BOOLEAN,   BOOLEAN,	NULL,
		/* M */	 NULL,		NULL,		BOOLEAN,   NULL,	BOOLEAN
	}),
	NE(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,   NULL,	NULL,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,
		/* L */	 NULL,		NULL,		BOOLEAN,   BOOLEAN,	NULL,
		/* M */	 NULL,		NULL,		BOOLEAN,   NULL,	BOOLEAN
	}),
	AND(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,
		/* L */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,
		/* M */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN
	}),
	OR(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	
		/* N */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	
		/* B */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,
		/* L */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,
		/* M */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN
	});
	public static int COLS = 5;
	BuiltinType[] allowed;
	
	private BinaryOperation(BuiltinType[] allowed) {
		this.allowed = allowed;
	}
	public BuiltinType allowed(int index) {
		return allowed[index];
	}
}
