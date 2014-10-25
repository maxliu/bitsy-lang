subtractExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
<if(lval.number&&rval.number)>
%r<scope.register> = fsub double <argRegister(lval, "lval", scope.register)>, <argRegister(rval, "rval", scope.register)>
<elseif(lval.number&&rval.string)>

<elseif(lval.string&&rval.number)>

<elseif(lval.string&&rval.string)>

<endif>
>>