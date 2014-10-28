divideExpression(lval, rval, scope) ::= <<
r<scope.register>=$(echo "<arg(lval)> / <arg(rval)>"|bc)

>>