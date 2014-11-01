addExpression(lval, rval, scope) ::= <<
<if(lval.number&&rval.number)>
r<scope.register>=$(echo "<arg(lval)> + <arg(rval)>"|bc)
<else>
r<scope.register>=<arg(lval)>;r<scope.register>+=<arg(rval)>
<endif>

>>