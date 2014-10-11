ifStat(value, block, scope, label, sublevel) ::= <<
<if(value.reference)>
<if(value.boolean)>
iconst_1
iload <value.register>
if_icmpne false<label>_<sublevel>
<elseif(value.number)>
dload <value.register>
ldc2_w 0.0
dcmpl
ifeq false<label>_<sublevel>
<else>
aload <value.register>
ldc ""
invokevirtual java/lang/String/equals(Ljava/lang/Object;)Z
ifne false<label>_<sublevel>
<endif><else>
iconst_1
iconst_<value.toBoolean>
if_icmpne false<label>_<sublevel>
<endif>

    <block>
    goto endif<label>
false<label>_<sublevel>:

>>