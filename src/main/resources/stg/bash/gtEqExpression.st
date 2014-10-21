gtEqExpression(lval, rval, scope) ::= <<
[ $(echo "<arg(lval)> >= <arg(rval)>"|bc) -eq 1 ] && r<scope.register>=true || r<scope.register>=false

>>