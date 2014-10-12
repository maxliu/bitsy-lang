elseifStat(expression, value, block, scope, label, sublevel) ::= <<
<expression>
<if(value.reference)>
<if(value.number)>
elif [[ $(echo "$<value> != 0.0"|bc) -eq 1 ]]; then
<elseif(value.boolean)>
elif [[ $<value> -ne 0 ]]; then
<else>
elif [[ "$<value>" != "" ]]; then
<endif><else>
elif [[ "<value.toBoolean>" != "0" ]]; then
<endif>
    <block>

>>