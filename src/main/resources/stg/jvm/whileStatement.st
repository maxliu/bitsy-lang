whileStatement(valBlock, value, block, label, register) ::= <<
whileStatement<label>:
	<valBlock>
	<ifFalseGoto(value, "endWhileStatement", label)>
	<block>
	goto whileStatement<label>
endWhileStatement<label>:


>>