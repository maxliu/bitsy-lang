unaryMinusExpression(value, scope) ::= <<
r<scope.register>=$(echo "0 - <arg(value)>"|bc)

>>