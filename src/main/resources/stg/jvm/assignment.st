assignment(name, value, scope) ::= <<
<if(value.reference)>
<if(value.number)>
dload_<value.register>
dstore <scope.nextLocal>
<elseif (value.boolean)>
iload <value.register>
istore <scope.nextLocal>
<else>
aload_<value.register>
astore <scope.nextLocal>
<endif>
<else>
<if(value.number)>
ldc2_w <value>
dstore <scope.nextLocalWide>
<elseif(value.boolean)>
iconst_<value>
istore <scope.nextLocal>
<else>
ldc "<value>"
astore <scope.nextLocal>
<endif>
<endif>
>>