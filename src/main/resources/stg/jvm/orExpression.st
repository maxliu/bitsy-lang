orExpression(lval, rval, scope) ::= <<
<load(lval)>
<ifTrueGotoLabel(lval, scope.nextLabel, rval.onstack)>
	<load(rval)>
	<ifTrueGotoLabel(rval, scope.label, false)>
		iconst_0
		goto endif<scope.label>
<if(rval.onstack)>
truePop<scope.label>:		
	pop
<endif>
true<scope.label>:
	iconst_1
endif<scope.label>:

>>