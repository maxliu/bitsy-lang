multiplyExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.register> = fmul double <argRegister(lval, "lval", scope.register)>, <argRegister(rval, "rval", scope.register)>
>>