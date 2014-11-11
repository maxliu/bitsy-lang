identifierFunctionCall(className, returnType, id, arguments, register) ::= <<
<arguments:{arg| <load(arg)>}; separator="\n">
invokestatic <className>/<id>(<arguments:{arg | <typeMap.(arg.type)>}; separator="">)<typeMap.(returnType)>

>>