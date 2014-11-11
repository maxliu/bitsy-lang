functionDecl(className, returnType, id, arguments, block, localCount) ::= <<
function <id> {
	<arguments.keys:{arg | local <arg>=$<i>}; separator="\n">
	<block>
}
>>