println(value, scope) ::= <%
<if(value.reference)>
	printf "$<value>\n"
<else>
	printf <bashValue(value,"\\n")>
<endif>
%>
