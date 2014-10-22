println(value, scope) ::= <<
<loadOperand(value, scope.nextRegister, "r")>
<if(value.string)>
call i32 (i8 *, ...)* @printf(i8* <argRegister(value, "r", scope.register)>)
<elseif(value.number)>
call i32 (i8 *, ...)* @printf(i8* getelementptr ([3 x i8]* @.double, i32 0, i32 0), double <argRegister(value, "r", scope.register)>)
<elseif(value.boolean)>
%c<scope.register> = icmp ne i32 %r<scope.register>, 0
br i1 %c<scope.register>, label %true<scope.register>, label %false<scope.register>
true<scope.register>: 
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([5 x i8]* @.true, i32 0, i32 0))
    br label %endif<scope.register>
false<scope.register>:
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([6 x i8]* @.false, i32 0, i32 0))
    br label %endif<scope.register>
endif<scope.register>:
<endif>
call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
>>