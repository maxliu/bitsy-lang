assignment(name, value, scope) ::= <%
<if(value.reference)>
	<name>=${<value>}
<else>
	<name>=<bashValue(value)>
<endif>
%>
