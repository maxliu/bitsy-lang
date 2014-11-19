loadOperand(val, register, prefix="r") ::= <%
<if(val.symbol&&val.string)><loadString(val, prefix, register)>
<elseif(val.symbol&&val.number)><loadNumber(val, prefix, register)>
<elseif(val.symbol&&val.boolean)><loadBoolean(val, prefix, register)>
<elseif(val.symbol&&val.list)>%<prefix><register> = load %struct.List** %<bitsyVariable(val)>
<endif>
%>
