andExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.register> = call i32 @and<lval.type><rval.type>(<args(lval, rval, scope)>)
>>