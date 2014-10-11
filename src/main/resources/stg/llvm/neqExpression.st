neqExpression(lexpr, rexpr, lval, rval, scope) ::= <<
<eqExpression(lexpr, rexpr, lval, rval, scope)>
%r<scope.nextRegister> = icmp ne i32 %r<scope.lastRegister>, 0
%r<scope.nextRegister> = xor i1 %r<scope.lastRegister>, true
%r<scope.nextRegister> = zext i1 %r<scope.lastRegister> to i32
>>
