runtime() ::= <<

.method static comparestringstring(Ljava/lang/String;Ljava/lang/String;)Z
    .limit stack 2
    .limit locals 2
    aload_0
    aload_1
    invokevirtual java/lang/String/compareTo(Ljava/lang/String;)I
    ifne Label0
    iconst_1
    goto Label1
    Label0:
    iconst_0
    Label1:
    ireturn
.end method

.method static comparestringnumber(Ljava/lang/String;D)Z
    .limit stack 4
    .limit locals 4
    new java/text/DecimalFormat
    dup
    ldc "#.#########################"
    invokespecial java/text/DecimalFormat/\<init>(Ljava/lang/String;)V
    astore_3
    aload_0
    aload_3
    dload_1
    invokevirtual java/text/NumberFormat/format(D)Ljava/lang/String;
    invokevirtual java/lang/String/equals(Ljava/lang/Object;)Z
    ireturn
.end method

.method static comparestringboolean(Ljava/lang/String;Z)Z
    .limit stack 2
    .limit locals 3
    aload_0
    invokevirtual java/lang/String/length()I
    ifle Label0
    iconst_1
    goto Label1
    Label0:
    iconst_0
    Label1:
    istore_2
    iload_2
    iload_1
    if_icmpne Label2
    iconst_1
    goto Label3
    Label2:
    iconst_0
    Label3:
    ireturn
.end method

.method static comparenumberstring(DLjava/lang/String;)Z
    .limit stack 3
    .limit locals 3
    aload_2
    dload_0
    invokestatic test/comparestringnumber(Ljava/lang/String;D)Z
    ireturn
.end method

.method static comparenumbernumber(DD)Z
    .limit stack 4
    .limit locals 4
    dload_0
    dload_2
    dcmpl
    ifne Label0
    iconst_1
    goto Label1
    Label0:
    iconst_0
    Label1:
    ireturn
.end method

.method static comparenumberboolean(DZ)Z
    .limit stack 4
    .limit locals 4
    dload_0
    dconst_0
    dcmpl
    ifeq Label0
    iconst_1
    goto Label1
    Label0:
    iconst_0
    Label1:
    istore_3
    iload_3
    iload_2
    if_icmpne Label2
    iconst_1
    goto Label3
    Label2:
    iconst_0
    Label3:
    ireturn
.end method

.method static comparebooleanstring(ZLjava/lang/String;)Z
    .limit stack 2
    .limit locals 2
    aload_1
    iload_0
    invokestatic test/comparestringboolean(Ljava/lang/String;Z)Z
    Label1:
    ireturn
.end method

.method static comparebooleannumber(ZD)Z
    .limit stack 3
    .limit locals 3
    dload_1
    iload_0
    invokestatic test/comparenumberboolean(DZ)Z
    Label1:
    ireturn
.end method

.method static comparebooleanboolean(ZZ)Z
    .limit stack 2
    .limit locals 2
    iload_0
    iload_1
    if_icmpne Label0
    iconst_1
    goto Label1
    Label0:
    iconst_0
    Label1:
    ireturn
.end method

>>