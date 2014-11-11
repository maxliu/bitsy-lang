whileStatement(valBlock, value, block, label, register) ::= <<
<valBlock>
while [[ $r<register> == true ]]
do
	<block>
	<valBlock>
done

>>