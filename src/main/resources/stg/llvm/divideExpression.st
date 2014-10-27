divideExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.register> = fdiv double <argRegister(lval, "lval", scope.register)>, <argRegister(rval, "rval", scope.register)>
>>