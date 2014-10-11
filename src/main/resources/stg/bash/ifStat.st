ifStat(value, block, scope, label, sublevel) ::= <<
<if(value.reference)>
<if(value.number)>
if [[ $(echo "$<value> != 0.0"|bc) -eq 1 ]]; then
<elseif(value.boolean)>
if [[ $<value> -ne 0 ]]; then
<else>
if [[ "$<value>" != "" ]]; then
<endif><else>
if [[ "<value.toBoolean>" != "0" ]]; then
<endif>
    <block>

>>