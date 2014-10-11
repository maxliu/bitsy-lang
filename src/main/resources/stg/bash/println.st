println(value, scope) ::= <<
<if(value.reference)>
<if(value.boolean)>
if [ "$<value>" == "1" ]; then
    printf "true\n"
else
    printf "false\n"
fi
<else>
printf "$<value>\n"<endif><else>
printf "<bashValue(value)>\n"<endif>
>>
