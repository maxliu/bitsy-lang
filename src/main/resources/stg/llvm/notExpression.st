notExpression(value, scope) ::= <<
<loadOperand(value, scope.register, "r")> 
<compareRegToZero("r", value, scope.register, scope.lastRegister)>
%r<scope.nextRegister> = add i1 0, %r_cmp<scope.lastRegister>
>>