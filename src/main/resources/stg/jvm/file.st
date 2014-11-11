file(fileName, strings, functions, block, localCount) ::= <<
.class public <fileName>
.super java/lang/Object

.method public \<init>()V
    aload_0
    invokenonvirtual java/lang/Object/\<init>()V
    return
.end method

<functions:{f | <f>}; separator="\n">

.method public static main([Ljava/lang/String;)V
    .limit stack 10  
    .limit locals <localCount>
    <block>
    return
.end method

<runtime()>
>>