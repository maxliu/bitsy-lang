eqExpression(lval, rval, scope) ::= <<
<load(lval)>
<load(rval)>
invokestatic <runtimeclass()>/compare<lval.type><rval.type>(<typeMap.(lval.type)><typeMap.(rval.type)>)Z

>>