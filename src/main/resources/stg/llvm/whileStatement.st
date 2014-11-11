whileStatement(valBlock, value, block, label, register) ::= <<
br label %whileStatement<label>
whileStatement<label>:
	<valBlock>
	<compareValToZero(value, register)>
	br i1 %c<register>, label %whileLoop<label>, label %endWhileLoop<label>
	whileLoop<label>:
	<block>
	br label %whileStatement<label>
endWhileLoop<label>:

>>