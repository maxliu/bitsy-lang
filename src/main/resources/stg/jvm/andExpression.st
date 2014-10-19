andExpression(lval, rval, scope) ::= <<
<load(lval)>
<ifFalseGotoLabel(lval, scope.nextLabel)>
	<load(rval)>
	<ifFalseGotoLabel(rval, scope.label)>
		iconst_1
		goto endif<scope.label>
false<scope.label>:
	iconst_0
endif<scope.label>:

>>