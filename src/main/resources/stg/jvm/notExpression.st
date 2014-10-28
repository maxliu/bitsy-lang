notExpression(value, scope) ::= <<
<load(value)>
<if(value.string)>
invokevirtual java/lang/String/length()I
<elseif(value.number)>
dconst_0
dcmpl
<endif>
<isZero(scope.nextLabel)>

>>