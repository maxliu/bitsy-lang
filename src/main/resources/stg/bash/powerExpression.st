powerExpression(lval, rval, scope) ::= <<
r<scope.register>=$(echo | awk '{ print <arg(lval)>^<arg(rval)>}')

>>