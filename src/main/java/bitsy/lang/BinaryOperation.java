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
		//       S, 	N, 		B,		L,		M, 		Null
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	NULL,
		/* N */  NULL,  NUMBER,	NULL,	NULL,	NULL,	NULL,
		/* B */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	MULTIPLY(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M, 		Null
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,	NULL,	NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	DIVIDE(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M, 		Null
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,	NULL,	NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	MODULUS(new BuiltinType[] {
		//       S, 	N, 		B,		L,		M, 		Null
		/* S */  NULL,  NULL,	NULL,   NULL,	NULL,	NULL,	
		/* N */  NULL,  NUMBER,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,	NULL,	NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	NULL,	NULL,	NULL,	NULL,	NULL
	}), 
	ADD(new BuiltinType[] {
		//       S, 	 N, 		B,		L,		M,		Null
		/* S */  STRING, STRING,	NULL,   LIST,	NULL,	NULL,	
		/* N */  STRING, NUMBER,	NULL,   LIST,	NULL,	NULL,	
		/* B */	 NULL,	 NULL,		NULL,   LIST,	NULL,	NULL,
		/* L */	 LIST,	 LIST,		LIST,	LIST,	NULL,	LIST,
		/* M */	 NULL,	 NULL,		NULL,	NULL,	MAP,	NULL,
		/*Nul*/	 NULL,	 NULL,		NULL,	LIST,	NULL,	NULL
	}),
	SUBTRACT(new BuiltinType[] {
		//       S, 	 N, 		B,		L,		M,		Null
		/* S */  NUMBER, NUMBER,	NULL,   NULL,	NULL,	NULL,	
		/* N */  NUMBER, NUMBER,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,	 NULL,		NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,	 NULL,		NULL,	LIST,	NULL,	NULL,
		/* M */	 NULL,	 NULL,		NULL,	NULL,	MAP,	NULL,
		/*Nul*/	 NULL,	 NULL,		NULL,	NULL,	NULL,	NULL
	}),
	GTE(new BuiltinType[] {
		//       S,			N, 			B,		L,		M,		Null
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	NULL,	NULL,	NULL
	}),
	GT(new BuiltinType[] {
		//       S,			N, 			B,		L,		M,		Null
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	NULL,	NULL,	NULL
	}),
	LTE(new BuiltinType[] {
		//       S,			N, 			B,		L,		M,		Null
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	NULL,	NULL,	NULL
	}),
	LT(new BuiltinType[] {
		//       S,			N, 			B,		L,		M,		Null
		/* S */  BOOLEAN, 	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	NULL,   NULL,	NULL,	NULL,	
		/* B */	 NULL,		NULL,		NULL,   NULL,	NULL,	NULL,
		/* L */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/* M */	 NULL,		NULL,		NULL,	NULL,	NULL,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	NULL,	NULL,	NULL
	}),
	EQ(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M,			Null
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   NULL,	NULL,		NULL,
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,   NULL,	NULL,		NULL,
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/* L */	 NULL,		NULL,		BOOLEAN,   BOOLEAN,	NULL,		NULL,
		/* M */	 NULL,		NULL,		BOOLEAN,   NULL,	BOOLEAN,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	   NULL,	NULL,		NULL
	}),
	NE(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M,			Null
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   NULL,	NULL,		NULL,	
		/* N */  BOOLEAN,	BOOLEAN,	BOOLEAN,   NULL,	NULL,		NULL,	
		/* B */	 BOOLEAN,	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/* L */	 NULL,		NULL,		BOOLEAN,   BOOLEAN,	NULL,		NULL,
		/* M */	 NULL,		NULL,		BOOLEAN,   NULL,	BOOLEAN,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	   NULL,	NULL,		NULL
	}),
	AND(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M,			Null
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,	
		/* N */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/* L */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/* M */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	   NULL,	NULL,		NULL
	}),
	OR(new BuiltinType[] {
		//       S,			N, 			B,		   L,		M,			Null
		/* S */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,	
		/* N */  BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,	
		/* B */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/* L */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/* M */	 BOOLEAN, 	BOOLEAN,	BOOLEAN,   BOOLEAN,	BOOLEAN,	NULL,
		/*Nul*/	 NULL,	 	NULL,		NULL,	   NULL,	NULL,		NULL
	});
	public static int COLS = 6;
	BuiltinType[] allowed;
	
	private BinaryOperation(BuiltinType[] allowed) {
		this.allowed = allowed;
	}
	public BuiltinType allowed(int index) {
		return allowed[index];
	}
}
