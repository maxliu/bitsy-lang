argsList(args, register) ::= <%
<args:{arg | <typeMap.(arg.type)> <argRegister(arg, prefixIndex("args", i), register)>}; separator=", ">
%>