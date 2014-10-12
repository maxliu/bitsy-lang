ifStat(value, block, scope, label, sublevel) ::= <<
<if(value.reference)>
<if(value.number)>
if [[ $(echo "<arg(value)> != 0.0"|bc) -eq 1 ]]; then
<elseif(value.boolean)>
if [[ "<arg(value)>" -ne 0 ]]; then
<else>
if [[ "<arg(value)>" != "" ]]; then
<endif><else>
if [[ "<value.toBoolean>" != "0" ]]; then
<endif>
    <block>

>>