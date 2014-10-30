ternaryExpression(value, trueBlock, trueVal, falseBlock, falseVal, scope, label) ::= <<
; ternaryExpression 
<compareValToZero(value, scope)>
%t<scope.register> = alloca <typeMap.(trueVal.type)>
br i1 %c<scope.register>, label %true<label>, label %false<label>
true<label>: 
    <trueBlock>
    <storeResult(trueVal, "t", scope.register, "tval")>
    br label %endif<label>
false<label>:
	<falseBlock>
	<storeResult(falseVal, "t", scope.register, "fval")>
    br label %endif<label>
endif<label>:
%r<scope.nextRegister> = load <typeMap.(trueVal.type)>* %t<scope.lastRegister>

>>