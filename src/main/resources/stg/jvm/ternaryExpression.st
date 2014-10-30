ternaryExpression(value, trueBlock, trueVal, falseBlock, falseVal, scope, label) ::= <<
; ternary
<load(value)>
<if(value.reference)>
<if(value.boolean)>
iconst_1
if_icmpne false<label>
<elseif(value.number)>
ldc2_w 0.0
dcmpl
ifeq false<label>
<else>
ldc ""
invokevirtual java/lang/String/equals(Ljava/lang/Object;)Z
ifne false<label>_<sublevel>
<endif><else>
iconst_1
if_icmpne false<label>
<endif>
    <trueBlock>
	<load(trueVal)>    
    goto endif<label>
false<label>:
	<falseBlock>
	<load(falseVal)>
endif<label>:

>>