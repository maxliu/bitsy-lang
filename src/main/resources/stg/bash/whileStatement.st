whileStatement(valBlock, value, register, block, label, scope) ::= <<
<valBlock>
while [[ $r<register> == true ]]
do
	<block>
	<valBlock>
done

>>