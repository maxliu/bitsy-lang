andExpression(lval, rval, scope) ::= <<
if [[ <isTrue(lval)> && <isTrue(rval)> ]]; then
	r<scope.register>=true
else
	r<scope.register>=false
fi

>>