println(value, scope) ::= <%
<if(value.symbol)>
	printf "$<value>\n"
<elseif(value.reference)>
	printf "$r<value>\n"
<else>
	printf <bashValue(value,"\\n")>
<endif>
%>
