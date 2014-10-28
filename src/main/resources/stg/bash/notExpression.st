notExpression(value, scope) ::= <<
<isTrue(value)> && r<scope.register>=false || r<scope.register>=true

>>