whileStatement(valBlock, value, block, label, scope) ::= <<
br label %whileStatement<label>
whileStatement<label>:
	<valBlock>
	<compareValToZero(value, scope)>
	br i1 %c<scope.register>, label %whileLoop<label>, label %endWhileLoop<label>
	whileLoop<label>:
	<block>
	br label %whileStatement<label>
endWhileLoop<label>:

>>