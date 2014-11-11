identifierFunctionCall(className, returnType, id, arguments, register) ::= <<
r<register>=$(<id> <arguments:{ arg | <arg(arg)>}; separator=" ">)

>>