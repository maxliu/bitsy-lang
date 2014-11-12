listExpression(register, list) ::= <<
%r<register> = alloca [<length(list)> x %struct.Object]
<list:{ value | <addToList(register, i0, length(list), value)>}; separator="\n">
>>