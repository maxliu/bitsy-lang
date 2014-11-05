functionDecl(id, idList, block, returnValue, scope) ::= << ; [returnValue]
define <typeMap.(returnValue.type)> @<id>(<idList:{id | double %<i>}; separator=", ">) {
	<block>
	ret <typeMap.(returnValue.type)> <argRegister(returnValue, "r", scope.register)>
}

>> 