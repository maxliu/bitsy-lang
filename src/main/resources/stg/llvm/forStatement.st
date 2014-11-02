forStatement(id, symbol, fromVal, toVal, block, scope, label, register) ::= <<
; forStatement <id> <fromVal> <toVal>
<loadNumber(fromVal, "from", scope.register)>
<loadNumber(toVal, "to", scope.register)>

store double %from<scope.register>, double* %<bitsyVariable(id)>
br label %compareIdAndTo<label>

compareIdAndTo<label>:
	%d<scope.register> = load double* %<bitsyVariable(id)>
	%c<scope.register> = fcmp ole double %d<scope.register>, 1.000000e+01
	br i1 %c<scope.register>, label %forBlock<label>, label %endForStatement<label>
forBlock<label>:    
	<block>

	%currentId<scope.register> = load double* %<bitsyVariable(id)>
	%nextId<scope.register> = fadd double %currentId<scope.register>, 1.000000e+00
	store double %nextId<scope.register>, double* %<bitsyVariable(id)>
	br label %compareIdAndTo<label>
endForStatement<label>:

>>