eqExpression(lval, rval, scope) ::= <<
r<scope.register>=$(compare<lval.type><rval.type> <args(lval, rval)>)

>>