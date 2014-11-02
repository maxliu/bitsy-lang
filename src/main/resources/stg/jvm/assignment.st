assignment(name, symbol, value, scope) ::= <<
; <name> = <value> <symbol.local>
<load(value)>
<if(value.number)>
dstore <symbol.local>
<elseif (value.boolean)>
istore <symbol.local>
<else>
astore <symbol.local>
<endif>
>>