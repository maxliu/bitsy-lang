subtractExpression(lval, rval, scope) ::= <<
<if(lval.number&&rval.number)>
<load(lval)>
<load(rval)>
dsub
<elseif(lval.string&&rval.number)>
<load(lval)>
invokestatic java/lang/Double/parseDouble(Ljava/lang/String;)D
<load(rval)>
dsub
<elseif(lval.number&&rval.string)>
<load(lval)>
<load(rval)>
invokestatic java/lang/Double/parseDouble(Ljava/lang/String;)D
dsub
<elseif(lval.string&&rval.string)>
<load(lval)>
invokestatic java/lang/Double/parseDouble(Ljava/lang/String;)D
<load(rval)>
invokestatic java/lang/Double/parseDouble(Ljava/lang/String;)D
dsub
<endif>
>>