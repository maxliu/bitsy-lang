powerExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.register> = call double @pow(<args(lval, rval, scope)>)
>>