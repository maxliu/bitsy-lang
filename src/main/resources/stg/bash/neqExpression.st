neqExpression(lval, rval, scope) ::= <<
r<scope.register>=$(not $(compare<lval.type><rval.type> <args(lval, rval)>))

>>