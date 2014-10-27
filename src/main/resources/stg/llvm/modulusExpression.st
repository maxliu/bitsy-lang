modulusExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.register> = call double @fmod(<args(lval, rval, scope)>)
>>