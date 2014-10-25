orExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
%r<scope.nextRegister> = alloca i1
<compareRegToZero("lval", lval, scope.register, scope.lastRegister)>
br i1 %lval_cmp<scope.register>, label %orrval<scope.nextLabel>, label %true<scope.label>
orrval<scope.label>:
	<compareRegToZero("rval", rval, scope.register, scope.lastRegister)>
	br i1 %rval_cmp<scope.register>, label %false<scope.label>, label %true<scope.label>
true<scope.label>:
	store i1 1, i1* %r<scope.register>
	br label %endif<scope.label>
false<scope.label>:
	store i1 0, i1* %r<scope.register>
	br label %endif<scope.label>
endif<scope.label>:
%r<scope.nextRegister> = load i1* %r<scope.lastRegister>
>>