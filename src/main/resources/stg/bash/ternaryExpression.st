ternaryExpression(value, trueBlock, trueVal, falseBlock, falseVal, scope, label) ::= <<
<ifStat(value, trueBlock, scope, label, "0")>
	r<scope.register>=<arg(trueVal)>
<elseStat(falseBlock, "0")>
	r<scope.register>=<arg(falseVal)>
<endifStat("0")>
	
>>