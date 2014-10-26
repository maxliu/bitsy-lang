assignment(name, value, scope) ::= <<
<load(value)>
<if(value.number)>
dstore <scope.nextLocalWide>
<elseif (value.boolean)>
istore <scope.nextLocal>
<else>
astore <scope.nextLocal>
<endif>
>>