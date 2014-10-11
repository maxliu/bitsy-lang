file(fileName, strings, locals, block) ::= <<
.class public <fileName>
.super java/lang/Object

.method public \<init>()V
    aload_0
    invokenonvirtual java/lang/Object/\<init>()V
    return
.end method

.method public static main([Ljava/lang/String;)V
    .limit stack 4  
    .limit locals <locals>
    <block>
    return
.end method
>>