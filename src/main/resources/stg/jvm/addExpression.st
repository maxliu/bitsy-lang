addExpression(lval, rval, scope) ::= <<
<if(lval.number&&rval.number)>
<load(lval)>
<load(rval)>
dadd
<elseif(lval.string&&rval.number)>
new java/lang/StringBuilder
dup
invokespecial java/lang/StringBuilder/\<init>()V
<load(lval)>
invokevirtual java/lang/StringBuilder/append(Ljava/lang/String;)Ljava/lang/StringBuilder;
new java/text/DecimalFormat
dup
ldc "#.####"
invokespecial java/text/DecimalFormat/\<init>(Ljava/lang/String;)V
<load(rval)>
invokevirtual java/text/DecimalFormat/format(D)Ljava/lang/String;
invokevirtual java/lang/StringBuilder/append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invokevirtual java/lang/StringBuilder/toString()Ljava/lang/String;
<elseif(lval.number&&rval.string)>
new java/lang/StringBuilder
dup
invokespecial java/lang/StringBuilder/\<init>()V
new java/text/DecimalFormat
dup
ldc "#.####"
invokespecial java/text/DecimalFormat/\<init>(Ljava/lang/String;)V
<load(lval)>
invokevirtual java/text/DecimalFormat/format(D)Ljava/lang/String;
invokevirtual java/lang/StringBuilder/append(Ljava/lang/String;)Ljava/lang/StringBuilder;
<load(rval)>
invokevirtual java/lang/StringBuilder/append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invokevirtual java/lang/StringBuilder/toString()Ljava/lang/String;
<elseif(lval.string&&rval.string)>
new java/lang/StringBuilder
dup
invokespecial java/lang/StringBuilder/\<init>()V
<load(lval)>
invokevirtual java/lang/StringBuilder/append(Ljava/lang/String;)Ljava/lang/StringBuilder;
<load(rval)>
invokevirtual java/lang/StringBuilder/append(Ljava/lang/String;)Ljava/lang/StringBuilder;
invokevirtual java/lang/StringBuilder/toString()Ljava/lang/String;
<endif>
>>