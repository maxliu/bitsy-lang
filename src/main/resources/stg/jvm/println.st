println(value, scope) ::= <<
<load(value)>
<if(value.number)>
dstore <scope.nextLocalWide>
getstatic java/lang/System/out Ljava/io/PrintStream;
dload <scope.lastLocalWide>
invokevirtual java/io/PrintStream/println(D)V
<elseif(value.boolean)>
getstatic java/lang/System/out Ljava/io/PrintStream;
swap
invokevirtual java/io/PrintStream/println(Z)V
<else>
getstatic java/lang/System/out Ljava/io/PrintStream;
swap
invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
<endif> 
>>