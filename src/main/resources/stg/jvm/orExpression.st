orExpression(lval, rval, scope) ::= <<
<load(lval)>
<ifTrueGotoLabel(lval, scope.nextLabel)>
	<load(rval)>
	<ifTrueGotoLabel(rval, scope.label)>
		iconst_0
		goto endif<scope.label>
true<scope.label>:
	iconst_1
endif<scope.label>:

>>