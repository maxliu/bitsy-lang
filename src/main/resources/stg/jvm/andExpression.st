andExpression(lval, rval, scope) ::= <<; START and
<load(lval)>
<ifFalseGotoLabel(lval, scope.nextLabel, rval.onstack)>
	<load(rval)>
	<ifFalseGotoLabel(rval, scope.label, false)>
		iconst_1
		goto endif<scope.label>
<if(rval.onstack)>
falsePop<scope.label>:		
	pop
<endif>
false<scope.label>:
	iconst_0
endif<scope.label>:
; END and

>>