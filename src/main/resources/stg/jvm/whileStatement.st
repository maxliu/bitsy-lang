whileStatement(valBlock, value, block, label, register) ::= <<
whileStatement<label>:
	<valBlock>
	<ifFalseGoto(value, "endWhileLoop", label)>
	<block>
	goto whileStatement<label>
endWhileLoop<label>:


>>