functionDecl(returnType, id, arguments, block, scope) ::= <<
function <id> {
	<arguments.keys:{arg | local <arg>=$<i>}; separator="\n">
	<block>
}
>>