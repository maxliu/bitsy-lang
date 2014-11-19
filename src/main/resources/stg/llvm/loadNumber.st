loadNumber(val, side, register) ::= <%
<if(val.reference)>
%<side><register> = load double* %<bitsyVariable(val)>
<else>
%<side><register> = fadd double 0.0, <val>
<endif>
%>