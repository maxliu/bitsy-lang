eqExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.register> = call i32 @compare<lval.type><rval.type>(<args(lval, rval, scope)>)
>>
