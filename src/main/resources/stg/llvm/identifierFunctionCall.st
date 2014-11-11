identifierFunctionCall(returnType, id, arguments, register) ::= <<
<loadList(arguments, register)>
<if(!returnType.null)>%r<register> = <endif>call <typeMap.(returnType)> (<typeList(arguments)>)* @<id>(<argsList(arguments, register)>)

>>