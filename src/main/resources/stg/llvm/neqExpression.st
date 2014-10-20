neqExpression(lval, rval, scope) ::= <<
<eqExpression(lval, rval, scope)>
%r<scope.nextRegister> = icmp eq i1 %r<scope.lastRegister>, 0
>>
