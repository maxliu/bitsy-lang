powerExpression(lval, rval, scope) ::= <<
<load(lval)>
<load(rval)>
invokestatic java/lang/Math/pow(DD)D

>>