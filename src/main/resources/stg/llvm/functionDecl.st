functionDecl(returnType, id, idList, idTypes, block, scope) ::= <<
define <typeMap.(returnType)> @<id>(<idList:{param | <idTypes.(i)> %<param.text>}; separator=", ">) {
	<idList:{param | %<bitsyVariable(param.text)> = alloca double}; separator="\n">
	<idList:{param | store double %<param.text>, double* %<bitsyVariable(param.text)>}; separator="\n">
	<block>
}

>> 