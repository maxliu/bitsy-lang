loadList(args, register) ::= <%
<args:{arg | <loadOperand(arg, register, prefixIndex("args",i))>}; separator="\n">
%>
