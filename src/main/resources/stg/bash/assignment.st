assignment(name, value, scope) ::= <<
<if(value.reference)>
<name>=${<value>}
<else>
<if(value.string)>
<name>="<value>"<else>
<name>=<value>
<endif>
<endif>
>>
