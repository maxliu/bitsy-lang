whileStatement(valBlock, value, register, block, label, scope) ::= <<
whileStatement<label>:
	<valBlock>
	<ifFalseGoto(value, "endWhileLoop", label)>
	<block>
	goto whileStatement<label>
endWhileLoop<label>:


>>