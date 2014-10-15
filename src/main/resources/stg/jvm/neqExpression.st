neqExpression(lval, rval, scope) ::= <<
<eqExpression(lval, rval, scope)>
ifeq false<scope.nextLabel>
iconst_0
goto endif<scope.label>
false<scope.label>:
iconst_1
endif<scope.label>:

>>