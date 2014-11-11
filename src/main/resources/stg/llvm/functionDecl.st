functionDecl(className, returnType, id, arguments, block, localCount) ::= <<
define <typeMap.(returnType)> @<id>(<arguments.keys:{param | <typeMap.(arguments.(param))> %<param>}; separator=", ">) {
	<arguments:{param | %<bitsyVariable(param)> = alloca <typeMap.(arguments.(param))>}; separator="\n">
	<arguments:{param | store <typeMap.(arguments.(param))> %<param>, <typeMap.(arguments.(param))>* %<bitsyVariable(param)>}; separator="\n">
	<block>
	ret <typeMap.(returnType)> <returnMap.(returnType)>
}

>> 