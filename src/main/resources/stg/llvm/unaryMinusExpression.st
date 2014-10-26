unaryMinusExpression(value, scope) ::= <<
<loadOperand(value, scope.register, "r")> 
%r<scope.nextRegister> = fsub double -0.000000e+00, <argRegister(value, "r", scope.lastRegister)>

>>