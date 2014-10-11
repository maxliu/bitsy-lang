assignment(name, value, scope) ::= <<
<if(value.reference)>
<if(value.number)>
dload_<value.register>
dstore_<scope.nextLocal>
<elseif (value.boolean)>
iload <value.register>
istore <scope.nextLocal>
<else>
aload_<value.register>
astore_<scope.nextLocal>
<endif>
<else>
<if(value.number)>
ldc2_w <value>
dstore_<scope.nextLocalWide>
<elseif(value.boolean)>
iconst_<value>
istore <scope.nextLocal>
<else>
ldc "<value>"
astore_<scope.nextLocal>
<endif>
<endif>
>>