functionDecl(className, returnType, id, arguments, block, localCount) ::= <<
.method public static <id>(<arguments.values:{type | <typeMap.(type)>}; separator="">)<typeMap.(returnType)>
	.limit stack 10
	.limit locals <localCount>
    <block>
    <doreturn(returnType)>
.end method

>>