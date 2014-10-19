andExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
<if(lval.string&&rval.string)>
%r<scope.nextRegister> = alloca i32
%lval<scope.register> = load i8* <argRegister(lval, "lval", scope.lastRegister)>
%rval<scope.register> = load i8* <argRegister(rval, "rval", scope.lastRegister)>
%lval_sext<scope.register> = sext i8 %lval<scope.register> to i32
%lval_cmp<scope.register> = icmp eq i32 %lval_sext<scope.register>, 0
br i1 %lval_cmp<scope.register>, label %false<scope.nextLabel>, label %andrval<scope.label>
andrval<scope.label>:
	%rval_sext<scope.register> = sext i8 %rval<scope.register> to i32
	%rval_cmp<scope.register> = icmp eq i32 %rval_sext<scope.register>, 0
	br i1 %rval_cmp<scope.register>, label %false<scope.label>, label %true<scope.label>
true<scope.label>:
	store i32 1, i32* %r<scope.register>
	br label %endif<scope.label>
false<scope.label>:
	store i32 0, i32* %r<scope.register>
	br label %endif<scope.label>
endif<scope.label>:
%r<scope.nextRegister> = load i32* %r<scope.lastRegister>
<elseif(lval.string&&rval.number)>


%r<scope.nextRegister> = alloca i32
%lval<scope.register> = load i8* <argRegister(lval, "lval", scope.lastRegister)>
%rval<scope.register> = fadd double <argRegister(rval, "rval", scope.lastRegister)>, 0.0
%lval_sext<scope.register> = sext i8 %lval<scope.register> to i32
%lval_cmp<scope.register> = icmp eq i32 %lval_sext<scope.register>, 0
br i1 %lval_cmp<scope.register>, label %false<scope.nextLabel>, label %andrval<scope.label>
andrval<scope.label>:
	%rval_cmp<scope.register> = fcmp ueq double %rval<scope.register>, 0.000000e+00
	br i1 %rval_cmp<scope.register>, label %false<scope.label>, label %true<scope.label>
true<scope.label>:
	store i32 1, i32* %r<scope.register>
	br label %endif<scope.label>
false<scope.label>:
	store i32 0, i32* %r<scope.register>
	br label %endif<scope.label>
endif<scope.label>:
%r<scope.nextRegister> = load i32* %r<scope.lastRegister>




<elseif(lval.string&&rval.boolean)>
<elseif(lval.number&&rval.string)>
<elseif(lval.number&&rval.number)>
<elseif(lval.number&&rval.boolean)>
<elseif(lval.boolean&&rval.string)>
<elseif(lval.boolean&&rval.number)>
<elseif(lval.boolean&&rval.boolean)>
<endif>
>>