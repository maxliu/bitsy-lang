ifStat(value, block, scope, label, sublevel) ::= <<
<if(value.reference)>
<if(value.number)>
if [[ $(echo "<arg(value)> != 0.0"|bc) -eq 1 ]]; then
<elseif(value.boolean)>
if [[ <arg(value)> == true ]]; then
<else>
if [[ "x<arg(value)>" != "x" ]]; then
<endif><else>
if [[ <if(value.onTrue)>true<else>false<endif> == true ]]; then
<endif>
    <block>

>>