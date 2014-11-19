argRegister(val, prefix, register) ::= <%
<if(val.reference&&!val.symbol)>%r<val>
<elseif(val.symbol)>%<prefix><register>
<elseif(val.string)><getString(val)>
<else><val><endif>
%>
