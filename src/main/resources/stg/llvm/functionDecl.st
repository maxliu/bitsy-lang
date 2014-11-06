functionDecl(id, idList, block, scope) ::= << ; [returnValue]
define <typeMap.(returnValue.type)> @<id>(<idList:{id | double %<i>}; separator=", ">) {
	<block>
}

>> 