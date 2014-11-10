identifierFunctionCall(returnType, id, arguments, register) ::= <<
%r<register> = call <typeMap.(returnType)> (<typeList(arguments)>)* @<id>(<argsList(arguments)>)

>>