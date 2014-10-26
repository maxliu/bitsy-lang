addExpression(lval, rval, scope) ::= <<
<if(lval.string&&rval.string)>
r<scope.register>=<arg(lval)>;r<scope.register>+=<arg(rval)>
<else>
r<scope.register>=$(echo "<arg(lval)> + <arg(rval)>"|bc)
<endif>

>>