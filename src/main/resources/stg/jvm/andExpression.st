andExpression(lval, rval, scope) ::= <<
<load(lval)>
<isTrue(lval, scope.nextLabel)>
	<load(rval)>
	<isTrue(rval, scope.label)>
		iconst_1
		goto endif<scope.label>
false<scope.label>:
	iconst_0
endif<scope.label>:

>>