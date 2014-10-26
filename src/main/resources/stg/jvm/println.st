println(value, scope) ::= <<
<load(value)>
<if(value.number)>
getstatic java/lang/System/out Ljava/io/PrintStream;
dup_x2 ; swap word with double
pop
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