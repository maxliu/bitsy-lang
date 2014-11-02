assignment(name, symbol, value, scope) ::= <%
<if(value.symbol)>
	<name>=${<value>}
<elseif(value.reference)>
	<name>=$r<value>
<else>
	<name>=<bashValue(value)>
<endif>
%>
