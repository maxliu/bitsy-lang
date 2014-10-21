eqExpression(lval, rval, scope) ::= <<
<if(lval.string&&rval.string)>
<load(lval)>
<load(rval)>
invokevirtual java/lang/String/compareTo(Ljava/lang/String;)I
<isZero(scope.nextLabel)>
<elseif(lval.string&&rval.number)>
<compareStringToNumber(lval, rval)>
<elseif(lval.string&&rval.boolean)>
<compareStringBoolean(lval, rval, scope)>
<elseif(lval.number&&rval.string)>
<compareStringToNumber(rval,lval)>
<elseif(lval.number&&rval.number)>
<load(lval)>
<load(rval)>
dcmpl
<isZero(scope.nextLabel)>
<elseif(lval.number&&rval.boolean)>
<compareNumberBoolean(lval, rval, scope)>
<elseif(lval.boolean&&rval.string)>
<compareStringBoolean(rval, lval, scope)>
<elseif(lval.boolean&&rval.number)>
<compareNumberBoolean(rval, lval, scope)>
<elseif(lval.boolean&&rval.boolean)>
<load(lval)>
<load(rval)>
<compareBooleans(scope.nextLabel)>
<endif>

>>