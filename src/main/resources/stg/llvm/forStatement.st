forStatement(id, symbol, fromVal, toVal, block, label, register) ::= <<
; forStatement <id> <fromVal> <toVal>
<loadNumber(fromVal, "from", register)>
<loadNumber(toVal, "to", register)>

store double %from<register>, double* %<bitsyVariable(id)>
br label %compareIdAndTo<label>

compareIdAndTo<label>:
	%d<register> = load double* %<bitsyVariable(id)>
	%c<register> = fcmp ole double %d<register>, %to<register>
	br i1 %c<register>, label %forBlock<label>, label %endForStatement<label>
forBlock<label>:    
	<block>

	%currentId<register> = load double* %<bitsyVariable(id)>
	%nextId<register> = fadd double %currentId<register>, 1.000000e+00
	store double %nextId<register>, double* %<bitsyVariable(id)>
	br label %compareIdAndTo<label>
endForStatement<label>:

>>