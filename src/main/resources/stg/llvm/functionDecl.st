functionDecl(returnType, id, idList, block, scope) ::= <<
define <typeMap.(returnType)> @<id>(<idList:{param | double %<param.text>}; separator=", ">) {
	<block>
}

>> 