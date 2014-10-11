println(value, scope) ::= <<
getstatic java/lang/System/out Ljava/io/PrintStream;
<if(value.reference)>
<if(value.number)>
dload_<value.register>
invokevirtual java/io/PrintStream/println(D)V
<elseif(value.boolean)>
iload <value.register>
invokevirtual java/io/PrintStream/println(Z)V
<else>
aload_<value.register>
invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
<endif>
<else>
<if(value.number)>
ldc2_w <value>
invokevirtual java/io/PrintStream/println(D)V
<elseif(value.boolean)>
iconst_<value>
invokevirtual java/io/PrintStream/println(Z)V
<else>
ldc "<value>"
invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
<endif>
<endif>
>>